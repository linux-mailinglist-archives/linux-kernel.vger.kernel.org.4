Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8676BC74C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCPHek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCPHeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:34:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450991ADE0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:33:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so3891211edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678952003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvT+O6JyRo0F05dzn7oIrPWKecuQu71C9w69TOt77mA=;
        b=Mt1kfBJc4En2FuXBuXB6yx3GalwXh7DlBBWDt/mTcQY/PgHPrezn151FrdXzFl5cXw
         OAUhnzCjqxfpyTFYlZzXxB9z0C+LZ32uel5w0JYVbuBIGoBtglvyggXMCbdpaTWmX+7S
         9QuEWJsqcBGZTJV1PlhDx8JFuzxY/Cgk7UKUhQ70ozLs+3gfY0BAsOyJHd+K6Y9yirmP
         JJlSxoN6sXHXrQ4N0Ykqeo+7mcLPgQHsr4lLKS/Mifh/T2BIKvfL9Mab3TrGORn4BLRc
         a5EsNInSQxjkNiU0hNTLKo+ZFRVEK08pnh6r1JBlBkgSElqK8gaUQfP4sIJpLXTdhPBd
         Z2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvT+O6JyRo0F05dzn7oIrPWKecuQu71C9w69TOt77mA=;
        b=zPnz71LIXTaXqgfLTx3gH8KRHifo8ioNmNpYrs7ogv1vgRTmuXKQhpRsAPwjq9Hwb/
         DnW7BSColPXFXBD2U0mORcBLP4wy03e646MgTKArPg2tki+UnWTSPLnjXtwZVlc1hAEK
         2kS4YN6GOZqsLOurxRmHXG4jeWiOOHTq5Lyn7km4Wj5cZS/osMzY6SDXeFCqQ36guAon
         heuGj+oLRA42sBvQGOeBlA85Rejxf3haif8u/QhJWT1WAXTTEgB2Vl7bKrrZaedDJqGz
         fecZs0/VFJxWjdDE6KAUd0atevBVSwC3IVa5iBnzRlJpfTiOR3J0qL4DqiUKDHPJgFPz
         6j/A==
X-Gm-Message-State: AO0yUKVOZPZnCCry88jQ1Jqc/qFVArdgqGMaVGq3H0dYVVj0XoXRumdJ
        SWtdd0QHy6rZpC397J7/MoFr9A==
X-Google-Smtp-Source: AK7set+TFVuFkFEpPQr3QyG9IDsqqwpg4uF11Kp4JQI8rPc5seUfifZSwCVWHuk5POr1GcQZQcWfXg==
X-Received: by 2002:a50:ed11:0:b0:4fd:240d:f36e with SMTP id j17-20020a50ed11000000b004fd240df36emr4547426eds.36.1678952003716;
        Thu, 16 Mar 2023 00:33:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id x60-20020a50bac2000000b004fd219242a5sm3456183ede.7.2023.03.16.00.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:33:23 -0700 (PDT)
Message-ID: <f8b323b4-fd07-f5fd-70cf-31450e9ef204@linaro.org>
Date:   Thu, 16 Mar 2023 08:33:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/15] dt-bindings: arm: Add initial bindings for Nuvoton
 platform
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-8-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-8-ychuang570808@gmail.com>
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

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
> Add initial bindings for ma35d1 series development boards.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../devicetree/bindings/arm/nuvoton.yaml      | 30 +++++++++++++++++++

And what is npcm for? Why it was made an directory?

All these should be just one Nuvoton.

>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/nuvoton.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/nuvoton.yaml b/Documentation/devicetree/bindings/arm/nuvoton.yaml
> new file mode 100644
> index 000000000000..f95e7b30711e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/nuvoton.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause


Best regards,
Krzysztof

