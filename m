Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845525F40D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJDKaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJDKaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:30:13 -0400
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E56C3FA1A;
        Tue,  4 Oct 2022 03:30:11 -0700 (PDT)
Date:   Tue, 4 Oct 2022 12:30:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
        t=1664879409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
         references:references; bh=OtgXDt1K9Xr569XkXgHs+3oFO+loxhoMDfDoP0PGi/I=;
        b=DlXQWBHf6kpg26CrfAz4lEpQNeuV3/XbviD+wh8ic96AsckU5w40uQpALVKlWr6ssukqTg
        FaeyyxiwH6+Z6YmVwEWdaba+AAew9A6cFMKtIuUhQI9ERpkcuqybaCuBhraHTPcl4NrgCz
        WWU/igBtOeNw8/6tXGrKn/UXhMSCB1ZfQp4GKG4QbME6h06JwFLgFi/PREL8xDcGWFVYuZ
        vBA9HYMyk5gbXlkyOjHnqM+CNGQII5jKK4F8qZ0WrVME5JL71Pbdgvwmy5E1N4NIZw66bM
        Da/ITS/Xl90MN+ZKR3YTpMqEsAWRVc/gHTnvofsfFLlYIljIis1iJszH9zLsJA==
From:   Alexander Dahl <ada@thorsis.com>
To:     Mark Gross <markgross@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>
Subject: Re: [ANNOUNCE] 4.9.327-rt197
Message-ID: <YzwLK9outbQ/oBhv@ada.ifak-system.com>
Mail-Followup-To: Mark Gross <markgross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>
References: <165222469651.210737.17409564443317121708@T470>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165222469651.210737.17409564443317121708@T470>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei Mark,

Am Fri, Sep 23, 2022 at 01:03:24PM -0700 schrieb Mark Gross:
> Hello RT-list!
> 
> I'm pleased to announce the 4.9.327-rt197 stable release.

My MUA shows the identical Message-ID for your mail on 4.9.327-rt197
as for your mail on 4.9.312-rt193 which you send back on Thu, 12 May
2022 17:46:22 -0700:

<165222469651.210737.17409564443317121708@T470>

How is this even possible? Maybe some issue with some release script?

I only notice because mutt marked the second one as duplicate.

Greets
Alex

> 
> You can get this release via the git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>   branch: v4.9-rt-next
>   Head SHA1: d47e3fd2615dbd0aa6eac3745cd209fdd93a868a
> 
> 
> This rebase was a tricky one.  Sebastian provided some patches and I was too
> dense to figure out where and how to apply them.  My colleague Junxiao did the
> following and I replicated the steps.
> 1) convert the v4.9-rt-rebase branch into a quilt series.
> 2) applied the series to v4.9.327 skipping patches where changes to the random
> number logic has conflicts.
> 3) apply the patches Sebastian provided.
> 4) git quiltimport and pushed it to the above branch.
> 
> It seems to compile and it passes the RT BAT testing Junxiao does.
> 
> As this was a tricky one I request people to give a good look over.
> 
> 
> Enjoy!
> Mark Gross
> 
