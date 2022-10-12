Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFF5FC6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJLN4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJLN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:56:27 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025B04153E;
        Wed, 12 Oct 2022 06:56:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8581A5803C6;
        Wed, 12 Oct 2022 09:56:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Oct 2022 09:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1665582982; x=1665590182; bh=XlV/Yq00Qw
        PSf+Ud73CTUzN/nw8RT+/ZvVGs7PZYPEU=; b=dAe3xDjbfplZsSCcGXxIJ9P554
        XXSHA9yraxJYzykP7hvxGsOauEeS7UqkNPFVzOm3qMxewvCqRYhc3wVaBrQj33pi
        HXCaovNXbkNEd9EumI9fpc3pZ6AfOT489N7FVRQ3Os1t36RBI8zdnjo5ZS0SBkey
        Zb/7y/NJNIX5e4IBiQosU67UJyDqEhdOHio+urIBOSkGY0bHsGtA5oz1CubkdTd5
        O+4Ju/LfxwJuCuzRQRxtWaxBFn0LN1F1L7dOA/LA343KQjbEdFwHOefT1N2zc5q6
        hX8gJpQ+srlPw50WZ4/GsCRwz9hvSZJIibn5/2VNCbNvGI+YeOsPhNX9U/ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665582982; x=1665590182; bh=XlV/Yq00QwPSf+Ud73CTUzN/nw8R
        T+/ZvVGs7PZYPEU=; b=JUz13dR6hCiYXQzpyCdOs1q1baWqg+xXO2MmLy2nAklG
        gWgmy/pv6nHgImdgHy8aJ99h7Uu9DCrZN79pwcxgSXMmQshgkZOx1gj9dEEXB0BR
        Lx6Dfypn8SBwj0YEytbxgae6QTjDvsrWYP4EyMuHxuVPEJf9ya/B/XofBbNE/IC0
        YiPgKSByqPfy8W/e9FTv3Izi6L47E1TXQBNqkUQOcK7PjZUp0qqyfK3cGKLfwxuA
        8qkdDl7l0vylClDnvud1A8oZn/MiV4RdKyly1CZqGCwl29MuJ6Ia6miU77Zs1bJ4
        ZBnShr6xqvrnvqxT6nt1U2zsYdr1cqDiv2CkwZwaNQ==
X-ME-Sender: <xms:hcdGY3_gkj662TG8aglhzizBZAV5FSuiv-fAxCkSp9FdU-j30cijyQ>
    <xme:hcdGYzvMRfncOwouuG1hFpQ-IYfaKlg7TMtO41AgCkbNH8SwVLy3IqV8QWN84HkY3
    E7dmdMCrxdTHwQTbeA>
X-ME-Received: <xmr:hcdGY1BP-T_tk4o-KQjOKS8GYt45LBPykkhRWDw5n07MW7X9kLA0f21GxfbdUKVTqCZGWsC91ZfTK9YTQohJRVboEC-0ImQivgBO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:hcdGYzcRDP1OOBNjtEsj0yOonQ8UP1Wr5XyE_FJrshrrYguFRedZSQ>
    <xmx:hcdGY8OCkmKSCxIOQQt8h0duWPnPYjdewvKAKv2ARtvq4XvhDS4e_Q>
    <xmx:hcdGY1l7h8BrZTtxoeCPGoXOdMalIiV07RJLHvLQVq3CL5tc-cJjcw>
    <xmx:hsdGY4tYjPoUvPnYU851weDsmGbKaavwTl6PEaPbOJW6xS_4puK4Sw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Oct 2022 09:56:21 -0400 (EDT)
Date:   Wed, 12 Oct 2022 15:56:19 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: mediatek: clk-mux: Add .determine_rate() callback
Message-ID: <20221012135619.wxyzuqheolhypoec@houat>
References: <20221011135548.318323-1-angelogioacchino.delregno@collabora.com>
 <20221012085555.3nls7ja56vlnaz2w@houat>
 <c4a1eb9f-016d-c184-e494-c869038b87ff@collabora.com>
 <20221012094004.jgiyvmbgomiyedik@houat>
 <6e76f90f-3b6a-330d-6902-b31bf3d33ad4@collabora.com>
 <20221012114813.6d6adro746w5bd7c@houat>
 <decfd5e5-a48b-b2d1-f21b-1a4d52e05538@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kcn6qssihiu6sfuo"
