Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1B5EE0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiI1Pkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiI1Pk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:40:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA8F77541
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:40:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso1523260wmk.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:from:to:cc:subject:date;
        bh=RlCJgVI6Z1kRKUu162lI1Q0Miy/QkoL2EOMUCru7JOg=;
        b=nFYwD4inLbXHI2KI3mcZJFiCAmWWRnRLfk6INy0ajOoLv+9id23hJ709fq2nsT1ARY
         JXTql75OGeEPIL2Bb1jdZsYCd2AVaXx7S7kPd/2Yc8pz2Yc/BZI4vthG2ASm0LGq/Ib6
         BSi9hJcXlNuxxXKfd8iRtO7c4Ajq1lwgdffnBTkUY8FZ4up9BZR2PvlVAtp7bY7Pjg3H
         ZqKEmZxKtFXXY/xdgK77zCiLh8DQz1/pL0F/rWsGsiLlxXAdpz51bQYfRspdG/UCL9zu
         FHHsPSZX0dZeegJoC1SyEKjmpK0eQ4I1ZSVldL60QwJMhmPsNKCTs5Gm0oZS8pwMkCh1
         9phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RlCJgVI6Z1kRKUu162lI1Q0Miy/QkoL2EOMUCru7JOg=;
        b=lDJyAOyRWq6/i+uvuYuPitTvyvpIZSUEWRWkb4VjjnwFM6Q2RZOm1G2UPK6eydFpC8
         +PcY8NOmGPWQErHC8im2fNSAfeW0NUHEN/uGtHbJL8z92QHn9mrnFT2sIuy3XJb9jmwH
         pUu0HPxvODcDL4H6Msygv4DI48T6DRIdkyEj/Z8kJep5+gtjqxIV6xBY6pri0yvgbCpq
         O+kl290ojBwb+frg65DWqmGgCP/WgV8SLdQhUqQ7XV/A7ZdWtlBJ/Ap0xK9wudwDClpo
         nuhdojSriS3KnOEhJ88znMR164cI7ijSkNY833W9zEP1uzAeHYjpq7aqyCmK/+fMYVgv
         ZS0g==
X-Gm-Message-State: ACrzQf0mkVcfpL30OdLhHUT2/x6GmY1iNLhTgCF8O/G4KWCCQcE1T/by
        TXaCFvKMpvK7dws/A4bmLWP6xw==
X-Google-Smtp-Source: AMsMyM77Xhhmn8GlOIfa6q5vVJalkBkY4ZS5/PYh6pUA6az+X2B6Y4rCsG6DO5E1t5DCYgZ8KQjH4Q==
X-Received: by 2002:a05:600c:2191:b0:3b4:868a:aad3 with SMTP id e17-20020a05600c219100b003b4868aaad3mr7433148wme.112.1664379621319;
        Wed, 28 Sep 2022 08:40:21 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d5150000000b0021f131de6aesm4254590wrt.34.2022.09.28.08.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:40:20 -0700 (PDT)
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-7-yu.tu@amlogic.com>
 <1jedxlzxyz.fsf@starbuckisacylon.baylibre.com>
 <8f40cb49-fdc5-20cd-343b-8ce50e5d6d97@amlogic.com>
 <1j7d2rte33.fsf@starbuckisacylon.baylibre.com>
 <2b6035f3-8cbe-ab75-bed9-5751b141d3d6@amlogic.com>
 <0b621dfa-4ecd-a9a6-8681-8ab8b00d7841@amlogic.com>
User-agent: mu4e 1.8.7; emacs 28.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 6/6] clk: meson: s4: add s4 SoC peripheral clock
 controller driver
Date:   Wed, 28 Sep 2022 17:35:00 +0200
In-reply-to: <0b621dfa-4ecd-a9a6-8681-8ab8b00d7841@amlogic.com>
Message-ID: <1jtu4rzevv.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 21 Sep 2022 at 17:01, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Jerome,
>
> On 2022/8/30 16:20, Yu Tu wrote:
>> On 2022/8/29 20:19, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>>
>>> On Tue 16 Aug 2022 at 20:00, Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>> Please trim your replies
>>>
>>>>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>>>>> index f4244edc7b28..ec6beb9284d3 100644
>>>>>> --- a/drivers/clk/meson/Kconfig
>>>>>> +++ b/drivers/clk/meson/Kconfig
>>>>>> @@ -127,4 +127,17 @@ config COMMON_CLK_S4_PLL
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Support for the pll=
 clock controller on Amlogic S805X2 and
