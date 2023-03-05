Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775526AAE2E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 05:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCEE1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 23:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEE1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 23:27:44 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E8AF12079
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 20:27:43 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3254RTKY032152;
        Sun, 5 Mar 2023 05:27:29 +0100
Date:   Sun, 5 Mar 2023 05:27:29 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Vincent Dagonneau <v@vda.io>
Subject: Re: [PATCH 1/4] tools/nolibc: add stdint.h
Message-ID: <ZAQaMTNqPo55OA8X@1wt.eu>
References: <20230304142606.5995-1-w@1wt.eu>
 <20230304142606.5995-2-w@1wt.eu>
 <20230305004734.GA1270367@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230305004734.GA1270367@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Sat, Mar 04, 2023 at 04:47:34PM -0800, Paul E. McKenney wrote:
> On Sat, Mar 04, 2023 at 03:26:03PM +0100, Willy Tarreau wrote:
> > From: Vincent Dagonneau <v@vda.io>
> > 
> > Nolibc works fine for small and limited program however most program
> > expect integer types to be defined in stdint.h rather than std.h.
> > 
> > This is a quick fix that moves the existing integer definitions in std.h
> > to stdint.h.
> > 
> > Signed-off-by: Vincent Dagonneau <v@vda.io>
> > Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> I queued all three serieses, and it does look good, thank you!
> 
> make[1]: Leaving directory '/home/git/linux-rcu'
> 125 test(s) passed.
> 
> I am figuring on pushing these into the v6.4 merge window, that is,
> the one after the current just-now-closing merge window.

Yes that was the intent, so that we still have time to make some
adjustments if any would be needed. Many thanks!

Willy
