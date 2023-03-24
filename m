Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A86C825F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjCXQbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjCXQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:31:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8BD2D55
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D0E2B82568
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 386BBC433A0;
        Fri, 24 Mar 2023 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679675468;
        bh=nYwqoSdM0p+YBcfrNrawjeOYMaLErwUJzT1sCp1/ZTA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iNbRP8EJuf6+8G60QkRm3QsGAm59HaKM2l098wVGTgIiiJ9rEPXGLboyBM1XSp6HI
         5zcmxgUCg9ADoMhB2u3qbuHoi2g3Wxr32DvfZsSwignYIIKbsd91kkf3ZaFN86syET
         T/k/LzCvcZXxoCeOXIPxf0FOcLj8rGicvpG0QN/L+jytF6gzQCCuvNXS5wanzjmOJy
         1JKzhQjNUuXgdoCqKNS+p1jHHv06JT6a4ocLfCvmn27TKOoqk0jL4zWorRwE/GwRXd
         4yGiPuvcj9/C46W7984gwlWbWbHHlfpXnwf+1//belmNwBOtWnhesCXFpvZi5/gnGM
         LBQ9/fEcKivdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24600E2A039;
        Fri, 24 Mar 2023 16:31:08 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform fixes for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZB0bphQcL7KLRuV6@google.com>
References: <ZB0bphQcL7KLRuV6@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZB0bphQcL7KLRuV6@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v6.3-rc4
X-PR-Tracked-Commit-Id: b20cf3f89c56b5f6a38b7f76a8128bf9f291bbd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bae0ad148f41904dd4e5857bdc2e3e31b950b3d
Message-Id: <167967546814.8924.11093683484440209193.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 16:31:08 +0000
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 11:40:22 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bae0ad148f41904dd4e5857bdc2e3e31b950b3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
