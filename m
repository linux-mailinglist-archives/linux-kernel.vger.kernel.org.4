Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7F86A516B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjB1CrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1CrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:47:23 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 313231167F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:47:22 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31S2lDu8019821;
        Tue, 28 Feb 2023 03:47:13 +0100
Date:   Tue, 28 Feb 2023 03:47:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Vincent Dagonneau <v@vda.io>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] tools/nolibc: add stdint.h
Message-ID: <Y/1rMdRIK1LyDrxl@1wt.eu>
References: <20230228021136.13472-1-v@vda.io>
 <20230228021136.13472-2-v@vda.io>
 <85e5fe90-4ff9-45f5-99d4-08ee737dfb51@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85e5fe90-4ff9-45f5-99d4-08ee737dfb51@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 02:24:15AM +0000, Thomas Weiﬂschuh wrote:
> On Mon, Feb 27, 2023 at 09:11:33PM -0500, Vincent Dagonneau wrote:
> > Nolibc works fine for small and limited program however most program
> > expect integer types to be defined in stdint.h rather than std.h.
> > 
> > This is a quick fix that moves the existing integer definitions in std.h
> > to stdint.h.
> > 
> > Signed-off-by: Vincent Dagonneau <v@vda.io>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> One more nitpick (applies to all patches):
> 
> The correct order of trailers would be:
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Vincent Dagonneau <v@vda.io>
> 
> In chronological order.
> 
> First Willy submitted something, then I reviewed it and then you
> submitted it.
> Your previous submissions/Signed-off-by are superseeded by the last one.
> 
> See Documentation/process/submitting-patches.rst.
> (Especially search for "chronological")
> 
> Willy can probably fix this up when applying the series, so a new
> revision may not be necessary.

Yeah absolutely. In fact I'll just drop my initial sob since I only
slightly re-adjusted some of Vincent's patches to illustrate what I
meant and not at all as something sensitive.

Thanks to you both!
Willy
