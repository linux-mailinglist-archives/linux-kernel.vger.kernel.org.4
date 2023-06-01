Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E9071F4EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjFAVlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjFAVlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441681AC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D97E564A75
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A9F9C433EF;
        Thu,  1 Jun 2023 21:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655640;
        bh=RA/GXG6/916awg+awBQL70oZiccXy7Hn7TFIiriVzGY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e8jUZTCUYZjGK2B3ruVp5VSonkzaAbWsyxIxe35OwOVj+dCg4B+MH9WsLw0Xn48+V
         W78UG8O7gCg2v7nMUsHHID4R+3J89TMZF1tnx9SkVLtTf0ZtWHTjOBMfbewnYfujPS
         aW3sm1IncFkg0lWPWQVNVK3WG83364o87iW6R32jjdGBCDRPDwufeXU0B/6G+962+r
         8AyiNSRylRLG9VVuTfWN4HloSjSF878logoPkyL0MlunnBORaoDNIwYIlvMYHb8zPr
         yhIdw0xyRCdvmztuZw3iDECdg9SETHVBgup9FUhGlu6RTb8jClzT0DhuwbGGAZEE2W
         W7VBQhzuxbQ1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A59AC43162;
        Thu,  1 Jun 2023 21:40:40 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230601181916.515b516a@xps-13>
References: <20230601181916.515b516a@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230601181916.515b516a@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.4-rc5
X-PR-Tracked-Commit-Id: c4d28e30a8d0b979e4029465ab8f312ab6ce2644
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0e78154c0876a46ec874615262bd3ea58b80788
Message-Id: <168565564016.17545.7344128695610453416.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jun 2023 21:40:40 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Jun 2023 18:19:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0e78154c0876a46ec874615262bd3ea58b80788

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
