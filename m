Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95473EE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjFZWL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjFZWL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76BB46A6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73A136106C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D89FEC43395;
        Mon, 26 Jun 2023 22:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687817181;
        bh=SvanVYs8nGubiMrW4i4BGufQ28s8VBgbrz/o1pvZMa8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=efTC0qojNHBYNHMiv4EpI0p3mBhPbfXSVG/0B3oLHHSmcgOD3CvdQECCp4S6tb6LL
         UlTWJSnR2e+WsJd3xHsRroK+i2/Ph0gRMXnpHMn16PWV051bXmqGScwwGjmfDOvPDA
         9aRirRIOqXyRaQ/VTTrDFbXaqAc5ly9rpzoz+FJLqHFcOn/AdmYpcYfdeX/hgMVxHD
         cu3hCiT2fHo5vyUBkovoA1Yrx1/yip728AYVDysApr6giMs3bkdDcDoUwJky3/00kI
         +iGcmhZuUvUoCYdfpApl5YS1e4RXZF0wUOlLEKsK8KERmMs5kcx8Hpr/rnfz/ZuGQF
         wbWgifrIS7rlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C02B8E537FF;
        Mon, 26 Jun 2023 22:06:21 +0000 (UTC)
Subject: Re: [GIT pull] x86/boot for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168778151512.3634408.11432553576702911909.tglx@vps.praguecc.cz>
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz> <168778151512.3634408.11432553576702911909.tglx@vps.praguecc.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168778151512.3634408.11432553576702911909.tglx@vps.praguecc.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2023-06-26
X-PR-Tracked-Commit-Id: 0a9567ac5e6a40cdd9c8cd15b19a62a15250f450
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cffdbe3607a6cc2dc02d135e13732ec36bc4e28
Message-Id: <168781718178.14634.15956812711759923955.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:06:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:13:52 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2023-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cffdbe3607a6cc2dc02d135e13732ec36bc4e28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
