Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE15F5065
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJEHfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJEHfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:35:45 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89DAC543F2;
        Wed,  5 Oct 2022 00:35:33 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2957YtGi004237;
        Wed, 5 Oct 2022 09:34:55 +0200
Date:   Wed, 5 Oct 2022 09:34:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 1/1] clk: mstar: msc313 cpupll clk driver
Message-ID: <20221005073454.GA3728@1wt.eu>
References: <20220603190509.45986-1-romain.perier@gmail.com>
 <20220603190509.45986-2-romain.perier@gmail.com>
 <20220930191742.9A9FEC433C1@smtp.kernel.org>
 <20220930193535.GB9469@1wt.eu>
 <CABgxDoK-r_ENKo4qcB3PbCS2KOifHhzMvy1gWM=8yEsrH4JVvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgxDoK-r_ENKo4qcB3PbCS2KOifHhzMvy1gWM=8yEsrH4JVvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:33:40AM +0200, Romain Perier wrote:
> Hi,
> 
> Quiet frankly I don't want to debate about this , as is it seems to be
> basically "the rule" (see
> https://www.kernel.org/doc/html/v6.0/process/submitting-patches.html).
> It is okay for you Willy, if I transform your tag to
> "Co-developed-by:" plus a "Signed-off-by" ? So Stephen can apply it ,
> and everyone is happy :)

Yes absolutely! I just wanted to avoid yet another round trip.
Many thanks Romain!

Willy
