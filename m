Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA8467B1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjAYLrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbjAYLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:47:49 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5544C30
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:47:46 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id u13-20020a056830118d00b00686def09868so3634791otq.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=282ayFkuAOjZoYUDc0aDlm7l4Ua6SR1w7Gvov+9rFIo=;
        b=7ELM5ELNmfhBRPR/Gs+cgstult7RW0LN78AkkyDVzlQEWt0GUDxu/Z1adhsy541aaJ
         clw/v2+j7rpa5cc6At+6fuUjKE4eoFWJ8FGlAzgdcz5nCez3XyHGph+9fB6Q46PuV6wv
         gIz4jvZGkGPUsvAWJIH2J0jxt1PXPRxNxErbXAMGijsU1FuA6EqFitii0bMHB9gYMGa8
         eHV6fIi57rwPF1MA2yLbW13Szmx8/AvHaAtiTx9aGvVf6XWpbc4sbUVTnCAqeKWlCqnH
         WwQCqvR8az6nwIfdxgMNaqdv6dBJg/lMo13+VzEEY5TZURD/eBbX1/e5Kznopobke6jP
         3UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=282ayFkuAOjZoYUDc0aDlm7l4Ua6SR1w7Gvov+9rFIo=;
        b=TAuE5Df372vRESPq0XsevTnZfxdP4lWPD0a3kAHEnzpg/43mLGzSmsNL90F+ngtJg0
         WKu1b8C7pVHzbiuuwWMqGAr9QpzY53jwy4ci0qtJ6YfFDlS5G37+DsFJ3WH8yRfBo/K0
         bn6Jwm1e0kMa1R7mYvn4qe4hMpDrBK2gvG3Dhf785mU2cZFd4ISfZ/O+OfV0HCEGwsom
         SuVecAG+lDk+nFBx5FnLTr5XHOC1bgxT0GKPZlas1poFlkHmnTzhC/QroVV62zqLDJOt
         5dU/fxiZrpXYc13D3CxvMXUsA28qTJtYDrNSEyBbwVI3mjo0D5sCPmKaNWG4JnR3Sz47
         13pQ==
X-Gm-Message-State: AFqh2krHsB94Jy1RQWgPopfHrrFGTlZH/j2mh9XD8fXzL4Sx/+PckPCU
        fStWY4XeqdjYyR7Re1BBLAO/rw==
X-Google-Smtp-Source: AMrXdXsYy9M6zgykl3pQp5N8QV8MvjKvA7HOSfsVgIVVtJXWaGCQrLAWP+1ET0/QECBTiYPNT25iQw==
X-Received: by 2002:a9d:6e07:0:b0:686:3a34:4997 with SMTP id e7-20020a9d6e07000000b006863a344997mr16134224otr.22.1674647266317;
        Wed, 25 Jan 2023 03:47:46 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.253])
        by smtp.gmail.com with ESMTPSA id u81-20020aca6054000000b0036cbde661ecsm2104012oib.54.2023.01.25.03.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 03:47:45 -0800 (PST)
Date:   Wed, 25 Jan 2023 08:47:34 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH RESEND 1/2] media: dt-bindings: media: rockchip-rga: add
 rockchip,rk3568-rga
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Jacob Chen <jacob-chen@iotwrt.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Message-Id: <A3I1PR.VPFD55TNUYE81@vanguardiasur.com.ar>
In-Reply-To: <20230119-rk3568-rga-v1-1-43d4d14365e6@pengutronix.de>
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
        <20230119-rk3568-rga-v1-1-43d4d14365e6@pengutronix.de>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Jan 20 2023 at 10:14:21 AM +0100, Michael Tretter 
<m.tretter@pengutronix.de> wrote:
> Add a new compatible for the rk3568 Rockchip SoC, which also features 
> an
> RGA, which is called RGA2 in the TRM Part2. It is the same core as 
> used
> on the rk3288, which documents the same RGA2.
> 
> Specify a new compatible for the rk3568 to be able to handle unknown
> SoC-specific differences in the driver.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  Documentation/devicetree/bindings/media/rockchip-rga.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git 
> a/Documentation/devicetree/bindings/media/rockchip-rga.yaml 
> b/Documentation/devicetree/bindings/media/rockchip-rga.yaml
> index dd645ddccb07..ea2342222408 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-rga.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-rga.yaml
> @@ -21,7 +21,9 @@ properties:
>        - const: rockchip,rk3288-rga
>        - const: rockchip,rk3399-rga
>        - items:
> -          - const: rockchip,rk3228-rga
> +          - enum:
> +              - rockchip,rk3228-rga
> +              - rockchip,rk3568-rga
>            - const: rockchip,rk3288-rga
> 
>    reg:
> 
> --
> 2.30.2


