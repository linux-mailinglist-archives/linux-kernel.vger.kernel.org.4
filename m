Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7F734010
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjFQKM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjFQKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:12:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7A31BF0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 03:12:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977d7bdde43so336189466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686996740; x=1689588740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TgP7Xo0/BI+q/hHqVMJMUYkrnaQIXgCa1ZtLOmCe39I=;
        b=WY/Al9fg2u/uL7+ehIIXuN3VmIYDiGimoYGFQeZU7j8AvPZCB+bcbRw/+WqHtBruYr
         ETErEbysbq115pvxQot3y8VruE74oD1UwQMYIRagJLyOxXLehg4EwLAlNRfH0kRRSkDz
         wSLNCUUueHDn9G0f2kA7bNDD86wzffQKqbq5sO3Ow2jlbhRsG0hn646D5aEmZre6NfVe
         s4SOKzNa4tdpcPXF8+sMQGyOQSUfUytKGY9n8FPEaGDgKgEeSfm5ddwC9IlXMquMhlL1
         84g4IDdebc+bMhNpNSMw1kE0850ioi+5VEaN9QcNCz4LhNBPQ2QCw83m1zPCHLrb82xI
         JWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686996740; x=1689588740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgP7Xo0/BI+q/hHqVMJMUYkrnaQIXgCa1ZtLOmCe39I=;
        b=NeBnq71aQ1qN4kuNVDfs2eXrkkg4lz/MivuGmbOSzTB7wa9ySZ9G+oK2iAHD89G8oX
         vzm4CLoOJyrunlIM4F4VvZAHAP2e8/n3unNCAW7o9Igf/+OPaoFh8elJ+DnrsUvm1PN5
         f3L4lU2DfNCQofPzceLYlAlW8dbNdVqctw52ZE/3JpqJkqVDCrXtStq4TDrUil7P5EF6
         J3s+x3MG1jbs4vnLWdbwb5OiJhbxxl63Ucfg+zP2tsWGzIW3h1CZtVcLldGmA7GKDV1I
         lefBLuDDiEJjZ7gsq20inNiSy4I2JNQMC5PA2Y7u2tzqPOEsjwRiWOrTrwXGKDhjVpo+
         k9Ag==
X-Gm-Message-State: AC+VfDzyEU898/+95GnG9w7S7z/xXIZ4+2KZDuxMUUE8LjmoXppKAab0
        oK8wxrNS8Nq5qlIjhq498c+/Ng==
X-Google-Smtp-Source: ACHHUZ6Yrsd8H0C60FMXwj8vhCdlHIXessbhg49bscbUVgRS9oFYMYBeaKA0rC+pw4cm1EFHhY8Ygg==
X-Received: by 2002:a17:907:d26:b0:977:d468:827 with SMTP id gn38-20020a1709070d2600b00977d4680827mr4767373ejc.17.1686996739862;
        Sat, 17 Jun 2023 03:12:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i24-20020a170906115800b0098642e99c26sm1980189eja.174.2023.06.17.03.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 03:12:19 -0700 (PDT)
Message-ID: <17576d81-a342-0b77-367a-eb9f2b97b734@linaro.org>
Date:   Sat, 17 Jun 2023 12:12:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] dt-bindings: backlight: lm3630a: add entries to
 control boost frequency
Content-Language: en-US
To:     Maximilian Weigand <mweigand2017@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Maximilian Weigand <mweigand@mweigand.net>
References: <20230602-lm3630a_boost_frequency-v1-0-076472036d1a@mweigand.net>
 <20230602-lm3630a_boost_frequency-v1-2-076472036d1a@mweigand.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230602-lm3630a_boost_frequency-v1-2-076472036d1a@mweigand.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 21:08, Maximilian Weigand wrote:
> From: Maximilian Weigand <mweigand@mweigand.net>
> 
> Add 'ti,boost_use_1mhz' to switch between 500 kHz and 1 MHz boost
> converter switching frequency, and add 'ti,boost_frequency_shift' to
> activate a frequency shift to 560 kHz or 1.12 MHz, respectively.
> 
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> ---
>  .../bindings/leds/backlight/lm3630a-backlight.yaml           | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> index 3c9b4054ed9a..ef7ea0ad2d25 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -33,6 +33,18 @@ properties:
>      description: GPIO to use to enable/disable the backlight (HWEN pin).
>      maxItems: 1
>  
> +  ti,boost_use_1mhz:

No underscores in property names.

> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      If present, change the boost converter switching frequency from the
> +      default 500 kHz to 1 MHz. Refer to data sheet for hardware requirements.
> +    type: boolean
> +
> +  ti,boost_frequency_shift:
> +    description: |
> +      If present, change boost converter switching frequency from 500 kHz to
> +      560 kHz or from 1 Mhz to 1.12 Mhz, respectively.

So just make it a property choosing the frequency, not bools, with
proper unit suffix.


Best regards,
Krzysztof

