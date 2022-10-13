Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92575FD57D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJMHTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJMHTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:19:38 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7F3EA46;
        Thu, 13 Oct 2022 00:19:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 44FAC580405;
        Thu, 13 Oct 2022 03:19:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 13 Oct 2022 03:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1665645564; x=1665652764; bh=EsB1O0l6Ib
        ka4jLDJYiAWkv+FmVsovwo3iT4Y5sk7YY=; b=X8Jt/l9AOcH25tJKSPJWzp8w+A
        SiC/lnBoIAjZHlpOVdRDgCpAvLzGsMSx4r5GerSsTu1r4FtdyB2nET1GayBsjMjD
        MLGKN+z60N1yyLmPV9Y8AnPJxBuBeSIdXmJwaaBArYd7DnPPUG9RZmnpdQ+oRSdN
        qMnm4YfFQQ+0bKZNxhbexU1iuTysu1ToB70wQofA68cqYtbG5PT6s5oXWlkMvYkt
        TjkYrYmgTKgN5gAaQEW2ch3mSjB0IoZ+mY2s9X0fX3V1d8NCqi9Wywwcq4STfjDy
        SxPoW7JrDd0aCU0ljOhrdVuZqwXZPX6RjHuYVjfAicpAUOUiyUFVTsDuJ3wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665645564; x=1665652764; bh=EsB1O0l6Ibka4jLDJYiAWkv+FmVs
        ovwo3iT4Y5sk7YY=; b=eKNR7CoGJUA2QA5NjLpgZfxIiVYz/1SrqPbRCjbqAec8
        7QSp2ZpIy74/UaNKoT4E2vxJKdJrBbWY6FCK712qd6k3WhZwXvVwe/9KLC2cnh4o
        9wnZlmB5vzTZawvEFV7VrnZsKx+MVFv21iKd3ewGVMZidWkIudw8qKKa1cEn2MBw
        fOmPMERvf56l6a4hkaKcR6mF8dfuSuDLdRWQVnrUobZACz0uZ+Lu9BrbHRFb8S+S
        htlRpx1B9rCWSB+h4vkEWbWM8fb6XlbYO66SesvXHV+PJU9ZHNWaUgESa0URwJ5+
        hWTzqIfZeMjh+qaUIxbNtyF4nkohhAgSykh/uO9K9g==
X-ME-Sender: <xms:-7tHY2gCmeqpFAfZaABmEyI98T5i-XyAkgT7ZBpMzxUhHiVgvIoyUw>
    <xme:-7tHY3CSJQviESIf2WCug27SzbhriyzHGGWlSA5r3SWnIrKkJJBP_P8Cr8jP5vTT3
    xgatddBZjwzFrfW4cw>
X-ME-Received: <xmr:-7tHY-FRMJd1ae1pjabGJubM7cm3FO1W8h-IsPwJGbQ3YU-S43xULBwjeGJGYj5kVRxW6PPf7zhRsy7MiubEi8KrX3X3jefrCQaT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptdelkeejiedufedvhfeiffetlefhiedvleeigfeiuefghfdvleeiffej
    ieegteejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:-7tHY_Rucqf9Ueyym6UbcZ1rzF4k6_2Vtv2_vE3zSc0srd7OZNx0Sg>
    <xmx:-7tHYzw6nDixFzQzDDkDCr2U54LeAKlaQfadRQzuai-QCupozs74OQ>
    <xmx:-7tHY95PDa-fFqfmEvKFxki5jZLUL9iddXlZuGSIkzsKBxoqITH8MA>
    <xmx:_LtHY6hwhwHeldDtR4EOSy3ot8jRzLtN2KF76WbPsslWPG3lnt5mRQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 03:19:23 -0400 (EDT)
