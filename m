Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D776224C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKIHhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiKIHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:37:07 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C26761B1E7;
        Tue,  8 Nov 2022 23:37:06 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E928380FB;
        Wed,  9 Nov 2022 07:27:18 +0000 (UTC)
Date:   Wed, 9 Nov 2022 09:37:04 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Mark Jackson <mpfj@newflow.co.uk>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] Update Nanobone
Message-ID: <Y2tYoHSFdJzrp9MW@atomide.com>
References: <20221004143901.130935-1-mpfj@newflow.co.uk>
 <CAAbcLfiCoa=-20cydPG9=42G9npaeBOCRXPPPTwkNFU-3yGoCg@mail.gmail.com>
 <20221108194742.0d9340f4@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108194742.0d9340f4@aktux>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Andreas Kemnade <andreas@kemnade.info> [221108 18:38]:
> Hi,
> 
> On Tue, 8 Nov 2022 17:18:54 +0000
> Mark Jackson <mpfj@newflow.co.uk> wrote:
> 
> > Any update on this patch ?
> > Did it ever get through ?
> 
> it got probably caught in peoples "internal spam filter"
> reasons: 
>  - bad subject line 
>      look at  git log arch/arm/boot/dts/am335x-nano.dts for sane values
>  - bad recipient list
>      get_maintainer.pl is your friend
> 
> Hmm, you already have contributed long time ago, it looks better:
> Author: Mark Jackson <mpfj-list@newflow.co.uk>
> Date:   Thu Dec 15 10:52:13 2016 +0000
> 
>     ARM: dts: Update Nanobone dts file to add external FRAM chip
> 
> That looks ok. But maybe reread the documentation/SubmittingPatches again

Hmm yeah please use similar subject line with the prefix for the dts
changes.

Looking at the dts changes only, the changes for status = "okay" changes
should not be needed for devices enabled by default. Seems like the other
changes are for rs485, please describe why the changes are made in the
patch description.

The separate defconfig should not be needed. Please send any defconfig
changes to multi_v7_defconfig or omap2plu_defconfig as separate patches.

Note that you can run make savedefconfig first to produce a minimal diff.
Then if adding device drivers, please add them as loadable modules where
possible.

Regards,

Tony
