Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3ED5FD626
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJMIZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJMIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:25:12 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA4D4A127;
        Thu, 13 Oct 2022 01:25:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 45E8358040D;
        Thu, 13 Oct 2022 04:25:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 13 Oct 2022 04:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1665649508; x=1665656708; bh=cqp4+YWAOm
        3k0gFogpvKyshExlmiJ4IVLFWhm86SsZk=; b=yOHxYbLfWTjjCiVFodNBVXapcF
        TQiRdm3Bgk7Q+3aYTPWYYAQVL7kLfp6TD5Ztwsr5PX7PoJoeoYupxIup9IEuwDyp
        nqdJbfniFdzwQ15chm+CKZb1KKBRbilz2q11HDRGpj8PvdU+m5F862Z+62d3gJkJ
        Lq6jj6kSxcjCAlGjrsCZCIAFQ4tgrGIDb480FMiyOOFFeey89bM2Jjm5iIS4gLaK
        3A8OpsF6UT1IOywBhxKIf36z9tU7eeHLa4Iz6zQNyExgeQ9rPJolV8Vede7/JK3W
        8tflO/cT/SODl2N4Hj3QsPMcZozT7J6v7ew61lom6T6v2I5cOPFkW+HI6Z8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665649508; x=1665656708; bh=cqp4+YWAOm3k0gFogpvKyshExlmi
        J4IVLFWhm86SsZk=; b=dOV6t4ns9vvqo3y00c3+LPhK43CoUucZ3saMMjtG3jBq
        W4chuvvt5uKiEWw8yn5yCwqt1YKM03CkgFEATK2r11VPGRZd/8rWUPzTqkt4XIV8
        ICponfj6txBuht0J5kLqwd6wJGLyh4oMcR3TSfYZBXrfQ5TlBn1oczlbEYCnCOmM
        DHha/EYnUS/+7ibXpfE7Ppv+iyetLNd30aWPjnKEXjkRzLQnhZjFbpfifJMeoRz6
        XTDi1kJP58umNCi0lPqPSTgyLg5+wyzjmITvnnSy0q7OFV5VO+CnJ7wDGpEwLsNF
        knZ8i3XyIWXA3MMnZhYd2qawI0lh9npHkN/01cKnFw==
X-ME-Sender: <xms:Y8tHY_JfdyB8yrdLaCFmKarCDhUY8DBdY_SBV7xpR9rgaUcexWliag>
    <xme:Y8tHYzJiFarbbp_U7_S7O785jWR5nrwYBdcnCTdlcS52z1i1DgJmqZoY0Bc8r4CHG
    EzRNoRRwXeuNN-7xHc>
X-ME-Received: <xmr:Y8tHY3sTzHqKyH3io5sc0j0XyZbxV9ruL3vbLkpa50oAOdT-3B0iQUsR_jVjWWjfRvlb4NNehZUfvJz1TrERGuBWNd-Y7LYB74db>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:Y8tHY4Y5rIZeODhdUD1gsdPvrbEeULDBN_83-QsGqDdaaIYJgC_AiQ>
    <xmx:Y8tHY2amzoojpK4C2mW_XC1Y8r79y2Vyvu-8vwMpO8GCWRhv14nzbg>
    <xmx:Y8tHY8AZax7WdS8rNzfP92t8Pq26LmLIQ2F82n2PP_8DTp07PQXWZQ>
    <xmx:ZMtHYzJbpQKpuMZEh6fqQvjhpIf9G4Cg_hTW0yTxlW3qscLrg1rDcw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 04:25:07 -0400 (EDT)