Date:   Thu, 13 Oct 2022 09:19:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: mediatek: clk-mux: Add .determine_rate() callback
Message-ID: <20221013071921.ny6qskjubweiyq6q@houat>
References: <20221011135548.318323-1-angelogioacchino.delregno@collabora.com>
 <20221012085555.3nls7ja56vlnaz2w@houat>
 <c4a1eb9f-016d-c184-e494-c869038b87ff@collabora.com>
 <20221012094004.jgiyvmbgomiyedik@houat>
 <6e76f90f-3b6a-330d-6902-b31bf3d33ad4@collabora.com>
 <20221012114813.6d6adro746w5bd7c@houat>
 <decfd5e5-a48b-b2d1-f21b-1a4d52e05538@collabora.com>
 <20221012135619.wxyzuqheolhypoec@houat>
 <20221012164204.oulzmj67hxrojrb6@houat>
 <CAGb2v67A5u99mgNTdDfp4161OKKKjib5kM_EuWHJXBwUvxXU+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6mdsuosigjozhu2"
Content-Disposition: inline
In-Reply-To: <CAGb2v67A5u99mgNTdDfp4161OKKKjib5kM_EuWHJXBwUvxXU+g@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t6mdsuosigjozhu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2022 at 12:52:41AM +0800, Chen-Yu Tsai wrote:
> On Thu, Oct 13, 2022 at 12:42 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Wed, Oct 12, 2022 at 03:56:19PM +0200, Maxime Ripard wrote:
> > > On Wed, Oct 12, 2022 at 02:14:39PM +0200, AngeloGioacchino Del Regno =
wrote:
> > > > Il 12/10/22 13:48, Maxime Ripard ha scritto:
> > > > > On Wed, Oct 12, 2022 at 11:57:15AM +0200, AngeloGioacchino Del Re=
gno wrote:
> > > > > > Il 12/10/22 11:40, Maxime Ripard ha scritto:
> > > > > > > On Wed, Oct 12, 2022 at 11:09:59AM +0200, AngeloGioacchino De=
l Regno wrote:
> > > > > > > > Il 12/10/22 10:55, Maxime Ripard ha scritto:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On Tue, Oct 11, 2022 at 03:55:48PM +0200, AngeloGioacchin=
o Del Regno wrote:
> > > > > > > > > > Since commit 262ca38f4b6e ("clk: Stop forwarding clk_ra=
te_requests
> > > > > > > > > > to the parent"), the clk_rate_request is .. as the titl=
e says, not
> > > > > > > > > > forwarded anymore to the parent:
> > > > > > > > >
> > > > > > > > > It's not entirely true, the rate request should still be =
forwarded, but
> > > > > > > > > we don't pass the same instance of clk_rate_request anymo=
re.
> > > > > > > > >
> > > > > > > > > > this produces an issue with the MediaTek clock MUX driv=
er during GPU
> > > > > > > > > > DVFS on MT8195, but not on MT8192 or others.
> > > > > > > > > >
> > > > > > > > > > This is because, differently from others, like MT8192 w=
here all of
> > > > > > > > > > the clocks in the MFG parents tree are of mtk_mux type,=
 but in the
> > > > > > > > > > parent tree of MT8195's MFG clock, we have one mtk_mux =
clock and
> > > > > > > > > > one (clk framework generic) mux clock, like so:
> > > > > > > > > >
> > > > > > > > > > names: mfg_bg3d -> mfg_ck_fast_ref -> top_mfg_core_tmp =
(or) mfgpll
> > > > > > > > > > types: mtk_gate ->      mux        ->     mtk_mux      =
(or) mtk_pll
> > > > > > > > > >
> > > > > > > > > > To solve this issue and also keep the GPU DVFS clocks c=
ode working
> > > > > > > > > > as expected, wire up a .determine_rate() callback for t=
he mtk_mux
> > > > > > > > > > ops; for that, the standard clk_mux_determine_rate_flag=
s() was used
> > > > > > > > > > as it was possible to.
> > > > > > > > >
> > > > > > > > > It probably fixes things indeed, but I'm a bit worried th=
at it just
> > > > > > > > > works around the actual issue instead of fixing the actua=
l bug...
> > > > > > > > >
> > > > > > > > > > This commit was successfully tested on MT6795 Xperia M5=
, MT8173 Elm,
> > > > > > > > > > MT8192 Spherion and MT8195 Tomato; no regressions were =
seen.
> > > > > > > > > >
> > > > > > > > > > For the sake of some more documentation about this issu=
e here's the
> > > > > > > > > > trace of it:
> > > > > > > > > >
> > > > > > > > > > [   12.211587] ------------[ cut here ]------------
> > > > > > > > > > [   12.211589] WARNING: CPU: 6 PID: 78 at drivers/clk/c=
lk.c:1462 clk_core_init_rate_req+0x84/0x90
> > > > > > > > > > [   12.211593] Modules linked in: stp crct10dif_ce mtk_=
adsp_common llc rfkill snd_sof_xtensa_dsp
> > > > > > > > > >                   panfrost(+) sbs_battery cros_ec_lid_a=
ngle cros_ec_sensors snd_sof_of
> > > > > > > > > >                   cros_ec_sensors_core hid_multitouch c=
ros_usbpd_logger snd_sof gpu_sched
> > > > > > > > > >                   snd_sof_utils fuse ipv6
> > > > > > > > > > [   12.211614] CPU: 6 PID: 78 Comm: kworker/u16:2 Taint=
ed: G        W          6.0.0-next-20221011+ #58
> > > > > > > > > > [   12.211616] Hardware name: Acer Tomato (rev2) board =
(DT)
> > > > > > > > > > [   12.211617] Workqueue: devfreq_wq devfreq_monitor
> > > > > > > > > > [   12.211620] pstate: 40400009 (nZcv daif +PAN -UAO -T=
CO -DIT -SSBS BTYPE=3D--)
> > > > > > > > > > [   12.211622] pc : clk_core_init_rate_req+0x84/0x90
> > > > > > > > > > [   12.211625] lr : clk_core_forward_rate_req+0xa4/0xe4
> > > > > > > > > > [   12.211627] sp : ffff80000893b8e0
> > > > > > > > > > [   12.211628] x29: ffff80000893b8e0 x28: ffffdddf92f9b=
000 x27: ffff46a2c0e8bc05
> > > > > > > > > > [   12.211632] x26: ffff46a2c1041200 x25: 0000000000000=
000 x24: 00000000173eed80
> > > > > > > > > > [   12.211636] x23: ffff80000893b9c0 x22: ffff80000893b=
940 x21: 0000000000000000
> > > > > > > > > > [   12.211641] x20: ffff46a2c1039f00 x19: ffff46a2c1039=
f00 x18: 0000000000000000
> > > > > > > > > > [   12.211645] x17: 0000000000000038 x16: 000000000000d=
904 x15: 0000000000000003
> > > > > > > > > > [   12.211649] x14: ffffdddf9357ce48 x13: ffffdddf935e7=
1c8 x12: 000000000004803c
> > > > > > > > > > [   12.211653] x11: 00000000a867d7ad x10: 00000000a867d=
7ad x9 : ffffdddf90c28df4
> > > > > > > > > > [   12.211657] x8 : ffffdddf9357a980 x7 : 0000000000000=
000 x6 : 0000000000000004
> > > > > > > > > > [   12.211661] x5 : ffffffffffffffc8 x4 : 00000000173ee=
d80 x3 : ffff80000893b940
> > > > > > > > > > [   12.211665] x2 : 00000000173eed80 x1 : ffff80000893b=
940 x0 : 0000000000000000
> > > > > > > > > > [   12.211669] Call trace:
> > > > > > > > > > [   12.211670]  clk_core_init_rate_req+0x84/0x90
> > > > > > > > > > [   12.211673]  clk_core_round_rate_nolock+0xe8/0x10c
> > > > > > > > > > [   12.211675]  clk_mux_determine_rate_flags+0x174/0x1f0
> > > > > > > > > > [   12.211677]  clk_mux_determine_rate+0x1c/0x30
> > > > > > > > > > [   12.211680]  clk_core_determine_round_nolock+0x74/0x=
130
> > > > > > > > > > [   12.211682]  clk_core_round_rate_nolock+0x58/0x10c
> > > > > > > > > > [   12.211684]  clk_core_round_rate_nolock+0xf4/0x10c
> > > > > > > > > > [   12.211686]  clk_core_set_rate_nolock+0x194/0x2ac
> > > > > > > > > > [   12.211688]  clk_set_rate+0x40/0x94
> > > > > > > > > > [   12.211691]  _opp_config_clk_single+0x38/0xa0
> > > > > > > > > > [   12.211693]  _set_opp+0x1b0/0x500
> > > > > > > > > > [   12.211695]  dev_pm_opp_set_rate+0x120/0x290
> > > > > > > > > > [   12.211697]  panfrost_devfreq_target+0x3c/0x50 [panf=
rost]
> > > > > > > > > > [   12.211705]  devfreq_set_target+0x8c/0x2d0
> > > > > > > > > > [   12.211707]  devfreq_update_target+0xcc/0xf4
> > > > > > > > > > [   12.211708]  devfreq_monitor+0x40/0x1d0
> > > > > > > > > > [   12.211710]  process_one_work+0x294/0x664
> > > > > > > > > > [   12.211712]  worker_thread+0x7c/0x45c
> > > > > > > > > > [   12.211713]  kthread+0x104/0x110
> > > > > > > > > > [   12.211716]  ret_from_fork+0x10/0x20
> > > > > > > > > > [   12.211718] irq event stamp: 7102
> > > > > > > > > > [   12.211719] hardirqs last  enabled at (7101): [<ffff=
dddf904ea5a0>] finish_task_switch.isra.0+0xec/0x2f0
> > > > > > > > > > [   12.211723] hardirqs last disabled at (7102): [<ffff=
dddf91794b74>] el1_dbg+0x24/0x90
> > > > > > > > > > [   12.211726] softirqs last  enabled at (6716): [<ffff=
dddf90410be4>] __do_softirq+0x414/0x588
> > > > > > > > > > [   12.211728] softirqs last disabled at (6507): [<ffff=
dddf904171d8>] ____do_softirq+0x18/0x24
> > > > > > > > > > [   12.211730] ---[ end trace 0000000000000000 ]---
> > > > > > > > >
> > > > > > > > > ... Indeed, you shouldn't hit that warning at all. It hap=
pens in
> > > > > > > > > clk_core_round_rate_nolock, which takes (before your patc=
h) the
> > > > > > > > > CLK_SET_RATE_PARENT branch. This indeed has been changed =
by the patch
> > > > > > > > > you mentioned, and will call clk_core_forward_rate_req() =
now, that in
> > > > > > > > > turn calls clk_core_init_rate_nolock().
> > > > > > > > >
> > > > > > > > > I think the warning you hit is because core->parent is NU=
LL, which is
> > > > > > > > > passed to clk_core_forward_rate_req() as the parent argum=
ent, and we'll
> > > > > > > > > call clk_core_init_rate_req() with parent set as the core=
 argument.
> > > > > > > > >
> > > > > > > > > In clk_core_init_rate_req(), the first thing we do is a W=
ARN_ON(!core),
> > > > > > > > > which is what you hit here I think.
> > > > > > > > >
> > > > > > > > > This is different to the previous behavior that was calli=
ng
> > > > > > > > > clk_core_round_rate_nolock() with core->parent directly, =
and
> > > > > > > > > clk_core_round_rate_nolock() if its core argument is NULL=
 will set
> > > > > > > > > req->rate to 0 and bail out without returning an error.
> > > > > > > > >
> > > > > > > > > Now, your patch probably works because now that you provi=
de a
> > > > > > > > > determine_rate implementation, clk_core_can_round() retur=
ns true and
> > > > > > > > > you'll take a different branch in clk_core_round_rate_nol=
ock(), avoiding
> > > > > > > > > that issue entirely.
> > > > > > > > >
> > > > > > > > > Does that patch work better (on top of next-20221012)?
> > > > > > > >
> > > > > > > > I admit I didn't go too deep in the research, as my brain p=
rocessed that as
> > > > > > > > "this is a mux clock, not really different from a standard =
mux, this callback
> > > > > > > > is missing, that's not optimal"... then that fixed it and c=
alled it a day.
> > > > > > > >
> > > > > > > > I should've prolonged my research for a better understandin=
g of what was
> > > > > > > > actually going on.
> > > > > > >
> > > > > > > No worries :)
> > > > > > >
> > > > > > > > What you said actually opened my mind and, with little surp=
rise, your patch
> > > > > > > > works as good as mine - no warnings and the clock scales as=
 expected!
