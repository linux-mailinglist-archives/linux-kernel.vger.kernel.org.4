Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2276A2394
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjBXVQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjBXVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:16:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804C46C538;
        Fri, 24 Feb 2023 13:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B918DB81D45;
        Fri, 24 Feb 2023 21:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82134C433D2;
        Fri, 24 Feb 2023 21:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677273358;
        bh=HhL2eTGVzDqvhS6NMQlbS7NFZRyMNmQKQRgjbniLNSQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nya9Uzw8ItSVEczCaZoz51DGmwioRMhQoEmMGN5O/FlWPLsg6ZqyEYaMrKBoLDo5r
         uUb0KhZXssU2nZ2u5Eaqe/GfuyAk0OK6KvCClgHHgSkaSy2PNBT+Mgkge4lxELu8KI
         q2lA/LXOM3yQeYuxHH3lfVIkvnY9a1l6aYjnNhM7m+fOSmJFVt2svSj11+87PNpw+k
         jUWUjfg9/aScFtwZ+vqkVYokZTyNBdYZ2Huh5jNdGAJ71u0Sdd/LUTfqz16p4HzI/F
         AHGBWMhgmjJURaLlAeB03E/U+8J2qQP1KSkLIihgmynMGl8g4VUch4QDLcPLK1b38+
         rifLKMs0YzU0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C454E68D2D;
        Fri, 24 Feb 2023 21:15:58 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/iywbFbiUAA6ZD3@kroah.com>
References: <Y/iywbFbiUAA6ZD3@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/iywbFbiUAA6ZD3@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.3-rc1
X-PR-Tracked-Commit-Id: 72206cc730b5c9208e9a99ace1c619f542035312
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17cd4d6f05087ea1ae5c1416ef260e5b7fc5d5c9
Message-Id: <167727335843.26367.2645999876245444213.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Feb 2023 21:15:58 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 13:51:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17cd4d6f05087ea1ae5c1416ef260e5b7fc5d5c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
