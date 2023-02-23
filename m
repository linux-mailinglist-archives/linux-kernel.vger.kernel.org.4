Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328EB6A0696
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjBWKuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjBWKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:50:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8C5A385
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:50:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eg37so36737814edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z75r85big+eTd7SRoWbxuz/3yfeOTQT/y0Ym6DgGu6w=;
        b=rE/2OkqvCwxyCrT6NCJvh2WIYWp+IXAmQY2UTjjskIKGmA0znZKG80kgHmhHqTtvI6
         AhJz+lss6gIGXrujccakHc21UYX/7/LQ7o0YFXzXIxc5f1zN7mT27teP5DYoBUxZK/qS
         xEnQ211/cjV8sVDNvqDUHSNxb/LKReSxH/YQBz44SLejD7UgEdYNnBu6yYoPyxZZnINX
         ZB+PJa9KDAR5L4yTfqXCmF9L0dfARlKed4+I6FQOebUX1bFqfwpoy6mTbhmKEG47AYOq
         i1wvEGzfuj02Ud/Jmn2UP4mETBR4l2oO5oEi5oRsUmyd4EKFvuirxIhvgZvcb0t7xMeN
         i8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z75r85big+eTd7SRoWbxuz/3yfeOTQT/y0Ym6DgGu6w=;
        b=xXeBrX3kvqTwemzNbsLGg94uqGynISGVHIuabH+6cvBmq6i02zddo8RH4M7WdQF8aQ
         FrbJJptNn/UszTskyZhpTa7OExsUBtxdgcQozHIeVujTpGsunegJ19rEBfk5o/GxmDFi
         YXn/dT7GzD0pP7a88MZuxuue7LHs2pEj1PFlcM6uXjmaJDQ2x5V9vy3woNS8LPkFNsbu
         5oLFgqpk8BlaX2EonVpFGrzXncGSAXNasFkwsNCc9B4JIhV//aW3QIIUV1BaPjg3lGru
         WilYer/XfMrwxWsqt1s2j8q0Wv8pE6NN5kx5W+eBGP/fnZgF8TTKPqCnugEqEPMETVEq
         9Frg==
X-Gm-Message-State: AO0yUKVoLfIgn/+H/uZcWDCt5fbNjsmXBy/lDDHN7hAwUo6vtvsDvue6
        UEY1j4U/S6HKE8o7PmabcLkwkg==
X-Google-Smtp-Source: AK7set/k5hZw1d2ceZ8JOQNHJ+gRiUWYvfMbLQkZ6RwkAayL/fmZHc8zui1veDRs4fnRcE5qLNYftg==
X-Received: by 2002:a17:906:e24b:b0:8ae:11ca:81de with SMTP id gq11-20020a170906e24b00b008ae11ca81demr16293867ejb.34.1677149439941;
        Thu, 23 Feb 2023 02:50:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id zc18-20020a170906989200b008cae50b0115sm5811726ejb.87.2023.02.23.02.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:50:39 -0800 (PST)
Message-ID: <e6d97e34-0c63-019d-93b6-c39e722d1d8c@linaro.org>
Date:   Thu, 23 Feb 2023 11:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm: Drop CONFIG_MTD_M25P80 in various defconfig files
Content-Language: en-US
To:     Bin Meng <bmeng@tinylab.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     andrew <andrew@lunn.ch>, agross <agross@kernel.org>,
        arnd <arnd@arndb.de>, andersson <andersson@kernel.org>,
        "chuck.lever" <chuck.lever@oracle.com>,
        dinguyen <dinguyen@kernel.org>, festevam <festevam@gmail.com>,
        "gregory.clement" <gregory.clement@bootlin.com>,
        "jernej.skrabec" <jernej.skrabec@gmail.com>,
        "konrad.dybcio" <konrad.dybcio@linaro.org>,
        linux-imx <linux-imx@nxp.com>,
        "neil.armstrong" <neil.armstrong@linaro.org>,
        kernel <kernel@pengutronix.de>, elliott <elliott@hpe.com>,
        linux <linux@armlinux.org.uk>,
        "s.hauer" <s.hauer@pengutronix.de>,
        "sebastian.hesselbarth" <sebastian.hesselbarth@gmail.com>,
        shawnguo <shawnguo@kernel.org>,
        newbie13xd <newbie13xd@gmail.com>,
        "sudeep.holla" <sudeep.holla@arm.com>, ziy <ziy@nvidia.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20230210093224.689990-1-bmeng@tinylab.org>
 <em4fed7efe-b8aa-4a34-86d4-655b0a96fec0@1adcb789.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <em4fed7efe-b8aa-4a34-86d4-655b0a96fec0@1adcb789.com>
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

On 23/02/2023 11:46, Bin Meng wrote:
> On 2023/2/10 17:32:24, "Bin Meng" <bmeng@tinylab.org> wrote:
> 
>> Drop CONFIG_MTD_M25P80 that was removed in
>> commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
>>
>> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>>
>> ---
>>
>>  arch/arm/configs/axm55xx_defconfig     | 2 +-
>>  arch/arm/configs/davinci_all_defconfig | 1 -
>>  arch/arm/configs/dove_defconfig        | 1 -
>>  arch/arm/configs/keystone_defconfig    | 1 -
>>  arch/arm/configs/mvebu_v5_defconfig    | 1 -
>>  arch/arm/configs/mxs_defconfig         | 1 -
>>  arch/arm/configs/pxa_defconfig         | 1 -
>>  arch/arm/configs/qcom_defconfig        | 1 -
>>  arch/arm/configs/socfpga_defconfig     | 1 -
>>  9 files changed, 1 insertion(+), 9 deletions(-)
>>
>>
> 
> Ping?

No need for pinging, but you need to send to soc folks. Otherwise no one
will pick it up. You will get the address from get_maintainer.pl -f
arch/arm/boot/dts/Makefile (yes, it is quite hidden on purpose).

Best regards,
Krzysztof

