Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7126AA08C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjCCUYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjCCUYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:24:12 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8025B93
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:24:11 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f13so15024485edz.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677875050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqd8PwlTbEQKoNiEpIhG5Ylf8nKCyupIVw/XZ5IGPp4=;
        b=za2BwLgVxpkqQE8FBQBtGfnUZ25CtnmbKb6pbS7Sqlw0R8Zxn/D4QC+1znyAMPjuV5
         NF8jvaR05jMI/U/5S6VNZiteblOhOUa6b6Pc80cP13zxmi8uZs6FGvmpeWq5fD+eRwEK
         9X/SAjvfOv7B5WiCcUpzobdRULAzu/2cwvZEpPKZoeGbtqy6waNixOQSmxJH8aY6aD5k
         linsBPhQxsDFKDNhHYqaIbWFY3L2DsewULcqzO85AgMqvN4ZXLpK4znB2UaAAwspRIfa
         NFsJ0fpwx/zQBI33IHvtpP76mHmSzc8P+ud7jWP2pfb7ng2gMAB4+QqL2AEB1O+9NGuh
         txYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqd8PwlTbEQKoNiEpIhG5Ylf8nKCyupIVw/XZ5IGPp4=;
        b=Ah9OsrJBwX7yB94RCQWlbsP4IjfjmgALjgHhAp5SLYU145ByvFS90pFd4bWMqEFztm
         N159UlBxe867JWVgUDqHg3AOgXZF5758mfaAHx4NRN5RGFHxv+IMj9ufUUSmfqGVz/cS
         akXK40ficz1uIqu1cuMblHjb5kaJKkBIbTHfY1cvOQrXXel5frFj2tGlcWXFeje19rb2
         1ArMcr4ZzhKO2SkGvLhcTT3sMCh6CQIm/gp/niQDYFW25HLb/fWvD9pQxYME26wIvrmB
         BrlcsS+jL/ltIvOlpsPR1UYaVDoD/yNenQGvJ+UDfiu40ExWQbV7pf+gha42zppDAt6s
         g5AA==
X-Gm-Message-State: AO0yUKVX3TS4zBnHWlT7M+VioiIwUai07ppcxF6gEFt4OKFOXW8zQWqM
        TMI5vcwK7ZbRR6IcYvlwXLVawA==
X-Google-Smtp-Source: AK7set+frnak4WVkx20nM70PS3iNSTl4awD0Cm7PWZ0fZE3WE2MNDFNQAbCnqUZCjrUapcB1jZemhg==
X-Received: by 2002:aa7:cd73:0:b0:4c0:6511:dd61 with SMTP id ca19-20020aa7cd73000000b004c06511dd61mr3345998edb.37.1677875049854;
        Fri, 03 Mar 2023 12:24:09 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:3321:2e91:9111:67ba? ([2a02:810d:15c0:828:3321:2e91:9111:67ba])
        by smtp.gmail.com with ESMTPSA id a2-20020a509b42000000b004c30e2fc6e5sm1553516edj.65.2023.03.03.12.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:24:09 -0800 (PST)
Message-ID: <a05155ca-8781-f9ce-63d3-4090c492e61a@linaro.org>
Date:   Fri, 3 Mar 2023 21:24:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/5] clk: hisilicon: Rename some symbols for Hi3798CV200
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230303151417.104321-1-mmyangfl@gmail.com>
 <20230303151417.104321-4-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303151417.104321-4-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 16:14, David Yang wrote:
> These symbols might cause confusion when adding support for other Hi3798
> series SoCs.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/clk/hisilicon/crg-hi3798.c      | 41 ++++++++++++-------------
>  include/dt-bindings/clock/histb-clock.h |  2 ++

Bindings do not go together with code. Split and use proper subject prefix.

>  2 files changed, 22 insertions(+), 21 deletions(-)
> 


Best regards,
Krzysztof

