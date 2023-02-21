Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFF769E318
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjBUPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjBUPIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:08:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176435AF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:08:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 223EE34BCA;
        Tue, 21 Feb 2023 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676992116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Et1TqBVYxjAD/qvgRNl/niPQ2MyrbJSF9+LiI8hMeT4=;
        b=CuwhRjQ7r4Oox3Tq1lbLKezRsSK5MERpwkXAK6mApalNxHSOcLyYHVQqH9hgZkJb9wNX2D
        DXIzYtY2qaZvYeX+wwesukuyIWkj+kJRtzHzMzPp+xm3Z0tXwogEhBpoAYL3ockHjIGsPG
        UWBYshC/ckit9EDy53QHKiYJNAdPeIM=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F3A2D2C141;
        Tue, 21 Feb 2023 15:08:35 +0000 (UTC)
Date:   Tue, 21 Feb 2023 16:08:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove orphaned CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT
Message-ID: <Y/Teb9QnY8DOihZ1@alley>
References: <5c19e248-1b6b-330c-7c4c-a824688daefe@tuyoix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c19e248-1b6b-330c-7c4c-a824688daefe@tuyoix.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-02-20 22:10:32, Marc Aurèle La France wrote:
> After 93d102f094be9beab28e5afb656c188b16a3793b "printk: remove safe buffers",
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT is no longer useful.  Remove it.
> 
> This change is not eligible for stable@.
> 
> Please Reply-To-All.

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have already sent pull request with printk changes for 6.3.
I am going to queue this patch either for 6.3-rc or 6.4.

Best Regards,
Petr