Content-Disposition: inline
In-Reply-To: <decfd5e5-a48b-b2d1-f21b-1a4d52e05538@collabora.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kcn6qssihiu6sfuo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2022 at 02:14:39PM +0200, AngeloGioacchino Del Regno wrote:
> Il 12/10/22 13:48, Maxime Ripard ha scritto:
> > On Wed, Oct 12, 2022 at 11:57:15AM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > Il 12/10/22 11:40, Maxime Ripard ha scritto:
> > > > On Wed, Oct 12, 2022 at 11:09:59AM +0200, AngeloGioacchino Del Regn=
o wrote:
> > > > > Il 12/10/22 10:55, Maxime Ripard ha scritto:
> > > > > > Hi,
> > > > > >=20
> > > > > > On Tue, Oct 11, 2022 at 03:55:48PM +0200, AngeloGioacchino Del =
Regno wrote:
> > > > > > > Since commit 262ca38f4b6e ("clk: Stop forwarding clk_rate_req=
uests
> > > > > > > to the parent"), the clk_rate_request is .. as the title says=
, not
> > > > > > > forwarded anymore to the parent:
> > > > > >=20
> > > > > > It's not entirely true, the rate request should still be forwar=
ded, but
> > > > > > we don't pass the same instance of clk_rate_request anymore.
> > > > > >=20
> > > > > > > this produces an issue with the MediaTek clock MUX driver dur=
ing GPU
> > > > > > > DVFS on MT8195, but not on MT8192 or others.
> > > > > > >=20
> > > > > > > This is because, differently from others, like MT8192 where a=
ll of
> > > > > > > the clocks in the MFG parents tree are of mtk_mux type, but i=
n the
> > > > > > > parent tree of MT8195's MFG clock, we have one mtk_mux clock =
and
> > > > > > > one (clk framework generic) mux clock, like so:
> > > > > > >=20
> > > > > > > names: mfg_bg3d -> mfg_ck_fast_ref -> top_mfg_core_tmp (or) m=
fgpll
> > > > > > > types: mtk_gate ->      mux        ->     mtk_mux      (or) m=
tk_pll
> > > > > > >=20
> > > > > > > To solve this issue and also keep the GPU DVFS clocks code wo=
rking
> > > > > > > as expected, wire up a .determine_rate() callback for the mtk=
_mux
> > > > > > > ops; for that, the standard clk_mux_determine_rate_flags() wa=
s used
> > > > > > > as it was possible to.
> > > > > >=20
> > > > > > It probably fixes things indeed, but I'm a bit worried that it =
just
> > > > > > works around the actual issue instead of fixing the actual bug.=
=2E.
> > > > > >=20
> > > > > > > This commit was successfully tested on MT6795 Xperia M5, MT81=
73 Elm,
> > > > > > > MT8192 Spherion and MT8195 Tomato; no regressions were seen.
> > > > > > >=20
> > > > > > > For the sake of some more documentation about this issue here=
's the
> > > > > > > trace of it:
> > > > > > >=20
> > > > > > > [   12.211587] ------------[ cut here ]------------
> > > > > > > [   12.211589] WARNING: CPU: 6 PID: 78 at drivers/clk/clk.c:1=
462 clk_core_init_rate_req+0x84/0x90
> > > > > > > [   12.211593] Modules linked in: stp crct10dif_ce mtk_adsp_c=
ommon llc rfkill snd_sof_xtensa_dsp
> > > > > > >                   panfrost(+) sbs_battery cros_ec_lid_angle c=
ros_ec_sensors snd_sof_of
> > > > > > >                   cros_ec_sensors_core hid_multitouch cros_us=
bpd_logger snd_sof gpu_sched
> > > > > > >                   snd_sof_utils fuse ipv6
> > > > > > > [   12.211614] CPU: 6 PID: 78 Comm: kworker/u16:2 Tainted: G =
       W          6.0.0-next-20221011+ #58
> > > > > > > [   12.211616] Hardware name: Acer Tomato (rev2) board (DT)
> > > > > > > [   12.211617] Workqueue: devfreq_wq devfreq_monitor
> > > > > > > [   12.211620] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DI=
T -SSBS BTYPE=3D--)
> > > > > > > [   12.211622] pc : clk_core_init_rate_req+0x84/0x90
> > > > > > > [   12.211625] lr : clk_core_forward_rate_req+0xa4/0xe4
> > > > > > > [   12.211627] sp : ffff80000893b8e0
> > > > > > > [   12.211628] x29: ffff80000893b8e0 x28: ffffdddf92f9b000 x2=
7: ffff46a2c0e8bc05
> > > > > > > [   12.211632] x26: ffff46a2c1041200 x25: 0000000000000000 x2=
4: 00000000173eed80
> > > > > > > [   12.211636] x23: ffff80000893b9c0 x22: ffff80000893b940 x2=
1: 0000000000000000
> > > > > > > [   12.211641] x20: ffff46a2c1039f00 x19: ffff46a2c1039f00 x1=
8: 0000000000000000
> > > > > > > [   12.211645] x17: 0000000000000038 x16: 000000000000d904 x1=
5: 0000000000000003
> > > > > > > [   12.211649] x14: ffffdddf9357ce48 x13: ffffdddf935e71c8 x1=
2: 000000000004803c
> > > > > > > [   12.211653] x11: 00000000a867d7ad x10: 00000000a867d7ad x9=
 : ffffdddf90c28df4
