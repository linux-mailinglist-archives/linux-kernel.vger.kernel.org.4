Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE229727779
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjFHGkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjFHGkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:40:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6609F26AA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:40:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977d7bdde43so64928466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686206407; x=1688798407;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVRZfjPusUlMd2YSAWkUFw8x4CXFJxYh+aCGHiCjN5A=;
        b=xqI+reGDDN9cNUgG8bBTYU3s/nwG1PuvXOzHTpns4U2llK/sWtFsXu4o2iTRqW4nko
         2cdhmsc4/LtNfg3u/NU3tA7N3vf3bh8GCoYVjdffQjmRW4hV5zq41p2HxgflyOADfA5H
         ndTJJnG1CHYwzWyDHOG3XSqa0VoUJYcOls4so/APVmpetMjI5U1Sc+iAd9HK14dtEMZF
         4JcJy4NSNowUarzzT65nN0OytYabtvVXzMcvm5WKRYrR9iV+zJomX4j9SQ20L0d0l+07
         Sk1hhQslbx6Bpfd62KwUXXE7GSNs6cBTl38hGJJXWtJy+mRXCImcErhmqxG3SIwESpee
         uMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206407; x=1688798407;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVRZfjPusUlMd2YSAWkUFw8x4CXFJxYh+aCGHiCjN5A=;
        b=E5yikjaKPnN/KmiDJmxhrAWlMs/D2WbzI8a0JYcJMIk/socXotgaQc08HfZjY3J8jR
         bJsdLynsdypwYZWYcnlW6/myK8FAnNUL3zNh+PDLfNj9KaKMgXYMc//ChYzL3PsZwCyM
         4qTdHPb4/8zJMTu66hkreAX/X2Jhd11PryVyTVnTo8c34nvazNxKSz+nBL8g5ZXnR8Ey
         Ql2XpEGp67ivUqmyRZfjqPlISN2pdHVSGk2jm4Uvq2vu3kI0gy3npcod11IKm+zDWeX1
         4GCRmer5K37WA0Fg7TvySoJ+YbQiyYZzE7cqNbhiNnqsuAazAkKmqRXOr99/TQFsuXCk
         fM7w==
X-Gm-Message-State: AC+VfDwytxlFMTB5g6U4rER7lSAcWB1S7NcC/X9BW8zkFjqGXzuZiepo
        OOxN0Og2ZtDm0ZKliIm9Aw2aNw==
X-Google-Smtp-Source: ACHHUZ7Y49qxpbARq0/PESo5rGH/0TBRzIPZEdIk349An/yWXAvAuSNvyKVBJn4VTWgCDaiQFX9UyA==
X-Received: by 2002:a17:907:9404:b0:977:e8ca:ab34 with SMTP id dk4-20020a170907940400b00977e8caab34mr1008654ejc.22.1686206406850;
        Wed, 07 Jun 2023 23:40:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906249a00b009662c57b4ffsm273586ejb.96.2023.06.07.23.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 23:40:06 -0700 (PDT)
Message-ID: <becd5ac7-a9ea-c63e-5716-316a8e705104@linaro.org>
Date:   Thu, 8 Jun 2023 08:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        corbet@lwn.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-3-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608021839.12769-3-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 04:18, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-tach device.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..627aa00f2e92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed Tach controller can support upto 1 fan input.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1

NAK, not true based on previous discussions. Device does not come with
resets and clocks.


Best regards,
Krzysztof

