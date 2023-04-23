Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57126EBC64
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 04:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDWCTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 22:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDWCTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 22:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76451BD5;
        Sat, 22 Apr 2023 19:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634B660B51;
        Sun, 23 Apr 2023 02:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9BA5C433EF;
        Sun, 23 Apr 2023 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682216343;
        bh=z5+A1RZSqI7NEF+u17BC2Wk+13SViH+UhzWxCAu3ssM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lq9mT2pZt1k+aa/xmOW6bCdAf9SdoHG+Szo9u04E0JXv/FXrm7cRW8BX82dPJtq/m
         4DKAUC+6+rhgkKnHapSTc3g66hzW+bDFagqUbxli89SkpBGGqtCemc6BE1NLSjbdgZ
         XSe6zAtjm33XyB4VR7swkw5uSu4Ui4kWMg2DIXxBXQnrpo7ET6ZtUUUDPMsqXFG1qC
         9/tFMwlj5HstykPIRwnrS308E1on+dPXVIg8Vwie+osd+ALSPMroWYtDqk+C2YUv0M
         /jUxthoX9OtoXxmJ/EidAN4y5S59Tgdy8itTCwytfeJ/FFtcrbEXvEoWsqoIfrpAvh
         p0cb5HFT2WkSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6443E270DB;
        Sun, 23 Apr 2023 02:19:03 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230422212534.GA7257@alpha.franken.de>
References: <20230422212534.GA7257@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230422212534.GA7257@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.3_2
X-PR-Tracked-Commit-Id: 6dcbd0a69c84a8ae7a442840a8cf6b1379dc8f16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 622322f53c6d9ddd3c2a4aad852b3e1adbd56da7
Message-Id: <168221634373.27513.14791443979191365431.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Apr 2023 02:19:03 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Apr 2023 23:25:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.3_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/622322f53c6d9ddd3c2a4aad852b3e1adbd56da7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
