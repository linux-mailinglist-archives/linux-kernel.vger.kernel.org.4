Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7157223B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjFEKkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFEKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79668A6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1316C6227D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63101C4339B;
        Mon,  5 Jun 2023 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961620;
        bh=J9L9ZgxC2Kly/z+obdv2lAt35t36sXkamU/X8cpUyCI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t+5Ho53un0fNOIbSg7XaYfL51mL3yUz/msTZuvobC84aH8eUw//S05cXB+WF4UjDt
         M4rw6Rtil0b5kYXs6jRFjLRJX7zsslKkK0Hfaan4o/e7s+zHczWTtM/7KMz5H9/rpY
         bQCOVHy9kqAc9iXPV9W5mot9Rt5tyYP3TnhAoDCXfp/lvp9XNqozOhaLKol4D2E9n3
         CTsd48WeKP+zbYOHllTf+In//gcztCmykq3TUy4fWPeFe/5qI/VZINPAK8pMcD9eXo
         /UsBOTMYsjKtl3fTZ3TwipKExJldDdA5phMRlF+Evhz/+yVio9gbrcw/QkxNBrAPo7
         M9k0lBLxOD6gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C6A0E8723C;
        Mon,  5 Jun 2023 10:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: dwmac-qcom-ethqos: fix a regression on EMAC
 < 3
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168596162030.847.18206193816609441964.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Jun 2023 10:40:20 +0000
References: <20230602190455.3123018-1-brgl@bgdev.pl>
In-Reply-To: <20230602190455.3123018-1-brgl@bgdev.pl>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     vkoul@kernel.org, bhupesh.sharma@linaro.org,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        ahalaney@redhat.com, jesse.brandeburg@intel.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bartosz.golaszewski@linaro.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Jun 2023 21:04:55 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We must not assign plat_dat->dwmac4_addrs unconditionally as for
> structures which don't set them, this will result in the core driver
> using zeroes everywhere and breaking the driver for older HW. On EMAC < 2
> the address should remain NULL.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: dwmac-qcom-ethqos: fix a regression on EMAC < 3
    https://git.kernel.org/netdev/net/c/9bc009734774

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


