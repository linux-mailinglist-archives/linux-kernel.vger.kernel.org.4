Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16DB6BBA16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjCOQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjCOQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:43:32 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A26382ABB;
        Wed, 15 Mar 2023 09:42:32 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 4308641853;
        Wed, 15 Mar 2023 21:41:38 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678898498; bh=4rN3OclD+DIXhDrK5IXWGA7Kf0vsIK1+LnpasFhlIbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mn+pvXoA1bVcdM8vUn8Y+TPOFfmmZGesXLCu00LWlgdu4yiDIio2gbmhr/S/Sf/bz
         0iN5SObu/nZDCkbuhfHmaCmkrx+JMnqYUqJ7xanctm7tVBmkXxpgzojMT//Xvg055d
         3UUu5ZeTrTV7SB1MiPmbc2SMLwuHyac71UTecn4eGQIOPZNbfS20nYYzNdAdgOksQL
         HkoU7aHT07QrzVVlPxt5+Mf2qe1Iribi7u53Jg2vgTPTm6nnlfIkjX4N8dAifAl5oY
         uSTtP5HuLiaZOOh/rqLJPDF/TPCQGCCeK2lizkg++9dls8lXZfYOea6wvT2AMD+d6y
         L4FTYTVaAlbyg==
MIME-Version: 1.0
Date:   Wed, 15 Mar 2023 21:41:37 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add Acer Aspire 1
In-Reply-To: <b8805711-d720-8f91-c198-10b0553417a4@linaro.org>
References: <20230315154311.37299-1-nikita@trvn.ru>
 <20230315154311.37299-5-nikita@trvn.ru>
 <b8805711-d720-8f91-c198-10b0553417a4@linaro.org>
Message-ID: <e901b4f51d258a505b771b1acec6bc64@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 15.03.2023 21:09:
> On 15/03/2023 16:43, Nikita Travkin wrote:
>> Acer Aspire 1 is a WoA laptop based on Snapdragon 7c gen1 platform.
>>
>> The laptop design is similar to trogdor in the choice of primary
>> components but the specifics on usage of those differ slightly.
>>
>> Add the devicetree for the laptop with support for most of the
>> hardware present.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>> Changed in v2:
>>  - Various styling, ordering and node naming issues fixed. (Krzysztof)
>>
>> Changed in v3:
>>  - Kepp camcc on, wakeup on touchpad, minor style issues. (Konrad)
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>  .../boot/dts/qcom/sc7180-acer-aspire1.dts     | 859 ++++++++++++++++++
>>  2 files changed, 860 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 89e23a74bc7f..4bd4b4079b17 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-acer-aspire1.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>> new file mode 100644
>> index 000000000000..b4161f1f21a7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>> @@ -0,0 +1,859 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +
>> +#include "sc7180.dtsi"
>> +
>> +#include "pm6150.dtsi"
>> +#include "pm6150l.dtsi"
>> +
>> +/delete-node/ &tz_mem;
>> +/delete-node/ &ipa_fw_mem;
>> +
>> +/ {
>> +	model = "Acer Aspire 1";
>> +	compatible = "acer,aspire1", "qcom,sc7180";
>> +	chassis-type = "laptop";
>> +
>> +	aliases {
>> +		bluetooth0 = &bluetooth;
>> +		hsuart0 = &uart3;
>> +		serial0 = &uart8;
>> +		wifi0 = &wifi;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	reserved-memory {
> 
> I still don't think it is ordered by name.... "r" is definitely after "a".

Yes, as I said before, I want to separate the "special" DT spec nodes
(aliases, chosen, reserved-memory, ... that are defined in the
chapter 3 of the DT spec) from the other, device nodes.

I see them on the top on many other boards and I believe this separation
makes sense since those are not really devices but "more extended"
properties of the board as a whole.

If you still believe those must be mixed together and sorted, please 
explicitly let me know that and I will change the order.

Also, if there is any documentation that already enforces the order,
making clear that my opinion is wrong, I would appreciate you pointing
me to that.

Regards,
Nikita

> 
> Best regards,
> Krzysztof
