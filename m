Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F96A2C92
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 00:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBYXWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 18:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBYXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 18:22:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5F417CEE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 15:22:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 973F0B80B46
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 23:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 321B5C433EF;
        Sat, 25 Feb 2023 23:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677367342;
        bh=E6LjFQRkX5+e6/IhM1A6ia5iiMGD3tAs+jfyGi8ltVA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AmtG/yzbFm3HBtz4B+KmBMwqpf2D9PWSyh/QaKNVbCLY5bMmgHlBFhboahteIiKv/
         jYlZvUj8223JizLNgVxNFYC7OsgzewHHxXeFPN80NoTu1vIaKM5Ym5b2ot8jN+byBm
         QyYeCohjvmu3cjDA4o6A0mUv+JGF7X7Jm5T4sDMxmn8yYDVIfwr2C7BlPxRJStQHvB
         k0x6D1MiY0/aQhIAwy/vCcW2atSthy0ce0oFpid2zv3qSj4gY8OVUbwBggq8eA4xRp
         bfwzHCkPUeFMZNw6ZsEnM3lzXOn9qrq3Opr1faCDYXhUb50p2ZNTrChTUp/cP4dfJX
         KwP2opg0Oe+aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20606E68D26;
        Sat, 25 Feb 2023 23:22:22 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230224113919.31bd95b3@xps-13>
References: <20230224113919.31bd95b3@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230224113919.31bd95b3@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.3
X-PR-Tracked-Commit-Id: f4440abc08917d9a7032abb8a6a5d4b36ca979b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e3036a2642b6145a8117d21514bfc5f8d5ea595
Message-Id: <167736734212.9412.4435452983341536790.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 23:22:22 +0000
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

The pull request you sent on Fri, 24 Feb 2023 11:39:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e3036a2642b6145a8117d21514bfc5f8d5ea595

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
