Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F83C6A888F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjCBSeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCBSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:34:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F720252A5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0273261635
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 673E6C4339C;
        Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677782047;
        bh=TWZxDaDtCL03k7b0H1LUr4suIoajd7GM+Zx6siQYVa4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jJMxr57QOqFCf8TiSgezjQtaBQBp1sCd4oivJQU6BHKOIzkGPY0LJTwgdzgqjUkW9
         2RKsAELi+uUJhpKocmwm9+PytztjGADZ7aevz6bkFcWbuqGRm52VUw4w6q0Y5iEBgV
         241QhFBPtUcboWCJrM2oY1xbY+S/0hKssQeBOsYoiy1/unDh6mSrOPklbBqtcWp6uP
         lKl5AKURKl7GWwBztPVN2yswwEN8+n8GJdR5MtLXrZpkQPdp8VYufVxglcILB81HqP
         7PqsHEPNw0qkoY14RfmOTlzgtBW96wvMXk9dSys+YwlvupMj303huna10d2jo0kUNC
         YvzP1xxgQfRxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51DA4C43161;
        Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZAB4YGjj/M9scmiQ@kroah.com>
References: <ZAB4YGjj/M9scmiQ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZAB4YGjj/M9scmiQ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc1_2
X-PR-Tracked-Commit-Id: 0c058fb94ae0e2a68639f4569de1c3abf5df7ad7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c2bc4ed278ee0ffc0a1a37aaf7f39f1bfe8da4d
Message-Id: <167778204733.4243.6435307877119840505.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 18:34:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Mar 2023 11:20:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc1_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c2bc4ed278ee0ffc0a1a37aaf7f39f1bfe8da4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
