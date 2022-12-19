Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707A365135E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiLSTgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiLSTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:36:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35367B34
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:36:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E637CB80EF7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 19:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEAA3C433D2;
        Mon, 19 Dec 2022 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671478574;
        bh=Ca/uscCkiFzOQ77KyfVqfIPrusZEf557kvGSDEn7/5s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S/ohq+j5f0LS8fxnFN9N0q6tjgNWO8Wb9U0A/xJvfaDOpsC37WEYXiXHhwK/NB9tN
         hJRMGERrryBhrdFHk6xd8skx+Y7X9B/XnuhKieDAL6tEij0MbJjEFqZTDg2NPlznyX
         2AczTWNaf1buKmH679HODTyGHSgDC7N/naC6vJiZ8gZPkZ1Z4vIIljBM1KV+w8RR5T
         Hh/JsS1kjKyxy4UmjMVln28pSs0UMvVpupKQza/wDLfLH2o5i+hTxnwABT8cmn6cF/
         feV62VJFpQywku6FdySSHv8MSWjO6yIoG2gHASNkrdhzLmOJUwFFPE8lshFsykj47P
         2xGSQjUxuG/5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E0BBE21EEE;
        Mon, 19 Dec 2022 19:36:14 +0000 (UTC)
Subject: Re: [GIT PULL] zstd changes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9956A306-DFFD-4D23-869A-8B6EC0B88EE6@fb.com>
References: <9956A306-DFFD-4D23-869A-8B6EC0B88EE6@fb.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9956A306-DFFD-4D23-869A-8B6EC0B88EE6@fb.com>
X-PR-Tracked-Remote: https://github.com/terrelln/linux.git tags/zstd-linus-v6.2
X-PR-Tracked-Commit-Id: 70d822cfb782ebed5c41bdad9fa520b5ec1c6923
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 158738ea75059fb4ddf812e2cb9fe1ff6e22bc70
Message-Id: <167147857464.10172.7478974368220617726.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 19:36:14 +0000
To:     Nick Terrell <terrelln@meta.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Sam Hardeman <natrox@outlook.com>,
        Kernel Team <kernel-team@meta.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Dec 2022 01:24:40 +0000:

> https://github.com/terrelln/linux.git tags/zstd-linus-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/158738ea75059fb4ddf812e2cb9fe1ff6e22bc70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
