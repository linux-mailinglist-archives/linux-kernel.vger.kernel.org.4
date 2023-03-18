Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9436BFD69
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 00:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCRXJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 19:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCRXJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 19:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B9314EB5;
        Sat, 18 Mar 2023 16:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B06260E9F;
        Sat, 18 Mar 2023 23:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9C10C433EF;
        Sat, 18 Mar 2023 23:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679180973;
        bh=6gH1CXlaOz1aS2cGHYVDFVLZlj6M6INTH6JluFxWyWI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ld31iLZShGI47o/KyvxpDbCmU1ddT2EnBrrN8UKflzAFON5385QU4Tzh63CGsCcy6
         X1PR5UKYGtT3lbVPSyuwdMPdV92HxTDr+6xGcWtiDcj5DuPWK7T86oAMWuo2EavQH2
         wycNSFh8Kect8iaVTX5RhPMNZN81YMuAzHtTPmVgG1/q5WgfWaQXYYOpLjasPh0uLj
         gx0TYB18k9kpH1W2RcBH58VlwklYvUhl6sFzMeW/pTPAlS40Yt+bIZDe/67Ds6xEMp
         rQY7w8q/Xhm7OdTj+jEVVL6YAxLN9LaZlDIgTRW+d9Mtn0QdPrB0osfbXBzscWx6CK
         GN3aK07sMWzgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7CCAC395F4;
        Sat, 18 Mar 2023 23:09:32 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZBYjSkFz/FEobQmk@ls3530>
References: <ZBYjSkFz/FEobQmk@ls3530>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <ZBYjSkFz/FEobQmk@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.3-rc3
X-PR-Tracked-Commit-Id: 29413f05fe34e8824551b91f660fde781249417d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3671bd86a9770e34969522d29bb30a1b66fd88a
Message-Id: <167918097287.6305.4633226409323190897.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Mar 2023 23:09:32 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Mar 2023 21:47:06 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3671bd86a9770e34969522d29bb30a1b66fd88a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
