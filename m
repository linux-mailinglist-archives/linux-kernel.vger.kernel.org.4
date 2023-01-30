Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA2968082F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbjA3JHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjA3JHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:07:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86E82CFD2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:07:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q5so10380565wrv.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=lsYDdEUERNa3haOuJCyAm4JNnP3W5R6kzY4+GKk1/bQ=;
        b=BcPcAmLYez/2WbtfoRyE4Tmt4L6RHSzHIyQHIxkGShoJ8nsggaHJo/hwm2rGInqlBY
         TOd96pVmLH5CSkR0ZpjrrTbvm2nHG3lPJ2QuHgFFzzNcV9xsgqhyJgEKP2jh1wih3R0x
         rHNeicYddOa1OfTbdn6h8Cuu0f80lXvIkp4d3WXn2ZPz4ZcHFX0Adcfpd/WPHXKWJK8w
         aYW8w9p6UJOHYCcRhB7K8KfU1z3HL7YoMjMMUT7ROa/ei1AM3yNX3GfNGYS9wHK76lS7
         sUDri8lcLIE+vQRuLMTizVOcbcxD7rF3PPnNVxxoOEqkxUHtH2CNO5XnuQF5b3RolWi6
         APZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsYDdEUERNa3haOuJCyAm4JNnP3W5R6kzY4+GKk1/bQ=;
        b=GCo2e6g2NBbBN1SoeIC5gH3W47UjBxDSDmUobldpLK1aPy47gXEfHKqk0S3FyQmc1u
         p2HebUen91FD/ek1uI6FEBSFBob8LcGxGdsY0RZOH1G7TiB0Q3HReJZ+fvF+OSyo0R8e
         TuAXTJdzBhnA7YJZjf+pPyDsuBNDLunGQEVITIuaxONMK5a+AVEodmA3b4a1/Wuw68Ok
         wPeDxfIdqBDW730umg562ASWavw6eZ1SXKZJ9kaho6IHcQT6YAwbUrrW272sp4/6Hx+S
         Si87PgvZenF7jyfERvJk8wBLXZzCRIOitwsNX/XNZMiwHg0HMkFPE8xcTulk1a0ofJBL
         7Vug==
X-Gm-Message-State: AFqh2kqxG+bJnJwnX2kFZBGTjqMNISsge4CI3Dvgu76Q0ohRgva6E2OA
        7Ekmk4isEjU62pZVmzkYLtIiq+YTA3ydQzN1
X-Google-Smtp-Source: AMrXdXtLM5yCOsKxBBWj+DH7khxMs+DnILPh4por/ncjDzW//iFJ0t2Qxjhu8HVdGwvrrSuBjQGabQ==
X-Received: by 2002:adf:c78b:0:b0:2bd:dd13:170f with SMTP id l11-20020adfc78b000000b002bddd13170fmr52501442wrg.26.1675069657414;
        Mon, 30 Jan 2023 01:07:37 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600001c400b002bdcce37d31sm12691897wrx.99.2023.01.30.01.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:07:36 -0800 (PST)
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-4-yu.tu@amlogic.com>
 <1ja62eybrv.fsf@starbuckisacylon.baylibre.com>
 <aedb0764-b5cb-7f49-f279-51dbec070e80@amlogic.com>
 <1jwn5hwn0w.fsf@starbuckisacylon.baylibre.com>
 <a4ad6ac6-60c2-8f7b-fdb0-509de31db282@amlogic.com>
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
Date:   Mon, 30 Jan 2023 10:06:49 +0100
In-reply-to: <a4ad6ac6-60c2-8f7b-fdb0-509de31db282@amlogic.com>
Message-ID: <1jy1pko0fc.fsf@starbuckisacylon.baylibre.com>
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


On Sat 28 Jan 2023 at 18:17, Yu Tu <yu.tu@amlogic.com> wrote:

> On 2023/1/20 17:47, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Fri 20 Jan 2023 at 11:33, Yu Tu <yu.tu@amlogic.com> wrote:
>> 
>>> Hi
>>> On 2023/1/19 19:37, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>>> On Mon 16 Jan 2023 at 15:42, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>
>>>>> Add the peripherals clock controller driver in the s4 SoC family.
>>>>>
>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> [...]
>>>>
>>>>> +
>>>>> +/* Video Clocks */
>>>>> +static struct clk_regmap s4_vid_pll_div = {
>>>>> +	.data = &(struct meson_vid_pll_div_data){
>>>>> +		.val = {
>>>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>>>> +			.shift   = 0,
>>>>> +			.width   = 15,
>>>>> +		},
>>>>> +		.sel = {
>>>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>>>> +			.shift   = 16,
>>>>> +			.width   = 2,
>>>>> +		},
>>>>> +	},
>>>>> +	.hw.init = &(struct clk_init_data) {
>>>>> +		.name = "vid_pll_div",
>>>>> +		/*
>>>>> +		 * The frequency division from the hdmi_pll clock to the vid_pll_div
>>>>> +		 * clock is the default value of this register. When designing the
>>>>> +		 * video module of the chip, a default value that can meet the
>>>>> +		 * requirements of the video module will be solidified according
>>>>> +		 * to the usage requirements of the chip, so as to facilitate chip
>>>>> +		 * simulation. So this is ro_ops.
>>>>> +		 * It is important to note that this clock is not used on this
>>>>> +		 * chip and is described only for the integrity of the clock tree.
>>>>> +		 */
>>>> If it is reset value and will be applicable to all the design, regarless
>>>> of the use-case, then yes RO ops is OK
>>>>
>>>> >From what I understand here, the value will depend on the use-case requirements.
>>>> This is a typical case where the DT prop "assigned-rate" should be used, not RO ops.
>>>
>>> Check the previous chip history, the actual scene is not used at all,
>>> basically is used in simulation. So the previous SOC was "ro_ops" without
>>> any problems.  This S4 SOC is not actually useful either.
>>>
>>> So when you were upstream, you had no problem making "ro_ops". I wonder if
>>> I could delete this useless clock, so you don't have to worry about it.
>> I don't know what to make of this. What is the point of adding a useless
>> clock ?
>
> As explained earlier this "vid_pll_div" is actually used in chip
> emulation. So next I'd like to know what you suggest to do with the clock?
>

If it does not exist in the actual SoC, please remove it
