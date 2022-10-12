Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3715FC680
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJLNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJLNaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:30:17 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE133F315
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:30:15 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x13so7874238qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afx1ZUqeiYFFIsDIPyGi6jdl/Bfo8+YGidTSsospIO8=;
        b=G9I0WOy7GRTJuGqu7tFU2yADPFJn79gPN93sAfqSaFuxUizi+cvINq5ZOE/10RRud/
         nLfXRA2z+Qgherce0oM66BDsgEq97pQmAKKJUmwgl/pSkEZsBqpObvDy/fZRbqFMZ2Yf
         nbusbD13vN0it7E5AJBK4ye0ehbgbHoElKcnU5uWe4zSlhlEHWnrcSwcvKzbFQCTSOXG
         hGN36i8jPD+FuknRWNjBhjlSbzT/utr6cuthM1wmqJhV7XOTOUxjN2wSVviYcJV69UXz
         mtAfmlzZwsjcg7JpCrRZdKrZW+WfvGrcWApXhYgb2WBIBoEkPn6uhVeaoOkhJ5EVTA/A
         SOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afx1ZUqeiYFFIsDIPyGi6jdl/Bfo8+YGidTSsospIO8=;
        b=ek1B0PlRcUPMJTebMWoI17TtjfEPri/bp6eWoERjs+eTLM5ZJRQrckwK75D9EV/rFZ
         ZYl8y396KGgGfK1cshXPB+wnrF/UJvoJImk9GptMMorg60LgJaeZibgH+82jPYGhBuEf
         BM4ObQaEDQFGMBbkJD0lXtgEUAnZ3N+LAV4SaHMsGCnz211YZDM3H8umsiL6ICSoUngx
         H2j2yyTefpNG+JlXbSbVfeMTQQYr1WRTu+qsD64OXbIONLBYmolV7tkaEoLKtNLO3IWe
         MHcAxRSCjpSLmUKZt+o8EGfXRnzBho8Ki/RrBMp3EFWhWYDu8ZJ+EdddAF0jBxq3fS3D
         krHQ==
X-Gm-Message-State: ACrzQf1XC7lTDwx7XwoCEo14RGI8Ot167IAV2c8nyDAa1ibCX4+H4X4K
        DgLaPDgSlcb4rcEhQ4FrnKcMNQ==
X-Google-Smtp-Source: AMsMyM4tIyXqJb2NSCtLgGnokhnQqKWd4N0bJ0FSwi5lzOrDt/guBCmXfFMCdKH+nEzyqIH7vgdRaQ==
X-Received: by 2002:a05:620a:4709:b0:6ce:d97a:fc9a with SMTP id bs9-20020a05620a470900b006ced97afc9amr19891291qkb.340.1665581414179;
        Wed, 12 Oct 2022 06:30:14 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id e8-20020ac85988000000b0034305a91aaesm5894919qte.83.2022.10.12.06.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:30:13 -0700 (PDT)
Message-ID: <f68cdc01-2195-70fa-df11-521cca3505f0@linaro.org>
Date:   Wed, 12 Oct 2022 09:28:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-5-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221010101816.298334-5-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 06:18, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert usbmisc-imx to yaml format.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
>  .../devicetree/bindings/usb/usbmisc-imx.yaml  | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> deleted file mode 100644
> index b796836d2ce7..000000000000
> --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Freescale i.MX non-core registers
> -
> -Required properties:
> -- #index-cells: Cells used to describe usb controller index. Should be <1>
> -- compatible: Should be one of below:
> -	"fsl,imx6q-usbmisc" for imx6q
> -	"fsl,vf610-usbmisc" for Vybrid vf610
> -	"fsl,imx6sx-usbmisc" for imx6sx
> -	"fsl,imx7d-usbmisc" for imx7d
> -	"fsl,imx7ulp-usbmisc" for imx7ulp
> -- reg: Should contain registers location and length
> -
> -Examples:
> -usbmisc@2184800 {
> -	#index-cells = <1>;
> -	compatible = "fsl,imx6q-usbmisc";
> -	reg = <0x02184800 0x200>;
> -};
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml

Filename: fsl,usbmisc.yaml

> new file mode 100644
> index 000000000000..c0741ce9b523
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/usbmisc-imx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX non-core registers

non-core registers? Does not look right.


Best regards,
Krzysztof

