Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B5C741A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjF1VKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjF1VJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0861FF6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FBF461474
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 21:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3DC8C433C8;
        Wed, 28 Jun 2023 21:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687986566;
        bh=iklCgUzKFKvnAQb/SJu90FChLiPIXnlwTqKHNSVyY5A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FfRbKI9EFigVyi9JGtNWIc9NHObCpzD/nxGe1hTFDl0/Cn+yNeulWENncitoGtrcy
         gKj6ZbCWtFFW4uLHy76Mxzn1tqBw/U4UIACCL4ePJSHq8dM6W0GAdFgubaaCUBybAO
         Zl2xypfbKPML7qn1nMNbgHgz9siGPfvuZ86VeLbzzK07XPZ6CQ4XseRc2CTs+hBohm
         QWiDXsoCKLVfNAeCzSysefTzPw9PbwdBYE9Ts3Sisq9XuzPGfh2qsfVplVxtPgSqvB
         Kfhw00HNq5DtpKJhExhkRUukBJIWamo36zKZUY4nx4d1A0zFA6C/sitZcRFzi6n6EU
         NSIkKVb0GbiEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0710E5380A;
        Wed, 28 Jun 2023 21:09:25 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626130252.7bc89a45@xps-13>
References: <20230626130252.7bc89a45@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230626130252.7bc89a45@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.5
X-PR-Tracked-Commit-Id: cf431a5998326a0468532a188a188ac2c8e9c55d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1364b4068a421d99fb4da8b570e54525096b1cef
Message-Id: <168798656583.29247.7718407316804429405.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 21:09:25 +0000
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 13:02:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1364b4068a421d99fb4da8b570e54525096b1cef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
