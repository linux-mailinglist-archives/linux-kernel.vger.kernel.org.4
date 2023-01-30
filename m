Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3385A6809E7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjA3JvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbjA3Ju5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:50:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB223326
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:50:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so8285633wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Tpw0PlvU/+G3/AbOY+LmAHVcN3lWBOIxI7cN0V/UDVA=;
        b=h82BWsutbbUIKXsH/3YncLuOYd3bwt2KXgv++28nnYdCR1GbVtpJvLkis3WXCtMYTU
         CV+8xGJhqF9RgN6pcbWClcovF3FZs0V7mqNwt4hM44hRnXzMxynPA1fjKFKnf8h52qOX
         6HPu2AAMnUBRJW34NGWiPJHI9xvgqU9eoC8yuIhB88HUO/iheNMHTFVLWvoNKg8X9lKc
         oFH1VAjUkm6VLV0FJpAkeFFauhnesHzbUPHcT8B6xU2gsaqKMZqi1nMEHlQlDlni+M6y
         wOWlmK6w2Xyjj72ILxbvo8luR4yw4LgFoZ7pjwUyogOu/MFseX4yhoRcY7+wNP1zyAEj
         y7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpw0PlvU/+G3/AbOY+LmAHVcN3lWBOIxI7cN0V/UDVA=;
        b=pSjB7UWwcWbvo4ExV1x6EmQ0Zj9j+CykdhZDYOfU6xm7exSPTUm6982wMDKkcy8UEY
         HFK0DtPw74qjoO3vk3LmqEZb7oSnH2J+Vjn3uC8iNMrBXKW3cWsr4V1XXmlGv+pyvK4D
         Ei+1t5R8FZyQ/G/+veFk/n9Ls2e2hJaIdVyAozPvYQQ37MW7LpvaVYHvnMz2Zm/kGpCT
         FeqbHehUZusFp8V8tuKE2O3vNzxRAPL753ldNbdIwFOKg+q65VyUZtFcb8Fy+8Sbw33R
         dogUA+NMOrN+vpar6bYfwQAr7FXC1XFk2toClHwxGdzVfEliDGNTrXadJPLYhSIRsvVg
         jiIQ==
X-Gm-Message-State: AFqh2krI5NRtM0O73cgYhep2EVczTTuJaqXLj8W5NsMLYjgoNARDhJDq
        BqNofaoo++LnOSep5kyjsc1xaA==
X-Google-Smtp-Source: AMrXdXty/CzopwFwFNA46HfW4nEHg4fXkhUd7YpiCqaPcpsB4N8Ar9Le/a46P2MQpwUdKi9Uo2zL1Q==
X-Received: by 2002:a7b:cc07:0:b0:3da:fcb7:39e5 with SMTP id f7-20020a7bcc07000000b003dafcb739e5mr47379046wmh.23.1675072253184;
        Mon, 30 Jan 2023 01:50:53 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c028200b003dc4baaedd3sm6725641wmk.37.2023.01.30.01.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:50:52 -0800 (PST)
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-4-yu.tu@amlogic.com>
 <1ja62eybrv.fsf@starbuckisacylon.baylibre.com>
 <aedb0764-b5cb-7f49-f279-51dbec070e80@amlogic.com>
 <1jwn5hwn0w.fsf@starbuckisacylon.baylibre.com>
 <a4ad6ac6-60c2-8f7b-fdb0-509de31db282@amlogic.com>
 <1jy1pko0fc.fsf@starbuckisacylon.baylibre.com>
 <e2e9045a-6e35-112f-69a7-15b080571b69@amlogic.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "kelvin . zhang" <Kelvin.Zhang@amlogic.com>,
        "qi . duan" <qi.duan@amlogic.com>
Subject: Re: [PATCH V6 3/3] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
Date:   Mon, 30 Jan 2023 10:47:04 +0100
In-reply-to: <e2e9045a-6e35-112f-69a7-15b080571b69@amlogic.com>
Message-ID: <1jr0vcnyf7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 30 Jan 2023 at 17:41, Yu Tu <yu.tu@amlogic.com> wrote:

> On 2023/1/30 17:06, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Sat 28 Jan 2023 at 18:17, Yu Tu <yu.tu@amlogic.com> wrote:
>> 
>>> On 2023/1/20 17:47, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>>> On Fri 20 Jan 2023 at 11:33, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>
>>>>> Hi
>>>>> On 2023/1/19 19:37, Jerome Brunet wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>> On Mon 16 Jan 2023 at 15:42, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>>>
>>>>>>> Add the peripherals clock controller driver in the s4 SoC family.
>>>>>>>
>>>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>>> [...]
>>>>>>
>>>>>>> +
>>>>>>> +/* Video Clocks */
>>>>>>> +static struct clk_regmap s4_vid_pll_div = {
>>>>>>> +	.data = &(struct meson_vid_pll_div_data){
>>>>>>> +		.val = {
>>>>>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>>>>>> +			.shift   = 0,
>>>>>>> +			.width   = 15,
>>>>>>> +		},
>>>>>>> +		.sel = {
>>>>>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>>>>>> +			.shift   = 16,
>>>>>>> +			.width   = 2,
>>>>>>> +		},
>>>>>>> +	},
>>>>>>> +	.hw.init = &(struct clk_init_data) {
>>>>>>> +		.name = "vid_pll_div",
>>>>>>> +		/*
>>>>>>> +		 * The frequency division from the hdmi_pll clock to the vid_pll_div
>>>>>>> +		 * clock is the default value of this register. When designing the
>>>>>>> +		 * video module of the chip, a default value that can meet the
>>>>>>> +		 * requirements of the video module will be solidified according
>>>>>>> +		 * to the usage requirements of the chip, so as to facilitate chip
>>>>>>> +		 * simulation. So this is ro_ops.
>>>>>>> +		 * It is important to note that this clock is not used on this
>>>>>>> +		 * chip and is described only for the integrity of the clock tree.
>>>>>>> +		 */
>>>>>> If it is reset value and will be applicable to all the design, regarless
>>>>>> of the use-case, then yes RO ops is OK
>>>>>>
>>>>>> >From what I understand here, the value will depend on the use-case requirements.
>>>>>> This is a typical case where the DT prop "assigned-rate" should be used, not RO ops.
>>>>>
>>>>> Check the previous chip history, the actual scene is not used at all,
>>>>> basically is used in simulation. So the previous SOC was "ro_ops" without
>>>>> any problems.  This S4 SOC is not actually useful either.
>>>>>
>>>>> So when you were upstream, you had no problem making "ro_ops". I wonder if
>>>>> I could delete this useless clock, so you don't have to worry about it.
>>>> I don't know what to make of this. What is the point of adding a useless
>>>> clock ?
>>>
>>> As explained earlier this "vid_pll_div" is actually used in chip
>>> emulation. So next I'd like to know what you suggest to do with the clock?
>>>
>> If it does not exist in the actual SoC, please remove it
>> 
>
> If I remove it, the "vid_pll_sel" clock will be missing a parent
> (vid_pll_div). I will use the table method and give the above reasons. Do
> you accept this method?

Either the clock exists or it does not.

If the HW actually exist, it is expected to be properly described.
If it does not, it obviously cannot be an input to another clock.

Please sort this out and make the necessary changes.
