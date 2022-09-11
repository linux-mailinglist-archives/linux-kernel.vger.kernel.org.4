Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12495B50E4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 21:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIKThO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 15:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIKThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 15:37:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F5324BC8;
        Sun, 11 Sep 2022 12:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 573D8CE0D85;
        Sun, 11 Sep 2022 19:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5299DC433D6;
        Sun, 11 Sep 2022 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662925017;
        bh=qATfq3uV0uYed6GVR5QWKg0Nysd8+WfJ9jBuPPmCXmE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U2UTP4/SOH9aMsDzgqLFTE9EkPBw02aXR8eAax5nbdNLgsJIhdIKtgqcPm3LQt4kR
         U/mzGvV9gjsxwwP4d1Iwhb+XGVB7uwaHodPD3U1SmyAY4MXLnV7uNjOz95fL1xuEc0
         MRiwYosBaKUJDbCdgn1mVYwulgWS0KBFJ8ZuxW/BJP6s8WLPGg8iCiH9piDMfNHIyz
         7Ny6Acwzk2gjudI255GRdi89BrQhLdmX+UcSW7o66mtNI060FPfnQfrq4xRmSm1wR9
         ErTKC1Se3s/qFexHL1QUcPf8ITX3vCHpoHkeHQBfiGAKupij/qRcLNHpLpI+vWknkl
         4PFsPRYQAKprg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40403C04E59;
        Sun, 11 Sep 2022 19:36:57 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220910224858.GA13203@alpha.franken.de>
References: <20220910224858.GA13203@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220910224858.GA13203@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.0_1
X-PR-Tracked-Commit-Id: 727488e305b223ca69205ca5a3b99ace21bbbf5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 134984dbcacd6e2242bd2d85aab605838614b6dd
Message-Id: <166292501725.24843.4575704455340670182.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Sep 2022 19:36:57 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
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

The pull request you sent on Sun, 11 Sep 2022 00:48:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.0_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/134984dbcacd6e2242bd2d85aab605838614b6dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
