Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0B6F25CD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjD2SUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjD2SU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E082122
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 11:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6089E60C00
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 18:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C65D2C4339C;
        Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792420;
        bh=/HNq7GtJEFL/5yrBdd3HW2YwUCcsn8+FQOJWLEPh2O4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f/oRHPPl2tkUC+RpGzyNvbvDNXPGUy3lCvbapykIId8RrV37hZFvdhk8fZ2usAJ1U
         K9L3uT5mrqNTeMlg7iS5Fp4QhvWjdah6PXq3kf4ErCJI6OpjXF+QVWk9Wv0PSjjIoc
         2PbnpXqPCScC4Z1N2lPi2cCa8p3UZcbwzDo1ACKEfMUflMlvb8bHTN538UsLQ4YLe9
         UfE2czvpBihuGkArrUlsyJPLTXLBTcAcJg6iPHX8RQTqGgSDqmOUIYtVg+QmsAFw5I
         nUU01HdY6oHTWjA7NFSys8MlTpAqGzwrDhzBmz8AlIekqpRR86X/HzRjMaI2Rmkp0l
         ocz1vegypK2UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD5D7C43158;
        Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEtjUWcp6qm4l+zl@infradead.org>
References: <ZEtjUWcp6qm4l+zl@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEtjUWcp6qm4l+zl@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.4-2023-04-28
X-PR-Tracked-Commit-Id: ec274aff21b6a94c7973384ca80a503c1bc3b173
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b28e6315a0b42b39351d1953c1c4b54f80855857
Message-Id: <168279242070.22076.12388422174123596835.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:20:20 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 08:10:25 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.4-2023-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b28e6315a0b42b39351d1953c1c4b54f80855857

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
