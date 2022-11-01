Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9953614B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKANBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKANBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:01:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284D21B790
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:01:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C6C94336C4;
        Tue,  1 Nov 2022 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667307696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9zD7pkX2vVzhG42fM/SlT3j8mn6GgD7tD8EPuRyjm54=;
        b=K2I3NIW99c6SNlb4Yl8zs+36KRlBL+BmgYql9miS42iNQGui/EKWqxCLyLPI+R8qQ20Gu/
        TGE1QCcdP4VdLTPeuIUw505k/cOJeNk4AB06B0aWZIWRIKdkRjrEBAgE4AlOb87EwBCW47
        bkuOWozBFws5euwrvGdUiGyYXj+WESo=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 917F92C141;
        Tue,  1 Nov 2022 13:01:36 +0000 (UTC)
Date:   Tue, 1 Nov 2022 14:01:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] test_printf: Refactor fwnode_pointer() to make it
 more readable
Message-ID: <Y2EYrIHe8sQwT4ko@alley>
References: <20220824170542.18263-1-andriy.shevchenko@linux.intel.com>
 <Yw9tTD1Qt6LG25bX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw9tTD1Qt6LG25bX@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-08-31 17:16:44, Andy Shevchenko wrote:
> On Wed, Aug 24, 2022 at 08:05:42PM +0300, Andy Shevchenko wrote:
> > Converting fwnode_pointer() to use better swnode API allows to
> > make code more readable.
> > 
> > While at it, rename full_name to full_name_third to show exact
> > relation in the hierarchy.
> 
> Any comments?
> 
> Note, I would like to reduce exported swnode APIs and this will
> help to do so.

JFYI, I have just pushed the patch into printk/linux.git, branch
for-6.2.

I am sorry that it took so long. I have got a long backlog of mails
to proceed.

Best Regards,
Petr