> > > > > > >
> > > > > > > I'm actually wondering if you didn't encounter two issues. Wh=
at kernel
> > > > > > > were you testing before? If it's older than today's next
> > > > > > > (next-20221012), you're likely missing
> > > > > > >
> > > > > >
> > > > > > I was testing next-20221011.
> > > > > >
> > > > > > > https://lore.kernel.org/linux-clk/20221010-rpi-clk-fixes-agai=
n-v1-0-d87ba82ac404@cerno.tech/
> > > > > > >
> > > > > > > Which is likely to be what fixed the clock scaling. And my pa=
tch only
> > > > > > > fixed the warning. Could you test next-20221012? If I'm right=
, you
> > > > > > > should only get the warning.
> > > > > > >
> > > > > >
> > > > > > No, I am getting the same situation even after rebasing over ne=
xt-20221012, without
> > > > > > any of the two patches (determine_rate() for mtk mux, nor the o=
ne you shared for
> > > > > > clk.c), when the warning happens, I get very slow GPU operation=
 and the same "nice"
> > > > > > timeout:
> > > > > >
> > > > > > [   27.785514] panfrost 13000000.gpu: gpu sched timeout, js=3D1,
> > > > > > config=3D0x7b00, status=3D0x0, head=3D0xa1cb180, tail=3D0xa1cb1=
80,
> > > > > > sched_job=3D00000000f07d39e3
> > > > > >
> > > > > > ...so I'm not encountering the same issue that you've fixed wit=
h the patches that
> > > > > > got merged in next-20221012.
> > > > > >
> > > > > > Of course, as you were expecting, the warning is also still the=
re and still
> > > > > > the same:
> > > > > >
> > > > > > [   27.750504] WARNING: CPU: 4 PID: 164 at drivers/clk/clk.c:14=
62
> > > > > > clk_core_init_rate_req+0x84/0x90
> > > > >
> > > > > Ok. I'm still a bit unsure why it actually fixes anything.
> > > > >
> > > > > In the current next, clk_core_init_rate_req (through
> > > > > clk_core_forward_rate_req) will bail out right away, but the patc=
h will
> > > > > clear the request and set the requested rate.
> > > > >
> > > > > I don't think the req->rate assignment changes anything because o=
ur next
> > > > > call will be to clk_core_round_rate_nolock that will clear it in =
the
> > > > > !core path, but it might just be that we don't initialize the req=
uest
> > > > > and end up with some garbage data in it?
> > > > >
> > > > > Could you test, on top of next-20221012,
> > > >
> > > > No that's not the case, this patch has no effect at all (yes I've t=
ested it).
> > >
> > > Ok. Too bad. I've tried to build a test case that was reproducing what
> > > you experience, but I don't seem to be able to build one for now.
> > >
> > > If we go back to your previous explanation on the clock tree, and what
> > > we discussed then, there's still something a bit puzzling.
> > >
> > > You were saying that are calling clk_set_rate on mfg_bg3d, which is a
> > > mtk_gate, registered with mtk_clk_register_gate(), and with the
> > > mtk_clk_gate_ops_setclr clk_ops. There's no determine_rate / round_ra=
te
> > > implementation which makes sense for a gate, and CLK_SET_RATE_PARENT =
is
> > > set by mtk_clk_register_gate(). Everything's good.
> > >
> > > The clk_set_rate call will thus be forwarded to its parent,
> > > mfg_ck_fast_ref, which is a mux, registered with
> > > devm_clk_hw_register_mux(), with CLK_SET_RATE_PARENT as well. Makes
> > > sense too, any clk_set_rate() call will thus evaluate all of the
> > > mfg_ck_fast_ref parents and will either adjust the rate of a parent, =
or
> > > reparent.
> > >
> > > mfg_ck_fast_ref then has two parents, top_mfg_core_tmp and mfgpll.
> > > Judging from your patch, top_mfg_core_tmp is being used.
> > > top_mfg_core_tmp is a mtk_mux, registered by mtk_clk_register_mux()
> > > (through mtk_clk_register_muxes()), and using
> > > mtk_mux_gate_clr_set_upd_ops. CLK_SET_RATE_PARENT is set by
> > > mtk_clk_register_mux(). That flag still makes sense for a mux. Howeve=
r,
> > > it's really not clear to me how a mux operates without a determine_ra=
te
> > > implementation to forward the rates to each of its parents.
> > >
> > > It looks like we were relying before on the fact that the request was
> > > indeed forwarded as is to the current parent. It looks like the parent
> > > was not registered at all (core->parent being NULL), and then it was
> > > working because of $REASON, possibly one of the muxes preferred to
> > > switch to some other clock source.
> > >
> > > I think we need to address this in multiple ways:
> > >
> > > - If you have ftrace enabled on that platform, running with "tp_printk
> > >   trace_event=3Dclk:*" in the kernel command line on a failing kernel=
 would
