Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1868F6671DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjALMQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjALMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:16:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957FA3E85F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B20A6202A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62D74C433EF;
        Thu, 12 Jan 2023 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673525767;
        bh=RiDhcePfRCPtASv2qquTP93C+kQKj3eqBVi2tsk3YG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kFAXK5ccJQHF0FXQaJUJoNE1lBikScW4cu/zcztAgF/2HFc6z6GYDEyguI1ZLsslk
         nRS09mrJ1qy4vHznp1GvvSNCniEmUCNoTRIVb9xDeOI0Q6lH9tA2AWG/qtf7VXJxBs
         vHfe8jVz2hbeCm8OxhpJml8Zx298ncS6ApjugozMv86dfkdyjK/SFegmDbMC9Dctwv
         yOwaNKnDMfZ0iBgnt8gosX0mfDRAms6BJ+L8c+ImXkg1P5/kx2kcKcDwh+uwAKlXZL
         9FuRX21KKlqIG8onVoiyyxnI1ui470zoYBvR1CS8/x59ityg3LmzOLp3NpfLyKkMQO
         7WI3qKXNzTi2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CE7FC395D4;
        Thu, 12 Jan 2023 12:16:07 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for v6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230112104941.27840eb4@xps-13>
References: <20230112104941.27840eb4@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230112104941.27840eb4@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.2-rc4
X-PR-Tracked-Commit-Id: c0f7ae27539fbac267384a7bfc58296ea7550d52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e58f087e9c579a909e62600c3812801227cd564c
Message-Id: <167352576731.4374.9346849073067184118.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Jan 2023 12:16:07 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Jan 2023 10:49:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e58f087e9c579a909e62600c3812801227cd564c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
