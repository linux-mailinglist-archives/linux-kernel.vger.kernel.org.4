Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2C64D5D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 05:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLOE0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 23:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOE0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 23:26:45 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 469E323156;
        Wed, 14 Dec 2022 20:26:44 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Dec 2022 13:26:42 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B1CA02059054;
        Thu, 15 Dec 2022 13:26:42 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 15 Dec 2022 13:26:42 +0900
Received: from [10.212.156.43] (unknown [10.212.156.43])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 031C9196B;
        Thu, 15 Dec 2022 13:26:41 +0900 (JST)
Message-ID: <2af8adc0-5733-4e0b-83f3-6954ca31c062@socionext.com>
Date:   Thu, 15 Dec 2022 13:26:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 03/17] dt-bindings: pinctrl: Fix node descriptions in
 uniphier-pinctrl example
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-4-hayashi.kunihiko@socionext.com>
 <13944337-facd-a12a-818f-b54c17cbf5ee@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <13944337-facd-a12a-818f-b54c17cbf5ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/13 23:52, Krzysztof Kozlowski wrote:
> On 13/12/2022 09:24, Kunihiko Hayashi wrote:
>> Drop parent node of the pinctrl as it is not directly necessary, and
>> add more examples, that is "groups", "function", and a child node to set
>> pin attributes, to express this pinctrl node in detail.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../pinctrl/socionext,uniphier-pinctrl.yaml     | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
>> b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
>> index 14a8c0215cc6..bc34e2c872bc 100644
>> ---
>> a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
>> +++
>> b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +
> 
> Drop this part, no blank lines between SPDX and YAML.

Thank you for checking.
I carelessly added a blank line. I'll remove it.

Thank you,

---
Best Regards
Kunihiko Hayashi
