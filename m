Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165245FC32D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJLJkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:40:11 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25E5357C9;
        Wed, 12 Oct 2022 02:40:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 70CB7580320;
        Wed, 12 Oct 2022 05:40:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Oct 2022 05:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665567607; x=
        1665574807; bh=jIw1X1OWq80oU2H2+NRiXoIfwbXHEKKKboIcZC9PvE0=; b=F
        gE06xXtIGl/CXdZ/hYvqQ3ivFNxdzi1khTxMRZfc43pIXIdYIhyKtMOrHh4B80ss
        NnjqxmaiTBwL5IFtp2Re7QI+gTp2R+1WjAxdrYHzfWX4wJVd0UTwdcvQnPvyWyKA
        h48aT27TDws2hy1lh8LkiLSkdIQNEccILZCb5To97hCDvTp2A0idUZdAEjM40vu0
        ecgKzFxp1Px5LLQm+MD3xvuK7Qmcf8LRHJkmDOrgAAcMz/4arKqAasIHoAoQNm91
        M9AHHJhmWRjL6ShjyKc1BfpzOdHRd/4Y1H/48hcIqigeWUAfnIpPpYcM+PF3Hwsj
        ufPeM5ebRVtSqQjiY7nRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665567607; x=
        1665574807; bh=jIw1X1OWq80oU2H2+NRiXoIfwbXHEKKKboIcZC9PvE0=; b=V
        WiGVFXdVd0Dd/zto8rpPDKrniT+oGSjiT5TToUmPb3s2yCwiJUONhsWaRrCtLExZ
        tOXR/LKwbj2TVeBrTEh3LJoClem2AVdH7q1Dak48wynGv8fJxi0gjmlTN8mDpK2O
        eVAvWlJNE7xESEoC+Mb0vtI3jJgA6+I1oM3hlGbgIfCRK6LpVeReUI3bZEYbY9q2
        vJrLcpqsNRaC5aLsVRaVKD4PqeRvBHmypNwfbeZjlwjlNJRdYm5Up+7lg0QqKODQ
        +GngeDgTuv8QQJe1VNs6Q3fa2gMd+1P2dKikB7aX4wi7KgIC3HllrV/yNWwr0H1e
        qhOT5oJxULVaBPutwnL6A==
X-ME-Sender: <xms:dotGY-GvlhZotYDF22OxWd1rynwv8cqBYUlp3tPAfopsnLrcie_pNw>
    <xme:dotGY_Ukj4mVbm_h2N844-w7OlP5qJcWAXvIslfm4KXiIt0U2I5lJKr2oQUcRXvel
    FXIS-zHcI0q8vaWxoE>
X-ME-Received: <xmr:dotGY4IyY6w4YgGrbxn7KYZLydtDgjrxzzsLLjFFOEc_aBkWv98tp7J1W8S4EMUlot1N7MNFyZFXKko0AAGe_eUHHJUkb_i0yCx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepiedtueffveeiueeftdduvdffffffgeffgfekiefhleelkedtlefhvefh
    udduhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:d4tGY4G5WBa42tjim1N_Mt_R5-O0VdB8TjSZ6s8Cvp8QaCVMXgd17g>
    <xmx:d4tGY0WmoFfYn876J-XBkqpyPMn36acN3EbyU9oOrKXM_o6J80MLvg>
    <xmx:d4tGY7NlS0PAFPfno4vmrdKGtkVmpYDB-mLLgW34lk_8u9N8jXWRAA>
    <xmx:d4tGY529AaZHmTLWqHb1-eqoPQhNNFR1SsyDAbE0EDFWIfv3SlQrsw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Oct 2022 05:40:06 -0400 (EDT)
Date:   Wed, 12 Oct 2022 11:40:04 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: mediatek: clk-mux: Add .determine_rate() callback
Message-ID: <20221012094004.jgiyvmbgomiyedik@houat>
References: <20221011135548.318323-1-angelogioacchino.delregno@collabora.com>
 <20221012085555.3nls7ja56vlnaz2w@houat>
 <c4a1eb9f-016d-c184-e494-c869038b87ff@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c4a1eb9f-016d-c184-e494-c869038b87ff@collabora.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:09:59AM +0200, AngeloGioacchino Del Regno wrote:
