Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D0612C46
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJ3SfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJ3Set (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A8624E;
        Sun, 30 Oct 2022 11:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C220060F23;
        Sun, 30 Oct 2022 18:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 339C5C4347C;
        Sun, 30 Oct 2022 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667154887;
        bh=b+5iszjetwOI9mCpBV5UZqItVVGMLCOHEDmtLZopYyw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MWqpGV/RdvtmhIpgFKxhoQJvAx7ZGl2TRf+x87P8TitC0ehgCVk+mayB58tacgQpT
         /jT2ifm4PltbCU3IHflhRYE3t/ydCf/sknHQ1yWKe1yELXKVdtihN4UCPNX9WSFgEp
         orkeUByyMdxqaLrhUA5JW7u5MdAn81047iWHWXmY94QauTqYBhsXxAmCnCvCOrqpu8
         s/Vr7ND+4WFG72EBM78wp/0aSFg1UmzRyXXQFy0Ft8YlqvEmgcsstg0pT+hoFdZbHe
         UbIjL2GFUG11DwZnxwbOVVb1yHdM8nSAcX34agqaU2IuIEzxUEwLxUxOJhsXNYyFzd
         GiW4fIznZix8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F350C41670;
        Sun, 30 Oct 2022 18:34:47 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y16F7fZSFrXupUU6@kroah.com>
References: <Y16F7fZSFrXupUU6@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y16F7fZSFrXupUU6@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc3
X-PR-Tracked-Commit-Id: 308c316d16cbad99bb834767382baa693ac42169
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4d25ce6e9de47f6d9fb6cc1a34b47ce5f0a46ab
Message-Id: <166715488712.31922.13632339161027072208.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 18:34:47 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Oct 2022 15:10:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4d25ce6e9de47f6d9fb6cc1a34b47ce5f0a46ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
