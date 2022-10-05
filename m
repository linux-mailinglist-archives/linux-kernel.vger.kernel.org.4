Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B7E5F4DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJECom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJECoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:44:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B272EE5;
        Tue,  4 Oct 2022 19:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7160615AC;
        Wed,  5 Oct 2022 02:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BCADC433D6;
        Wed,  5 Oct 2022 02:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664937696;
        bh=B8MA8KZzLLMEJ3aZSG1Q2+0t2TDcfu0ayue3g2VXe1I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fvAnonpISxqa5HxtF+U2cuJ1+pFDb+fJvAgvCxTZAAz6xRAUwm4VL6jEHAJtHh4lK
         lqIZKlSEdAjjZz1MOJXJvyxzZFsKouol0Qxz1prLNPpuHVhi6EcvJ/5BerjpwVXjlg
         Hu7WJo5huuT14zLQ5+ylOjIoAItL+QuXp/g6m65X0SGpUSxT7/bn9FGWXrRFMfhDjK
         TgM53vhzUAwt0WVD0tFH2H+3RgG56w9M+TyD529I/YvHCeTgaiOfHE/IQbybeCbh6e
         ceLxOWyPfJFeml7RGOV8XIjKqwoFANhsAeDmQA6Xna0R31Oszi7lrKpmVEkstQwDPN
         eVz2PwILa1yfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35973E21ED6;
        Wed,  5 Oct 2022 02:41:36 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003124713.15A30C433D6@smtp.kernel.org>
References: <20221003124713.15A30C433D6@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003124713.15A30C433D6@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.1
X-PR-Tracked-Commit-Id: 8e9204cddcc3fea9affcfa411715ba4f66e97587
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bca25eaeba6190efbfcb38ed169bd7ee43b5aaf
Message-Id: <166493769621.5416.922181860104126906.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Oct 2022 02:41:36 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 03 Oct 2022 13:47:03 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bca25eaeba6190efbfcb38ed169bd7ee43b5aaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
