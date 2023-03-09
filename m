Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1D6B20B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjCIJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCIJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:54:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF330B01
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:54:04 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so4607518edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678355643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OoHRnRoLlzxAiSAqp4tivCtuegEL4xuBxbRKH0S0dSg=;
        b=y1ckPIhrxAMHTNj7vNntlrKmA7wNpobhZV8QaQYNPfyprD0NF6SszzPBEmhqUNgCn/
         t0FzR21q9C9TB9lVUSsju77PkB+m8os9Nd6fn3BSevXCmoe6dIOdsEnLSS2vYCPFW0XS
         g6Dq54fXTGPePcw5nxSrXTKQpFPgQnF0+OV3NqGGYZ86EG9QR0CRTgQx39Urw5gIttQ8
         bwXBt/jHU/SsU+HraeakfV+hYH4ggaBH1UBpUZKcNXFMdc4D4g2CW/FVom1TPQ5To8FC
         IEdIpvUMRkN+96EI7ux/eZSzCuzNoZzMyyyaM6jN6XKy1reYMmDY9+Ja6nZaCWvtaM06
         k+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678355643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoHRnRoLlzxAiSAqp4tivCtuegEL4xuBxbRKH0S0dSg=;
        b=lTXtZ+wrO8BZQkcmb3I9xcwpDeorAEmBWOkMUr2EBh8G47zmJ5laYnTetkMFbYp5Pu
         wqw8+1oLcrWIloowoNTvtJPqvVeDHV8BkKiID1Nppw9zQFY+75fOEFGes2TyjSUBCMAg
         Ihuyf7QHtr4xpFJlcyd/MWmGAbuSSf/1lpz7RYTswZ4FdxlnKcZizxWGBvyXzj8Eelrv
         Vt9s/+oE/X5SGKK3Vmi2i1WpH8JooDJdgqBLLxdYLxR+zQ9uFHd1fsag58EfAVi9qWyp
         Z0v/TyPDyyGGqcSwSmGegqY6PA1mVF2NegB605qgSBcziTHze5VUjhWPiSKN3MM/vFE8
         rLTA==
X-Gm-Message-State: AO0yUKVBC7nLZK52Mz5gAJt284C7jOvlK/46/4OnnvfV1DhXkHVHnfJD
        4tm5lFLKBe0pK4NtTTd1u55PGA==
X-Google-Smtp-Source: AK7set/ZIn/kXnD8baLDvDAitMbJdAzko6v7BA4mlUMGpJqJ/bRwwAyBuxpxpbqahDmf/rFNLs91bQ==
X-Received: by 2002:a17:906:304a:b0:8f1:937c:f450 with SMTP id d10-20020a170906304a00b008f1937cf450mr19012832ejd.13.1678355642859;
        Thu, 09 Mar 2023 01:54:02 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id fw20-20020a170907501400b00914fec9f40esm4216820ejc.71.2023.03.09.01.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:54:02 -0800 (PST)
Message-ID: <61539204-afbf-f504-dfe7-237824dc0d6c@linaro.org>
Date:   Thu, 9 Mar 2023 10:54:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 19/20] dt-bindings: pinctrl: mediatek: mt7620: split
 binding
Content-Language: en-US
To:     arinc9.unal@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-20-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303002850.51858-20-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 01:28, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The MT7628 and MT7688 SoCs contain different pin muxing information,
> therefore, should be split. This can be done now that there are compatible
> strings to distinguish them from other SoCs.
> 
> Split the schema out to mediatek,mt76x8-pinctrl.yaml.
> 
> Remove mediatek,mt76x8-pinctrl from mt7620.
> 
> Deprecate ralink,mt7620-pinctrl. The reason is, the DTs for mt76x8 which
> use this string will incorrectly match the pin muxing information for
> mt7620. There's a new string, mediatek,mt7620-pinctrl, which makes the
> deprecation possible.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 380 +--------------
>  .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 450 ++++++++++++++++++
>  2 files changed, 459 insertions(+), 371 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
> index 11530b29d52b..38b71c74b9a0 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
> @@ -11,16 +11,13 @@ maintainers:
>    - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>  
>  description: |
> -  MediaTek MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
> +  MediaTek MT7620 pin controller for MT7620 SoC.
>    The pin controller can only set the muxing of pin groups. Muxing individual
>    pins is not supported. There is no pinconf support.
>  
>  properties:
>    compatible:
> -    enum:
> -      - mediatek,mt7620-pinctrl
> -      - mediatek,mt76x8-pinctrl
> -      - ralink,mt7620-pinctrl

I see removal, not deprecation.

Best regards,
Krzysztof

