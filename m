Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D306A2EA3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBZGuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBZGuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:50:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CC9C66E;
        Sat, 25 Feb 2023 22:50:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2810AB80B03;
        Sun, 26 Feb 2023 06:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6800FC433D2;
        Sun, 26 Feb 2023 06:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677394203;
        bh=vF+70qVhywRhbCbGBSckNNXQtvtxvXSYrI8qFIqDfME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kYX1JmlVZqypNXaBRZ9k+aBqOQWjPtujHrLc+hdw6dN367POk0TvH9ajz/X+d4oto
         oJOHK+tVYYgQqL35ScYEucrCV+pX5GHuHd1zgXRdnEcPhFyJH0ICm/3lMJRy3HYU5k
         yktbU8bCTUh8xqAHTPN/BDXbGqWVQDWItXgUzjEs=
Date:   Sun, 26 Feb 2023 07:50:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
Message-ID: <Y/sBGesMZSd188OQ@kroah.com>
References: <Y/iywbFbiUAA6ZD3@kroah.com>
 <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
 <Y/qcXOxTVHTNDQbY@mit.edu>
 <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 06:14:11PM -0800, Linus Torvalds wrote:
> On Sat, Feb 25, 2023 at 3:40 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > For what it's worth, in the VM world (e.g., qemu, AWS, GCP, Azure,
> > Linode, etc.)  serial consoles are quite common way of debugging VM's,
> > and as an emergency login path when the networking has been screwed up
> > for some reason....
> 
> Everybody seems to be missing the point.
> 
> We don't make new drivers "default y" (or, in this case, "default SERIAL_8250".
> 
> It does not matter ONE WHIT if you have a serial device in your
> machine. If your old driver was enabled and worked for you and you
> used it daily, that is ENTIRELY IMMATERIAL to a new driver, even if
> that new driver then happens to use some of the same infrastructure as
> the old one did.

I agree, sorry for the delay, I'll fix this up before -final for this
release.

thanks,

greg k-h
