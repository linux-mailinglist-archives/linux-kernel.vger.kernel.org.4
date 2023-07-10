Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8820374D446
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGJLJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjGJLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:09:14 -0400
X-Greylist: delayed 804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 04:09:09 PDT
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF6DD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:09:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=CR46z7G4pA2j7R2rcjI+mkhCZYT1XWYJGu1dQEzzmhgtUNbvWyaYNp872JW/90qIoFMq2FVaCS6EqRUCixG6EjivzZZg0/Ye7/6lTbDGjJ5eyUD9krSWI+6LouQg0kBcXTH6Bk4oPLVmuOibVMQrFAN7HqvK4q2nFYIzk7X4iI7/22SxRhmewhyb4MbkNJSSJnlSyXTEfsb0avRfLpkhiSf4fcL0gJxd6h5318mWTeOphgQy+ncB1OZFO5Jn51To8PMKRpFQ40ScrhyulVXnLf+cheCdYsuCbBfafqDMkQdyC+ZOk674oOoezz9D7KzLAb2m3FyuRkLFSPRvuAO81A==; s=purelymail1; d=iskren.info; v=1; bh=lV9ppPsaEOEUAnUrflv2EQZQzeibRC/rcgeYGnMmG3E=; h=Received:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=sQP16rDNnb/IEgmYI3OUskIyrc79nOrvoGvb7vdLe0Pzx2xit27ukgMVj1r9rX6nWpmI4tnz+SMTzL14Zg0RFhNXk9tTfEoP40HUvObGdvg/G30fwjAmQwjyC6du/5G/N8AdSSvibB48/mIbX075QUUnlTEPkCGOIsvpd8vMpKxJWXciV1tBS755N52Iwa5xP6qt0Pr7CMDDxnXcSMVTv99ZkPSRc2OKqQ2I025hFJFDOIOk3lSeMAt1Oal1yjI43rozpUFC+FXKDLgkeMLCxp965Mx5PhaRCqwa6t96ogVqDAYjQnZ65KtvBw6Mi9pvo6HLxmTzFGB7sg1kldEd9Q==; s=purelymail1; d=purelymail.com; v=1; bh=lV9ppPsaEOEUAnUrflv2EQZQzeibRC/rcgeYGnMmG3E=; h=Feedback-ID:Received:Subject:To:From;
Feedback-ID: 10275:2339:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1418986860;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 10 Jul 2023 10:55:13 +0000 (UTC)
Message-ID: <5dbd78ee-6726-650f-31d4-526382001e68@iskren.info>
Date:   Mon, 10 Jul 2023 13:55:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: leds: Convert Panasonic AN30259A to DT
 schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Simon Shields <simon@lineageos.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniele Debernardi <drebrez@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20230707210653.868907-1-robh@kernel.org>
 <361a4706-6a64-9322-3210-d9cd45827a2a@linaro.org>
From:   Iskren Chernev <me@iskren.info>
In-Reply-To: <361a4706-6a64-9322-3210-d9cd45827a2a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 12:13, Krzysztof Kozlowski wrote:
> On 07/07/2023 23:06, Rob Herring wrote:
>> Convert the Panasonic AN30259A 3-channel LED controller binding to DT
>> schema format.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
>>  .../bindings/leds/leds-an30259a.txt           | 55 ------------
>>  .../bindings/leds/panasonic,an30259a.yaml     | 84 +++++++++++++++++++
> 
> ...
> 
>> diff --git a/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml b/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml
>> new file mode 100644
>> index 000000000000..f55f8c232bc6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/leds/panasonic,an30259a.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Panasonic AN30259A 3-channel LED controller
>> +
>> +maintainers:
>> +  - Simon Shields <simon@lineageos.org>
> 
> Device is used in qcom-msm8974pro-samsung-klte.dts, so maybe its main
> authors would maintain this binding?
> 
> Iskren Chernev <me@iskren.info>

I'll be happy to be listed as a maintainer of that binding.

> Daniele Debernardi <drebrez@gmail.com>
> 
> 
> Best regards,
> Krzysztof
> 
