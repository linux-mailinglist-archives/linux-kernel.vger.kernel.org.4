Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCE06907B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBILry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBILrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:47:25 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18E1B631C9;
        Thu,  9 Feb 2023 03:34:44 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Feb 2023 20:34:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 286522058B4F;
        Thu,  9 Feb 2023 20:34:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 9 Feb 2023 20:34:30 +0900
Received: from [10.212.157.203] (unknown [10.212.157.203])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 557923D57;
        Thu,  9 Feb 2023 20:34:03 +0900 (JST)
Message-ID: <8d80a837-b2bd-26af-e633-5b6081caaaef@socionext.com>
Date:   Thu, 9 Feb 2023 20:34:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: mmc: Add resets property to cadence SDHCI
 binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230209014211.17816-1-hayashi.kunihiko@socionext.com>
 <ec412378-ae31-e199-b5a1-f37a4731f31a@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <ec412378-ae31-e199-b5a1-f37a4731f31a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2023/02/09 18:14, Krzysztof Kozlowski wrote:
> On 09/02/2023 02:42, Kunihiko Hayashi wrote:
>> Cadence SDHCI controller allows reset control support on UniPhier SoC.
>> Add resets property to cadence SDHCI binding.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> index d3dce4d6c168..adacd0535c14 100644
>> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> @@ -29,6 +29,9 @@ properties:
>>     clocks:
>>       maxItems: 1
>>
>> +  resets:
>> +    maxItems: 1
> 
> This looks specific to UniPhier, doesn't it?

I think this IP has some hardware reset lines, however,
it depends on the implementation whether the lines can be
soft controlled or controlled by power-on-reset.

In case of UniPhier SoC, these lines are connected to the syscon
reset controller, but deasserted with initial state.

Currently, the binding has one compatible.
If drawing this dependency, Is the device dependent compatible necessary?
Or I can remove reset property from DT.

Thank you,

---
Best Regards
Kunihiko Hayashi
