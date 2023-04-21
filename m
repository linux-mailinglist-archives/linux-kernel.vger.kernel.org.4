Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D296EA770
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjDUJpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjDUJoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E3BB452;
        Fri, 21 Apr 2023 02:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F64264F6F;
        Fri, 21 Apr 2023 09:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AC0C433EF;
        Fri, 21 Apr 2023 09:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682070259;
        bh=RJvg9Cl+YFqg0zLVP3PJyan3HevOBCGTOaODk9YxFk8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=OtIYL1ILsEvQ3ssJ4FjPRxbk066rNrrUEGHT+eLqNPBLc9399cehsK1f2f61cNI5d
         YMei8zmjkJRUOJQDpHqc8T09JGpgkDxY6fN1A0DjFlo6qrzQGuwrKKwx9sPD30XpLz
         q+s7AEKx3l99uQ0EP+0uuBlAphXlrXVGtGDtqZn0mqvl/cNG6teVP87j/cXGVG7twf
         gANGOiu3hegwUPNZUX7M8h1iZ345ji+Jtd6BH02abOD4qZ67zBBvgpXHe0YSNFMxz/
         prvNWQbg6ImzXCOyEEhXktg1B/DgtR2a2wjOQ9287bffv+6PlD81L+jf9c7S1ASARq
         lC26afFLKIyAQ==
Message-ID: <288d8b93-8dfc-2aa2-4c36-49a2612820fd@kernel.org>
Date:   Fri, 21 Apr 2023 11:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/7] ARM: dts: s5pv210: Adjust I2S entries to match spec
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <CY4PR04MB056784D54ADDBB4F57F82D4ACB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <4ebe2bb9-4f92-2dff-6737-d057e5950b24@kernel.org>
 <f44c9881-6f7b-f4f5-8225-e0c74c83fab1@kernel.org>
 <CY4PR04MB05677B21384FCE2013EB1B94CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <414f1ad8-8ee1-9913-c0e8-b4f66f3e7180@kernel.org>
In-Reply-To: <414f1ad8-8ee1-9913-c0e8-b4f66f3e7180@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 12:49, Krzysztof Kozlowski wrote:
> On 23/03/2022 18:24, Jonathan Bakker wrote:
>> Hi Krzysztof,
>>
>> On 2022-03-23 8:15 a.m., Krzysztof Kozlowski wrote:
>>> On 23/03/2022 16:14, Krzysztof Kozlowski wrote:
>>>> On 23/03/2022 16:03, Jonathan Bakker wrote:
>>>>> Based on the device tree spec, clocks should be ordered tx/rx.
>>>>> Re-order from rx/tx to avoid warnings when running make dtbs_check
>>>>>
>>>>> Additionally, the number of #sound-dai-cells should be 1, not 0
>>>>>
>>>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>>>> ---
>>>>>  arch/arm/boot/dts/s5pv210-aries.dtsi |  2 +-
>>>>>  arch/arm/boot/dts/s5pv210.dtsi       | 18 +++++++++---------
>>>>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>>> index 70ff56daf4cb..503b5a50ef1a 100644
>>>>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>>> @@ -644,7 +644,7 @@
>>>>>  };
>>>>>  
>>>>>  &i2s0 {
>>>>> -	dmas = <&pdma0 9>, <&pdma0 10>, <&pdma0 11>;
>>>>> +	dmas = <&pdma0 10>, <&pdma0 9>, <&pdma0 11>;
>>>>>  	status = "okay";
>>>>
>>>> Except that fix that's the same commit as here:
>>>> https://lore.kernel.org/all/20200907161141.31034-26-krzk@kernel.org/
>>>> so just extend it.
>>>>
>>>> sound-dai-cells should go to a separate commit. But are you sure they
>>>> are correct? The Fascinate 4G seems to be using them as cells=0.
>>>
>>> See my previous patch and discussion:
>>> https://lore.kernel.org/all/20200907161141.31034-10-krzk@kernel.org/
>>>
>>
>> Thanks, I'd totally forgotten about this series from the past.  I'll re-test
>> those commits and submit your copies of them in v2 if that's OK with you and
>> that they're confirmed functional?
> 
> My dma fixes change lacked this aries fix. The sound-dai-cells needed
> more rethinking.
> 

Hi Jonathan,

Any plans for checking/fixing/testing and resending the sound-dai-cells
fixes?

Best regards,
Krzysztof