> > > > > > > [   12.211657] x8 : ffffdddf9357a980 x7 : 0000000000000000 x6=
 : 0000000000000004
> > > > > > > [   12.211661] x5 : ffffffffffffffc8 x4 : 00000000173eed80 x3=
 : ffff80000893b940
> > > > > > > [   12.211665] x2 : 00000000173eed80 x1 : ffff80000893b940 x0=
 : 0000000000000000
> > > > > > > [   12.211669] Call trace:
> > > > > > > [   12.211670]  clk_core_init_rate_req+0x84/0x90
> > > > > > > [   12.211673]  clk_core_round_rate_nolock+0xe8/0x10c
> > > > > > > [   12.211675]  clk_mux_determine_rate_flags+0x174/0x1f0
> > > > > > > [   12.211677]  clk_mux_determine_rate+0x1c/0x30
> > > > > > > [   12.211680]  clk_core_determine_round_nolock+0x74/0x130
> > > > > > > [   12.211682]  clk_core_round_rate_nolock+0x58/0x10c
> > > > > > > [   12.211684]  clk_core_round_rate_nolock+0xf4/0x10c
> > > > > > > [   12.211686]  clk_core_set_rate_nolock+0x194/0x2ac
> > > > > > > [   12.211688]  clk_set_rate+0x40/0x94
> > > > > > > [   12.211691]  _opp_config_clk_single+0x38/0xa0
> > > > > > > [   12.211693]  _set_opp+0x1b0/0x500
> > > > > > > [   12.211695]  dev_pm_opp_set_rate+0x120/0x290
> > > > > > > [   12.211697]  panfrost_devfreq_target+0x3c/0x50 [panfrost]
> > > > > > > [   12.211705]  devfreq_set_target+0x8c/0x2d0
> > > > > > > [   12.211707]  devfreq_update_target+0xcc/0xf4
> > > > > > > [   12.211708]  devfreq_monitor+0x40/0x1d0
> > > > > > > [   12.211710]  process_one_work+0x294/0x664
> > > > > > > [   12.211712]  worker_thread+0x7c/0x45c
> > > > > > > [   12.211713]  kthread+0x104/0x110
> > > > > > > [   12.211716]  ret_from_fork+0x10/0x20
> > > > > > > [   12.211718] irq event stamp: 7102
> > > > > > > [   12.211719] hardirqs last  enabled at (7101): [<ffffdddf90=
4ea5a0>] finish_task_switch.isra.0+0xec/0x2f0
> > > > > > > [   12.211723] hardirqs last disabled at (7102): [<ffffdddf91=
794b74>] el1_dbg+0x24/0x90
> > > > > > > [   12.211726] softirqs last  enabled at (6716): [<ffffdddf90=
410be4>] __do_softirq+0x414/0x588
> > > > > > > [   12.211728] softirqs last disabled at (6507): [<ffffdddf90=
4171d8>] ____do_softirq+0x18/0x24
> > > > > > > [   12.211730] ---[ end trace 0000000000000000 ]---
> > > > > >=20
> > > > > > ... Indeed, you shouldn't hit that warning at all. It happens in
> > > > > > clk_core_round_rate_nolock, which takes (before your patch) the
> > > > > > CLK_SET_RATE_PARENT branch. This indeed has been changed by the=
 patch
