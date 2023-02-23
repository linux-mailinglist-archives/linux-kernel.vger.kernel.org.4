Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3F6A12BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBWWUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBWWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01705C155;
        Thu, 23 Feb 2023 14:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33B9AB81B49;
        Thu, 23 Feb 2023 22:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE4DBC433A8;
        Thu, 23 Feb 2023 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677190808;
        bh=vRtO5KIGuYGogw2M3+Xwqv/ZntKLkIo3ODp1eVXZrqQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iIFenXHh1Qe/0tKVaWYwUunhFOemQOaQjU+2u7uNzL7XSSRwq4mt5mFsOQIsxounG
         nr3Pg1L+kswWNGr2LSXYUx9HzUqyzJlzUOmaMVnbHQNkommYPrshrlCyLqJALyaWQm
         QoRbcn0P2i+iOW1HJnsSOTfzvkLX4qUcmG9JsGqtmT+KSE8C7En2oKR4Mq8ja/7fa+
         R7dj+j8P8myK/6rdLbR2vgAYwtPxbt5omZUQtGG9WlMux4NOhNhv2D0NcGmGg497NP
         eOPI8tWcJ8evlouqgQNstnggt6Ro3PE6xMtR/XDjCmPChGUA8u0hidfS3yvCBIjyTX
         sowMDadYxdJyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C92AEC43157;
        Thu, 23 Feb 2023 22:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] modules changes for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/VLCgqeWIvzfiAj@bombadil.infradead.org>
References: <Y/VLCgqeWIvzfiAj@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/VLCgqeWIvzfiAj@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.3-rc1
X-PR-Tracked-Commit-Id: f412eef03938d3a40d4f6f5a79d0f98ed89b596d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c538944d8efb14e9809b685608490b017bfc2d48
Message-Id: <167719080881.29288.10772156348000939230.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 22:20:08 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, mpdesouza@suse.com,
        masahiroy@kernel.org, christophe.jaillet@wanadoo.fr,
        rdunlap@infradead.org, dan.j.williams@intel.com, nicolas@fjasle.eu,
        nick.alcock@oracle.com, tglx@linutronix.de, peterz@infradead.org,
        linux@weissschuh.net, jiapeng.chong@linux.alibaba.com,
        p.raghav@samsung.com, dave@stgolabs.net, linux@roeck-us.net,
        hch@infradead.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 14:51:54 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c538944d8efb14e9809b685608490b017bfc2d48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
