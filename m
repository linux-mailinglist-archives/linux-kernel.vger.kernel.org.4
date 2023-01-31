Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C67683797
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjAaUe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAaUeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:34:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38CA564B5;
        Tue, 31 Jan 2023 12:34:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ECA9B81EBB;
        Tue, 31 Jan 2023 20:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F19C4339C;
        Tue, 31 Jan 2023 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675197261;
        bh=2dcHZUt4gA+sNzsb9Ul5/JGddOzsRpJfH6O3eBnU+ZI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yp6RgDtTI496lwXglf67Yykf9GFobC5GZXP5lMNxQ9Awhl2XROmRb08WhQX8657sR
         yoi2B5REeY80wSokOmjK2qDm+R1zbfIVoPGnyJCSv14Q5nd1FXthICJ7xC+zm89sdh
         ZKmd0tPCTb0Gg+axm773VWWCS54fEtMPAZM5/QZ4l5nSwV4DyKEjAdkgu81fU/n8xu
         R/36TQuUJWD+1nZs/mv1MqMVEvgBnjiQjVVVc+Eno06y4YLR2Qo5wV/y3uVxTyeVbZ
         OD3jSxc5nsICTp0G2OHiGW/d8ASC4s80faIRteN9Pn6BdLM9YLHBTl84ugscCZgb8d
         2LturZsC2uRzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6B5EC072E7;
        Tue, 31 Jan 2023 20:34:21 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b7da90228a0f844928c9331eab0be64072d237f5.camel@HansenPartnership.com>
References: <b7da90228a0f844928c9331eab0be64072d237f5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <b7da90228a0f844928c9331eab0be64072d237f5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 15600159bcc6abbeae6b33a849bef90dca28b78f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58706f7fb045b7019bada81fa17f372189315fe5
Message-Id: <167519726167.29102.10602723959680078727.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Jan 2023 20:34:21 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Jan 2023 14:21:25 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58706f7fb045b7019bada81fa17f372189315fe5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