> > > > > > you mentioned, and will call clk_core_forward_rate_req() now, t=
hat in
> > > > > > turn calls clk_core_init_rate_nolock().
> > > > > >=20
> > > > > > I think the warning you hit is because core->parent is NULL, wh=
ich is
> > > > > > passed to clk_core_forward_rate_req() as the parent argument, a=
nd we'll
> > > > > > call clk_core_init_rate_req() with parent set as the core argum=
ent.
> > > > > >=20
> > > > > > In clk_core_init_rate_req(), the first thing we do is a WARN_ON=
(!core),
> > > > > > which is what you hit here I think.
> > > > > >=20
> > > > > > This is different to the previous behavior that was calling
> > > > > > clk_core_round_rate_nolock() with core->parent directly, and
> > > > > > clk_core_round_rate_nolock() if its core argument is NULL will =
set
> > > > > > req->rate to 0 and bail out without returning an error.
> > > > > >=20
> > > > > > Now, your patch probably works because now that you provide a
> > > > > > determine_rate implementation, clk_core_can_round() returns tru=
e and
> > > > > > you'll take a different branch in clk_core_round_rate_nolock(),=
 avoiding
> > > > > > that issue entirely.
> > > > > >=20
> > > > > > Does that patch work better (on top of next-20221012)?
> > > > >=20
> > > > > I admit I didn't go too deep in the research, as my brain process=
ed that as
> > > > > "this is a mux clock, not really different from a standard mux, t=
his callback
> > > > > is missing, that's not optimal"... then that fixed it and called =
it a day.
> > > > >=20
> > > > > I should've prolonged my research for a better understanding of w=
hat was
> > > > > actually going on.
> > > >=20
> > > > No worries :)
> > > >=20
> > > > > What you said actually opened my mind and, with little surprise, =
your patch
> > > > > works as good as mine - no warnings and the clock scales as expec=
ted!
> > > >=20
> > > > I'm actually wondering if you didn't encounter two issues. What ker=
nel
> > > > were you testing before? If it's older than today's next
> > > > (next-20221012), you're likely missing
> > > >=20
> > >=20
> > > I was testing next-20221011.
> > >=20
> > > > https://lore.kernel.org/linux-clk/20221010-rpi-clk-fixes-again-v1-0=
-d87ba82ac404@cerno.tech/
> > > >=20
> > > > Which is likely to be what fixed the clock scaling. And my patch on=
ly
> > > > fixed the warning. Could you test next-20221012? If I'm right, you
> > > > should only get the warning.
> > > >=20
> > >=20
> > > No, I am getting the same situation even after rebasing over next-202=
21012, without
> > > any of the two patches (determine_rate() for mtk mux, nor the one you=
 shared for
> > > clk.c), when the warning happens, I get very slow GPU operation and t=
he same "nice"
> > > timeout:
> > >=20
> > > [   27.785514] panfrost 13000000.gpu: gpu sched timeout, js=3D1,
> > > config=3D0x7b00, status=3D0x0, head=3D0xa1cb180, tail=3D0xa1cb180,
> > > sched_job=3D00000000f07d39e3
> > >=20
> > > ...so I'm not encountering the same issue that you've fixed with the =
patches that
> > > got merged in next-20221012.
> > >=20
> > > Of course, as you were expecting, the warning is also still there and=
 still
