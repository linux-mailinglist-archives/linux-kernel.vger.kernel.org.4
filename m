Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43E662151
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjAIJUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjAIJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:20:32 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F3CDBE26
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:17:57 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3099HoeR027651;
        Mon, 9 Jan 2023 10:17:50 +0100
Date:   Mon, 9 Jan 2023 10:17:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] nolibc: usability improvements (errno, environ,
 auxv)
Message-ID: <20230109091750.GA25476@1wt.eu>
References: <20230109084208.27355-1-w@1wt.eu>
 <Y7vbQEZ56Td15nTs@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7vbQEZ56Td15nTs@biznet-home.integral.gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 04:15:44PM +0700, Ammar Faizi wrote:
> On Mon, Jan 09, 2023 at 09:41:46AM +0100, Willy Tarreau wrote:
> > Ammar Faizi (3):
> >   nolibc/stdlib: Implement `getauxval(3)` function
> >   nolibc/sys: Implement `getpagesize(2)` function
> >   selftests/nolibc: Add `getpagesize(2)` selftest
> 
> Now that these went through your hands, they also need your signoff :-)

Oops, you're right, I missed them. I'll respin.

Thanks!
Willy
