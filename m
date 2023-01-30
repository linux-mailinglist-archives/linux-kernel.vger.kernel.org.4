Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47B5680A48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbjA3KBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjA3KBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:01:03 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D251A4B6;
        Mon, 30 Jan 2023 02:00:00 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 30 Jan
 2023 17:59:34 +0800
Message-ID: <37e5d1a9-9379-a7ff-e288-9a4b80a0cc5f@amlogic.com>
Date:   Mon, 30 Jan 2023 17:59:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V6 3/3] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "kelvin . zhang" <Kelvin.Zhang@amlogic.com>,
        "qi . duan" <qi.duan@amlogic.com>
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-4-yu.tu@amlogic.com>
 <1ja62eybrv.fsf@starbuckisacylon.baylibre.com>
 <aedb0764-b5cb-7f49-f279-51dbec070e80@amlogic.com>
 <1jwn5hwn0w.fsf@starbuckisacylon.baylibre.com>
 <a4ad6ac6-60c2-8f7b-fdb0-509de31db282@amlogic.com>
 <1jy1pko0fc.fsf@starbuckisacylon.baylibre.com>
 <e2e9045a-6e35-112f-69a7-15b080571b69@amlogic.com>
 <1jr0vcnyf7.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jr0vcnyf7.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/30 17:47, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Mon 30 Jan 2023 at 17:41, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> On 2023/1/30 17:06, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Sat 28 Jan 2023 at 18:17, Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>>> On 2023/1/20 17:47, Jerome Brunet wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>>> On Fri 20 Jan 2023 at 11:33, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>>
>>>>>> Hi
>>>>>> On 2023/1/19 19:37, Jerome Brunet wrote:
>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>> On Mon 16 Jan 2023 at 15:42, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>>>>
>>>>>>>> Add the peripherals clock controller driver in the s4 SoC family.
>>>>>>>>
>>>>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>>>> [...]
>>>>>>>
>>>>>>>> +
>>>>>>>> +/* Video Clocks */
>>>>>>>> +static struct clk_regmap s4_vid_pll_div = {
>>>>>>>> +	.data = &(struct meson_vid_pll_div_data){
>>>>>>>> +		.val = {
>>>>>>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>>>>>>> +			.shift   = 0,
>>>>>>>> +			.width   = 15,
>>>>>>>> +		},
>>>>>>>> +		.sel = {
>>>>>>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>>>>>>> +			.shift   = 16,
>>>>>>>> +			.width   = 2,
>>>>>>>> +		},
>>>>>>>> +	},
>>>>>>>> +	.hw.init = &(struct clk_init_data) {
>>>>>>>> +		.name = "vid_pll_div",
>>>>>>>> +		/*
>>>>>>>> +		 * The frequency division from the hdmi_pll clock to the vid_pll_div
>>>>>>>> +		 * clock is the default value of this register. When designing the
>>>>>>>> +		 * video module of the chip, a default value that can meet the
>>>>>>>> +		 * requirements of the video module will be solidified according
>>>>>>>> +		 * to the usage requirements of the chip, so as to facilitate chip
>>>>>>>> +		 * simulation. So this is ro_ops.
>>>>>>>> +		 * It is important to note that this clock is not used on this
>>>>>>>> +		 * chip and is described only for the integrity of the clock tree.
>>>>>>>> +		 */
>>>>>>> If it is reset value and will be applicable to all the design, regarless
>>>>>>> of the use-case, then yes RO ops is OK
>>>>>>>
>>>>>>> >From what I understand here, the value will depend on the use-case requirements.
>>>>>>> This is a typical case where the DT prop "assigned-rate" should be used, not RO ops.
>>>>>>
>>>>>> Check the previous chip history, the actual scene is not used at all,
>>>>>> basically is used in simulation. So the previous SOC was "ro_ops" without
>>>>>> any problems.  This S4 SOC is not actually useful either.
>>>>>>
>>>>>> So when you were upstream, you had no problem making "ro_ops". I wonder if
>>>>>> I could delete this useless clock, so you don't have to worry about it.
>>>>> I don't know what to make of this. What is the point of adding a useless
>>>>> clock ?
>>>>
>>>> As explained earlier this "vid_pll_div" is actually used in chip
>>>> emulation. So next I'd like to know what you suggest to do with the clock?
>>>>
>>> If it does not exist in the actual SoC, please remove it
>>>
>>
>> If I remove it, the "vid_pll_sel" clock will be missing a parent
>> (vid_pll_div). I will use the table method and give the above reasons. Do
>> you accept this method?
> 
> Either the clock exists or it does not.
> 
> If the HW actually exist, it is expected to be properly described.
> If it does not, it obviously cannot be an input to another clock.
> 
> Please sort this out and make the necessary changes.
> 

The CLKCTRL_VID_PLL_CLK_DIV register is actually described, but it is 
not used in the actual board. According to your reply just now, 
description is required, but I want to know how to describe it to meet 
your requirements.

Please give me some suggestions.
