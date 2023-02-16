Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A381698E49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBPII6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPII4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:08:56 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5CB2366B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:08:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id fi26so1627514edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFWHYzQ47F08kHCRk+CWBqg2wpk6kOfepSZvlMuKJME=;
        b=WX0oYy9lfCJIEjq74PrXD62FgtWfmHosGgxgT0UvwifnLXr3CW1TkRnoxk/o5qk3wR
         jU/NNzBineBSw4YQ6E2XenNOHtdolgpARYITqqgwalb1OA6ujxwRmpiYnS3+XYFSuJJ2
         OXY55ZyRLd41mTUQwpUS4PE6I5+MugD6zD+jALbWdneUmVB4Rj/MbA+jciXJx42HMzvP
         xFtknXmuqnwLHp/Wbr1RHpyMpt3HO3kJZnZS21oBkhujmpcBsfmViwscIF654Z2ebVYS
         1VESqkMorWS7ui9XysezRNwTgrjH6c+Jk7m8lgBsn9K/I+PwgPEUAm2bHMV9K3Fc0Iqn
         obAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFWHYzQ47F08kHCRk+CWBqg2wpk6kOfepSZvlMuKJME=;
        b=kM/48gY8XGQ4VJ23QiQuvzbblqwuayMGNY1J8I1TyP+7qgJsuUpBEmUXCNslXF+0yE
         yTaFp6vvI43rpMNaBmU4nOCGL9zz2uTepW2xrEgO5/OsIksb9mMtaB254bbdawBijlHj
         nEO4P0h90EmT/zqN2XSIs1G9ROv5B+X426pUeRUwx8olWcWyEdIn2L4g1oZ6AXxHptOW
         YIYT7S5AN6/ulbyI6BeOomXp9flyWDYwFQx9I1zamWriHCuqylsTcJeBm55v+Zq+4My4
         0M1W1lbDoSxw7cFknSp2ubloKjFQoz0pWsWBMmIHdEnSpZUTRyABz85LY0DPWvVkBXjx
         SubQ==
X-Gm-Message-State: AO0yUKUdog7vQ+ecVgIB8JAOnRFxT2zj2eA+qDnN9BvwiA8QFMoFlC08
        CukZb8M5257BHHS02kHbLlCQjA==
X-Google-Smtp-Source: AK7set8I2bHOqG2L4ep05Jnc+APlOvu9ihdXtivHE3MB/bdMnlmw01tngILrwwV+YpsHBAbsDyW1PQ==
X-Received: by 2002:a05:6402:1f04:b0:4ad:66e8:ca9a with SMTP id b4-20020a0564021f0400b004ad66e8ca9amr109314edb.6.1676534933708;
        Thu, 16 Feb 2023 00:08:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709064a9600b007bff9fb211fsm470600eju.57.2023.02.16.00.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 00:08:53 -0800 (PST)
Message-ID: <198c084e-66ff-1f3d-33cb-a1339b34336c@linaro.org>
Date:   Thu, 16 Feb 2023 09:08:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
Content-Language: en-US
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
 <b0f55494-3a17-4d87-7b8f-5b078503cb53@linaro.org>
 <SEZPR06MB52690A1D06F3CFEAAF1FDBDEF2A39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <a62fb259-3ad3-b75e-c59e-2ce937bf799a@linux.microsoft.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a62fb259-3ad3-b75e-c59e-2ce937bf799a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 05:17, Dhananjay Phadke wrote:
> Hi Ryan,
> 
> On 2/14/2023 9:43 PM, Ryan Chen wrote:
>> It is not duplicated, as my description in cover " This series add AST2600 i2c new register set driver"
>> So, this will be different driver compatible.
>> The original compatible is
>>        - aspeed,ast2400-i2c-bus
>>        - aspeed,ast2500-i2c-bus
>>        - aspeed,ast2600-i2c-bus
>> So the new register set compatible is "- aspeed,ast2600-i2c", remove "bus".
> 
> Is it possible to keep existing driver drivers/i2c/busses/i2c-aspeed.c
> for ast2400/ast2500, while move ast2600 support to new driver
> altogether, say i2c-ast2600.c along with new register mode? By default
> new driver can support legacy mode with same compatible "aspeed,ast2600-
> i2c-bus", additionally driven by dt props, switch to new mode.

So this is for the same hardware? Then the bindings are duplicated.
Driver is actually duplicated as well - rework the old one, instead of
adding this.

Best regards,
Krzysztof