> > > the same:
> > >=20
> > > [   27.750504] WARNING: CPU: 4 PID: 164 at drivers/clk/clk.c:1462
> > > clk_core_init_rate_req+0x84/0x90
> >=20
> > Ok. I'm still a bit unsure why it actually fixes anything.
> >=20
> > In the current next, clk_core_init_rate_req (through
> > clk_core_forward_rate_req) will bail out right away, but the patch will
> > clear the request and set the requested rate.
> >=20
> > I don't think the req->rate assignment changes anything because our next
> > call will be to clk_core_round_rate_nolock that will clear it in the
> > !core path, but it might just be that we don't initialize the request
> > and end up with some garbage data in it?
> >=20
> > Could you test, on top of next-20221012,
>=20
> No that's not the case, this patch has no effect at all (yes I've tested =
it).

Ok. Too bad. I've tried to build a test case that was reproducing what
you experience, but I don't seem to be able to build one for now.

If we go back to your previous explanation on the clock tree, and what
we discussed then, there's still something a bit puzzling.

You were saying that are calling clk_set_rate on mfg_bg3d, which is a
mtk_gate, registered with mtk_clk_register_gate(), and with the
mtk_clk_gate_ops_setclr clk_ops. There's no determine_rate / round_rate
implementation which makes sense for a gate, and CLK_SET_RATE_PARENT is
set by mtk_clk_register_gate(). Everything's good.

The clk_set_rate call will thus be forwarded to its parent,
mfg_ck_fast_ref, which is a mux, registered with
devm_clk_hw_register_mux(), with CLK_SET_RATE_PARENT as well. Makes
sense too, any clk_set_rate() call will thus evaluate all of the
mfg_ck_fast_ref parents and will either adjust the rate of a parent, or
reparent.

mfg_ck_fast_ref then has two parents, top_mfg_core_tmp and mfgpll.
Judging from your patch, top_mfg_core_tmp is being used.
top_mfg_core_tmp is a mtk_mux, registered by mtk_clk_register_mux()
(through mtk_clk_register_muxes()), and using
mtk_mux_gate_clr_set_upd_ops. CLK_SET_RATE_PARENT is set by
mtk_clk_register_mux(). That flag still makes sense for a mux. However,
it's really not clear to me how a mux operates without a determine_rate
implementation to forward the rates to each of its parents.

It looks like we were relying before on the fact that the request was
indeed forwarded as is to the current parent. It looks like the parent
was not registered at all (core->parent being NULL), and then it was
working because of $REASON, possibly one of the muxes preferred to
switch to some other clock source.

I think we need to address this in multiple ways:

- If you have ftrace enabled on that platform, running with "tp_printk
  trace_event=3Dclk:*" in the kernel command line on a failing kernel would
  be great, so that we can figure out what is happening exactly.

- We really need to merge your patch above as well;

- And, if we can, we should forbid to register a mux without a
  determine_rate implementation. We have to take into account that some
  muxes are going to be RO and won't need a determine_rate
  implementation at all, but a clock with a set_parent and without a
  determine_rate seems like a weird combination.

What do you think?
Maxime

--kcn6qssihiu6sfuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY0bHgwAKCRDj7w1vZxhR
xRdjAQC88Smw62YZ1wYzHqINZHYyDh7VIc0s3TVzSxDwxIH+/AEAhuJVmfCksO7A
ODVG1x4qrBpqNXsiecvSzrJaoOOzgAI=
=q6gZ
-----END PGP SIGNATURE-----

--kcn6qssihiu6sfuo--
