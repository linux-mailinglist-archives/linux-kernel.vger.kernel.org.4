Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECF67FA78
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 20:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjA1Tdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 14:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjA1Tdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 14:33:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907724C8F;
        Sat, 28 Jan 2023 11:33:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDD5EB80B98;
        Sat, 28 Jan 2023 19:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92961C433D2;
        Sat, 28 Jan 2023 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674934424;
        bh=7z7ocdSC3ZX3zW89zHx/1RISjAakExFDobQt2nk4zfY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lW3XkAKxvGWxCC/4vtjBoxcTlhAfMgn9tUo/7zuLFq323MZeYOi4PAX8mPwxTeN8n
         0WR2iDkBBCOtZnaikVkktT++nCeo47ZGxYSqKT22zyp6Sr3jFzXmHepMRmhtrhO1OV
         H/Wi9X7dLJ7jysG/IOTwAGUffFZoBANEQMZq31BgboAOSVEYyA1rjkxC8IKEw7ewQq
         Oj6NGCbB+qrQbwtR7SGyrjjjdRM0YhGnFC3Vzd1t8a0KxZQU3xysB6FekvM5iLPeFg
         pQcBw/z1u6sxFNEhZm7gkvyyDueVfutEVxhn2wVGGvmeo+rkNIiH2wz0NqcmbfjHiA
         v4K89DyMBfpKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C944C39564;
        Sat, 28 Jan 2023 19:33:44 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtnrm6nSsziYEZs=qyC2n28Vk3=KS1fNbqeWXP+4gu0vw@mail.gmail.com>
References: <CAH2r5mtnrm6nSsziYEZs=qyC2n28Vk3=KS1fNbqeWXP+4gu0vw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtnrm6nSsziYEZs=qyC2n28Vk3=KS1fNbqeWXP+4gu0vw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.2-rc5-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: a34dc4a9b9e2fb3a45c179a60bb0b26539c96189
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2543fdbd5cd3bb7d72a6c810b431ba17778a607d
Message-Id: <167493442450.9400.9759845576566406842.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Jan 2023 19:33:44 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Jan 2023 19:45:23 -0600:

> git://git.samba.org/ksmbd.git tags/6.2-rc5-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2543fdbd5cd3bb7d72a6c810b431ba17778a607d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
