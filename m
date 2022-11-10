Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9172F6242B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKJNAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiKJNAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:00:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652D770193
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:00:39 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2546B1FAFF;
        Thu, 10 Nov 2022 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668085238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GhC/9jHJ/SxMDxpV4zAdhTCXO6g1ZnO43OO3osnjQiM=;
        b=ouqnHe1gPE/SutOr3Cxg87uyccgGhHtuvJgrTPf+Noz/t+Bjsq6iXNnmqHjCcUhRnVQbjF
        Hk1zldf9YNw/DVGKDTGJ6tOmj/+XMlWbQ8mR56o2AQfnkKzZeBrZF6MpNrXnSkcyQrJ3ZS
        L+4JzjXxJz9zyZboHY1uAPUcN6Cp0jI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F3A302C141;
        Thu, 10 Nov 2022 13:00:37 +0000 (UTC)
Date:   Thu, 10 Nov 2022 14:00:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 22/40] console: introduce
 console_is_registered()
Message-ID: <Y2z19STrTZj+nDhj@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-23-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-23-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:20, John Ogness wrote:
> Currently it is not possible for drivers to detect if they have
> already successfully registered their console. Several drivers
> have multiple paths that lead to console registration. To avoid
> attempting a 2nd registration (which leads to a WARN), drivers
> are implementing their own solution.
> 
> Introduce console_is_registered() so drivers can easily identify
> if their console is currently registered. A _locked() variant
> is also provided if the caller is already holding the
> console_list_lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
