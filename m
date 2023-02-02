Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6507468798D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjBBJ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBBJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:56:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24F48934B;
        Thu,  2 Feb 2023 01:55:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m14so1122117wrg.13;
        Thu, 02 Feb 2023 01:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Stgr6vfm0HEaVlIajYL/GQy19ItPErkJb1Nwjrj3VxQ=;
        b=DGhHNeY4428AtR6ijDYnRHS5YEzktQbrxXUDsprWPLMjaYEw4F7GnvFM70lJcYjj8h
         8i9qBfZfaPI7Sf+L4NdYZ5yB/FZ+H3VzuvC7ytWVjqxxBlVzm4imYkn9ExZbcW8P1jgK
         reEzD0Vaf8RJY8ArKFVPeerkK8hOGFZZBOmPYZRnQXl0zfy4kX/t4aWWRY/27RgCPLPT
         36P+m7BvZihLipw+MSMHUe2U0tVmnbAUoMolYY1kxSfzb+TYMOZNjQOPlUhXVSsktM1g
         Z2l9r1JB5GxwtDozt2s3JZMUEfcwGlfvK5DcUT+REC4KreDg8CC344ipcaqk8q+LNqXo
         jeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Stgr6vfm0HEaVlIajYL/GQy19ItPErkJb1Nwjrj3VxQ=;
        b=SwNR5w4nfzThFMLeintf0tl31nRB6Wa3MGQlYaPSsgkeCnnGJJD6xkiwYAQnhDdaHq
         f+I/eNf8Fh49KEjGQ/0ZQKqYt0BgQVP35yJIFZtMItbsUe2QQIp0MAMsJA2HxaOswP1d
         NhzJ/xv1O2/6wwdsTTRCr8nfuxVbW53xUsyHFtctSJzA4CyGFW+V2zl6+njPGUUh01lD
         oO/5xuUnRBny+qD6TDyQbbyjd8nTcMDjVzQaniloMVTItbjxiMnQCpBRLi93kN7UD2DO
         9y78OVsc1BQyHyddKnS9XBT6MYrUcRzP5sJ4ZJdhZnu3ad3qJl6OGcu5+s5bhq0NMVxG
         9tQg==
X-Gm-Message-State: AO0yUKUQO+cKFRBIM0uLHPB1yT28k0BSOVcboUnLfb7ZKe+b8juWbNVW
        7ZxNNJI8ML24iYFUVeYv5FauecI4cI8=
X-Google-Smtp-Source: AK7set9+0KCJ4iG0B6Soqhj9NDaWHm930UPc8+G8z5nT+EeUjOSrCYTZjIZIelt1X/dZTH3B2Fl4nQ==
X-Received: by 2002:a5d:4e02:0:b0:2bf:e1f8:c4b6 with SMTP id p2-20020a5d4e02000000b002bfe1f8c4b6mr5026167wrt.52.1675331751349;
        Thu, 02 Feb 2023 01:55:51 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p8-20020adff208000000b002423edd7e50sm19640568wro.32.2023.02.02.01.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:55:50 -0800 (PST)
Message-ID: <44654beb-58d3-ff50-e495-938538c065cd@gmail.com>
Date:   Thu, 2 Feb 2023 10:55:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: pwm: mediatek: add mediatek,mt7986
 compatible
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <70fe0b606d988958b87f89828b8728e2f68eaace.1675278958.git.daniel@makrotopia.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <70fe0b606d988958b87f89828b8728e2f68eaace.1675278958.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2023 20:25, Daniel Golle wrote:
> Since commit 241eab76657f ("pwm: mediatek: Add support for MT7986")
> support for the 2 PWM channels implemented in MediaTek MT7986 SoCs has
> been added. Also add the compatible string to dt-bindings now that
> they have been converted to YAML.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> This patch has previously been submitted, but we decided to deferr it until
> after the conversion to YAML which has now been done via commit
> 3e98855ca0cf ("dt-bindings: pwm: mediatek: Convert pwm-mediatek to DT schema")
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/Y39PjU1BqBB8tZ98@makrotopia.org/
> 
> Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
> index dbc974bff9e9..8e176ba7a525 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
> @@ -22,6 +22,7 @@ properties:
>             - mediatek,mt7623-pwm
>             - mediatek,mt7628-pwm
>             - mediatek,mt7629-pwm
> +          - mediatek,mt7986-pwm
>             - mediatek,mt8183-pwm
>             - mediatek,mt8365-pwm
>             - mediatek,mt8516-pwm
> 
> base-commit: 66eee64b235411d512bed4d672c2d00683239daf
