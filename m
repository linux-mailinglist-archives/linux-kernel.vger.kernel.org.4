Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B7E715DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjE3Lnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjE3LnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:43:14 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77159131;
        Tue, 30 May 2023 04:42:54 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D075F8479B;
        Tue, 30 May 2023 13:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685446971;
        bh=fPulCLOn1mDw2aXbZrWUn9R4dyD+ptp9MMeZ6zuSx4s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fQOI2qQIliHlw5IBVoVQPjBW8dfbxdCD/zknMLgW+WX7i+RCMkehb3tGYYhLracTA
         K+6OsEGYkX9yTYUvqZUinTcRc0x3wEvAaj7H85kchvnCMpMT+Pp8kiHDPTcDnbm6zE
         XHHSpPvPSDfZOEBiW0alPBrw3x79efxt8g/XZE/E/EWAXgV9JqJ9M3sUV0YhqEnUKk
         HfrlFCdHX5aFDd9deniXm6paoU0ZYl4u/RPoq4e8T86i6djNn2l2joyJKkZDjZQpXA
         rvPZlWqmBJOffSxwjn85DrPymQUktn/6q1c8zNyOjGF+zydZRe/9bW4/whGaccCfTT
         wSN0fBx1Oz8JA==
Message-ID: <974c3ce3-5081-67d0-ae80-444e99e437e5@denx.de>
Date:   Tue, 30 May 2023 13:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/8] ARM: dts: stm32: adopt generic iio bindings for adc
 channels on dhcor-drc
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
 <20230524133918.1439516-8-olivier.moysan@foss.st.com>
 <cc7a0a1a-31bb-92f4-6365-5e0c4a4bc85c@denx.de>
 <5bb496d0-6dc1-6ba3-6126-6429037ecf5a@foss.st.com>
 <8a4f3112-54ed-e0c1-52ee-395a41255163@foss.st.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <8a4f3112-54ed-e0c1-52ee-395a41255163@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 09:59, Alexandre TORGUE wrote:
> Marek, Olivier
> 
> On 5/24/23 17:39, Olivier MOYSAN wrote:
>> Hi Marek,
>>
>> On 5/24/23 15:54, Marek Vasut wrote:
>>> On 5/24/23 15:39, Olivier Moysan wrote:
>>>> Use STM32 ADC generic bindings instead of legacy bindings on
>>>> DHCOR DRC Compact board.
>>>>
>>>> The STM32 ADC specific binding to declare channels has been deprecated,
>>>> hence adopt the generic IIO channels bindings, instead.
>>>> The STM32MP151 device tree now exposes internal channels using the
>>>> generic binding. This makes the change mandatory here to avoid a mixed
>>>> use of legacy and generic binding, which is not supported by the 
>>>> driver.
>>>>
>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>> ---
>>>>   .../dts/stm32mp15xx-dhcor-drc-compact.dtsi    | 28 
>>>> ++++++++++++++++---
>>>>   1 file changed, 24 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi 
>>>> b/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
>>>> index 39af79dc654c..92d906bfd5d7 100644
>>>> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
>>>> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
>>>> @@ -57,15 +57,35 @@ &adc {    /* X11 ADC inputs */
>>>>       status = "okay";
>>>>       adc1: adc@0 {
>>>
>>>
>>> I sent similar patch recently too:
>>>
>>> [PATCH] ARM: dts: stm32: Update to generic ADC channel binding on 
>>> DHSOM systems
>>>
>>> But I needed to add #address-cells/#size-cells here and to adc@100, 
>>> otherwise DTB checker was complaining . Did you run DTB check and was 
>>> it OK on your side ?
>>
>> The first patch in this serie adds the #address-cells/#size-cells to 
>> the   SoC DT. So, there is no need to add them later in the board DT.
>>
>> I can send a v2 with your patch (after removing the cells properties 
>> from the patch). Having all the patches in the same serie, will help 
>> avoiding sequencing problems.
>>
>> Do you agree with this ?
> 
> What is the status of this patch ?
> 
> Marek, I would prefer to take all ADC updates in this series if you agree.

I missed the reply from Olivier, sorry. Please pick the whole thing.