Date:   Thu, 13 Oct 2022 10:25:04 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: mediatek: clk-mux: Add .determine_rate() callback
Message-ID: <20221013082504.wedxd6os3ipe2x2v@houat>
References: <c4a1eb9f-016d-c184-e494-c869038b87ff@collabora.com>
 <20221012094004.jgiyvmbgomiyedik@houat>
 <6e76f90f-3b6a-330d-6902-b31bf3d33ad4@collabora.com>
 <20221012114813.6d6adro746w5bd7c@houat>
 <decfd5e5-a48b-b2d1-f21b-1a4d52e05538@collabora.com>
 <20221012135619.wxyzuqheolhypoec@houat>
 <20221012164204.oulzmj67hxrojrb6@houat>
 <CAGb2v67A5u99mgNTdDfp4161OKKKjib5kM_EuWHJXBwUvxXU+g@mail.gmail.com>
 <20221013071921.ny6qskjubweiyq6q@houat>
 <3cba4b83-98e7-0351-71f0-1aaa67f97797@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xvoswui7ypuqtq4i"
Content-Disposition: inline
In-Reply-To: <3cba4b83-98e7-0351-71f0-1aaa67f97797@collabora.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xvoswui7ypuqtq4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

Thanks again for testing, it's very appreciated

On Thu, Oct 13, 2022 at 10:13:04AM +0200, AngeloGioacchino Del Regno wrote:
> Il 13/10/22 09:19, Maxime Ripard ha scritto:
> > On Thu, Oct 13, 2022 at 12:52:41AM +0800, Chen-Yu Tsai wrote:
> > > On Thu, Oct 13, 2022 at 12:42 AM Maxime Ripard <maxime@cerno.tech> wr=
ote:
> > > >=20
> > > > On Wed, Oct 12, 2022 at 03:56:19PM +0200, Maxime Ripard wrote:
> > > > > On Wed, Oct 12, 2022 at 02:14:39PM +0200, AngeloGioacchino Del Re=
gno wrote:
> > > > > > Il 12/10/22 13:48, Maxime Ripard ha scritto:
> > > > > > > On Wed, Oct 12, 2022 at 11:57:15AM +0200, AngeloGioacchino De=
l Regno wrote:
> > > > > > > > Il 12/10/22 11:40, Maxime Ripard ha scritto:
> > > > > > > > > On Wed, Oct 12, 2022 at 11:09:59AM +0200, AngeloGioacchin=
o Del Regno wrote:
> > > > > > > > > > Il 12/10/22 10:55, Maxime Ripard ha scritto:
> > > > > > > > > > > Hi,
> > > > > > > > > > >=20
> > > > > > > > > > > On Tue, Oct 11, 2022 at 03:55:48PM +0200, AngeloGioac=
chino Del Regno wrote:
> > > > > > > > > > > > Since commit 262ca38f4b6e ("clk: Stop forwarding cl=
k_rate_requests
> > > > > > > > > > > > to the parent"), the clk_rate_request is .. as the =
title says, not
> > > > > > > > > > > > forwarded anymore to the parent:
> > > > > > > > > > >=20
> > > > > > > > > > > It's not entirely true, the rate request should still=
 be forwarded, but
> > > > > > > > > > > we don't pass the same instance of clk_rate_request a=
nymore.
> > > > > > > > > > >=20
> > > > > > > > > > > > this produces an issue with the MediaTek clock MUX =
driver during GPU
> > > > > > > > > > > > DVFS on MT8195, but not on MT8192 or others.
> > > > > > > > > > > >=20
> > > > > > > > > > > > This is because, differently from others, like MT81=
92 where all of
> > > > > > > > > > > > the clocks in the MFG parents tree are of mtk_mux t=
ype, but in the
> > > > > > > > > > > > parent tree of MT8195's MFG clock, we have one mtk_=
mux clock and
> > > > > > > > > > > > one (clk framework generic) mux clock, like so:
> > > > > > > > > > > >=20
> > > > > > > > > > > > names: mfg_bg3d -> mfg_ck_fast_ref -> top_mfg_core_=
tmp (or) mfgpll
> > > > > > > > > > > > types: mtk_gate ->      mux        ->     mtk_mux  =
    (or) mtk_pll
> > > > > > > > > > > >=20
> > > > > > > > > > > > To solve this issue and also keep the GPU DVFS cloc=
ks code working
> > > > > > > > > > > > as expected, wire up a .determine_rate() callback f=
or the mtk_mux
> > > > > > > > > > > > ops; for that, the standard clk_mux_determine_rate_=
flags() was used
> > > > > > > > > > > > as it was possible to.
> > > > > > > > > > >=20
> > > > > > > > > > > It probably fixes things indeed, but I'm a bit worrie=
d that it just
> > > > > > > > > > > works around the actual issue instead of fixing the a=
ctual bug...
> > > > > > > > > > >=20
> > > > > > > > > > > > This commit was successfully tested on MT6795 Xperi=
a M5, MT8173 Elm,
> > > > > > > > > > > > MT8192 Spherion and MT8195 Tomato; no regressions w=
ere seen.
> > > > > > > > > > > >=20
> > > > > > > > > > > > For the sake of some more documentation about this =
issue here's the
> > > > > > > > > > > > trace of it:
> > > > > > > > > > > >=20
> > > > > > > > > > > > [   12.211587] ------------[ cut here ]------------
> > > > > > > > > > > > [   12.211589] WARNING: CPU: 6 PID: 78 at drivers/c=
lk/clk.c:1462 clk_core_init_rate_req+0x84/0x90
> > > > > > > > > > > > [   12.211593] Modules linked in: stp crct10dif_ce =
mtk_adsp_common llc rfkill snd_sof_xtensa_dsp
> > > > > > > > > > > >                    panfrost(+) sbs_battery cros_ec_=
lid_angle cros_ec_sensors snd_sof_of
> > > > > > > > > > > >                    cros_ec_sensors_core hid_multito=
uch cros_usbpd_logger snd_sof gpu_sched
> > > > > > > > > > > >                    snd_sof_utils fuse ipv6
> > > > > > > > > > > > [   12.211614] CPU: 6 PID: 78 Comm: kworker/u16:2 T=
ainted: G        W          6.0.0-next-20221011+ #58
> > > > > > > > > > > > [   12.211616] Hardware name: Acer Tomato (rev2) bo=
ard (DT)
> > > > > > > > > > > > [   12.211617] Workqueue: devfreq_wq devfreq_monitor
> > > > > > > > > > > > [   12.211620] pstate: 40400009 (nZcv daif +PAN -UA=
O -TCO -DIT -SSBS BTYPE=3D--)
> > > > > > > > > > > > [   12.211622] pc : clk_core_init_rate_req+0x84/0x90
> > > > > > > > > > > > [   12.211625] lr : clk_core_forward_rate_req+0xa4/=
0xe4
> > > > > > > > > > > > [   12.211627] sp : ffff80000893b8e0
> > > > > > > > > > > > [   12.211628] x29: ffff80000893b8e0 x28: ffffdddf9=
2f9b000 x27: ffff46a2c0e8bc05
> > > > > > > > > > > > [   12.211632] x26: ffff46a2c1041200 x25: 000000000=
0000000 x24: 00000000173eed80
> > > > > > > > > > > > [   12.211636] x23: ffff80000893b9c0 x22: ffff80000=
893b940 x21: 0000000000000000
> > > > > > > > > > > > [   12.211641] x20: ffff46a2c1039f00 x19: ffff46a2c=
1039f00 x18: 0000000000000000
> > > > > > > > > > > > [   12.211645] x17: 0000000000000038 x16: 000000000=
000d904 x15: 0000000000000003
> > > > > > > > > > > > [   12.211649] x14: ffffdddf9357ce48 x13: ffffdddf9=
35e71c8 x12: 000000000004803c
> > > > > > > > > > > > [   12.211653] x11: 00000000a867d7ad x10: 00000000a=
867d7ad x9 : ffffdddf90c28df4
> > > > > > > > > > > > [   12.211657] x8 : ffffdddf9357a980 x7 : 000000000=
0000000 x6 : 0000000000000004
> > > > > > > > > > > > [   12.211661] x5 : ffffffffffffffc8 x4 : 000000001=
73eed80 x3 : ffff80000893b940
> > > > > > > > > > > > [   12.211665] x2 : 00000000173eed80 x1 : ffff80000=
893b940 x0 : 0000000000000000
> > > > > > > > > > > > [   12.211669] Call trace:
> > > > > > > > > > > > [   12.211670]  clk_core_init_rate_req+0x84/0x90
> > > > > > > > > > > > [   12.211673]  clk_core_round_rate_nolock+0xe8/0x1=
0c
> > > > > > > > > > > > [   12.211675]  clk_mux_determine_rate_flags+0x174/=
0x1f0
> > > > > > > > > > > > [   12.211677]  clk_mux_determine_rate+0x1c/0x30
> > > > > > > > > > > > [   12.211680]  clk_core_determine_round_nolock+0x7=
4/0x130
> > > > > > > > > > > > [   12.211682]  clk_core_round_rate_nolock+0x58/0x1=
0c
> > > > > > > > > > > > [   12.211684]  clk_core_round_rate_nolock+0xf4/0x1=
0c
> > > > > > > > > > > > [   12.211686]  clk_core_set_rate_nolock+0x194/0x2ac
> > > > > > > > > > > > [   12.211688]  clk_set_rate+0x40/0x94
> > > > > > > > > > > > [   12.211691]  _opp_config_clk_single+0x38/0xa0
> > > > > > > > > > > > [   12.211693]  _set_opp+0x1b0/0x500
> > > > > > > > > > > > [   12.211695]  dev_pm_opp_set_rate+0x120/0x290
> > > > > > > > > > > > [   12.211697]  panfrost_devfreq_target+0x3c/0x50 [=
panfrost]
> > > > > > > > > > > > [   12.211705]  devfreq_set_target+0x8c/0x2d0
> > > > > > > > > > > > [   12.211707]  devfreq_update_target+0xcc/0xf4
> > > > > > > > > > > > [   12.211708]  devfreq_monitor+0x40/0x1d0
> > > > > > > > > > > > [   12.211710]  process_one_work+0x294/0x664
> > > > > > > > > > > > [   12.211712]  worker_thread+0x7c/0x45c
> > > > > > > > > > > > [   12.211713]  kthread+0x104/0x110
> > > > > > > > > > > > [   12.211716]  ret_from_fork+0x10/0x20
> > > > > > > > > > > > [   12.211718] irq event stamp: 7102
> > > > > > > > > > > > [   12.211719] hardirqs last  enabled at (7101): [<=
ffffdddf904ea5a0>] finish_task_switch.isra.0+0xec/0x2f0
> > > > > > > > > > > > [   12.211723] hardirqs last disabled at (7102): [<=
ffffdddf91794b74>] el1_dbg+0x24/0x90
> > > > > > > > > > > > [   12.211726] softirqs last  enabled at (6716): [<=
ffffdddf90410be4>] __do_softirq+0x414/0x588
> > > > > > > > > > > > [   12.211728] softirqs last disabled at (6507): [<=
ffffdddf904171d8>] ____do_softirq+0x18/0x24
> > > > > > > > > > > > [   12.211730] ---[ end trace 0000000000000000 ]---
> > > > > > > > > > >=20
> > > > > > > > > > > ... Indeed, you shouldn't hit that warning at all. It=
 happens in
> > > > > > > > > > > clk_core_round_rate_nolock, which takes (before your =
patch) the
> > > > > > > > > > > CLK_SET_RATE_PARENT branch. This indeed has been chan=
ged by the patch
> > > > > > > > > > > you mentioned, and will call clk_core_forward_rate_re=
q() now, that in
> > > > > > > > > > > turn calls clk_core_init_rate_nolock().
> > > > > > > > > > >=20
> > > > > > > > > > > I think the warning you hit is because core->parent i=
s NULL, which is
> > > > > > > > > > > passed to clk_core_forward_rate_req() as the parent a=
rgument, and we'll
> > > > > > > > > > > call clk_core_init_rate_req() with parent set as the =
core argument.
> > > > > > > > > > >=20
> > > > > > > > > > > In clk_core_init_rate_req(), the first thing we do is=
 a WARN_ON(!core),
> > > > > > > > > > > which is what you hit here I think.
> > > > > > > > > > >=20
> > > > > > > > > > > This is different to the previous behavior that was c=
alling
> > > > > > > > > > > clk_core_round_rate_nolock() with core->parent direct=
ly, and
> > > > > > > > > > > clk_core_round_rate_nolock() if its core argument is =
NULL will set
> > > > > > > > > > > req->rate to 0 and bail out without returning an erro=
r.
> > > > > > > > > > >=20
> > > > > > > > > > > Now, your patch probably works because now that you p=
rovide a
> > > > > > > > > > > determine_rate implementation, clk_core_can_round() r=
eturns true and
> > > > > > > > > > > you'll take a different branch in clk_core_round_rate=
_nolock(), avoiding
> > > > > > > > > > > that issue entirely.
> > > > > > > > > > >=20
> > > > > > > > > > > Does that patch work better (on top of next-20221012)?
> > > > > > > > > >=20
> > > > > > > > > > I admit I didn't go too deep in the research, as my bra=
in processed that as
> > > > > > > > > > "this is a mux clock, not really different from a stand=
ard mux, this callback
> > > > > > > > > > is missing, that's not optimal"... then that fixed it a=
nd called it a day.
> > > > > > > > > >=20
> > > > > > > > > > I should've prolonged my research for a better understa=
nding of what was
> > > > > > > > > > actually going on.
> > > > > > > > >=20
> > > > > > > > > No worries :)
> > > > > > > > >=20
> > > > > > > > > > What you said actually opened my mind and, with little =
surprise, your patch
> > > > > > > > > > works as good as mine - no warnings and the clock scale=
s as expected!
> > > > > > > > >=20
> > > > > > > > > I'm actually wondering if you didn't encounter two issues=
=2E What kernel
> > > > > > > > > were you testing before? If it's older than today's next
> > > > > > > > > (next-20221012), you're likely missing
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I was testing next-20221011.
> > > > > > > >=20
> > > > > > > > > https://lore.kernel.org/linux-clk/20221010-rpi-clk-fixes-=
again-v1-0-d87ba82ac404@cerno.tech/
> > > > > > > > >=20
> > > > > > > > > Which is likely to be what fixed the clock scaling. And m=
y patch only
> > > > > > > > > fixed the warning. Could you test next-20221012? If I'm r=
ight, you
> > > > > > > > > should only get the warning.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > No, I am getting the same situation even after rebasing ove=
r next-20221012, without
> > > > > > > > any of the two patches (determine_rate() for mtk mux, nor t=
he one you shared for
> > > > > > > > clk.c), when the warning happens, I get very slow GPU opera=
tion and the same "nice"
> > > > > > > > timeout:
> > > > > > > >=20
> > > > > > > > [   27.785514] panfrost 13000000.gpu: gpu sched timeout, js=
=3D1,
> > > > > > > > config=3D0x7b00, status=3D0x0, head=3D0xa1cb180, tail=3D0xa=
1cb180,
> > > > > > > > sched_job=3D00000000f07d39e3
> > > > > > > >=20
> > > > > > > > ...so I'm not encountering the same issue that you've fixed=
 with the patches that
