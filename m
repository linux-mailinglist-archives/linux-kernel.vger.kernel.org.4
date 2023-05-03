Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113A06F617C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjECWuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjECWuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9044B7;
        Wed,  3 May 2023 15:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B0C86306F;
        Wed,  3 May 2023 22:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E6AC433EF;
        Wed,  3 May 2023 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683154216;
        bh=0ghuZTHCllMGC/CsV74+H0DShYTM8XeQjp1D0k/OePU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lBw9RzFJq2CJjKFz1DztWwO2G6m5bTE+n+yicYbMLOn2P7ivsWbj2BOVkUbwrwHpW
         0vh1DUvrkFDbfFZmjs/v8muPK9e0pVLXC833vSAOv0LVO98v4B+1BRFxYNOPN6FHoy
         bivWZS5y18Dux+FgKkpKdKdAgYW+/ONJ/IrHfacvIe7RNZZr2CG/1FwbSMQhEFvVr1
         vEJCaQB3u3oldvafx/mCB6WiqxYdHncu/0Lhv2ElTCUWbkGc/1rLzu1I1QH+x+tscF
         ZoXPB2BdldmDmRgG2fh3qy+7Wh3+JYXQ1De1kIN3UtbtH+eDG47df7i2qDek6NJbpA
         Bq4uEBLn64POA==
Message-ID: <4a01dd6af40e4395466133c97b3999fe.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <TYZPR04MB632148D739338EC2ABB1C035966C9@TYZPR04MB6321.apcprd04.prod.outlook.com>
References: <20230421-clk-v3-0-9ff79e7e7fed@outlook.com> <20230421-clk-v3-2-9ff79e7e7fed@outlook.com> <954b051546fe936db16353fc58a68438.sboyd@kernel.org> <TYZPR04MB632148D739338EC2ABB1C035966C9@TYZPR04MB6321.apcprd04.prod.outlook.com>
Subject: Re: [PATCH v3 2/2] clk: tests: Add missing test cases for mux determine_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Yang Xiwen <forbidden405@outlook.com>,
        Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Wed, 03 May 2023 15:50:14 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Xiwen (2023-05-03 11:44:45)
> On 5/3/2023 11:08 AM, Stephen Boyd wrote:
> > Quoting Yang Xiwen via B4 Relay (2023-04-26 12:34:17)
> >> diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
> >> index f9a5c2964c65d..4f7f9a964637a 100644
> >> --- a/drivers/clk/clk_test.c
> >> +++ b/drivers/clk/clk_test.c
> >> @@ -2194,7 +2194,47 @@ static void clk_leaf_mux_set_rate_parent_test_e=
xit(struct kunit *test)
> >>   * parent, the rate request structure returned by __clk_determine_rate
> >>   * is sane and will be what we expect.
> >>   */
> >> -static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit =
*test)
> >=20
> > Just leave this one alone and put the other test cases right after it.
> > Don't rename it and also move it lower down. It makes the diff hard to
> > read.
> I don't quite understand. In this patch, I renamed it to case3. Here I
> think you'd like it to remain as-is. But I think the comments below said
> I should rename it to clk_leaf_mux_determine_rate_exactly_parent1()?
> Actually what this test has done should be included in this series of
> test cases as one of them.

You can rename it, but don't move it lower in the file.

[...]
> >> +       KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case4),
> >=20
> > I'm not sure I understand what is being tested in this case. Are we
> > testing that __clk_determine_rate() with a rate between parent0 and
> > parent1 picks parent1?
> I think I have to speak more about how these tests are arranged.

The order that tests run in should not be relied upon. The tests should
be hermetic.

> Imagine
> that there is a segment starting at 0, ending at ULONG_MAX. Now add two
> points on it, assuming DUMMY_CLOCK_RATE_1(142MHz) and
> DUMMY_CLOCK_RATE_2(242MHz). We split the segment into 3 segments, and we
> have 4 endpoints in total. They are: 0, 0-142MHz, 142MHz, 142MHz-242MHz,
> 242MHz-ULONG_MAX, ULONG_MAX. Ideally, we need to test all these 7 cases.
> For those 4 points, the tests should be straightforward. But for the 3
> segments, we can only extract a random point on it to test. Besides, I
> think requesting for 142MHz or 242MHz has no big difference, so I
> omitted one of them. The original
> clk_leaf_mux_set_rate_parent_determine_rate() is considered to be one of
> the cases here, for which I think should be absorbed and renamed.

Got it. Adding various tests is OK. Hard-coding a rate, instead of doing
math makes it easier to read. Dividing by 2 threw me off because I was
trying to figure out why it was important.

I'll note that you're basically testing the rounding implementation of
the clk's determine_rate clk_op though, which may be different from what
this test suite is testing. The test suite talks about making sure the
struct clk_rate_request is correct. Maybe the suite should be renamed to
"clk-leaf-mux-determine-rate-request" because it doesn't call set_rate
at all.

If you want to add tests that check the rounding behavior then maybe add
a test for clk-mux.c called clk-mux_test.c and follow the
clk-gate_test.c approach to fake the register. Then also add tests for
the exported functions in there like clk_mux_val_to_index() and
clk_mux_determine_rate_flags(), etc. The mux determine rate API is in
clk.c, but that's mostly because it is so generic it can be used by any
mux type of clk hardware.

Please Cc Maxime on these patches too, because the lines you're
modifying were authored by Maxime.

>=20
> And as said in the previous email, the situation here would become even
> more complicated if CLK_MUX_ROUND_CLOSEST is true. I guess it should be
> in another patchset.

Yes, that's different, and probably should be implemented as a direct
call to __clk_mux_determine_rate_closest() instead.
