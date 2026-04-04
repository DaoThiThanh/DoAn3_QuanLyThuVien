export interface LoginRequest {
    email: string;
    matkhau: string;
}
export interface LoginResponse {
    token: string;
    user: {
        id: string;
        email: string;
        role: number;
        fullname?: string;
    }
}
export interface ApiResponse<T> {
    success: boolean;
    message: string;
    data?: T;

}