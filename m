Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8669E738
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBUSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjBUSOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:14:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63906301B1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:14:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A303611E2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B48D3C433EF;
        Tue, 21 Feb 2023 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677003094;
        bh=QhOVH8uSNWfWSu3pMqzB3pkviViAAdovJ/r2+vvtq4g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NeKwqUoRI+JCsUi4A7y1OqnHr4x3R/pebwTHGFAomqPXreNMEH6NfQz+w9AqCgL7y
         s1bp4oTU6HEbhg0yrdpKdk9cXf/eS95IGucqP7/64kstx/gSgkQx5kte0nNsIR9rlt
         VVVue1KaGpjAuYxZd66WpG8n0q611xjQ8KqHBaqMAZTX5d15RoTNWXnR0JESZKO4SR
         vL9YRjjcZ+fcKI5M3xrxSCC9KQSJvNUq5+6fHlPbAzip9AO4+wXQQEGkysZkRBAxii
         jQIxInpGdIxTyWAB9gLSC8DjRiV4cXx/8n11/RnOh/Phy0oOp9Fj4MCS25CE5q3/Dp
         03KSB6llTWOzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CAC8C43158;
        Tue, 21 Feb 2023 18:11:34 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167689254797.295764.1600565060995031919.tglx@xen13>
References: <167689254797.295764.1600565060995031919.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167689254797.295764.1600565060995031919.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-02-20
X-PR-Tracked-Commit-Id: 6f3ee0e22b4c62f44b8fa3c8de6e369a4d112a75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e58df973d2272e6e558965e7cb32453a4b380ff
Message-Id: <167700309462.29984.13789496352578046632.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 18:11:34 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 12:32:52 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e58df973d2272e6e558965e7cb32453a4b380ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
