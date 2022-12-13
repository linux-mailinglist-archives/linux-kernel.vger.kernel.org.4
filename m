Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683BC64BDE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiLMUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiLMUYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:24:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7416226EF;
        Tue, 13 Dec 2022 12:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FAA9B815CF;
        Tue, 13 Dec 2022 20:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5B0AC433F1;
        Tue, 13 Dec 2022 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670962819;
        bh=XIxVIV4u854tpmsqvmSQs8SsH2ntM3l9ZaoZEX0zemk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kFOApZURHBOXYDb/r4DopxmyzIgOtpAMseoWudU3BH2mkHzoVQtO9jL1+DqMU2cen
         t+SXRlcWbhhm+ZP9XNJ7WDMbGjBt5H3FElzargJdusvbE5Yj4zMUBajlmkYPyHlScz
         IQV4nS98Hd+c1nT+ie88VNmXT8I6dxNM1j4v9Ca313PKoPvyZIBXR/oSTP4TPWDDG7
         985BhpIfa1NIBEoQbnesbbaxMBIVKPDzJ9sdPJMf6Mdf01rHRp8rtiW9NjUhisNuGv
         Sdq0m6pWcpWl4Ci8FXm74WhmT3c9gcQVEMnNggHXEtgwCPXyZxgjBKtjojBlG4VX5/
         PHCwmNexnXReA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD693C00445;
        Tue, 13 Dec 2022 20:20:19 +0000 (UTC)
Subject: Re: [GIT PULL for v6.2-rc1] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212084920.756bfd7b@sal.lan>
References: <20221212084920.756bfd7b@sal.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212084920.756bfd7b@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-1
X-PR-Tracked-Commit-Id: 3178804c64ef7c8c87a53cd5bba0b2942dd64fec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdb9d3537711939e4d8fd0de2889c966f88346eb
Message-Id: <167096281976.13378.4746124475282302008.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 20:20:19 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 08:49:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdb9d3537711939e4d8fd0de2889c966f88346eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