> > > > > > > > got merged in next-20221012.
> > > > > > > >=20
> > > > > > > > Of course, as you were expecting, the warning is also still=
 there and still
> > > > > > > > the same:
> > > > > > > >=20
> > > > > > > > [   27.750504] WARNING: CPU: 4 PID: 164 at drivers/clk/clk.=
c:1462
> > > > > > > > clk_core_init_rate_req+0x84/0x90
> > > > > > >=20
> > > > > > > Ok. I'm still a bit unsure why it actually fixes anything.
> > > > > > >=20
> > > > > > > In the current next, clk_core_init_rate_req (through
> > > > > > > clk_core_forward_rate_req) will bail out right away, but the =
patch will
> > > > > > > clear the request and set the requested rate.
> > > > > > >=20
> > > > > > > I don't think the req->rate assignment changes anything becau=
se our next
> > > > > > > call will be to clk_core_round_rate_nolock that will clear it=
 in the
> > > > > > > !core path, but it might just be that we don't initialize the=
 request
> > > > > > > and end up with some garbage data in it?
> > > > > > >=20
> > > > > > > Could you test, on top of next-20221012,
> > > > > >=20
> > > > > > No that's not the case, this patch has no effect at all (yes I'=
ve tested it).
> > > > >=20
> > > > > Ok. Too bad. I've tried to build a test case that was reproducing=
 what
