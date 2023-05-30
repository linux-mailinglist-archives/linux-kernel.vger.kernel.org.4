Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA53A716A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjE3Qto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjE3Qtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:49:41 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5DA7;
        Tue, 30 May 2023 09:49:37 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 9DEDB5FD3D;
        Tue, 30 May 2023 19:49:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685465374;
        bh=6QfHdz+QFGSro1lLX069r4LLDn31Yt+etPSZIg88FW0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=dpGK3rAAHlcU7PfwWR89EoEznPx/N8kZhkidmhRJz6yqgZGAR4nH7fsRgxqWHEqSd
         bzX1QR3+HMqMpVsR+0KL4BnbBKsGgfP65KUq+6QDdgCRC2ekIGjKRF2VesXq4r/WJP
         mbdSRqdI23TBXABczaqRHl68bhmYrbN9zydeDRnSPqVoEZPCOu+A9lU3Yc0Bj5FcZZ
         JxiYnhq7hO6A4sepY9aC5GjJJWdvoYuuhG/2myN+B17z28Nti/GJcNJRpRksPaZfbc
         tZq0W2akM9DSEXckGogDnR9Dt029wH6NGsSF7N6YYg5d0vBh+AS9lXYocbupn+K2Ew
         mBZXBXGllW4CA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 30 May 2023 19:49:33 +0300 (MSK)
Date:   Tue, 30 May 2023 19:49:33 +0300
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
Subject: Re: [PATCH v15 0/6] add Amlogic A1 clock controller drivers
Message-ID: <20230530164933.m42ojv357atxd4gc@CAB-WSD-L081021>
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru><1jilc94x0d.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jilc94x0d.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/30 11:20:00 #21377521
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome,

On Tue, May 30, 2023 at 06:14:01PM +0200, Jerome Brunet wrote:
> On Wed 17 May 2023 at 16:33, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> > A1 SoC has four clock controllers on the board: PLL, Peripherals, CPU,
> > and Audio. The audio clock controller is different from others, but the
> > rest are very similar from a functional and regmap point of view.
> > This patch series add support for Amlogic A1 PLL and Peripherals clock
> > drivers.
> > It blocks all A1 peripherals mainline support and a couple of patch series,
> > which were already reviewed and acked, but weren't merged due to pending
> > clock controller drivers series, e.g.
> > https://lore.kernel.org/all/20230418111612.19479-1-ddrokosov@sberdevices.ru/
> >
> > TODO: CPU and Audio clock controllers are not included in this patch
> > series, it will be sent later. The following clks from these controllers
> > are not supported for now:
> > * Audio clks - vad, mclk_vad, mclk_d, resample_a, locker_in, mclk_b,
> >    pdmdclk, pdmsysclk, eqdrc, spdifin, mclk_a, audio2_toaudiotop,
> >    audio2_tovad, audio2_toddr_vad, audio2_tdmin_vad, audio2_pdm,
> >    audio2_ddr_arb, audio_audiolocker, audio_eqdrc, audio_resamplea,
> >    audio_spdifin, audio_toddrb, audio_toddra, audio_frddrb, audio_frddra,
> >    audio_tdmoutb, audio_tdmouta, audio_loopbacka, audio_tdminlb,
> >    audio_tdminb, audio_tdmina, audio_ddr_arb, mclk_c
> >
> > * CPU clks: cpu_fixed_source_sel0, cpu_fixed_source_div0,
> >             cpu_fixed_source_sel1, cpu_fixed_source_div1, cpu_clk
> >
> > Validation:
> > * to double check all clk flags run below helper script:
> >     pushd /sys/kernel/debug/clk
> >     for f in *; do
> >         if [[ -f "$f/clk_flags" ]]; then
> >             flags="$(cat $f/clk_flags | awk '{$1=$1};1' | sed ':a;N;$!ba;s/\n/ | /g')"
> >             echo -e "$f: $flags"
> >         fi
> >     done
> >     popd
> >
> > * to trace current clks state use '/sys/kernel/debug/clk/clk_dump' node
> >   with jq post-processing:
> >     $ cat /sys/kernel/debug/clk/clk_dump | jq '.' > clk_dump.json
> >
> > * to debug clk rate propagation, compile kernel with the following
> >   definition:
> >     $ sed -i "s/undef CLOCK_ALLOW_WRITE_DEBUGFS/define CLOCK_ALLOW_WRITE_DEBUGFS/g" drivers/clk/clk.c
> >   after that, clk_rate debug node for each clock will be available for
> >   write operation
> >
> 
> Applied, Thx

Thank you very much!

I noticed that you have applied version 15 of the patch. If I understand
correctly, this is because CLK_SET_RATE_NO_REPARENT for all RTC children
is preferred from your perspective. I agree with this decision. However,
version 16 includes a small refactoring patch that corrects a
misstyping by changing all sys_* related dividers and gates to
read-only operations, since they are set up from BootROM. Should I
submit this patch separately at a later time?

Also could you please clarify the official process for handling these
patches? Currently, I don't see them in the linux-amlogic for-next
branches. Is there a separate repository for clock changes? I believe
the next repository is a fork of the clock framework, but unfortunately,
I cannot seem to locate it on git.kernel.org... Apologies for the
potentially simple questions...

-- 
Thank you,
Dmitry

  :      ,   ,   .     ,       , , ,  ,    ,         ,  .       , ,           .
CONFIDENTIALITY NOTICE: This email and any files attached to it are confidential. If you are not the intended recipient you are notified that using, copying, distributing or taking any action in reliance on the contents of this information is strictly prohibited. If you have received this email in error please notify the sender and delete this email.
