Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5572A049
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjFIQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjFIQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7A32D71
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED0B659EA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 836C2C433D2;
        Fri,  9 Jun 2023 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686328803;
        bh=G2Q33B8KxwtFPHl814M2Os4E+1M8uuR7LRuh6lu/CEQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UpINuVdkslrxaBtQQO0CupFoKLM4vnbbo7mwlT9bpnEoywJTIim0CKo0yvgl2Z7Ot
         mgNwgz+TTd2IYyJP8/hvgwqQa5mjb7u63TD/W9RFL+tTA98u5x5Gw1tW0O6dEijzgH
         s3QjdpxAv/0d7va9pzpOIJuS0irMpKiSEi2LQc7Ih2pcazmAEPFyVNhra2FZx+CcCV
         ji5yoJNSDukMap8yikDaJLBzdLOKp3tnJc3s46jv4d0R1hGxes7IimWLWudiFkhM2T
         siQDdec7qfpDqLUaFOITvfVlEzz8pxwFjgwdkX3sgZAsXGRhrY+EZxqCGuTw2fNKRb
         lyOnHvy0+UOcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CB4EC395EC;
        Fri,  9 Jun 2023 16:40:03 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-bf5e8144-98a0-441d-b6df-63978648c75a@palmer-ri-x1c9>
References: <mhng-bf5e8144-98a0-441d-b6df-63978648c75a@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-bf5e8144-98a0-441d-b6df-63978648c75a@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc6
X-PR-Tracked-Commit-Id: 99a670b2069c725a7b50318aa681d9cae8f89325
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f506c7f7d3d8d68a1a020c3d914390b3ffc30d0
Message-Id: <168632880343.22626.17527323735551974086.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 16:40:03 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Jun 2023 07:45:06 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f506c7f7d3d8d68a1a020c3d914390b3ffc30d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
