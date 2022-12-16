Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D87364EE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiLPQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiLPQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:02:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED170BAD;
        Fri, 16 Dec 2022 08:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A01B5B81DB6;
        Fri, 16 Dec 2022 16:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65E18C433EF;
        Fri, 16 Dec 2022 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671206414;
        bh=eGizUScCq2c5nrwebgNQZmGOXtvn5XbteJ3+6hzBnkY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aTpBc5i0iq0MZZhNOcoz7+ERWfFBA0v8YvIZeYodzAuYDMGTFVS827vcud8gbpdRa
         bvEH1S3akBz8ftbS6a+y1tr0Ys+Czp/HW3aVF7qrPY37Cm1+/Wmfw4/jhG+P7c/47C
         Lw91ihNpR+wx/hbWUvL/UQElACDvN2cpNUvApBSHot+5lD0s6ikJ8mCs94Ri1NRutW
         Cj+i55BYMauIi82DpTQ62EJlvQ8PYDfToEa/nN53viKTlOh0cYIBcMyrw3PoRZ8age
         z0hWQsjWwOm50fA0cqzW69D80JkgM1oMfoqz1xp3RmhB9YKZHUhqWtda+KLu5cW02U
         Ax4miIeZu89tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FF31E4D00B;
        Fri, 16 Dec 2022 16:00:14 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver changes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5wvvK08gUxb7feH@kroah.com>
References: <Y5wvvK08gUxb7feH@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5wvvK08gUxb7feH@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc1
X-PR-Tracked-Commit-Id: 81c25247a2a03a0f97e4805d7aff7541ccff6baa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58bcac11fd94f950abc7b8466c5ceac7be07a00e
Message-Id: <167120641432.30725.8647246180685155442.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 16:00:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 09:43:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58bcac11fd94f950abc7b8466c5ceac7be07a00e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
