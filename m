Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C755F3AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 03:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJDBDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 21:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJDBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 21:03:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A7539B96;
        Mon,  3 Oct 2022 18:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F57C61215;
        Tue,  4 Oct 2022 01:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2D73C433C1;
        Tue,  4 Oct 2022 01:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664845423;
        bh=5s3K9rJI8dEgeYCSV/L1VS0YPx2lcRP3kt/p7mVGEDE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kvScv3+rFHE7nkb4BCspJAwq+AkymlYOLRNVD2XbGrS2KBcGko7hIvuXeW4hLCl/I
         P3+lPTFml3OHCXvxLWdeqP200IR8AmveqaTwQl7TxWx+4eKAOPYbJJxuB4YQwaZwJV
         eZlbYj3mm847gkTRmKhQPB2ybpkuIGHvvWcJw9iRLHKZPJmKlW5vcLe9jtJXb84OrV
         HJ/F9yz3XV/1TQS2EyrjE1TwoSKWKiBEH6lLQyOCRft6zADsWiyM8dkdLOgfpO3vvM
         W6pgfvCBXSXz7cSV22H1uRBUq/iWmOz+uwtWruc0L3qhDu0Hqda3/wH8kmuRBBwPHD
         ZO5FXmCvPmNLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1B2EE49FA7;
        Tue,  4 Oct 2022 01:03:42 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <37208884-5153-d922-e787-e830860df05e@schaufler-ca.com>
References: <37208884-5153-d922-e787-e830860df05e.ref@schaufler-ca.com> <37208884-5153-d922-e787-e830860df05e@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <37208884-5153-d922-e787-e830860df05e@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.1
X-PR-Tracked-Commit-Id: cc71271f5b793d619f8a7d2ef905374102533c75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74a0f84590eefaf0b55941e8bd8c476b35cdd40b
Message-Id: <166484542291.7481.3502643617185303980.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 01:03:42 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Oct 2022 07:35:55 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74a0f84590eefaf0b55941e8bd8c476b35cdd40b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
