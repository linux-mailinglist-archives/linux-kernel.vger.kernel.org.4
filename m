Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF0564D5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 05:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiLOE06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 23:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLOE0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 23:26:49 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D2A72E69F;
        Wed, 14 Dec 2022 20:26:48 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Dec 2022 13:26:47 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id D70682059054;
        Thu, 15 Dec 2022 13:26:47 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 15 Dec 2022 13:26:47 +0900
Received: from [10.212.156.43] (unknown [10.212.156.43])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 4DF98196B;
        Thu, 15 Dec 2022 13:26:47 +0900 (JST)
Message-ID: <9f8ea56b-21e0-0fa7-d38b-b187125d58d6@socionext.com>
Date:   Thu, 15 Dec 2022 13:26:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 06/17] dt-bindings: thermal: Fix node descriptions in
 uniphier-thermal example
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-7-hayashi.kunihiko@socionext.com>
 <6a434a50-886d-cab1-2f65-7df3e7386472@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <6a434a50-886d-cab1-2f65-7df3e7386472@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/13 23:54, Krzysztof Kozlowski wrote:
> On 13/12/2022 09:24, Kunihiko Hayashi wrote:
>> Prior to adding dt-bindings for SoC-dependent controllers, rename the
>> thermal node and its parent node to the generic names in the example.
>>
>> And drop a parent node of the thermal-sensor  as it is not directly
> 
> Drop double space in "thermal-sensor  as" above

I'll fix it.

> With this:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thank you,

---
Best Regards
Kunihiko Hayashi
