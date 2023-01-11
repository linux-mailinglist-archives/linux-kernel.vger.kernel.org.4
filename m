Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E0D66569B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjAKI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjAKI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:57:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A310543
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:57:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso13803692wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yw1hwfBWZKA4eArOgxuAWfDDW9pVN08Ny+kHlfHHKTs=;
        b=EsvdekbA1p6fczMMI+X8YHscBob+aET+s9nzz2DHvxICrDuOVSrctw1nY7odovVL39
         01ehLvGkrNayur3gslwYliDe/6pzX+yBCy791xBRyfh7Paq5OnBNZcX49U7gAbsaDjZY
         Ug5Ruc6ugBj2mD1tkRFSB07sXSPgJP3wTZQqKjiBbsBqb7r5wHU6hJRNnJnEqthEqOjx
         9sgf9mryQElHyOqbExivXJ8vrGTJF7sq7yp70Jy8S2IPpSyZDRCt7kVE1FqsBJ+C0Ine
         rRkbnJvSu8zPLog/zZN5zgEPIdrJjTiH/hotkDNh54uzKFi7P5eEF2H52JKS6cdtgsve
         uRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw1hwfBWZKA4eArOgxuAWfDDW9pVN08Ny+kHlfHHKTs=;
        b=7MuYaUIBhVZU049TV0NQbLFjfZvzi0o4Hws89Fr9xI9L1nv+cmwWX5kzMwcJ3RL612
         WAn78+bxUmP9N80mmWU5YiOqf/wy9VCXHBBm+JHkBk0u2OrK6YtOCyJqS3tkMs9yM0Ax
         A49kg2kF+jp0zZ91DtS4po7xftAs7hHybTGwp/5mBQNh6A7TtdQ6FR9aEomdhINaos7r
         IlxgfC2R7gO9IZ1urfWt99JbdoFmwX36V0/5/Yz+ibvnsuUKqrbt5b0gPJdu8/YJvjBi
         1bVWBhbh7v141lK0yMO+Orv2LkysCQhj+WnS3F8XlPbGx8CRfPIlN34j0F9oVncqzHu7
         Id8g==
X-Gm-Message-State: AFqh2kpIrQdtHSgKkc/yDxFOAZkkNBQ9NElM1B6pMpv/0t1WtjPS80iK
        ctEVUvhwIe35queLQ/MRRbBMfA==
X-Google-Smtp-Source: AMrXdXvfW0wGX2+BKbHuSVV9VoySBr4jZ/ApUkymTjNbEWMDTOqC6kNxLWXp4WimVhnYj6p0nXlHuw==
X-Received: by 2002:a05:600c:2318:b0:3c6:e63e:23e9 with SMTP id 24-20020a05600c231800b003c6e63e23e9mr54445395wmo.24.1673427433668;
        Wed, 11 Jan 2023 00:57:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q20-20020a7bce94000000b003c6c3fb3cf6sm17307533wmj.18.2023.01.11.00.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 00:57:13 -0800 (PST)
Message-ID: <39ed8a13-8b27-80d4-99b8-5693ce6d3f58@linaro.org>
Date:   Wed, 11 Jan 2023 09:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: meson-gxl: jethub-j80: Fix WiFi MAC unit
 address
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        adeep@lexina.in, khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
References: <20230110215926.1296650-1-martin.blumenstingl@googlemail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110215926.1296650-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 22:59, Martin Blumenstingl wrote:
> Unit addresses should be written using lower-case hex characters. Use
> wifi_mac@c to fix a yaml schema validation error once the eFuse
> dt-bindings have been converted to a yaml schema:
>   efuse: Unevaluated properties are not allowed ('wifi_mac@C' was
>   unexpected)
> 
> Fixes: abfaae24ecf3 ("arm64: dts: meson-gxl: add support for JetHub H1")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> index 6831137c5c10..4f742e1b9301 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> @@ -90,7 +90,7 @@ bt_mac: bt_mac@6 {
>  		reg = <0x6 0x6>;
>  	};
>  
> -	wifi_mac: wifi_mac@C {
> +	wifi_mac: wifi_mac@c {

While fixing the unit address, maybe also fix the node name -
underscores are cause warnings and should be replaced with hyphens.

Best regards,
Krzysztof

