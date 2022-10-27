Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D696F61040F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiJ0VLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbiJ0VLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:11:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E4727CCC;
        Thu, 27 Oct 2022 14:07:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29RL7FoY029726;
        Thu, 27 Oct 2022 16:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666904835;
        bh=GLCwhrH7P9GnX6pP57UFeRv4PvNoKDR2Duko3cA8iBg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NfbCkeguhYq4U6KJaoKEiLWUDDo5KMhVSGC2vOt4jhl5b0d8khwBed0x+35e7V3u1
         ibhBdbA+F03F0LP82Nd4mqWycSfMsEieh0uEQ5yor+7T2jTSk2HqQk+ZjKlEqjvPjE
         0PLtoiZgH00V3GJUxfCvecw2hd8yBZefG8l39Zzo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29RL7Fjr002219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Oct 2022 16:07:15 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 27
 Oct 2022 16:07:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 27 Oct 2022 16:07:15 -0500
Received: from [10.250.35.234] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29RL7EDS090916;
        Thu, 27 Oct 2022 16:07:14 -0500
Message-ID: <a4688f2d-0a0f-dffc-92cc-4fa50938d0d8@ti.com>
Date:   Thu, 27 Oct 2022 16:07:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/9] ARM: dts: nspire: Use syscon-reboot to handle
 restart
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221027181337.8651-1-afd@ti.com>
 <20221027181337.8651-3-afd@ti.com>
 <050f3d65-5720-9c97-1930-bc458c4c2fb8@linaro.org>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <050f3d65-5720-9c97-1930-bc458c4c2fb8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 2:33 PM, Krzysztof Kozlowski wrote:
> On 27/10/2022 14:13, Andrew Davis wrote:
>> Writing this bit can be handled by the syscon-reboot driver.
>> Add this node to DT.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Tested-by: Fabian Vogt <fabian@ritter-vogt.de>
>> Reviewed-by: Fabian Vogt <fabian@ritter-vogt.de>
>> ---
>>   arch/arm/boot/dts/nspire.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
>> index bb240e6a3a6f..48fbc9d533c3 100644
>> --- a/arch/arm/boot/dts/nspire.dtsi
>> +++ b/arch/arm/boot/dts/nspire.dtsi
>> @@ -172,7 +172,14 @@ rtc: rtc@90090000 {
>>   			};
>>   
>>   			misc: misc@900a0000 {
>> +				compatible = "ti,nspire-misc", "syscon", "simple-mfd";
> 
> You have syscon and simple-mfd, but bindings in patch #1 say only syscon.
> 

I'm not following, are you just saying my wording in the patch message just
wasn't complete?

Or are you saying something more about nodes that are both syscon and simple-mfd?
In that case, having both syscon and simple-mfd seems rather common, looks like
you added the rule for it[0].

Thinking on this, they almost represent the same thing. simple-mfd says "my child
nodes should be considered devices", why do we need that? Couldn't we simply state
that "syscon" node's children are always devices, I mean what else could they be,
syscon is an MFD after all (and lives in drivers/mfd/).

"syscon" often just says, others can use the registers within this node, so as a
different option, make "syscon" a property of "simple-mfd" nodes. I'm seeing all
these examples of devices that should have been children of the "syscon" device,
but instead use

regmap = <&x>;
syscon = <&x>;

or similar and put the device node out somewhere random. And in those cases,
wouldn't it have been more correct to use the normal "reg" and "regions" to
define the registers belonging to the child node/device?..

Thanks,
Andrew

[0] https://lore.kernel.org/all/20220817142246.828762-5-krzysztof.kozlowski@linaro.org/

> 
> Best regards,
> Krzysztof
> 
