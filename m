Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F245F12CC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiI3ThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiI3Tgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:36:40 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 771D110E032;
        Fri, 30 Sep 2022 12:36:18 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 28UJZZ5S009609;
        Fri, 30 Sep 2022 21:35:35 +0200
Date:   Fri, 30 Sep 2022 21:35:35 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 1/1] clk: mstar: msc313 cpupll clk driver
Message-ID: <20220930193535.GB9469@1wt.eu>
References: <20220603190509.45986-1-romain.perier@gmail.com>
 <20220603190509.45986-2-romain.perier@gmail.com>
 <20220930191742.9A9FEC433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930191742.9A9FEC433C1@smtp.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Sep 30, 2022 at 12:17:40PM -0700, Stephen Boyd wrote:
> Quoting Romain Perier (2022-06-03 12:05:09)
> > From: Daniel Palmer <daniel@0x0f.com>
> > 
> > Add a driver for the CPU pll/ARM pll/MIPS pll that is present
> > in MStar SoCs.
> > 
> > Currently there is no documentation for this block so it's possible
> > this driver isn't entirely correct.
> > 
> > Only tested on the version of this IP in the MStar/SigmaStar
> > ARMv7 SoCs.
> > 
> > Co-authored-by: Willy Tarreau <w@1wt.eu>
> 
> This is not a standard tag, maybe Co-developed-by is what you want?

Yeah it's the same. We're seeing 122 co-authored-by tags in the
kernel's history vs 3122 co-developed-by, so that's only 3% but
at least not a fantasist one..

> A Signed-off-by tag should be here from Willy Tarreau then.

Not all commits follow this, but indeed some do. Regardless I
really don't care at all about my name being listed there.

> > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> 
> Your Signed-off-by needs to be here. I can't apply this otherwise.

Quite frankly, we're talking about an old patch that was first
submitted 9 months ago (!), let's not postpone it even further just
for headers reason, please just drop this line mentioning my
little contribution, I don't care a single second at all, really.

Thanks,
Willy
