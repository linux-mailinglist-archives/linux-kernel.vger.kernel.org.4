Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E68654698
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiLVT3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiLVT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:28:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6E822B31;
        Thu, 22 Dec 2022 11:28:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E7CDB81F51;
        Thu, 22 Dec 2022 19:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E79CC433A0;
        Thu, 22 Dec 2022 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671737328;
        bh=j7KyGEafhU7rjZ2E+koeYs4kwfiSe1BCplgkWA5MAN0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S75mbAbk5M7/RK8F1F6f4IS4wKNrxcA86AH24/GwL4IKRZBNoxokQqgXyYwzpa3BT
         pATR2N5YNSQ+ctxANeBMFVGoQFU+7LXUv/ye3DB8n0Mb6giISHlmjyLZz6K44kXd14
         m8kt1Pa1JXCPU65c3p/lqdjFZt5qIrnYt0/+GBs/gmSIHd5cNCL3tJep5CtFD0KO2p
         CPHKu6Fe7rro/irB1LcabLIRbIpHS1HIkv7eCDJ2ZB1ka9ZX7NII57KJMEBJMPJFBf
         e+JpVuPpX3y6vqcRhNFgWgNhaQ8jRqWrZqF7pHEhTKF5NEbEWpF5jtPHxtSgfVhxoc
         1SIlesCDDAXvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D019C43141;
        Thu, 22 Dec 2022 19:28:48 +0000 (UTC)
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.1+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <65d488496e9889d1c2d3faf06bfa7c22f3807ef2.camel@HansenPartnership.com>
References: <65d488496e9889d1c2d3faf06bfa7c22f3807ef2.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <65d488496e9889d1c2d3faf06bfa7c22f3807ef2.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 68ad83188d782b2ecef2e41ac245d27e0710fe8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8395ae05cb5a2e31d36106e8c85efa11cda849be
Message-Id: <167173732817.14570.14536275017186165421.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Dec 2022 19:28:48 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Dec 2022 13:05:12 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8395ae05cb5a2e31d36106e8c85efa11cda849be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
