Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC5623C72
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiKJHPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiKJHMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:12:00 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 248932648;
        Wed,  9 Nov 2022 23:11:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 27C6F80C7;
        Thu, 10 Nov 2022 07:02:09 +0000 (UTC)
Date:   Thu, 10 Nov 2022 09:11:56 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Jackson <mpfj@newflow.co.uk>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] Update Nanobone
Message-ID: <Y2ykPDybdUaxJy4i@atomide.com>
References: <20221004143901.130935-1-mpfj@newflow.co.uk>
 <CAAbcLfiCoa=-20cydPG9=42G9npaeBOCRXPPPTwkNFU-3yGoCg@mail.gmail.com>
 <20221108194742.0d9340f4@aktux>
 <Y2tYoHSFdJzrp9MW@atomide.com>
 <CAAbcLfgYr1gfHNSycDc142aPuNUzxvhQ0GTyvExmMLa36e1nWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAbcLfgYr1gfHNSycDc142aPuNUzxvhQ0GTyvExmMLa36e1nWg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Mark Jackson <mpfj@newflow.co.uk> [221109 14:35]:
> On Wed, 9 Nov 2022 at 07:37, Tony Lindgren <tony@atomide.com> wrote:
> >
> > The separate defconfig should not be needed. Please send any defconfig
> > changes to multi_v7_defconfig or omap2plu_defconfig as separate patches.
> >
> > Note that you can run make savedefconfig first to produce a minimal diff.
> > Then if adding device drivers, please add them as loadable modules where
> > possible.
> 
> But using the omap2plus_defconfig increases my kernel to 4.7MB
>
> My "custom" one has been specifically designed for the NANO platform
> and currently sits at about 3.7MB (which nicely fits into the ~4MB memory
> bank allocated to the kernel)
> 
> Hence the use of my custom defconfig.

Maybe host your defconfig somewhere on a device related wiki page?

We got rid of the board specific config files in the kernel years ago in
favor of just a few generic ones.

> I don't have modules enabled as the platform functionality is pretty fixed.

OK nothing wrong with that, multi_v7_defconfig and omap2plus_defconfig are
trying to be more generic and distro friendly.

> The defconfig I posted was created using savedefconfig.
> Is it still wrong ?

Nothing wrong with that, except it should be hosted with the device
related documentation and not in the kernel :)

Regards,

Tony
