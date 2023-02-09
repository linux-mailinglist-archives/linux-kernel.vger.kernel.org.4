Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB28690789
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjBILb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjBILba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:31:30 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E14D60310;
        Thu,  9 Feb 2023 03:22:34 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Feb 2023 20:19:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 212DA2012096;
        Thu,  9 Feb 2023 20:19:37 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 9 Feb 2023 20:20:04 +0900
Received: from [10.212.157.203] (unknown [10.212.157.203])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5FE213D57;
        Thu,  9 Feb 2023 20:19:36 +0900 (JST)
Message-ID: <ba1a26c9-c5bd-ba50-b7b2-eea002f71d6f@socionext.com>
Date:   Thu, 9 Feb 2023 20:19:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: ata: Add UniPhier controller binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230209014052.17654-1-hayashi.kunihiko@socionext.com>
 <cbf10de1-ba6a-8e5a-6222-25f2322995c9@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <cbf10de1-ba6a-8e5a-6222-25f2322995c9@linaro.org>
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

Thank you for reviewing.

On 2023/02/09 17:51, Krzysztof Kozlowski wrote:
> On 09/02/2023 02:40, Kunihiko Hayashi wrote:
>> Add UniPhier SATA controller compatible string to the platform binding.
>> This controller needs two reset controls.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   Documentation/devicetree/bindings/ata/ahci-platform.yaml | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> index 7dc2a2e8f598..3f6b21032d02 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> @@ -45,6 +45,9 @@ properties:
>>                 - marvell,armada-8k-ahci
>>                 - marvell,berlin2-ahci
>>                 - marvell,berlin2q-ahci
>> +              - socionext,uniphier-pro4-ahci
>> +              - socionext,uniphier-pxs2-ahci
>> +              - socionext,uniphier-pxs3-ahci
>>             - const: generic-ahci
>>         - enum:
>>             - cavium,octeon-7130-ahci
>> @@ -74,7 +77,8 @@ properties:
>>       maxItems: 1
>>
>>     resets:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
> 
> You now allow two resets for each other platform, which is not justified
> in commit msg. Constrain it per device/compatible.

Ah I see.
I'll add if-then clause to constrain compatible instead of changing that
directly.

Thank you,

---
Best Regards
Kunihiko Hayashi
