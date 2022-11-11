Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F396255B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiKKItN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiKKItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:49:08 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84473742C1;
        Fri, 11 Nov 2022 00:49:07 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Nov 2022 17:49:06 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id D87142059027;
        Fri, 11 Nov 2022 17:49:06 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Nov 2022 17:49:06 +0900
Received: from [10.212.156.100] (unknown [10.212.156.100])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 2CBFFB62AE;
        Fri, 11 Nov 2022 17:49:06 +0900 (JST)
Message-ID: <f1c8a87c-b084-5496-d3e1-2c524e83e2a3@socionext.com>
Date:   Fri, 11 Nov 2022 17:49:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: uniphier: Add system controller
 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
 <20221107103410.3443-2-hayashi.kunihiko@socionext.com>
 <48988a50-3c3d-7a85-af28-66f7842e5893@linaro.org>
 <3fcebf71-bdcb-8592-020c-4aa240a9e9a7@socionext.com>
 <784c5975-661a-c71c-1489-229ada0a4e72@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <784c5975-661a-c71c-1489-229ada0a4e72@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/09 0:08, Krzysztof Kozlowski wrote:
> On 08/11/2022 15:30, Kunihiko Hayashi wrote:
>>>> +additionalProperties:
>>>> +  type: object
>>>
>>> No, instead you should describe the children. This must me
>>> additionalProperties: false
>>
>> Each controller has different children, so need to define children
>> for each controller using "if".
> 
> Then you should have different binding documents. Bindings should be
> specific.

I see. I'll separate this document into the specific documents.

Thank you,

---
Best Regards
Kunihiko Hayashi
