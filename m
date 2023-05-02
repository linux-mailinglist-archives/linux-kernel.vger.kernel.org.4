Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA956F495E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjEBR6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjEBR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62D010F8
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19C82627D0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 17:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EA05C433D2;
        Tue,  2 May 2023 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683050276;
        bh=54d4HTV0zCqUN5qsjzsxKN+oy22oCwYFZ4Z6O0UQQT8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uAzt+wmRg9yOLE4cHgm13Qo66F1TFj6klqQ/mcilLtZpApoowSzC2NoUMaj+l3E8Z
         +u+jgpm9Cxv6O70V15ir5zlFtOS3DAFb1MymyhwsGHsbJVimsxm7U6a2408A2O/tAo
         a0WQDOefhH3vrHtOYch2KeZyUNpjk3Nf1z7OpnfNOPD38AYrTfwS/nLp9Zuq/wrro+
         eMgve9yHX9r7YD9F1BrU+wt6wbB5alzKlzeMXQby49NdWO4yuEqZg6va2000oaWzGP
         5zFvJMoQLaf2xgvteIX9CCkcTVi3cXir/ff8W4xnh6fmImTw6g3rR5nosom/OkunlL
         R5OT+9B/traqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61E6BE5FFC9;
        Tue,  2 May 2023 17:57:56 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230502162221.GI620451@google.com>
References: <20230502162221.GI620451@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230502162221.GI620451@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.4
X-PR-Tracked-Commit-Id: 9e9ff39243ea8795a4833708613f884b39dc91f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3af49062b0115b55a54615109172b44f618daf97
Message-Id: <168305027639.6897.6645804428996781681.pr-tracker-bot@kernel.org>
Date:   Tue, 02 May 2023 17:57:56 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 May 2023 17:22:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3af49062b0115b55a54615109172b44f618daf97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
