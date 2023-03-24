Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82A6C8720
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjCXUyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjCXUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64C9009;
        Fri, 24 Mar 2023 13:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7142662CAD;
        Fri, 24 Mar 2023 20:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9DE6C4339B;
        Fri, 24 Mar 2023 20:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679691280;
        bh=Tg71sR7+E79w9+uE3gyuP+N6fIvd8dgm6ecjIdkEJn4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UtdX/M4I1YJnCX34kmnb2rJ5w9i3BdbPy9bQF29EWk+1RCukPWDly68G/arpoOmui
         tjwf52i3GQLdwnrcsopIdd2bpIKXw4JYPfOQ95QwDck8ZNwu4AOCuc8D9U069fHKgN
         Qlptmb64IqF90KDR6UXnIZsLwJxjyWmvzHbHo5OIfvg7MHKeKXBTjhmHBsab421WIe
         b01F+OoTzqrfllA9qkWCjcGWo+74F9avxe6rsyJjaT9pgVJozF0YHvOI7sG5zB7yXg
         hFL/jZYfhe3+qYBP+SH0W76dyIxxs7cmPqqxzx75Bxn2LSuULmF/aH8hpRryW03nF2
         xL+EMSDLLG/BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB691E52505;
        Fri, 24 Mar 2023 20:54:40 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iQq07J-DPcwFWndfASgQdb1dgm=3buJ9cDYer9rJ4Cug@mail.gmail.com>
References: <CAJZ5v0iQq07J-DPcwFWndfASgQdb1dgm=3buJ9cDYer9rJ4Cug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iQq07J-DPcwFWndfASgQdb1dgm=3buJ9cDYer9rJ4Cug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc4
X-PR-Tracked-Commit-Id: 6babf38d894bec696761c10fbfccafceae76f4eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd3d06ff5f4fa23f32bdb7f4d9f308503801d9e0
Message-Id: <167969128076.10856.18108628794225537839.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 20:54:40 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 17:35:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd3d06ff5f4fa23f32bdb7f4d9f308503801d9e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
