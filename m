Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D576FB327
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjEHOmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjEHOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6707DAF;
        Mon,  8 May 2023 07:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D185640A6;
        Mon,  8 May 2023 14:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8673BC43321;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683556916;
        bh=MQ5DoJA1f5DU0Jx7eqFBYGiVwF/uh9yVBMTNrxYMYIE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tZJut4FMcHrALPqDh2zYAwVmSSL7WEktSeQju/lInVcIKyJV3YQxdELZDXzE/4FcV
         a+xdEVih12ZS09iwE4Cm7uDi5XAkYq2iaNyHIVbmZXEboLjmZ8cfdXhzq7+UaIdf8A
         DNjVewcBH3R4CnX5tKmHoahlkyC4jKqL9T2bRbUtUwHvowwtM2nCZTnTdPw9k/8O4i
         ENIVVieYaTy45YyTku7vFGBJ2EDIStmGZRYki8YIU44aoVgcZQ1VuyQ15DT0HCDLzZ
         QNXcq/0bYs0XsBzoDkPjcOkopq37LnQAwMfOEBznR8/TLD3KGAT0LxllTbmXO2tSbm
         Hvrxnly9AVAaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A92FE4F0A1;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cpuidle: Use of_property_present() for testing DT property
 presence
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168355691642.25692.10503148227988680423.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 14:41:56 +0000
References: <20230310144703.1541888-1-robh@kernel.org>
In-Reply-To: <20230310144703.1541888-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-riscv@lists.infradead.org, ulf.hansson@linaro.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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
by Rafael J. Wysocki <rafael.j.wysocki@intel.com>:

On Fri, 10 Mar 2023 08:47:03 -0600 you wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> [...]

Here is the summary with links:
  - cpuidle: Use of_property_present() for testing DT property presence
    https://git.kernel.org/riscv/c/f914bfdd7f84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


