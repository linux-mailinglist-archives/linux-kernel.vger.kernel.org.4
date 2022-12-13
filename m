Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B340F64BEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbiLMV4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiLMVzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E122B2D;
        Tue, 13 Dec 2022 13:53:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E4CFB81239;
        Tue, 13 Dec 2022 21:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC41CC433D2;
        Tue, 13 Dec 2022 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968426;
        bh=vtNIGK++6C3c45uTYU2W01D8Y2qbfilKoc3ZqmzZLYM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qzw8EITGDG2rTQM/p3rpSTKBoCQQtSYNx8LbnLc8c1swqo9utHXE1jUClCKj2TGxz
         DuzQixgvOs0I0WJNY/oGwQCQU0RWEp+CXRmavZ3fZvXziDJLqf6UYgY2ccFhA57eMT
         fwqY9bu+ymoxE/p40lk08lkhyZJWckVDFR32lFRWdUkjW3hikjaDL6k0SACGsXsOfF
         I3T0G4dSrMnfoFFnw4/dlAGWypmsqU+11b2eYBStfZeFOYUmJqlMb4NivoFGUwtPYU
         qcXQ9Yy02AfCS+2y2HXdpZlPLxgZPAXzs8sacSBTlrrmb2vtIxYfey4ltXgAdQe0Zf
         p/PbtFoq6oU3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A998CC41612;
        Tue, 13 Dec 2022 21:53:46 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212152428.GA948323-robh@kernel.org>
References: <20221212152428.GA948323-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212152428.GA948323-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.2
X-PR-Tracked-Commit-Id: 580f9896e088b399fc79f1421e56a1b68f0450b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 531d2644f3b10098dadb25b2c26cf19ec0330f90
Message-Id: <167096842668.13204.1697773503656822728.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:53:46 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 09:24:28 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/531d2644f3b10098dadb25b2c26cf19ec0330f90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
