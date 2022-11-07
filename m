Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E471B61E800
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 01:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiKGAwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 19:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiKGAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 19:52:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F16BF7C;
        Sun,  6 Nov 2022 16:52:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h9so14130838wrt.0;
        Sun, 06 Nov 2022 16:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1pgYi1QW20bjgeUikoI4BXtKNA0Vcvd3wP6F6jHeVrI=;
        b=VIZxyyb2huPFhXBj6Ff8hqSONy0ejhL6YVxx9CUX8F8cCRHkvMe/ZULDe+GekW6emU
         jDUQYbJJ0c/S9PQlfCSgL4mVtLaLaKzsJ2B19fDgOhloQtDgswGPLk4KKi+k9EXD25yh
         rhHXFFfj30rzIoLnoLSSx2bKGVez5Parp8aibRfLGyRGRiplIa7cE2InL1rGi9EmPsIU
         SQFQU/aLx5ZJ3v4pApENwlKkMWkCUJZ7C2pg3rj4prieE+OfsHM9qAig80HDS6HpfggW
         LNbFAP4yVhGs6ekt9WK17j4GfXC2vp0CJFNKT1p2traIXj2LpulkprjDViC6JbK2FHba
         sv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pgYi1QW20bjgeUikoI4BXtKNA0Vcvd3wP6F6jHeVrI=;
        b=LDN8C+Jfro5v3PMVBgvZT5jdFPxrG2sonyJjd68xjULTGtAU35GWVKNHssJoLvoH5I
         r1xJKrRYnAEMLDhzeZ17fucuimzcgNhKfPkMsYA4YxR0ZqeVKGWFNEKm3DJBFYJfGHjH
         gUK/YkrjwC7c15ccyjjSyujRxBU5MHYYCFk+NY0TYSe01KrJGmKpfleteYRED5r7Pxrn
         ED1QSj+RJxcny8y5XZJbi2M2uQQicTcaKIeyd7/P5cPSVdqUbcJkcdSNvvbpasGBejY0
         kiBeEQoPxzVaF8jpVdRLO32JQbhyLGjk8r/uXNvSOEOAzKBQUj7qqxMu8yJvL1ajUtdz
         y15w==
X-Gm-Message-State: ACrzQf0K5ms3sM8Hg1QQGnq/BK9s+KYFsb+UGrzIS6U01MDOb8TLqAcr
        saQuKzUjtjGLFr79gpdqNA4Y0jTds8lFVYrPT8e8BgRw
X-Google-Smtp-Source: AMsMyM4KfNUysIYFDjpu/bJYRa8vPionmtkrY9MNWjh6DdFy8XZvlJoSX5bAkgc6WDaKsTTe2+xPrsK5y9VjJdUn6z4=
X-Received: by 2002:a5d:618a:0:b0:228:d897:228 with SMTP id
 j10-20020a5d618a000000b00228d8970228mr504099wru.539.1667782368115; Sun, 06
 Nov 2022 16:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20221106161443.4104-1-wens@kernel.org>
In-Reply-To: <20221106161443.4104-1-wens@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 6 Nov 2022 19:52:35 -0500
Message-ID: <CAMdYzYomgwo3RiUr4pptOD=AUgUS4f6Aqtio3agQP2F-bm2WZQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk356x: Add dma-names to UART
 device nodes
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 6, 2022 at 11:15 AM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> At least one implementation, Linux, requires "dma-names" properties
> be used together with "dmas" to describe DMA resources. These are
> currently missing, causing DMA to not be used for UARTs.
>
> Add "dma-names" to the UART device nodes.
>
> Fixes: a3adc0b9071d ("arm64: dts: rockchip: add core dtsi for RK3568 SoC")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Enabling dma globally can cause some interesting issues, have you
tested this fully?

> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 5706c3e24f0a..5cd55487c20e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -447,6 +447,7 @@ uart0: serial@fdd50000 {
>                 clocks = <&pmucru SCLK_UART0>, <&pmucru PCLK_UART0>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 0>, <&dmac0 1>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> @@ -1326,6 +1327,7 @@ uart1: serial@fe650000 {
>                 clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 2>, <&dmac0 3>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart1m0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> @@ -1340,6 +1342,7 @@ uart2: serial@fe660000 {
>                 clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 4>, <&dmac0 5>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart2m0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> @@ -1354,6 +1357,7 @@ uart3: serial@fe670000 {
>                 clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 6>, <&dmac0 7>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart3m0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> @@ -1368,6 +1372,7 @@ uart4: serial@fe680000 {
>                 clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 8>, <&dmac0 9>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart4m0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> @@ -1382,6 +1387,7 @@ uart5: serial@fe690000 {
>                 clocks = <&cru SCLK_UART5>, <&cru PCLK_UART5>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 10>, <&dmac0 11>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart5m0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> @@ -1396,6 +1402,7 @@ uart6: serial@fe6a0000 {
>                 clocks = <&cru SCLK_UART6>, <&cru PCLK_UART6>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 12>, <&dmac0 13>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart6m0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> @@ -1410,6 +1417,7 @@ uart7: serial@fe6b0000 {
>                 clocks = <&cru SCLK_UART7>, <&cru PCLK_UART7>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 14>, <&dmac0 15>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart7m0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> @@ -1424,6 +1432,7 @@ uart8: serial@fe6c0000 {
>                 clocks = <&cru SCLK_UART8>, <&cru PCLK_UART8>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 16>, <&dmac0 17>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart8m0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> @@ -1438,6 +1447,7 @@ uart9: serial@fe6d0000 {
>                 clocks = <&cru SCLK_UART9>, <&cru PCLK_UART9>;
>                 clock-names = "baudclk", "apb_pclk";
>                 dmas = <&dmac0 18>, <&dmac0 19>;
> +               dma-names = "tx", "rx";
>                 pinctrl-0 = <&uart9m0_xfer>;
>                 pinctrl-names = "default";
>                 reg-io-width = <4>;
> --
> 2.34.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