>>>>>> S905Y4 devices,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aka s4. Amlogic S80=
5X2 and S905Y4 devices include AQ222 and
>>>>>> AQ229.
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say Y if you want p=
eripherals and CPU frequency scaling to
>>>>>> work.
>>>>>> +
>>>>>> +config COMMON_CLK_S4
>>>>>> +=C2=A0=C2=A0=C2=A0 tristate "S4 SoC Peripherals clock controllers s=
upport"
>>>>>> +=C2=A0=C2=A0=C2=A0 depends on ARM64
>>>>>> +=C2=A0=C2=A0=C2=A0 default y
>>>>>> +=C2=A0=C2=A0=C2=A0 select COMMON_CLK_MESON_REGMAP
>>>>>> +=C2=A0=C2=A0=C2=A0 select COMMON_CLK_MESON_DUALDIV
>>>>>> +=C2=A0=C2=A0=C2=A0 select COMMON_CLK_MESON_VID_PLL_DIV
>>>>>> +=C2=A0=C2=A0=C2=A0 select COMMON_CLK_S4_PLL
>>>>> Do you really this ? your driver does not even include the related
>>>>> header.
>>>> If the PLL driver is not turned on in DTS, will it not cause an error?
>>>>>
>>>
>>> I don't get the question.
>>> Kconfig list compile deps. S4 PLL is not a compile dep of the peripheral
>>> controller.
>>>
>>> If you really want to, you may use 'imply'.
>> V4 has been changed as you suggested.
>
> The next edition is being changed according to your requirements. Please
> give us your valuable opinions.
>
>>=20
>>>>>
>>>>>> +static const struct clk_parent_data sys_ab_clk_parent_data[] =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "xtal" },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div2" },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div3" },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div4" },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div5" },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div7" },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .hw =3D &s4_rtc_clk.hw }
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap s4_sysclk_b_sel =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .data =3D &(struct clk_regmap_mux_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .offset =3D CLKCTRL_SYS_=
CLK_CTRL0,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mask =3D 0x7,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 26,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .table =3D mux_table_sys=
_ab_clk_sel,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 .hw.init =3D &(struct clk_init_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "sysclk_b_sel",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D &clk_regmap_mux=
_ro_ops,
>>>>> Why is this using the RO ops ?
>>>> Sys_clk is initialized during the Uboot phase and is fixed at
>>>> 166.666MHz. So I'm going to change it to ro.
>>>
>>> That really much depends on the bootloader and is a pretty weak design.
>>> The bootloader deps should be kept as minimal as possible.
>>>
>>> I see no reason for RO.
>>>
>>> You may cut rate propagation on the user if you need to and continue to
>>> whatever you want in your u-boot
>> I think I know what you mean. But we let the user be in control and not
>> set the frequency, which can be risky. If you insist, I will change it as
>> you suggest.
>
> It has been changed as you requested.
>
>>=20
>>>
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent_data =3D sys_ab_=
clk_parent_data,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D ARRAY_S=
IZE(sys_ab_clk_parent_data),
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap s4_sysclk_b_div =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .data =3D &(struct clk_regmap_div_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .offset =3D CLKCTRL_SYS_=
CLK_CTRL0,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 16,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .width =3D 10,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 .hw.init =3D &(struct clk_init_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "sysclk_b_div",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D &clk_regmap_div=
ider_ro_ops,
>>>>> Same here and for the rest of the sys part
>>>> Same above.
>>>
>>> We can play that game for a while
>> Ah, you're so funny.
>>=20
>>>
>>>>>> +
>>>>>> +/* Video Clocks */
>>>>>> +static struct clk_regmap s4_vid_pll_div =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .data =3D &(struct meson_vid_pll_div_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .val =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.reg_off =3D CLKCTRL_VID_PLL_CLK_DIV,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.shift=C2=A0=C2=A0 =3D 0,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.width=C2=A0=C2=A0 =3D 15,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sel =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.reg_off =3D CLKCTRL_VID_PLL_CLK_DIV,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.shift=C2=A0=C2=A0 =3D 16,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.width=C2=A0=C2=A0 =3D 2,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 .hw.init =3D &(struct clk_init_data) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "vid_pll_div",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D &meson_vid_pll_=
div_ro_ops,
>>>>> Why RO ? applies to the rest of the video part.
>>>> Because vid_pll_div parent is HDMI_PLL, and HDMI_PLL is a fixed
>>>> frequency. Flags is CLK_SET_RATE_PARENT. So we use RO.
>>>
>>> If the HDMI_PLL is fixed somehow, that is not reason for this clock to
>>> be RO
>>>
>>>> Can I remove RO and use CLK_SET_RATE_NO_REPARENT instead, which one do
>>>> you
>>>> think is more reasonable?
>>>
>>> Neither. CLK_SET_RATE_NO_REPARENT makes no sense, it is not mux
>>>
>> "drivers/clk/meson/vid-pll-div.c"
>> This file only provides ro_ops. Maybe the submission records will give us
>> the answer.
>> In fact, our hardware design is the same as the G12 series.
>
> I don't know if you checked this commit, but there is only one "ro_ops"in
> this place right now.
>
> The S4 SoC is consistent with the G12A/B and GX series.
>

I missed the vid_pll type, Ok then.

>>=20
>>>>
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent_data =3D (const =
struct clk_parent_data []) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
{ .fw_name =3D "hdmi_pll", }
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D 1,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flags =3D CLK_SET_RATE_=
PARENT,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap s4_vid_pll_sel =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .data =3D &(struct clk_regmap_mux_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .offset =3D CLKCTRL_VID_=
PLL_CLK_DIV,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mask =3D 0x1,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 18,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 .hw.init =3D &(struct clk_init_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "vid_pll_sel",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D &clk_regmap_mux=
_ops,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bit 18 selects f=
rom 2 possible parents:
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * vid_pll_div or h=
dmi_pll
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent_data =3D (const =
struct clk_parent_data []) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
{ .hw =3D &s4_vid_pll_div.hw },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
{ .fw_name =3D "hdmi_pll", }
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D 2,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flags =3D CLK_SET_RATE_=
NO_REPARENT,
>>>>> Why ? are you planning to DT assigned clocks to statically set this ?
>>>> Because vid_pll_sel one parent is HDMI_PLL, and HDMI_PLL is a fixed
>>>> frequency. To prevent modification, use CLK_SET_RATE_NO_REPARENT.
>>>
>>> Again, this makes no sense.
>> Unfortunately you don't read V4, in fact I have corrected in V4.
>> ".flags =3D CLK_SET_RATE_PARENT," in V4. Is that okay with you?
>
> I don't know what you think?
>

ok

>>=20
>>>
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap s4_vid_pll =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .data =3D &(struct clk_regmap_gate_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .offset =3D CLKCTRL_VID_=
PLL_CLK_DIV,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bit_idx =3D 19,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 .hw.init =3D &(struct clk_init_data) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "vid_pll",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D &clk_regmap_gat=
e_ops,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent_hws =3D (const s=
truct clk_hw *[]) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
&s4_vid_pll_sel.hw
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D 1,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flags =3D CLK_SET_RATE_=
PARENT,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +};
>>>>>> +
>>>>>> +static const struct clk_parent_data s4_vclk_parent_data[] =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 { .hw =3D &s4_vid_pll.hw },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "gp0_pll", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "hifi_pll", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "mpll1", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div3", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div4", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div5", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div7", },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap s4_vclk_sel =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .data =3D &(struct clk_regmap_mux_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .offset =3D CLKCTRL_VID_=
CLK_CTRL,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mask =3D 0x7,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 16,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 .hw.init =3D &(struct clk_init_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "vclk_sel",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D &clk_regmap_mux=
_ops,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent_data =3D s4_vclk=
_parent_data,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D ARRAY_S=
IZE(s4_vclk_parent_data),
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flags =3D CLK_SET_RATE_=
NO_REPARENT,
>>>>> Same
>>>> Since fclk_div* is a fixed frequency value, mplL1 and hifi_pll and
>>>> gp0_pll
>>>> are used by other specialized modules, vid_pll has
>>>> CLK_SET_RATE_PARENT. The
>>>> parent of vid_pll is that vid_pll_sel uses CLK_SET_RATE_NO_REPARENT.
>>>
>>> Still not good.
>>>
>>> You don't have CLK_SET_RATE, propagation is stopped and parent clock
>>> will not changed. The best parent will be picked but not changed.
>>>
>>> If one parent MUST NOT be picked, just remove it from the list and add a
>>> explaining why
>>>
>>> [...]
>> Okay.
>
> In the next edition I will change it to ".flags =3D CLK_SET_RATE_PARENT".
>

If you clock rate propagation is ok, then OK

>>=20
>>>
>>>>>> +
>>>>>> +static struct clk_regmap s4_ts_clk_div =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .data =3D &(struct clk_regmap_div_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .offset =3D CLKCTRL_TS_C=
LK_CTRL,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 0,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .width =3D 8,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 .hw.init =3D &(struct clk_init_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "ts_clk_div",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D &clk_regmap_div=
ider_ops,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent_data =3D &(const=
 struct clk_parent_data) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.fw_name =3D "xtal",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D 1,
>>>>> propagation stopped ?
>>>> Its parent is xtal, so I should use CLK_SET_RATE_NO_REPARENT.
>>>
>>> Still no. You seem to have problem with the meaning of
>>> CLK_SET_RATE_NO_REPARENT.
>>>
>>> * CLK_SET_RATE_NO_REPARENT: means the parent will no be changed, even if
>>> =C2=A0=C2=A0 selecting another parent would result in a closer rate to =
the
>>> =C2=A0=C2=A0 request. It makes sense only if the clock has several pare=
nts
>>>
>>> * CLK_SET_RATE_PARENT: means rate change may propagate the parent,
>>> =C2=A0=C2=A0 meaning the rate of the parent may change if it help the c=
hild achieve
>>> =C2=A0=C2=A0 a closer rate to the request
>> Thank you for explaining.I got it.
>>=20
>>>
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap s4_ts_clk_gate =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .data =3D &(struct clk_regmap_gate_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .offset =3D CLKCTRL_TS_C=
LK_CTRL,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bit_idx =3D 8,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 .hw.init =3D &(struct clk_init_data){
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "ts_clk",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D &clk_regmap_gat=
e_ops,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent_hws =3D (const s=
truct clk_hw *[]) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
&s4_ts_clk_div.hw
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D 1,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>> propagation stopped ?
>>>> I will add CLK_SET_RATE_PARENT.
>>>
>>> [...]
>>>
>>>>>> +/* EMMC/NAND clock */
>>>>>> +
>>>>>> +static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] =
=3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "xtal", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div2", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div3", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "hifi_pll", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div2p5", },
>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Following these parent clocks, we should=
 also have had mpll2,
>>>>>> mpll3
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * and gp0_pll but these clocks are too pre=
cious to be used
>>>>>> here. All
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the necessary rates for MMC and NAND ope=
ration can be
>>>>>> acheived using
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * hifi_pll or fclk_div clocks
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> You don't want to list mplls but hifi_pll is fine ? seems dangerous.
>>>> hifi pll is for EMMC and NAND on this SoC.
>>>
>>> That deserve a better explanation.
>>> Why can't it use fdiv2 and xtal like the previous SoCs ?
>>>
>>> Which PLLs are you using for Audio then ?
>>> Typical operation on these SoCs usually require 3 PLLs to acheive all
>>> rates
>>>
>> I'll list all the clocks and let the driver itself select Parent as
>> needed.
>
> I don't know what you think?
>

ok

>>=20
>>>>>
>>>
>>>
>>>>>> +/*
>>>>>> + * gen clk is designed for debug/monitor some internal clock
>>>>>> quality. Some of the
>>>>>> + * corresponding clock sources are not described in the clock tree,
>>>>>> so they are skipped.
>>>>>> + */
>>>>> Still feels a bit light, don't you think ? Among all the clocks, can't
>>>>> you add a bit more parents here ? It would certainly help debug down
>>>>> the road
>>>> [16:12]=C2=A0=C2=A0=C2=A0 is gen_clk source select.All is:
>>>> 0: cts_oscin_clk
>>>> 1:cts_rtc_clk
>>>> 2:sys_pll_div16 (internal clock)
>>>> 3:ddr_pll_div32=C2=A0 (internal clock)
>>>> 4: vid_pll
>>>> 5: gp0_pll
>>>> 7: hifi_pll
>>>> 10:adc_dpll_clk_b3 (internal clock for debug)
>>>> 11:adc_dpll_intclk (internal clock for debug)
>>>> 12:clk_msr_src(select from all internal clock except PLLs);
>>>> 16: no used
>>>> 17: sys_cpu_clk_div16 (internal clock)
>>>> 19: fclk_div2
>>>> 20: fclk_div2p5
>>>> 21: fclk_div3
>>>> 22: fclk_div4
>>>> 23: fclk_div5
>>>> 24: fclk_div7
>>>> 25: mpll0
>>>> 26: mpll1
>>>> 27: mpll2
>>>> 28: mpll3
>>>> So i only added the clocks that will actually be used, and some
>>>> debugging
>>>> clock peripherals will not be used.
>>>
>>> you may at least add vid_pll
>> Okay.
>
> It has been changed as you suggested.
>
>>=20
>>>
>>>>>
>>>>>> +static u32 s4_gen_clk_mux_table[] =3D { 0, 5, 7, 19, 21, 22,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 23, 24, 25, 26=
, 27, 28 };
>>>>>> +static const struct clk_parent_data s4_gen_clk_parent_data[] =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "xtal", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "gp0_pll", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "hifi_pll", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div2", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div3", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div4", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div5", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "fclk_div7", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "mpll0", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "mpll1", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "mpll2", },
>>>>>> +=C2=A0=C2=A0=C2=A0 { .fw_name =3D "mpll3", },
>>>>>> +};
>>>
>>> .

