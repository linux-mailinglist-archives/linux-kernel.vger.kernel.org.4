Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE426A888D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCBSd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjCBSd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:33:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B418149;
        Thu,  2 Mar 2023 10:33:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE0F161625;
        Thu,  2 Mar 2023 18:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F309C433D2;
        Thu,  2 Mar 2023 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677782035;
        bh=S4F8jWxfhwGLY0KZiRInylz7SE5J/khDvEDJcV4wFI8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wh4q9aIE4deZvwhxcCbnAewXBjm+9Uf5KhSDK4FwbwIllNQTr7tuSgr872l9cCcoz
         NPLBHZT0eZpP3t4sKacWUWSKjrSzOpFYzn5leSO2vFLPtCBpcw2SJ/BQxLGC561cif
         ZYlnJd69/xc1BIuzC7hkYm6hiWObHnlW7Yl03+/PjM7NkoKAffFC3IgisGnpCm/PQL
         wgNTbRknqVpiPq77H/kIrMtj9VRl9/xC08hWbyTeD6MLAlD+MxKay3G3wp8ozittFW
         Wz244ovNy+KVg7SdLUT8CdJ2ZyLxfRgtMaIdfJc5EIiR4FjJx5lOpa7JDbXGtgf07+
         sr70CX/dut4Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04F01C43161;
        Thu,  2 Mar 2023 18:33:55 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230301203511.BDD9FC433D2@smtp.kernel.org>
References: <20230301203511.BDD9FC433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230301203511.BDD9FC433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.3
X-PR-Tracked-Commit-Id: 2449d436681d40bc63ec2c766fd51b632270d8a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 093b2dc4024a9dca9cba539625c32c8056b51fe4
Message-Id: <167778203501.4243.16493663666506597056.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 18:33:55 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 01 Mar 2023 20:34:59 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/093b2dc4024a9dca9cba539625c32c8056b51fe4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
