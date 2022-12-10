Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8A648DD7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLJJN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLJJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:13:13 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3E6A17886
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:09:32 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BA98eLd021798;
        Sat, 10 Dec 2022 10:08:40 +0100
Date:   Sat, 10 Dec 2022 10:08:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] selftests/nolibc: add s390 support
Message-ID: <20221210090840.GC21743@1wt.eu>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-4-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209141939.3634586-4-svens@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:19:37PM +0100, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Looks pretty good and clean:

Acked-by: Willy Tarreau <w@1wt.eu>

BTW I'm glad to see that splitting the qemu args lately made it much
easier to add new archs!

Willy
