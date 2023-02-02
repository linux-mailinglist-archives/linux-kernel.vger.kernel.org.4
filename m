Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E0E687824
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjBBJCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjBBJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:02:47 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318DC5454E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:02:46 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n13so814447wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAzoaco2ejEfJ8IOcFTgCAN7HiD6JKdUffxiXGJRKvQ=;
        b=lDkLv5diE/c9URvqEzqU0QRKqW5UIzto2y7t4n/bhgjkwn9WMjnvUQZx449oqwD5qn
         x96MWCiI8k/DiiCILlGjhpez00P5thhk35xt6FQGh74ib2XY7bYo12+UmjOo1Zyt4Sxb
         5vYwp+JT5V/n6FjeOl7gWS8nx3X+kdIsF6e53O8RjPRX96iR+ftVJcIH80uEXQsk+8+C
         Z90IraukxKaIK4Sg82+hgNLglvoniJZT7VH+FUZxt8SDXDpWkpV6KNJBXyIvYG7VgZ1v
         QissFv0rKZXyAPtSnwy9PWS119huCxMjcF3HXW9JKB7NgxD27WvISTXpafC7XZ6YbRvk
         AYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAzoaco2ejEfJ8IOcFTgCAN7HiD6JKdUffxiXGJRKvQ=;
        b=HAC7HtKRtUwe0SUOwPMK3ijWZ0YWGSJcIlmlgS1UsVamPXvBmMII7ZBkFF22/MUOsA
         Ub2Er6cRoSHTDApS7l9cQZqQBOZa0/8qoddLXhRvUWuDVz2EMZ36PmbrOA9Eks1H5XB9
         WRN5Wz21/RaX7alRhm+DeLc1eRf5DOB7F3TVj8TGkAjlhEOfRA1t5VOyrpoezkC+MgEW
         zy15sklyPdksbGGZmcP3GtEqLhctD+XEM5KKJp3NTbhRmW051iuq6OWk2bB0bRdlHTjG
         1gl3dnrsQdTleVe81MpGpsIWo5nMpnCXtQj0fgvEn9oac9+45fWz93HtRuPt+ZZMa2SX
         6xdw==
X-Gm-Message-State: AO0yUKUVUPk4CqFV47Bf1P/SrwJRo9Lwehqh9/ehBr+IGMKZmY9H+Jgt
        0cdc/OBu29az0nquqztAjDzeYw==
X-Google-Smtp-Source: AK7set9luXTtHtQPjeR6Y3wxBmh7O3wx7Pt57EqX0r7jI3zq/wa0I4gmucrV08A2mLC2lXXAGmct6Q==
X-Received: by 2002:a05:600c:548d:b0:3db:114:a67f with SMTP id iv13-20020a05600c548d00b003db0114a67fmr5047340wmb.17.1675328564733;
        Thu, 02 Feb 2023 01:02:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b002425be3c9e2sm19444201wro.60.2023.02.02.01.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:02:44 -0800 (PST)
Message-ID: <dcf16715-203d-6357-661a-47c007ce11e5@linaro.org>
Date:   Thu, 2 Feb 2023 10:02:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 0/3] Add ASPEED AST2600 I2C new controller driver
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <ac9be40d-bbcb-02b1-2708-61f88095111b@linaro.org>
In-Reply-To: <ac9be40d-bbcb-02b1-2708-61f88095111b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 10:00, Krzysztof Kozlowski wrote:
> On 01/02/2023 11:33, Ryan Chen wrote:
>> This series add AST2600 i2c new register set driver. The i2c new
>> register set have new clock divider option for more flexiable generation.
>> And also have separate i2c master and slave register set for control.
>>
>> v4:
>> -fix i2c-ast2600.c driver buffer mode use single buffer conflit in
>>  master slave mode both enable.
>> -fix kmemleak issue when use dma mode.
>> -fix typo aspeed,i2c-ast2600.yaml compatible is "aspeed,ast2600-i2c"
>> -fix typo aspeed,i2c-ast2600.ymal to aspeed,i2c-ast2600.yaml
>>
> 
> How this can be a v4? Where are all others?
> 
> https://lore.kernel.org/all/?q=dfn%3Aaspeed%2Ci2c-ast2600-global.yaml
> https://lore.kernel.org/all/?q=dfn%3Aaspeed%2Ci2c-ast2600.yaml
> 
> I see it for the first time.

Ah, so v3 was never sent to DT maintainers:
https://lore.kernel.org/all/20220516064900.30517-3-ryan_chen@aspeedtech.com/

Best regards,
Krzysztof

