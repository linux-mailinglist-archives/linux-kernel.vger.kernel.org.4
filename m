Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1FC648E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLJJp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLJJpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:45:21 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 959AB16588
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:45:11 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BA9iqnK021841;
        Sat, 10 Dec 2022 10:44:52 +0100
Date:   Sat, 10 Dec 2022 10:44:52 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nolibc: add support for s390
Message-ID: <20221210094452.GF21743@1wt.eu>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-3-svens@linux.ibm.com>
 <20221210090728.GB21743@1wt.eu>
 <yt9dmt7vtxf3.fsf@linux.ibm.com>
 <20221210093734.GE21743@1wt.eu>
 <yt9dilijtx5s.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dilijtx5s.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 10:39:43AM +0100, Sven Schnelle wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > On Sat, Dec 10, 2022 at 10:34:08AM +0100, Sven Schnelle wrote:
> >> So it should be:
> >> 
> >> >> +#elif defined(__s390x__)
> >> >> +#include "arch-s390.h"
> >> 
> >> I'm fine with both - either you fixing it up or me sending a v2.
> >
> > As you like. If you prefer to rename the file to s390x as your colleague
> > suggested, I'll then ask you to send a v2. Otherwise either Paul or I can
> > drop that 'x' in the #include.
> 
> Just drop the 'x'. Thanks! :)

OK will do, thank you!
Wlily
