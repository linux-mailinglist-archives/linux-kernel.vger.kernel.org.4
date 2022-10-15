Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663D5FF7D0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 03:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJOB0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 21:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJOB0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 21:26:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F80167C9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 18:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80B25B821B5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 01:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29E10C433B5;
        Sat, 15 Oct 2022 01:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665797203;
        bh=c/fGbm9B1WCtqJFUkSd72KRFVg9PAxNIyOwfuz3qOzA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n5qTwF2DFa2H2E2JcWB8344j9FDyED/KdABThTyvJhnJOtqOgwi6zhD+OhuEojV0A
         R1HKOu/foHW34um1GowJtRREnUrC/4DZ6y1MmlrrAO87hR1OLrcVbX2JF63GSRihi6
         MpZUJ9bBFICBzbfsDKDRN2Oeb3gNzNWJUIgLDhONs1dhLD5uYAkfZqZDoC4uuQkh8D
         LRV03Y0TF/2A0oj7zHE0rCEIIV68OSjEnTUnkKK23zIEnR7Uq7zxv7BaNtJODgs2f7
         fQ3qS8O7O6sqXZC8PWOHSY3jM8PR6roiRs/HFXWTG7bh/FC3GXCaOGGC161pjZ3Bhr
         NBp6cKrcqn1KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16C0BE270EF;
        Sat, 15 Oct 2022 01:26:43 +0000 (UTC)
Subject: Re: [GIT PULL] UML updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1664125781.30715.1665782235123.JavaMail.zimbra@nod.at>
References: <1664125781.30715.1665782235123.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1664125781.30715.1665782235123.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.1-rc1
X-PR-Tracked-Commit-Id: 193cb8372424184dde28088a4230a5fed0afb0ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91080ab38f3eaa2a0af4888220d007698a2e7b03
Message-Id: <166579720308.30479.14940625172124884688.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Oct 2022 01:26:43 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 23:17:15 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91080ab38f3eaa2a0af4888220d007698a2e7b03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
