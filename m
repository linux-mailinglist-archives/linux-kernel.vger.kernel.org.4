Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBCC69F2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjBVKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBVKvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:51:19 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4C3A38654;
        Wed, 22 Feb 2023 02:51:17 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Feb 2023 19:51:17 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 208AA2058B4F;
        Wed, 22 Feb 2023 19:51:17 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 22 Feb 2023 19:51:17 +0900
Received: from [10.212.156.137] (unknown [10.212.156.137])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 3FFB3A6B9C;
        Wed, 22 Feb 2023 19:51:16 +0900 (JST)
Message-ID: <3786ea07-b1fe-8aff-c17e-a4cb9427344e@socionext.com>
Date:   Wed, 22 Feb 2023 19:51:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] dt-bindings: ata: Add UniPhier controller binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220054711.4584-1-hayashi.kunihiko@socionext.com>
 <8a4042fd-02a3-261e-4126-7a3090850fda@linaro.org>
 <7e19d3f4-a3bc-dc9d-35a0-9bfc05f22b2c@socionext.com>
 <5f2bebad-5c9d-41bd-63c1-043f1d8c6c16@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <5f2bebad-5c9d-41bd-63c1-043f1d8c6c16@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/22 17:38, Krzysztof Kozlowski wrote:
> On 22/02/2023 02:03, Kunihiko Hayashi wrote:
>>>> -  resets:
>>>> -    maxItems: 1
>>>
>>> Why moving it?
>>
>> Sorry for my mistake. I should fix it.
>>
>>>> +allOf:
>>>
>>> This goes to the same place as in example-schema.
>>
>> I can see "allOf" next to "required" in example-schema,
> 
> Are you agreeing or disagreeing here (thus I should explain that it's
> not the same place)? If the first, sometimes it's enough to say "ack" or
> "sure".

Sure. I'll move it in v4.

Thank you,
---
Best Regards
Kunihiko Hayashi
