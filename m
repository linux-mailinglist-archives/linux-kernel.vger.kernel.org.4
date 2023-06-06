Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237C723872
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFFHK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbjFFHKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:10:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE182118
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:10:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51496f57e59so7591397a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686035410; x=1688627410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LisFXxO/Zq5NzPlsNvfDE27JudIL0xXgnokQiH5CFkg=;
        b=Tp7aA1tetcMXR3NmkTpppp8ctzFm310/IxY7dr4udMqjbhxvVsAVnjEjVDFjFHG5r0
         26nfXTeCftd7ibz0Ger4E16G02bfbYH1RBuKs9GpRs3Irky9dRwd5P2LnXUQ18gfn13W
         03jU2X9FzHbDEVVN087UEpnuvgxBv4/uVpb/djJrnMT/avsyawDuR4/cdzALcJm8M80b
         kJP+7fm1xXXUdInfE+tV/FKLrNYMAL6ncRxJfJGzY23CY9/KyFKjNM+TYVTlYWutG158
         0SO1GarqMJLyIU7H+KS/a1xKxIM+kvCE1Chpjyz3ba9/TzIbylnGdwytm2cTfstevXw+
         6N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686035410; x=1688627410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LisFXxO/Zq5NzPlsNvfDE27JudIL0xXgnokQiH5CFkg=;
        b=e68v3jf9wF9I/lk06klK6gusIbXorhp/6unNma2Id+lJPlpE6xiaR1bRcXLbY+9Omh
         ReC0lvI5NDO5/eWFoXPexcpAw4jNmTqrG9Zh9o1aIwOh6vbOGfqKSGqfmguVF758bLtn
         7ZRlOb8pIOtWD1pqCM/XHmcKIUUInVU6FtcRE05mytzLVm2yoU0yZAXd2dnnPDYNVTpP
         0cgPlkAARjeJphzdalqDaJCSiobvbEs4P2N5hcPQjQ6cqAUg5U+9SkE4xuL4aw+R33K9
         EfIUOFN1N3T29vHDyWswyH29xuKxa+W6Oe1pAKLBU4A5IrDNzRXy9U2CVCGmq2iNqCY4
         OJ5A==
X-Gm-Message-State: AC+VfDyPXYu8cg7xHSpgMG04URuMMBuAff2gSpV0cE1s9Llh3TOw14RF
        wT1brytaEtkPOos1726GH9631g==
X-Google-Smtp-Source: ACHHUZ6Bw2R/3N0tQrQg3MAgzfrTK7S3Fu0Ps1sWt88Aosi9bHUp048ui/ckWGF3EaIH8l2jRRM0Ig==
X-Received: by 2002:aa7:d28c:0:b0:514:90de:423e with SMTP id w12-20020aa7d28c000000b0051490de423emr1159906edq.36.1686035410439;
        Tue, 06 Jun 2023 00:10:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d0c6000000b0050488d1d376sm4706904edo.0.2023.06.06.00.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 00:10:10 -0700 (PDT)
Message-ID: <7255ff65-9dac-3cce-fb74-09a8984775f2@linaro.org>
Date:   Tue, 6 Jun 2023 09:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: add fannal,c3004
Content-Language: en-US
To:     Paulo Pavacic <pavacic.p@gmail.com>, neil.armstrong@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230605153539.497602-1-pavacic.p@gmail.com>
 <20230605153539.497602-3-pavacic.p@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605153539.497602-3-pavacic.p@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 17:35, Paulo Pavacic wrote:
> Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
> Fannal C3004 is a 480x800 MIPI DSI Panel which requires
> DCS initialization sequences with certain delays between certain
> commands.


> +    #include <dt-bindings/gpio/gpio.h>
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        panel@0 {
> +            compatible = "fannal,c3004";
> +            reg = <0>;
> +            pinctrl-0 = <&pinctrl_mipi_dsi_rst>;
> +            pinctrl-names = "default";
> +            reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +            vdd-supply = <&reg1>;
> +            vddio-supply = <&reg2>;
> +            width-mm = <93>;
> +            height-mm = <56>;
> +            panel-timing {
> +                clock-frequency = <27000000>;
> +                hactive = <480>;
> +                vactive = <800>;
> +                hfront-porch = <30>;
> +                hback-porch = <30>;
> +                hsync-len = <8>;
> +                vback-porch = <30>;
> +                vfront-porch = <30>;
> +                vsync-len = <8>;
> +            };
> +        };
> +    };


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c22c828ab46..62374c8424b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6427,6 +6427,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
>  F:	drivers/gpu/drm/panel/panel-ebbg-ft8719.c
>  
> +DRM DRIVER FOR FANNAL C3004373132019A
> +M:	Paulo Pavacic <pavacic.p@gmail.com>
> +S:	Maintained
> +C:	matrix:r/mipi-dsi-bringup:matrix.org

I don't think we have chat channels for individual, small drivers. Add a
channel for entire subsystem.

Best regards,
Krzysztof

