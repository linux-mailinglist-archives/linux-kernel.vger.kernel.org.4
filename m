Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384FB6C98A6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCZXTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:19:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE7114;
        Sun, 26 Mar 2023 16:19:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C974068B05; Mon, 27 Mar 2023 01:18:58 +0200 (CEST)
Date:   Mon, 27 Mar 2023 01:18:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH RFC rcu 03/19] srcu: Begin offloading srcu_struct
 fields to srcu_update
Message-ID: <20230326231858.GA19606@lst.de>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop> <20230324001938.3443499-3-paulmck@kernel.org> <80166ee7-4ee3-bb2d-c715-a8180dddee31@intel.com> <a0a2f6a7-b623-454c-ac65-69043a9f9f4d@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a2f6a7-b623-454c-ac65-69043a9f9f4d@paulmck-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 01:11:47PM -0700, Paul E. McKenney wrote:
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Thank you!  I will add this on my next rebase.
> 
> It is possible that this will be v6.5 rather than v6.4 material.

I was hoping the RCU bits could land in 6.4, so that the block
layer work to take advantage of it can go into 6.5 without cross-tree
dependencies.
