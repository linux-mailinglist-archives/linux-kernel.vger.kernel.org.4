Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26676FE434
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjEJSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEJSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660C8F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB3863FB7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05F1BC433D2;
        Wed, 10 May 2023 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683744621;
        bh=kXzQk7xycngFctnvk0+DiB25T65v/Wg84JRhNZNwaGM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tCnwSXv5ScEZKB7ZtjGc2AtS9fPNtPgTLAbYb1T3zBqmKs1k2zyK/UV7qavJqFKTJ
         2Fiz7oYWFDS4XsNZUaptAQ/Hu1HA250XokTNY0V+ymMrYAx071Wd6cY/x7AJPJt+wx
         B2OporcGi80AsrondtpVLljuBEXZPy8o1Yq7wprldURmmAWaXBtvI9+yyf1jSknFs8
         eFMen1CEqnnn0UwmVNIgSaMI7cTvsgboo8YpaUNZcfcBe4Sliijo5MIGXDYjYIzb7z
         jQleRUaKGLeArm0NBtcIADYPVlsKtiLdOdHoZ3hZeIl7Ec2jftEvr/4WjaomP+Sqtw
         oKlztk8u2eySg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2B04E26D21;
        Wed, 10 May 2023 18:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix orphan section warnings caused by kernel/pi
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168374462092.20912.15148241104611653227.git-patchwork-notify@kernel.org>
Date:   Wed, 10 May 2023 18:50:20 +0000
References: <20230504120759.18730-1-alexghiti@rivosinc.com>
In-Reply-To: <20230504120759.18730-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, bjorn@rivosinc.com,
        linux-kernel@vger.kernel.org, lkp@intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  4 May 2023 14:07:59 +0200 you wrote:
> kernel/pi gives rise to a lot of new sections that end up orphans: the
> first attempt to fix that tried to enumerate them all in the linker
> script, but kernel test robot with a random config keeps finding more of
> them.
> 
> So prefix all those sections with .init.pi instead of only .init in
> order to be able to easily catch them all in the linker script.
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Fix orphan section warnings caused by kernel/pi
    https://git.kernel.org/riscv/c/3b90b09af5be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


