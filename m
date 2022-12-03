Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1FA64199A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 23:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLCW4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 17:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLCW4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 17:56:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428861DF22;
        Sat,  3 Dec 2022 14:56:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D062260C63;
        Sat,  3 Dec 2022 22:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4093FC433D7;
        Sat,  3 Dec 2022 22:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670108192;
        bh=/EHaDLLjToS5E7UnFmD/Dr7X9Jc8W/rDMx8ISBfC2U8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QMg7XiIIYIhxbpPx2n401wIW5lE/s2GUWH4WCLhtlo3XQQpz3l/+wSHPHl8Lgv2fY
         ipB46Ukf9DBDZWE9Z/Y7U4G6I3JeLT87QpmtaesWz3FdVoskoue/9NpqlF0dAAkpbb
         X4xOmTIk7f8n6CvAxWV9QsvvmHob9NwjBriJanDdXlECeQLCdMnPxQzdY9hJ+ZFUVK
         UcApBqjzXiww0OraVmUZ2tzAzNVuLAdEen9U/9j7upI2Tn4ja+xKyHeu/Ys5XtPSC+
         MDCw6kI7y/Kt/syfVv4XH19yBryImVWqo1rBmaxSXHMCZ80ZLxgzN4fWOS8now/V7w
         C800qZBwwKIqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C993C395F5;
        Sat,  3 Dec 2022 22:56:32 +0000 (UTC)
Subject: Re: [GIT PULL] DAX and HMAT fixes for v6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <638ab8e291345_c95729417@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <638ab8e291345_c95729417@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <638ab8e291345_c95729417@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-6.1-rc8
X-PR-Tracked-Commit-Id: 472faf72b33d80aa8e7a99c9410c1a23d3bf0cd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6085bc95797caa55a68bc0f7dd73e8c33e91037f
Message-Id: <167010819216.27892.14565489712803195440.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Dec 2022 22:56:32 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Dec 2022 18:48:02 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-6.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6085bc95797caa55a68bc0f7dd73e8c33e91037f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
