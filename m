Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1182652402
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLTP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLTP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:56:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A92BF4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:56:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bf43so19247624lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fb3EXHLztSLtWKQrjuaOBtd2wYq7DXjS9sXFC9KWxw=;
        b=JD3YLblDk1KnQLiONpAMmVlwOK8kLd0l8U1oYnWtwf29xlMiHG1Mig+NXDXTC5yjJG
         q1R9jmRR9/mL4qxCd8que177PK2j25NCyhOKh674FtCs78E16hEHrB6zQk3NDntAoSQp
         ew9dh2VusCBE5QGUslUjDjw4rNTPrGc0D7yYJ46/f3+soCNQ6PecIhZw19j9UGKRmYCI
         bif5ZTWpqZZukcZt3iBHdV1fwmJA2p2QQde86799OlXoZo9oB2+4wgRC8KFElgts5lcT
         PTMrJgAlqgKWrirOXPcumiVxN9rzq7N58uolgsjWej+Z24fN2ABpAQ+cCFiV9NdpPgBO
         rSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fb3EXHLztSLtWKQrjuaOBtd2wYq7DXjS9sXFC9KWxw=;
        b=LqKwC8NHFLSHNQfg7gx3SFOrCmnXufBeStOl5spBHp50LmlvEPUPnKPZE8dD3HCtN9
         ATIfvpL01sPiQTOqYjAbdtzmzrT1ZBmdN8HiXGRpMLX4cWjaIaB2lKxENc5mNP8EmV/1
         70DkHay7pTvBhOPvIMNVJwVY/P63Lo40eJkIwoPbAmnwd6Stvpr7FqTDvklNDgmHphtg
         6HGXff4CA/ZV5sdgoLWsuzdtX/5NFYSqaUIwAuU1MO95GEqcV0EuVn3JOiKH6vRPM7b+
         YaoQvGf/Sp2Z4lTqSELEcRHWrjbte5R3CvmDboy/9Fyb+Q7K7BfSKz4clik8Tccwx+dh
         pBlw==
X-Gm-Message-State: ANoB5pnaMzxLTRyuHirioMABD23LK7m5eeWBIi0yjyQ3nWFl4WrX/zbv
        9VyLFENf2GFmQhoheY+zKyLOWQ==
X-Google-Smtp-Source: AA0mqf7ukslzSdluDLTdG+4vtA+7HiyqX8tSilPUm6kafCwv00ZiTDRsxYasfcBXD5uMKFCQx+OZUA==
X-Received: by 2002:ac2:4bd6:0:b0:4a4:68b9:60b0 with SMTP id o22-20020ac24bd6000000b004a468b960b0mr13791811lfq.59.1671551804106;
        Tue, 20 Dec 2022 07:56:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m16-20020a056512015000b004b5748fa3afsm1489522lfo.107.2022.12.20.07.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:56:43 -0800 (PST)
Message-ID: <ae35cbc7-93c8-333a-4786-2c6d4a8a8752@linaro.org>
Date:   Tue, 20 Dec 2022 16:56:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 1/2] dt-bindings: uwb: Device tree information for Nxp
 SR1XX SOCs
Content-Language: en-US
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com, Kwame Adwere <kwame.adwere@nxp.com>
References: <20221220154747.2372597-1-manjunatha.venkatesh@nxp.com>
 <20221220154747.2372597-2-manjunatha.venkatesh@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220154747.2372597-2-manjunatha.venkatesh@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 16:47, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).
> 
> Link: https://lore.kernel.org/r/425858dc-59fe-2311-61ae-3b6dc77a2576@nxp.com
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Signed-off-by: Kwame Adwere <kwame.adwere@nxp.com>
> ---
> Changes since v5:
>   - Moved ioctl command definitions into header file.

How is this related to the binding?

>   - Version 5 patch review comments addressed.
>   - Corporate lawyer sign-off updated.
> 
>  .../bindings/uwb/nxp,uwb-sr1xx.yaml           | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> new file mode 100644
> index 000000000000..2a1caa661633
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +

Drop blank line.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/uwb/nxp,uwb-sr1xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:  NXP SR1XX SOC family of Ultra Wide Band(UWB) device bindings

Drop double space and "device bindings"

> +
> +description: The nxp-sr1xx driver works for the NXP SR1XX series of Ultra Wide

Drop references to driver. Missing new line after description.

> +    Band devices namely, SR150 and SR100T devices, and uses UWB Controller Interface (UCI).

This does not look like wrapped according to Linux coding style.

> +    The corresponding details are available in the FiRa Consortium Website.
> +    (https://www.firaconsortium.org/). More details on the SR1XX Family can be
> +    found at https://www.nxp.com/products/:UWB-TRIMENSION

You need to describe the hardware here.

> +
> +maintainers:
> +  - Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,sr1xx

Really?

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

I stopped reviewing. Rest is not necessarily good, but we get there later.

Best regards,
Krzysztof

