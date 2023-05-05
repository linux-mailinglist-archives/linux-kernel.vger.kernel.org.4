Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4B6F8A35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEEUdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjEEUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:33:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250A46AF;
        Fri,  5 May 2023 13:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2E2C62D1B;
        Fri,  5 May 2023 20:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34AFCC433D2;
        Fri,  5 May 2023 20:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683318783;
        bh=UYPqOtsH4YRt4ooKhI8l0nEnKZZP+N6RvPMGk2G78R4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kEVEr9S7eMYQv2G4F4Lb2DPsIZamo2mgO8proyDMGUJF01xe3Y1dWhMe6JLFNDkp1
         Ibisecf9Wyi5ichX9FU6+vkiniXSWaz6ztzv5B8ZiayWtm40b96Nkl2TZW1qwzhAHd
         E2U0MOkyumWa7wbossMOG97u7Nr9+I8tTFog9L6F67ufCr5baPCoT+OFE8mS2wKNjb
         K2sVLqpA1lEG7AZ1u6qw7rMY2dsc+GLbpNlx5Erw/wY3wdDOd31yuzEe9GmU5Ulr68
         +gQKP3dh3PAP0JsxlJJjihTH/o+CHg6BIPuS7LNkX52P3B903Gn9+NSIG7Jo3IKjpG
         kl4MS0uY5KxEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2213AE5FFCE;
        Fri,  5 May 2023 20:33:03 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.4, part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230505192951.GA3409270-robh@kernel.org>
References: <20230505192951.GA3409270-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230505192951.GA3409270-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.4-1
X-PR-Tracked-Commit-Id: 6997f847cbb72082a2e9aa0fef8ebfcc3bd4ddc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 418d5c98319f67b9ae651babea031b5394425c18
Message-Id: <168331878313.21250.9686503388427213980.pr-tracker-bot@kernel.org>
Date:   Fri, 05 May 2023 20:33:03 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 May 2023 14:29:51 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/418d5c98319f67b9ae651babea031b5394425c18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
