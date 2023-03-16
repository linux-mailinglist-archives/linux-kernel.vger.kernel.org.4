Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C2A6BC733
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjCPHcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCPHb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:31:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8C592269
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:31:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z21so3909998edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678951881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTN4NQIpgf6Jo4A0NXWAfIF91xzXZgRPNSS4md24FW0=;
        b=X+oF+NdHrjW5uD+dWshdnvV0Ne2tdgtau6d0xBcVIhBHGrjHts6x4Hvnk3xcgSfXTg
         jV4HaisLX05403mnWt2CAauf4/jKUqrpR58NI5rh44X44yyaVuSyBqeUe5CMFBXUU7lr
         2FSoH+WCMBwqBsyemdjT0wd92iuT9Xx1V8C9VaXTk0PZ8MEREbNjY8Bhflu9HssbFd7p
         U+mmpWd4WDZy0DxqM75Dhx2biWk/hLX1w7JhKDjDcxuaOQt3gXH4qBNrrWpujfduvdA+
         cKNPg6TjflhXXXtAub+6NpgISkIKGnydB5tuEy6XJQ4jr56kJcnNROH2ardgvV11lqUg
         2VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678951881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTN4NQIpgf6Jo4A0NXWAfIF91xzXZgRPNSS4md24FW0=;
        b=dPezP8i6+xS2SOck1gVZ1FnU53YVHeeNlEjFQrWvZCWnPAxlaVt9taSKTM65j9O9fU
         jkhMOyEHLJnb+SVkXy956X3QG+52OXfZxEfNHgDe6h7qguDfK8Los3r6oJLoMNJbct3w
         cBXajkRM/ERb8uv1QD5Scf7dwn9TvqHgruOOLdr447/KtYywvacQQuI4nHi/t6Ps3vXe
         te6yJnIf6IbEoJnV0Op1c4wDXF9rTVWbq9SFzI9DUh7LuQud1Wz6ndDtIOxm9E6amSUc
         uZf86NzSt3m+ins5Tea6bq0sKhe8JYY9m4kxfxibIhqh3XPCtRD2bzPYyaRMGSSy+n7a
         0VCQ==
X-Gm-Message-State: AO0yUKWOjWhN6LitvlMKu/Rgdvui3RV/10jnVinuS39TgK/zYGbmx1og
        1LacNYgRBZvrirgV/yhw2+T+jQ==
X-Google-Smtp-Source: AK7set9Vll/1hWCnpy2kN28EzqYQCfxTZ16YJguyUR4L1xna9EKBlT1lB2S0T72JA+zzB4HVy2wR4Q==
X-Received: by 2002:a17:906:f2d7:b0:889:ed81:dff7 with SMTP id gz23-20020a170906f2d700b00889ed81dff7mr8798260ejb.9.1678951881596;
        Thu, 16 Mar 2023 00:31:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id lz3-20020a170906fb0300b008f767c69421sm3493125ejb.44.2023.03.16.00.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:31:21 -0700 (PDT)
Message-ID: <a64bbd77-cd5c-8149-51e6-262122fe954e@linaro.org>
Date:   Thu, 16 Mar 2023 08:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/15] dt-bindings: clock: nuvoton: add binding for ma35d1
 clock controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-5-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-5-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
> between the clock controller and clock references in the dts.

I don't see the device binding. They come together.

> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 ++++++++++++++++++
>  1 file changed, 253 insertions(+)
>  create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> 
> diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> new file mode 100644
> index 000000000000..6c569fdd6e06
> --- /dev/null
> +++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> @@ -0,0 +1,253 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license.

Best regards,
Krzysztof

