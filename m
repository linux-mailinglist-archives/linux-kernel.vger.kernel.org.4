Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB065F667
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjAEWHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbjAEWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:07:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E146967BEA;
        Thu,  5 Jan 2023 14:07:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77BF261AC7;
        Thu,  5 Jan 2023 22:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD918C433D2;
        Thu,  5 Jan 2023 22:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672956428;
        bh=ZXS7KgtijCFSb9FBcsfviWMZju+pO2Fbjrc6YA8zszU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L2nIY1lETThhMehd7JXXUWj+eqYHhPtxdiu9423+XKIVOUfA/9D4kYd8+Z5IO3iyS
         x10wdBz5bpw2l0P8KaMX1DzDDz2wjoI8EADu06y2s3JrRgDHJJD3Pr1Wu8MsINwnBD
         CtKUIZtR2ONLjsNcIyMuAuQW6hLrlfimUhM7E+UMAzxRa2VoX37H/OLr1Jgfy4/PW3
         Tdq0/I9z8GB02Nx5Dm+DQJN+QmFgOmKv/u9dOGU//Sb9XChrIAQMdymmtIxCyHTKJj
         ArnY5RuN1tOOwog7A4CQOEW7hysbzngKxizA8CnCAgoKh2H2DbsG/Kif8xOh7XAbkl
         6FcGcML8+Xp0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE833E57254;
        Thu,  5 Jan 2023 22:07:08 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iXQzV-rbAAAOSALTCiT1nX6e-F3BarTSG7kZ32z9HL2g@mail.gmail.com>
References: <CAJZ5v0iXQzV-rbAAAOSALTCiT1nX6e-F3BarTSG7kZ32z9HL2g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iXQzV-rbAAAOSALTCiT1nX6e-F3BarTSG7kZ32z9HL2g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc3
X-PR-Tracked-Commit-Id: b878d3ba9bb41cddb73ba4b56e5552f0a638daca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f5abbd77e2c1787e74b7c2caffac97def78ba52
Message-Id: <167295642877.2778.4861180164262117652.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Jan 2023 22:07:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Jan 2023 22:09:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f5abbd77e2c1787e74b7c2caffac97def78ba52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
