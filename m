Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D256560FC76
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiJ0PzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiJ0PzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:55:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454AF9AC3F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6D4AB8267F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BBEC433C1;
        Thu, 27 Oct 2022 15:55:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Yz+BVrk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666886106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QeQ60BIP3jZU0Ri9J8V6P6ft5JOnUHK0BgfpvSb2GFQ=;
        b=Yz+BVrk/3n378ObDWGt8QFhe0BHRd2wrEPuY1WciXUD0gkQ6V8Hs8/nYU5nsbUts6GjHOz
        wUbYwNvkoF0xtgAKE4B7UV6Iy/HYISB1aSiv4CNF8DzcIdQOsdD8+r68Z2Ktd6C9BWBOtX
        MFth+c7Ztl1uuXo51sOFvF94aoKu3jI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 04bb5124 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Oct 2022 15:55:05 +0000 (UTC)
Date:   Thu, 27 Oct 2022 17:55:03 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC][PATCH v2 11/31] timers: random: Use del_timer_shutdown()
 before freeing timer
Message-ID: <Y1qp17ZEM7Mp+7Xc@zx2c4.com>
References: <20221027150525.753064657@goodmis.org>
 <20221027150927.162027754@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221027150927.162027754@goodmis.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:05:36AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, del_timer_shutdown() must be called.
> 
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> 
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

If this patchset lands,

    Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

However, please keep with the uniform subject convention for commits to
that file. Namely, title this:

    random: use del_timer_shutdown() before freeing timer

Jason
