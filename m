Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B376A1D27
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBXNxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBXNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:53:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E328D13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:53:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4492FB81694
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF091C433EF;
        Fri, 24 Feb 2023 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677246822;
        bh=tNxLOJJY/bL4f5EuksjRbirdWymnt6RMjtDuj24OAZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rq1lgqrVr+OoIhndg0nRCZ39RQ/EpHn7YFe0CsXMFzhGUJLNKsE07RZkxU/F4PvS1
         RxXkZwGolL9oSrpl0ooMmtK9tD1/4ah6zuCMu3ZS/O0l2AhgwizTKjK+PDydpOlWpG
         w1jEgm9tIrwlb5iVmyOIKO/2vUlDb3ZVKdTT1G0c=
Date:   Fri, 24 Feb 2023 14:53:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL] Driver core updates for 6.3-rc1
Message-ID: <Y/jBY9PJl68Lnva9@kroah.com>
References: <Y/iy9+Kn0SgzngDC@kroah.com>
 <CAMuHMdXT-LqqfzLqUHpORbNz89F4eGJrJY2TJdoM5+MME_4fdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXT-LqqfzLqUHpORbNz89F4eGJrJY2TJdoM5+MME_4fdw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:48:55PM +0100, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Fri, Feb 24, 2023 at 2:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:
> >
> >   Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc1
> >
> > for you to fetch changes up to 88cd618dcc7b63baa1478730b02eaba3e3148467:
> >
> >   debugfs: drop inline constant formatting for ERR_PTR(-ERROR) (2023-02-20 14:14:56 +0100)
> >
> > ----------------------------------------------------------------
> > Driver core changes for 6.3-rc1
> 
> Thanks for your PR!
> 
> > All of these have been in linux-next for a while with no reported
> > problems.
> 
> I think you should drop this sentence from your boilerplate, to avoid
> confusion among people who reported regressions and/or posted
> fixes that you promised to queue up after your PR is sent to Linus.

Ah, yeah, I had forgotten about your bug report / fix when writing this.
I'll send that to Linus after this is pulled, my fault.

thanks,

greg k-h