> > >   be great, so that we can figure out what is happening exactly.
> >
> > I spent more time trying to create a setup similar to yours but couldn't
> > find anything obviously wrong. In addition to the above, could you start
> > a faulty kernel with that patch:
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 884a58a98b6b..774953901a35 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -262,6 +262,9 @@ EXPORT_SYMBOL_GPL(__clk_get_name);
> >
> >  const char *clk_hw_get_name(const struct clk_hw *hw)
> >  {
> > +       if (!hw || !hw->core)
> > +               return "(null)";
> > +
> >         return hw->core->name;
> >  }
> >  EXPORT_SYMBOL_GPL(clk_hw_get_name);
> > @@ -1471,6 +1474,17 @@ static bool clk_core_can_round(struct clk_core *=
 const core)
> >         return core->ops->determine_rate || core->ops->round_rate;
> >  }
> >
> > +static void clk_core_request_dump(const struct clk_core *core,
> > +                                 const struct clk_rate_request *req)
> > +{
> > +       pr_crit("%s\n", core ? core->name : "(null)");
> > +       pr_crit("\trate %lu\n", req->rate);
> > +       pr_crit("\tmin %lu, max %lu\n", req->min_rate, req->max_rate);
> > +       pr_crit("\tbest parent %s, rate %lu\n",
> > +               clk_hw_get_name(req->best_parent_hw),
> > +               req->best_parent_rate);
> > +}
> > +
> >  static int clk_core_round_rate_nolock(struct clk_core *core,
> >                                       struct clk_rate_request *req)
> >  {
> > @@ -2254,8 +2268,12 @@ static unsigned long clk_core_req_round_rate_nol=
ock(struct clk_core *core,
> >
> >         clk_core_init_rate_req(core, &req, req_rate);
> >
> > +       clk_core_request_dump(core, &req);
> > +
> >         ret =3D clk_core_round_rate_nolock(core, &req);
> >
> > +       clk_core_request_dump(core, &req);
> > +
> >         /* restore the protection */
> >         clk_core_rate_restore_protect(core, cnt);
> >
> >
> > Alternatively, can I easily get a MT8195 device to test more easily?
>=20
> The Acer Spin Chromebook 513, specifically CP513-2H, should be available
> on Amazon in both the US and UK. No idea about France though. And it's
> quite pricey.

Thanks, but I was more expecting some kind of SBC, and it's a bit too
expensive for me indeed :/

Maxime

--t6mdsuosigjozhu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY0e7+QAKCRDj7w1vZxhR
xc1AAP98hg2wyk0l2f5WbUXJ/BQYI9bgRmbGeUl2LH/t3nu55wEAgiEfXp+M9NJ4
zGK5TzwRWYKSgObiYWrkOyewSco0OwQ=
=lqKE
-----END PGP SIGNATURE-----

--t6mdsuosigjozhu2--
