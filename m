Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313FD5F7DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiJGTU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiJGTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B189838
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC73D61D15
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACFB5C433C1;
        Fri,  7 Oct 2022 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170413;
        bh=To4qfShJi/DvHw7N6YLrxUt+VFPce+fdBNcr5fO6rKY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WX7obP38rpSUR3xYvdl7RBMMgw74qBRIXkjD5I1F1uzKuFi9LzqPIn7HLLGN0Psso
         jFW4QWpTwaLyCKIzSvBM52XEf51rPJCun3C9Akr1Fp01Pms7qKbrfjJgZpY30BBzbX
         dKHtaPbiY+9Yt6Ok7q0tSjiwgVvuJZAl9qukMyyPE+yd0KHwynDVZQiFVrjf+G8ZlL
         DDkZ3U5Y8an4TspUjH5aGJvF9XbSuNULzCqaUtUUuuBzovdSM0Oyok4A7ggObx2RKN
         baab+EFThxGZipjdyKz8G5/vcC3dEpK/pJgE0Uf26pNu6+DQkW6ltssXjUpneVDeWs
         TeSE/sxsjidqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A72DE2A05C;
        Fri,  7 Oct 2022 19:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221007172337.32e05296@xps-13>
References: <20221007172337.32e05296@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20221007172337.32e05296@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.1
X-PR-Tracked-Commit-Id: 63c30d70443064d71340e02024b4a463db5c77d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1227db9eab18f1ebaac990223d3f18eaddf1b442
Message-Id: <166517041362.8063.1721460274279860546.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:13 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 17:23:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1227db9eab18f1ebaac990223d3f18eaddf1b442

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