> > > > > you experience, but I don't seem to be able to build one for now.
> > > > >=20
> > > > > If we go back to your previous explanation on the clock tree, and=
 what
> > > > > we discussed then, there's still something a bit puzzling.
> > > > >=20
> > > > > You were saying that are calling clk_set_rate on mfg_bg3d, which =
is a
> > > > > mtk_gate, registered with mtk_clk_register_gate(), and with the
> > > > > mtk_clk_gate_ops_setclr clk_ops. There's no determine_rate / roun=
d_rate
> > > > > implementation which makes sense for a gate, and CLK_SET_RATE_PAR=
ENT is
> > > > > set by mtk_clk_register_gate(). Everything's good.
> > > > >=20
> > > > > The clk_set_rate call will thus be forwarded to its parent,
> > > > > mfg_ck_fast_ref, which is a mux, registered with
> > > > > devm_clk_hw_register_mux(), with CLK_SET_RATE_PARENT as well. Mak=
es
> > > > > sense too, any clk_set_rate() call will thus evaluate all of the
> > > > > mfg_ck_fast_ref parents and will either adjust the rate of a pare=
nt, or
> > > > > reparent.
> > > > >=20
> > > > > mfg_ck_fast_ref then has two parents, top_mfg_core_tmp and mfgpll.
> > > > > Judging from your patch, top_mfg_core_tmp is being used.
> > > > > top_mfg_core_tmp is a mtk_mux, registered by mtk_clk_register_mux=
()
> > > > > (through mtk_clk_register_muxes()), and using
> > > > > mtk_mux_gate_clr_set_upd_ops. CLK_SET_RATE_PARENT is set by
> > > > > mtk_clk_register_mux(). That flag still makes sense for a mux. Ho=
wever,
> > > > > it's really not clear to me how a mux operates without a determin=
e_rate
> > > > > implementation to forward the rates to each of its parents.
> > > > >=20
> > > > > It looks like we were relying before on the fact that the request=
 was
