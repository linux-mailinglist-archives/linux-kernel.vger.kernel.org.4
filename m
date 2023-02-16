Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D257698ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBPIis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBPIip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:38:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA74883E7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:38:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id dz21so1655617edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6uhhPMnk5tW+I7axF/xp2194BIT+Ni9bQQoOVB8Q2k=;
        b=tdjaFmK69i3vrH5icnfybzD4qKi4lwWd8tUb/IEaSMXSylVW8YfeiMuuJ70j/Hkkxk
         KFLZMm6L7UBHRS59b2I+in7CcNFbE/YhDGo5OMASUEZ+yVoUf97jHSqkmKS3kPoGCIXJ
         Fd8vcqjoriC0hOLwnnt/7fvhIt9tVlzE1OF7nAu45XTBLFVLtmteLHfa4yF5EsiuWiMB
         NcF9VOytK4mR9Bydc3e6IbOvWPjNUQK9pklwCsFY85skEHzZED4n78RZi03zn+1xYPml
         ZlVqggM6NO+Q83ySlkjrRwzacgqUvl1b193UbBlfy3uFJo99s9OV2tjyZkRIXhNlOsDm
         Ushw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6uhhPMnk5tW+I7axF/xp2194BIT+Ni9bQQoOVB8Q2k=;
        b=zyCcukXwuTyPO2D93oBX+HQwS8l7Tukmyv+6aRx9LDoBcG80rIQoTiO4ymISEL+mrt
         XmVPcaiyDztYxbb6JLfaSrZgGH7k906BMosTTEgEHxU+3H5aCf18rr5yW/dg2slWs/ps
         FA9zjhLk8EUPKxL3zZSa8morZRZGWpFdhT0LfDTA7y1zlC6mRviMB/nXHgyF0v09YydK
         o1/1edigXT432GdLbNdWx9vytnRUx0pPFi/ReHi0HaDcbt7n/S5KUpghVVVWwIghabgF
         Dt0zHzFS8hKG27U79MrZHvuoVulJIMlcPO5gETsS/hfhLthqzHbfIKGf5X5dytNAjjVC
         r3cg==
X-Gm-Message-State: AO0yUKV+X9cCMl/9SXlR0BpKuuUM9K/Jw2ea1Rh5fPV9bRCaUE0g6Q7x
        4WDwLieHTgCjNPkFyqsI5Y2d9w==
X-Google-Smtp-Source: AK7set8rS5weYiUSTsAm8dci9nN8p9H70SprTzEbU1eg/Z2jw8gh1OWSRR4tgGMJ1xPeclU6/ljGMA==
X-Received: by 2002:a05:6402:31e1:b0:47e:eaae:9a69 with SMTP id dy1-20020a05640231e100b0047eeaae9a69mr5292392edb.41.1676536722170;
        Thu, 16 Feb 2023 00:38:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k26-20020a50ce5a000000b004a2470f920esm491185edj.25.2023.02.16.00.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 00:38:41 -0800 (PST)
Message-ID: <19c21e4b-7ea1-aae3-9f94-bbc108a402db@linaro.org>
Date:   Thu, 16 Feb 2023 09:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/5] dt-bindings: hwlock: sun6i: Add a64 compatible
 string
Content-Language: en-US
To:     Bastian Germann <bage@debian.org>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20230215203711.6293-1-bage@debian.org>
 <20230215203711.6293-5-bage@debian.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230215203711.6293-5-bage@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 21:37, Bastian Germann wrote:
> Add an allwinner,sun50i-a64-hwspinlock compatible string to the device
> tree binding. The A31 and A64 have compatible hwspinlocks.
> 
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> index 6cdfe22deb3c..281c285282a1 100644
> --- a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> +++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> @@ -15,7 +15,9 @@ description:
>  
>  properties:
>    compatible:
> -    const: allwinner,sun6i-a31-hwspinlock
> +    items:
> +      - const: allwinner,sun6i-a31-hwspinlock
> +      - const: allwinner,sun50i-a64-hwspinlock

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

That's my template answer. More detailed:

Please test that your DTS changes always pass your binding changes. The
above looks reversed with your DTS, thus if you tested DTS, you would
see errors. Expecting that existing in-kernel DTS passes dtbs_check is a
bit too much (although Samsung Exynos is almost there!), but at least
new code could not introduce new errors.

Best regards,
Krzysztof

