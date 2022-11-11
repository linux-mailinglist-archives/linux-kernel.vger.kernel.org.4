Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F762626A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiKKTym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiKKTyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:54:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247E517E0D;
        Fri, 11 Nov 2022 11:54:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCF0DB827C6;
        Fri, 11 Nov 2022 19:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7261CC433C1;
        Fri, 11 Nov 2022 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668196477;
        bh=CmyQjJlzsjqy1YESlRnsyq/fzcLqEy4pSQagZhHIAvs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=stJwnGcCxWIlBkbsrYtxe5ua5DByfP96osCEW4ZSvD5bjHJBfmNPyJejoO+n1Sr0z
         rc+yJDAzoFWrxjIyx1mAy7CGVUc2rOnaVUWU6oaxIkpvoUpjyQl8ds6WnQwkhJsmHN
         b6PbEc/DrvXk+jOsOBsabCbNrhjo32uHmT70QBmCVhN9f5bKGSAyIEsW5gU757Y7LH
         jClRDnBM0wf/LqpQ9myhz/WHEXsZRi69Kw15jQYwsDnmjH/17zavYYVzhWVYFm7EHW
         3kuR++hPKKgfYWaiQJ1Q0eypqvBWnsYI5EhiDRQSkMKRas4jtQYlM1dDLdPeIMpH38
         QGXlmRUEPYd2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61408C395FE;
        Fri, 11 Nov 2022 19:54:37 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y26mTTsPtdaNJ4lP@tuxmaker.boeblingen.de.ibm.com>
References: <Y26mTTsPtdaNJ4lP@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y26mTTsPtdaNJ4lP@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-4
X-PR-Tracked-Commit-Id: 30d17fac6aaedb40d111bb159f4b35525637ea78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5020a08b2b371162a4a16ef97694cac3980397e
Message-Id: <166819647738.12241.16792432631946028997.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 19:54:37 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 20:45:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5020a08b2b371162a4a16ef97694cac3980397e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
