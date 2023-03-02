Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B06D6A8894
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCBShG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCBShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:37:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D331E1C31F;
        Thu,  2 Mar 2023 10:37:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84A40B8149C;
        Thu,  2 Mar 2023 18:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 223C3C433D2;
        Thu,  2 Mar 2023 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677782221;
        bh=RHPypLt6pwbDd4NAAg5+OwZexI7vmK5flbSe7OubaxM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YNaDh4c2kjpowsfsVYaQEPDvIdrfcgHKXl0RSY82QybSLxauC38Uv5vySCo7QHeQI
         MKxRvqZirIh/B7xOIefpZ1QgPn0PjnQQu05VOt7V3rhW/Wui0gBJTwxBA6BTS7GiEs
         q8iu2n702/bAPlyRyFF1F9HbIFbG5yqpz0X3Y/htqWmS5kJuA/eXLRVUAb04XSOzsJ
         s+5wsYRewj3fgYLpLPJVNIDxfPK29Xme8tkqsmS2Mjt33WOYiM17PmEFOMii4F4IfS
         XBCUYHjGW/peN0076zYBdfbFrDqCSUsdLnTA6QDdDzhjW9k2ZqHC1RnSpvbRYWztF6
         CZeTohvBVI/rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D5F6C43161;
        Thu,  2 Mar 2023 18:37:01 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes part 2 for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230302152123.GA11226@alpha.franken.de>
References: <20230302152123.GA11226@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230302152123.GA11226@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.3_1
X-PR-Tracked-Commit-Id: 1a2c73f4834dd79e4f2c590ac75358fb44137650
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04a357b1f6f0b6f7c8689361fa8802e8e35d02ad
Message-Id: <167778222104.7691.15858882695777512279.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 18:37:01 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Mar 2023 16:21:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.3_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04a357b1f6f0b6f7c8689361fa8802e8e35d02ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
