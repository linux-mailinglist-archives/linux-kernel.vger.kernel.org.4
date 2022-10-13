Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C9C5FE2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJMT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJMT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29958169CF6;
        Thu, 13 Oct 2022 12:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3AD96192A;
        Thu, 13 Oct 2022 19:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24DD6C433D6;
        Thu, 13 Oct 2022 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665689179;
        bh=lwGzG0oEcBObcEcj2FxpGauILqpL4l6Rv8mzKpv7xnA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dkQmi9r308dySXnuAN5UPJC3oaoZ5UGL686MVoUMTOWova1PBtytR+GLYrHC9Cz2V
         l1u0BvWY4gNv1veDaW8Uf1a2qYrMXQSHCZW5VxiS1EbPa2IjIJ0ehU4HKdPHMnxU9O
         oLGYjMt1Uv31vLJ/bPwM/Fkcujyo33NbJqY5ZsJ2D7at6bxSnkPxalKTNq7eqrS9SA
         8iFc0TDg87xdo3a2sk2Mdh3MUqIfhKWN7LK2J2aEAi34l/Q5oYQLxK1Y7onXaVe4tt
         HEYV805pBPLc3FPpy5N604aclPKs0OJ+LOa7IOkumh8VkbinA00JRehxTsa7lC6Pbn
         ZFWnMGiChi4Wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14494E29F31;
        Thu, 13 Oct 2022 19:26:19 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221013141334.511005-1-ulf.hansson@linaro.org>
References: <20221013141334.511005-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221013141334.511005-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-2
X-PR-Tracked-Commit-Id: 6e141772e6465f937458b35ddcfd0a981b6f5280
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 098179413d07392ad8c52c7c7605d3d3886ef569
Message-Id: <166568917907.4575.361847867125208088.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Oct 2022 19:26:19 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Oct 2022 16:13:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/098179413d07392ad8c52c7c7605d3d3886ef569

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
