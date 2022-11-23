Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5129F636572
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiKWQKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiKWQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:10:05 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5343668C76;
        Wed, 23 Nov 2022 08:10:00 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Nov 2022 01:10:00 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id F34592059054;
        Thu, 24 Nov 2022 01:09:59 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 24 Nov 2022 01:09:59 +0900
Received: from [10.212.158.163] (unknown [10.212.158.163])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6D262A8557;
        Thu, 24 Nov 2022 01:09:59 +0900 (JST)
Message-ID: <53680a59-ff01-bc50-ee28-ba0aaff41f3c@socionext.com>
Date:   Thu, 24 Nov 2022 01:09:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add Socionext F_OSPI controller
 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221121014800.13989-1-hayashi.kunihiko@socionext.com>
 <20221121014800.13989-2-hayashi.kunihiko@socionext.com>
 <579f9320-f114-2977-bb70-d5a26a3d2279@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <579f9320-f114-2977-bb70-d5a26a3d2279@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for reviewing.

On 2022/11/23 18:33, Krzysztof Kozlowski wrote:
> On 21/11/2022 02:47, Kunihiko Hayashi wrote:
>> Add devicetree binding documentation for Socionext F_OSPI SPI flash
>> controller.
> 
> Subject: drop second, redundant "bindings".

Ah, ok. I didn't notice it. I'll remove it in next.

>> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/spi/socionext,f-ospi.yaml        | 57 +++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
>> b/Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
>> new file mode 100644
>> index 000000000000..e04492c4fc84
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
>> @@ -0,0 +1,57 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/spi/socionext,f-ospi.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> Drop quotes from both lines.

I see. I'll keep it in mind.

>> +
>> +title: Socionext F_OSPI controller
>> +
>> +description: |
>> +  The Socionext F_OSPI is a controller used to interface with flash
>> +  memories using the SPI communication interface.
>> +
>> +maintainers:
>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +
>> +allOf:
>> +  - $ref: "spi-controller.yaml#"
> 
> Drop quotes.

Ditto.

> With above:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I'll fix the above in v3.

Thank you,

---
Best Regards
Kunihiko Hayashi
