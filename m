Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5FD72F0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbjFNALD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFNALC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:11:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB21B8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 17:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8223263410
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E562DC433C0;
        Wed, 14 Jun 2023 00:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686701457;
        bh=UremVR9Yk/i0U8+JW2S1pgvTtrYk8jILrPMGvbdUavg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=croYMOsuotJDB1/0WtCWhzR2ANsPdDG8dZ6JuDYe5zKfWxf0So9qcYdXSyC5FKn6Q
         vHhnPTXv/MBf8BupvK8AimFZHVvRuySqRkno4KP57l/gYSsFMaGC/FJajq7a8+RmUs
         MqKTfAC6WEX3hWT/P24NB0UklwUh9ax2F66CG9kofMl1VrxpqSl+ynbuH6BtiQrQEg
         xBEHCplA5cwgIJQKXYOm3JhZyMRfcnJK337rSG++HJvd43D5X878d/Ntz+qT4VWscq
         UR9QIne/jPIkCnCOK2GahEC/t0pKJ5RKxzk4TNKlVCES7fe/AMu85EK9hDX1PUg/FV
         Sx4z5nO+RZeXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCBC2C00446;
        Wed, 14 Jun 2023 00:10:57 +0000 (UTC)
Subject: Re: [GIT PULL] nios2: fix for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230613223510.20803-1-dinguyen@kernel.org>
References: <20230613223510.20803-1-dinguyen@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230613223510.20803-1-dinguyen@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fix_v6.4
X-PR-Tracked-Commit-Id: 85041e12418fd0c08ff972b7729f7971afb361f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6dad5178ceaf23f369c3711062ce1f2afc33644
Message-Id: <168670145782.22043.2882211666155977402.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Jun 2023 00:10:57 +0000
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     torvalds@linux-foundation.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Jun 2023 17:35:09 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fix_v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6dad5178ceaf23f369c3711062ce1f2afc33644

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
