Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F156B73DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCMKZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCMKZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:25:23 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E05E18152;
        Mon, 13 Mar 2023 03:25:20 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 204C75FD0B;
        Mon, 13 Mar 2023 13:25:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678703117;
        bh=3oXZsLeafS38+qYJFdTL8leUTox2P7WbbzgFUBRnCNg=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Qv/6hWdUh6jbEDRyIaWb0tKazL9ceDy5A4eBl9oL1x15fhKp0lC3vw3j324sOYQ0v
         6xUgWl2C/Qt2YbkdjVoKgbGd8evAqrEUN4qI8MXoluGDowAAJbyREitrFmUd5mtcP1
         Vb86myzYsKE7owVQq6dkJXyTvbxG1zJ52VDRSB4VRjGeQ/uqHS/+sQ5ESTa78y7EP5
         B/RmhZOkv8c8x5AFQSp2KlHC2db1nH+lwfJQzSwThjC3v79A9Iy1D8skAuOD9cdziT
         abV2qOGPZiflje6hBIFK+HijGFq3u1tLoSiv4KrTqWT0dVjrx8rkpIUQEnf47NMx+u
         cMvfkYXcMB4wQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 13 Mar 2023 13:25:16 +0300 (MSK)
Date:   Mon, 13 Mar 2023 13:25:16 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 2/5] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
Message-ID: <20230313102516.grkj4jhkke2w7blm@CAB-WSD-L081021>
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-3-ddrokosov@sberdevices.ru>
 <1jr0u2azfi.fsf@starbuckisacylon.baylibre.com>
 <20230306200549.7iuedbl27ejfhf6b@CAB-WSD-L081021>
 <1jlek60zun.fsf@starbuckisacylon.baylibre.com>
 <20230309182857.a2fzotcejueio23w@CAB-WSD-L081021>
 <1j5yb50zxz.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1j5yb50zxz.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/13 06:38:00 #20941627
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:18:02AM +0100, Jerome Brunet wrote:
> 
> On Thu 09 Mar 2023 at 21:28, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> >> >> 
> >> >> This last poke should not bits otherwise handled by parms.
> >> >> This is a rate init in disguise.
> >> >> 
> >> >
> >> > I believe, you are talking about hifi_pll clk_regmap conflicts with
> >> > hifi_init_regs. The above init sequence shouldn't affect pll regmap setup,
> >> > it doesn't touch them (we assume that default bit values are all zero):
> >> >
> >> >     .en = {
> >> >         .reg_off = ANACTRL_HIFIPLL_CTRL0,
> >> >         .shift   = 28,
> >> >         .width   = 1,
> >> >     },
> >> >     // init_value = 0x01f18440
> >> >     // en_mask    = 0x10000000
> >> >
> >> >     .m = {
> >> >         .reg_off = ANACTRL_HIFIPLL_CTRL0,
> >> >         .shift   = 0,
> >> >         .width   = 8,
> >> >     },
> >> >     // init_value = 0x01f18440
> >> >     // m_mask     = 0x0000000f
> >> 
> >> mask is 0xff with width 8
> >> 
> >
> > Ah, you're right. Anyway, I think this is just init value and it's okay
> > to set it during initialization and rewrite after in parameter
> > propagation stage.
> >
> 
> ... But the magic pokes are there only to initialize the unmanaged part
> of the clock regs. I'd like it to be clear and stay that way.
> 
> So please, clear the managed fields from the initial poke table.

I've double checked hifi_pll clk. In the my current configuration no any
clks inherited from it. Therefore its 'enable_count' equals to 0.
And of course in the such situation the rate must be zeroed as well.
It means you are right at all. I'll remove pre_sel and fbkdiv hifi_pll
pre-setup in the next version.
Thank you for hunted down!

-- 
Thank you,
Dmitry
