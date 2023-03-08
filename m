Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD5C6B01A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCHIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCHIiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:38:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A1B5BA0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:37:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k10so38640618edk.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678264662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/WzsZEhRWqesaA/VgihYCVlcuAuHDDmWjDn5s627q8=;
        b=hkLM635i6PbEzvxaklVMhvnoyMxzoamNwWrBl9HRjPD1ixywfwQssDR/Fq0d56W/J5
         ysP6gO+qTrOiwQltIacANsamOhN3sRFf3w8GIODKbgkNCQl/Aeok84B2diwhk00a+7bN
         4vMszuLBYpz/SHYSsU9Ej3PLkKVv/nBZ2eBO15DxYaqo85ExNyFLZ9gpq3si3LieIXNt
         7u2EeAKi52aDAte2DNGjPxVVSfWl4pj110+AbjWI9LDbgpi3mqKDeNDU2FK5778CaOIq
         eCSRiw+F+hUfqJ06K8iSV9YyZHnkuQoGpmpPe5+sqJWuKyf0Fe3uXb2Dv7yCKud7duQL
         bdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/WzsZEhRWqesaA/VgihYCVlcuAuHDDmWjDn5s627q8=;
        b=MSIWbvgvpF63m/jJ8bnyT20EIz/bKbqSl8rzbh/vTX3/ObMsTZkk3ePpMcXXzG7CYH
         NvBwAW+7PcrDynZqBiJgqKf/CH5wcqbP+VPW1roA00WNRK2lu9+ysFDIy0VfmEd0ZieQ
         8s8UuAa5hJNF1I//93bF2+MC/0CMasQ/bpdA68S11E+wn3ol4wv6MwTjynMquNjXlCh8
         PzNuZ2boyW+ImV/QwH/BuiAhcXD4LT8KlJ2QKGGlwoPdAZdQFp2BTH8wWsWsnhLMaLjR
         MKMWCtQGGbWQqe4Hyz7Gm7t98eLJSuFM45TQXeQGk/glsa2f83LY3b6PXKMy985XvC+l
         Z5vQ==
X-Gm-Message-State: AO0yUKUIjMR023Wvy5bz3Ifp2QddNKScC7emX0gN8MmB0KbSnFITpPZj
        k1Ph7i67lk4W0tXyENOUjykOeQ==
X-Google-Smtp-Source: AK7set8FU50SUCDPOEAD3jF8EdZXMqpxg583cG8nktaaEmYKPV8Cb4xBm2pZXn2RjynHCuDiBRcqiQ==
X-Received: by 2002:aa7:cfc2:0:b0:4bf:f9f4:9b1e with SMTP id r2-20020aa7cfc2000000b004bff9f49b1emr15578064edy.4.1678264662068;
        Wed, 08 Mar 2023 00:37:42 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:bba:fbfa:8aec:a133? ([2a02:810d:15c0:828:bba:fbfa:8aec:a133])
        by smtp.gmail.com with ESMTPSA id 20-20020a508e54000000b004d8d2735251sm5795219edx.43.2023.03.08.00.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 00:37:41 -0800 (PST)
Message-ID: <31e2a67a-c046-9501-80de-e754ed450195@linaro.org>
Date:   Wed, 8 Mar 2023 09:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v13 1/2] dt-bindings: clock: add loongson-2 boot clock
 index
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230307115022.12846-1-zhuyinbo@loongson.cn>
 <692a62da-a9a1-fa23-6e24-723d73c3a423@linaro.org>
 <5e9b3bd5-d885-6237-5e14-2becb3c956cc@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5e9b3bd5-d885-6237-5e14-2becb3c956cc@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 02:35, zhuyinbo wrote:
> 
> 在 2023/3/7 下午8:47, Krzysztof Kozlowski 写道:
>> On 07/03/2023 12:50, Yinbo Zhu wrote:
>>> The Loongson-2 boot clock was used to spi and lio peripheral and
>>> this patch was to add boot clock index number.
>>>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> ---
>> This is v13? Where is the changelog then?
> 
> in fact, this is a new patch(v1),   but another clock driver patch in 
> this series had send as v13 and need depend on
> 
> this patch so set current patch as v13.

This should be explained in changelog.

> 
>>
>>
>>>   include/dt-bindings/clock/loongson,ls2k-clk.h | 25 ++++++++++---------
>>>   1 file changed, 13 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/dt-bindings/clock/loongson,ls2k-clk.h b/include/dt-bindings/clock/loongson,ls2k-clk.h
>>> index db1e27e792ff1..e86804365e506 100644
>>> --- a/include/dt-bindings/clock/loongson,ls2k-clk.h
>>> +++ b/include/dt-bindings/clock/loongson,ls2k-clk.h
>>> @@ -13,17 +13,18 @@
>>>   #define LOONGSON2_DC_PLL				3
>>>   #define LOONGSON2_PIX0_PLL				4
>>>   #define LOONGSON2_PIX1_PLL				5
>>> -#define LOONGSON2_NODE_CLK				6
>>> -#define LOONGSON2_HDA_CLK				7
>>> -#define LOONGSON2_GPU_CLK				8
>>> -#define LOONGSON2_DDR_CLK				9
>>> -#define LOONGSON2_GMAC_CLK				10
>>> -#define LOONGSON2_DC_CLK				11
>>> -#define LOONGSON2_APB_CLK				12
>>> -#define LOONGSON2_USB_CLK				13
>>> -#define LOONGSON2_SATA_CLK				14
>>> -#define LOONGSON2_PIX0_CLK				15
>>> -#define LOONGSON2_PIX1_CLK				16
>>> -#define LOONGSON2_CLK_END				17
>>> +#define LOONGSON2_BOOT_CLK				6
>> That's an ABI break and commit msg does not explain it.
> you meaning is that need add a explanation in commit msg that why

You need good explanation to break the ABI. I don't understand the
commit msg, but anyway I could not find there justification for ABI
break. If you do not have good justification, don't break the ABI,



Best regards,
Krzysztof

