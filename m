Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439FD70A4E2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 05:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjETDXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 23:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjETDXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 23:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24387F3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 20:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B522660CFB
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 03:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27258C433EF;
        Sat, 20 May 2023 03:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684553012;
        bh=rwaoAboul94zfZFz6cOl695czqDtXxXDpRdPkgYovmw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G1gX6HHbjNrjdUH/rpKxAHBM7aCF0ENv1tSR/XL0ykxur1RjWf26nNnXJpAUiCl7S
         VCMe0tAsJ0NNHE5qKcrAFCZlOzn1srKdKje7bUao4xaOt8qCIisq3yGnCbKtAoAkz/
         /U8ncpsKv7/edTSA4BbTTBUkcDDGQYFTJmCnUbS+atZkNsIv5TnVqoZHnMuF3OFCHM
         juCUcYoTTGAoBlwiw4a9EYIsazocCbWt6jPK0njRx70f9w+PzLByA92hxE6XEOGdRe
         p06Xe2dY4xk9HEeb4JlDXUhu4b9jXc8MM+R3AqgHui66Ua4tlIr6U54/AEk/7Y74M2
         WWFabt+uNw33Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1549AC73FE0;
        Sat, 20 May 2023 03:23:32 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twwK+sN8iTjojdXd0waG0CUKmDqgyKuBvg76-cjT3PWxA@mail.gmail.com>
References: <CAPM=9twwK+sN8iTjojdXd0waG0CUKmDqgyKuBvg76-cjT3PWxA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twwK+sN8iTjojdXd0waG0CUKmDqgyKuBvg76-cjT3PWxA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-05-20
X-PR-Tracked-Commit-Id: 79ef1c9d14c65a5c3f7eec47389d8c2a33be8e8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d635f6cc934bcd467c5d67148ece74632fd96abf
Message-Id: <168455301207.31362.16072827749088539245.pr-tracker-bot@kernel.org>
Date:   Sat, 20 May 2023 03:23:32 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 May 2023 11:09:38 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-05-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d635f6cc934bcd467c5d67148ece74632fd96abf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