> > > > > indeed forwarded as is to the current parent. It looks like the p=
arent
> > > > > was not registered at all (core->parent being NULL), and then it =
was
> > > > > working because of $REASON, possibly one of the muxes preferred to
> > > > > switch to some other clock source.
> > > > >=20
> > > > > I think we need to address this in multiple ways:
> > > > >=20
> > > > > - If you have ftrace enabled on that platform, running with "tp_p=
rintk
> > > > >    trace_event=3Dclk:*" in the kernel command line on a failing k=
ernel would
> > > > >    be great, so that we can figure out what is happening exactly.
> > > >=20
> > > > I spent more time trying to create a setup similar to yours but cou=
ldn't
> > > > find anything obviously wrong. In addition to the above, could you =
start
> > > > a faulty kernel with that patch:
> > > >=20
> > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > index 884a58a98b6b..774953901a35 100644
> > > > --- a/drivers/clk/clk.c
> > > > +++ b/drivers/clk/clk.c
> > > > @@ -262,6 +262,9 @@ EXPORT_SYMBOL_GPL(__clk_get_name);
> > > >=20
> > > >   const char *clk_hw_get_name(const struct clk_hw *hw)
> > > >   {
> > > > +       if (!hw || !hw->core)
> > > > +               return "(null)";
> > > > +
> > > >          return hw->core->name;
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(clk_hw_get_name);
> > > > @@ -1471,6 +1474,17 @@ static bool clk_core_can_round(struct clk_co=
re * const core)
> > > >          return core->ops->determine_rate || core->ops->round_rate;
> > > >   }
> > > >=20
> > > > +static void clk_core_request_dump(const struct clk_core *core,
> > > > +                                 const struct clk_rate_request *re=
q)
> > > > +{
> > > > +       pr_crit("%s\n", core ? core->name : "(null)");
> > > > +       pr_crit("\trate %lu\n", req->rate);
> > > > +       pr_crit("\tmin %lu, max %lu\n", req->min_rate, req->max_rat=
e);
> > > > +       pr_crit("\tbest parent %s, rate %lu\n",
> > > > +               clk_hw_get_name(req->best_parent_hw),
> > > > +               req->best_parent_rate);
> > > > +}
> > > > +
> > > >   static int clk_core_round_rate_nolock(struct clk_core *core,
> > > >                                        struct clk_rate_request *req)
> > > >   {
> > > > @@ -2254,8 +2268,12 @@ static unsigned long clk_core_req_round_rate=
_nolock(struct clk_core *core,
> > > >=20
> > > >          clk_core_init_rate_req(core, &req, req_rate);
> > > >=20
> > > > +       clk_core_request_dump(core, &req);
> > > > +
> > > >          ret =3D clk_core_round_rate_nolock(core, &req);
> > > >=20
> > > > +       clk_core_request_dump(core, &req);
> > > > +
> > > >          /* restore the protection */
> > > >          clk_core_rate_restore_protect(core, cnt);
> > > >=20
> > > >=20
> > > > Alternatively, can I easily get a MT8195 device to test more easily?
> > >=20
> > > The Acer Spin Chromebook 513, specifically CP513-2H, should be availa=
ble
> > > on Amazon in both the US and UK. No idea about France though. And it's
> > > quite pricey.
> >=20
> > Thanks, but I was more expecting some kind of SBC, and it's a bit too
> > expensive for me indeed :/
> >=20
>=20
> Yeah that's the one - and it's exactly the device that I'm using here.
>=20
> Btw, I will avoid pasting the same trace over and over again and skip to
> the output that you added with the patch.
>=20
> [   11.447922] panfrost 13000000.gpu: clock rate =3D 699999695
> [   11.453402] panfrost 13000000.gpu: Looking up mali-supply from device =
tree
> [   11.461842] mfg_bg3d
> [   11.471067] 	rate 700000000
> [   11.473857] 	min 0, max 18446744073709551615
> [   11.478123] 	best parent mfg_ck_fast_ref, rate 699999695
>=20
> ...
>=20
> [   11.826631] mfg_bg3d
> [   11.829249] 	rate 699999695
> [   11.832472] 	min 0, max 18446744073709551615
> [   11.837159] 	best parent mfg_ck_fast_ref, rate 699999695
>=20
> ...
>=20
> [   12.190365] mfg_bg3d
> [   12.198676] 	rate 390000000
> [   12.206494] 	min 0, max 18446744073709551615
> [   12.236155] 	best parent mfg_ck_fast_ref, rate 699999695
>=20
> ...
>=20
> [   12.592687] mfg_bg3d
> [   12.592693] 	rate 390000000
> [   12.592698] 	min 0, max 18446744073709551615
> [   12.592702] 	best parent mfg_ck_fast_ref, rate 390000000

Yeah, so it all seems to make sense. The parent is still the same, and
the rate is equal or close enough.

It would be interesting to get the traces after the second
clk_core_request_dump() call to see what the CCF is doing, because
there's probably some difference there. Could you enable the traces like
I pointed above, and paste them with and without the patch?

Maxime

--xvoswui7ypuqtq4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY0fLYAAKCRDj7w1vZxhR
xSFwAP9y909Q0MEWfPtf6CAMhzA3LMXKaB/O3BHaU/uEhjXF8gD/Ykl8cB/dXg20
6NB4ttipcy9JA1ldRM99E6IvjETJlAc=
=lQeQ
-----END PGP SIGNATURE-----

--xvoswui7ypuqtq4i--
