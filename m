Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170066DB584
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDGU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjDGU5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0FCC1C;
        Fri,  7 Apr 2023 13:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 434BB65482;
        Fri,  7 Apr 2023 20:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FA41C433EF;
        Fri,  7 Apr 2023 20:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680901012;
        bh=p3jRf1L9xGohI32YHj7FCCNyMaoewqD3ww+BUmp2Wds=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VrjHV/NNqQz0DguIrG9GkzCcUC0HQrPXKDaseEGMQoo4axGTpwxz+x0HfESlpqhw+
         Uh44Lk9WrXD93GgG8jU0LISwHR7zMbXiWICD4enjQPX7t5TpWU6bdtM3ez8cy32BKU
         7357ksvdKbyL518jNh3gEyoiIjpvwTQjCYdA/z09MUsnqEGpRdxHLe7QQNopaKhTA8
         00Ukv07Cw5FiHrT8w5xfkV/M5uZtTXqlZ0HMdgsQ4eJhE9hZomIswoc0K4kceFXUV5
         1acpPHwik04kwct8IpVUDWqAWMVLI5DcncUTDWyR+UWc0PdAWsazoWEKpS8oWQ78wE
         mOf2+w9eblQ3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DA23C4167B;
        Fri,  7 Apr 2023 20:56:52 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muJ_pjqS7pqDOLWiqcwjR1eHB91dX5XeoM8TVL-Lng-eg@mail.gmail.com>
References: <CAH2r5muJ_pjqS7pqDOLWiqcwjR1eHB91dX5XeoM8TVL-Lng-eg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muJ_pjqS7pqDOLWiqcwjR1eHB91dX5XeoM8TVL-Lng-eg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.3-rc5-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: dc8289f912387c3bcfbc5d2db29c8947fa207c11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1e6fff395d3209511f6a2264c5b6256614afaa3
Message-Id: <168090101257.23908.8315231906053313171.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Apr 2023 20:56:52 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Apr 2023 23:16:37 -0500:

> git://git.samba.org/ksmbd.git tags/6.3-rc5-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1e6fff395d3209511f6a2264c5b6256614afaa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
