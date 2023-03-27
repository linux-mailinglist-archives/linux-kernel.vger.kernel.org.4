Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2B56CA244
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjC0LUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC0LT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:19:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF699423C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:19:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7B3B521F91;
        Mon, 27 Mar 2023 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679915996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mtob8tbjnOO6W6RcWP0/YXVLzrc9wp/Cm4nTdHamhsw=;
        b=CqOc5vFNvVq0q1kvs1J292YPGdaRSAUZK5x2vv07FNAs136/M2bnJfMlPtzNMvB9ONyBVc
        Ezo8qNruj6tHYkzAXN08KzR5iBMr8JftrO/XiFq6FfUQNBEw67G5GS4lzaUO3BzBUOkbVI
        50BnxClcz10ynoZHRZFVn3LaZvFRehc=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 554BE2C141;
        Mon, 27 Mar 2023 11:19:56 +0000 (UTC)
Date:   Mon, 27 Mar 2023 13:19:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove orphaned CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT
Message-ID: <ZCF72chpZx77+lEM@alley>
References: <5c19e248-1b6b-330c-7c4c-a824688daefe@tuyoix.net>
 <Y/Teb9QnY8DOihZ1@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/Teb9QnY8DOihZ1@alley>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-02-21 16:08:37, Petr Mladek wrote:
> On Mon 2023-02-20 22:10:32, Marc Aurèle La France wrote:
> > After 93d102f094be9beab28e5afb656c188b16a3793b "printk: remove safe buffers",
> > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT is no longer useful.  Remove it.
> > 
> > This change is not eligible for stable@.
> > 
> > Please Reply-To-All.
> 
> Great catch!
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I have already sent pull request with printk changes for 6.3.
> I am going to queue this patch either for 6.3-rc or 6.4.

JFYI, the patch has been committed into printk/linux.git,
branch for-6.4.

Best Regards,
Petr