> Il 12/10/22 10:55, Maxime Ripard ha scritto:
> > Hi,
> >=20
> > On Tue, Oct 11, 2022 at 03:55:48PM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > Since commit 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests
> > > to the parent"), the clk_rate_request is .. as the title says, not
> > > forwarded anymore to the parent:
> >=20
> > It's not entirely true, the rate request should still be forwarded, but
> > we don't pass the same instance of clk_rate_request anymore.
> >=20
> > > this produces an issue with the MediaTek clock MUX driver during GPU
> > > DVFS on MT8195, but not on MT8192 or others.
> > >=20
> > > This is because, differently from others, like MT8192 where all of
> > > the clocks in the MFG parents tree are of mtk_mux type, but in the
> > > parent tree of MT8195's MFG clock, we have one mtk_mux clock and
> > > one (clk framework generic) mux clock, like so:
> > >=20
> > > names: mfg_bg3d -> mfg_ck_fast_ref -> top_mfg_core_tmp (or) mfgpll
> > > types: mtk_gate ->      mux        ->     mtk_mux      (or) mtk_pll
> > >=20
> > > To solve this issue and also keep the GPU DVFS clocks code working
> > > as expected, wire up a .determine_rate() callback for the mtk_mux
> > > ops; for that, the standard clk_mux_determine_rate_flags() was used
> > > as it was possible to.
> >=20
> > It probably fixes things indeed, but I'm a bit worried that it just
> > works around the actual issue instead of fixing the actual bug...
> >=20
> > > This commit was successfully tested on MT6795 Xperia M5, MT8173 Elm,
> > > MT8192 Spherion and MT8195 Tomato; no regressions were seen.
> > >=20
> > > For the sake of some more documentation about this issue here's the
> > > trace of it:
> > >=20
> > > [   12.211587] ------------[ cut here ]------------
> > > [   12.211589] WARNING: CPU: 6 PID: 78 at drivers/clk/clk.c:1462 clk_=
core_init_rate_req+0x84/0x90
> > > [   12.211593] Modules linked in: stp crct10dif_ce mtk_adsp_common ll=
c rfkill snd_sof_xtensa_dsp
> > >                 panfrost(+) sbs_battery cros_ec_lid_angle cros_ec_sen=
sors snd_sof_of
> > >                 cros_ec_sensors_core hid_multitouch cros_usbpd_logger=
 snd_sof gpu_sched
> > >                 snd_sof_utils fuse ipv6
> > > [   12.211614] CPU: 6 PID: 78 Comm: kworker/u16:2 Tainted: G        W=
          6.0.0-next-20221011+ #58
> > > [   12.211616] Hardware name: Acer Tomato (rev2) board (DT)
> > > [   12.211617] Workqueue: devfreq_wq devfreq_monitor
> > > [   12.211620] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> > > [   12.211622] pc : clk_core_init_rate_req+0x84/0x90
> > > [   12.211625] lr : clk_core_forward_rate_req+0xa4/0xe4
> > > [   12.211627] sp : ffff80000893b8e0
> > > [   12.211628] x29: ffff80000893b8e0 x28: ffffdddf92f9b000 x27: ffff4=
6a2c0e8bc05
> > > [   12.211632] x26: ffff46a2c1041200 x25: 0000000000000000 x24: 00000=
000173eed80
> > > [   12.211636] x23: ffff80000893b9c0 x22: ffff80000893b940 x21: 00000=
00000000000
> > > [   12.211641] x20: ffff46a2c1039f00 x19: ffff46a2c1039f00 x18: 00000=
00000000000
> > > [   12.211645] x17: 0000000000000038 x16: 000000000000d904 x15: 00000=
00000000003
> > > [   12.211649] x14: ffffdddf9357ce48 x13: ffffdddf935e71c8 x12: 00000=
0000004803c
> > > [   12.211653] x11: 00000000a867d7ad x10: 00000000a867d7ad x9 : ffffd=
ddf90c28df4
> > > [   12.211657] x8 : ffffdddf9357a980 x7 : 0000000000000000 x6 : 00000=
00000000004
> > > [   12.211661] x5 : ffffffffffffffc8 x4 : 00000000173eed80 x3 : ffff8=
0000893b940
> > > [   12.211665] x2 : 00000000173eed80 x1 : ffff80000893b940 x0 : 00000=
00000000000
> > > [   12.211669] Call trace:
> > > [   12.211670]  clk_core_init_rate_req+0x84/0x90
> > > [   12.211673]  clk_core_round_rate_nolock+0xe8/0x10c
> > > [   12.211675]  clk_mux_determine_rate_flags+0x174/0x1f0
> > > [   12.211677]  clk_mux_determine_rate+0x1c/0x30
> > > [   12.211680]  clk_core_determine_round_nolock+0x74/0x130
> > > [   12.211682]  clk_core_round_rate_nolock+0x58/0x10c
> > > [   12.211684]  clk_core_round_rate_nolock+0xf4/0x10c
> > > [   12.211686]  clk_core_set_rate_nolock+0x194/0x2ac
> > > [   12.211688]  clk_set_rate+0x40/0x94
> > > [   12.211691]  _opp_config_clk_single+0x38/0xa0
> > > [   12.211693]  _set_opp+0x1b0/0x500
> > > [   12.211695]  dev_pm_opp_set_rate+0x120/0x290
> > > [   12.211697]  panfrost_devfreq_target+0x3c/0x50 [panfrost]
> > > [   12.211705]  devfreq_set_target+0x8c/0x2d0
> > > [   12.211707]  devfreq_update_target+0xcc/0xf4
> > > [   12.211708]  devfreq_monitor+0x40/0x1d0
> > > [   12.211710]  process_one_work+0x294/0x664
> > > [   12.211712]  worker_thread+0x7c/0x45c
> > > [   12.211713]  kthread+0x104/0x110
> > > [   12.211716]  ret_from_fork+0x10/0x20
> > > [   12.211718] irq event stamp: 7102
> > > [   12.211719] hardirqs last  enabled at (7101): [<ffffdddf904ea5a0>]=
 finish_task_switch.isra.0+0xec/0x2f0
