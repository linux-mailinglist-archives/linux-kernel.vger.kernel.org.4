Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF46671E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjALMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjALMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:16:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B450DEC9;
        Thu, 12 Jan 2023 04:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D017562020;
        Thu, 12 Jan 2023 12:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 415E5C433D2;
        Thu, 12 Jan 2023 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673525767;
        bh=tTMm4Uwh5blTeztGRAXxQApMhmA2p7m4kMVmAg1nAGE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fN76Sw6Z+Jd2YctH7BMwxUt5HfBAINlI7bQlPWwncJkjCGRnf3UQDmEv0lwY9tlKJ
         mQoF3dnls/ldwT/zOr8RA13T3qJPtOmmwUivOwzIHle3wTFPZ4OXLgpZ2XLT8SVpF8
         gfsKV4MLQM80EAQfmp5J0z+Oj81/L9pEhRasnpIMxEb2H5R7WYyeesI68V/9XoK9Sa
         UIw2Sfbu/aHi79QscGBkbH2XU5DCrG/PXZ6Z8FSN+fcRbZHesNWapy/kDlQu0MXDOF
         01AWU8uDuMtJw7x1Was8qhmylpQ1ISL7D7fKvEOABOT9qFvraOQX8wMgMitpPI3pOM
         F1FPLiYpLj+wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F1F7C395C9;
        Thu, 12 Jan 2023 12:16:07 +0000 (UTC)
Subject: Re: [GIT PULL resend] SCSI fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <255063201faa447278f005a52ef3c4cd22409cbd.camel@HansenPartnership.com>
References: <255063201faa447278f005a52ef3c4cd22409cbd.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <255063201faa447278f005a52ef3c4cd22409cbd.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: a67aad57d9aee41180aff36e54cb72fe4b8d5a5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23025cbccada8908fc6cd4d09e851de66898d2d7
Message-Id: <167352576718.4374.1927272577136703195.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Jan 2023 12:16:07 +0000
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

The pull request you sent on Wed, 11 Jan 2023 09:10:52 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23025cbccada8908fc6cd4d09e851de66898d2d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
