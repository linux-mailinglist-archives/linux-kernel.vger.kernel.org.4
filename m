Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCB6DC0D7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjDIRRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDIRRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 13:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007D430FA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 10:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8736960BBB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 17:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E28A5C433D2;
        Sun,  9 Apr 2023 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681060628;
        bh=OoIgdkcbud9dHnMFHEFi6PpF4kiPke22ohSvmnnmfHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZLZkSfbD+qhZBAkrjgCGHbiqRsF80YbVzCirwSq3oqNk7suaWLUjHhGgkgD+Zc1aJ
         VQyDXGARR97nDvRpV7qWt0XqYpzZEH7F2UycNCrjSh3h9qGAB5BpyY8ubzUwQCehc9
         wRGBuOGyL3o1aJQ9II99sTrxzprPr3v/APXpxgyHAPOnAxy6mzz/uWotLrTrYtruYx
         wheZyhjAWF+XIDlI+IgIz/iqVb6jd5ILzHX8zbuhviDVYvyEve0OWocDDL+6N4mQP6
         zn/3rSTTshcypkzebbM4x7mfhaCCKIDBB2KSFYvWwvAQ4NVXyCpn5jSuCY2vUp9LQX
         p7aNZCVD47AqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE990E21EF2;
        Sun,  9 Apr 2023 17:17:07 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230409110843.GBZDKcu+oZLHL7V8VL@fat_crate.local>
References: <20230409110843.GBZDKcu+oZLHL7V8VL@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230409110843.GBZDKcu+oZLHL7V8VL@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.3_rc6
X-PR-Tracked-Commit-Id: 24d3ae2f37d8bc3c14b31d353c5d27baf582b6a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: faf8f41858e2792925b2c526e16d2f539a53a730
Message-Id: <168106062784.14171.7516695744973001715.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Apr 2023 17:17:07 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Apr 2023 13:08:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.3_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/faf8f41858e2792925b2c526e16d2f539a53a730

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