> > > [   12.211723] hardirqs last disabled at (7102): [<ffffdddf91794b74>]=
 el1_dbg+0x24/0x90
> > > [   12.211726] softirqs last  enabled at (6716): [<ffffdddf90410be4>]=
 __do_softirq+0x414/0x588
> > > [   12.211728] softirqs last disabled at (6507): [<ffffdddf904171d8>]=
 ____do_softirq+0x18/0x24
> > > [   12.211730] ---[ end trace 0000000000000000 ]---
> >=20
> > ... Indeed, you shouldn't hit that warning at all. It happens in
> > clk_core_round_rate_nolock, which takes (before your patch) the
> > CLK_SET_RATE_PARENT branch. This indeed has been changed by the patch
> > you mentioned, and will call clk_core_forward_rate_req() now, that in
> > turn calls clk_core_init_rate_nolock().
> >=20
> > I think the warning you hit is because core->parent is NULL, which is
> > passed to clk_core_forward_rate_req() as the parent argument, and we'll
> > call clk_core_init_rate_req() with parent set as the core argument.
> >=20
> > In clk_core_init_rate_req(), the first thing we do is a WARN_ON(!core),
> > which is what you hit here I think.
> >=20
> > This is different to the previous behavior that was calling
> > clk_core_round_rate_nolock() with core->parent directly, and
> > clk_core_round_rate_nolock() if its core argument is NULL will set
> > req->rate to 0 and bail out without returning an error.
> >=20
> > Now, your patch probably works because now that you provide a
> > determine_rate implementation, clk_core_can_round() returns true and
> > you'll take a different branch in clk_core_round_rate_nolock(), avoiding
> > that issue entirely.
> >=20
> > Does that patch work better (on top of next-20221012)?
>
> I admit I didn't go too deep in the research, as my brain processed that =
as
> "this is a mux clock, not really different from a standard mux, this call=
back
> is missing, that's not optimal"... then that fixed it and called it a day.
>=20
> I should've prolonged my research for a better understanding of what was
> actually going on.

No worries :)

> What you said actually opened my mind and, with little surprise, your pat=
ch
> works as good as mine - no warnings and the clock scales as expected!

I'm actually wondering if you didn't encounter two issues. What kernel
were you testing before? If it's older than today's next
(next-20221012), you're likely missing

https://lore.kernel.org/linux-clk/20221010-rpi-clk-fixes-again-v1-0-d87ba82=
ac404@cerno.tech/

Which is likely to be what fixed the clock scaling. And my patch only
fixed the warning. Could you test next-20221012? If I'm right, you
should only get the warning.

> I still think that the mtk-mux driver should get a determine_rate callbac=
k but,
> at this point, that's going to have an entirely different commit descript=
ion...

Yeah, it might, but as you said it's a separate discussion

> Please go on and send your patch: if you want, please remember to add me =
to
> the Cc's, so that I can give you my R-b tag in a timely manner.

Thanks!
Maxime
