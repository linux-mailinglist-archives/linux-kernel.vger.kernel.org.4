Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C67087ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjERSkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjERSkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BEF1B8;
        Thu, 18 May 2023 11:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4545F650B0;
        Thu, 18 May 2023 18:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A007FC433EF;
        Thu, 18 May 2023 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684435220;
        bh=ISAYa7o0m4TPH7FUaEnbm0wuK0RkQR97lb9zQeja6nM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CTSo39fs1O9HtsRI5/sfvzzxXypCAuj5HZzKSLyVny6u4++iZOykOzIg8MkDU+WjM
         s9wIejIuvpOmtdr1vZJSX6bN1dsMV8zaRUkT5J0WvCkpi9aorxK77cMB8oXoy2Uv99
         cuccfV342rd7UKVxl4vEPesG9Hi1W3CyeXsn69bgbEqli92xR8X+E8HGYsqt6iVQVo
         Y6KErQYZOp0xNg9trkwn1lWI8Lp3/W6blTe6yeZnWGVnw+ehxCP1vktqRC5Ai5uY6j
         eIJ7mB/dWuJPGcFu1TpcX1BlX1tTXOt7H0XOM3Mkgr066JuZkhvDJ0fh7+jNKiPonO
         vkl8SIj9Kzjqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71E87E54223;
        Thu, 18 May 2023 18:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btnxpuart: Fix compiler warnings
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168443522046.20106.8326508699327664505.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 18:40:20 +0000
References: <20230518164347.2531983-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20230518164347.2531983-1-neeraj.sanjaykale@nxp.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 May 2023 22:13:47 +0530 you wrote:
> This fixes a compiler warning reported by kernel test robot.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305161345.eClvTYQ9-lkp@intel.com/
> ---
> v3: Use __maybe_unused instead of CONFIG_OF. (Luiz Augusto von Dentz)
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btnxpuart: Fix compiler warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/78c8f6e2d7d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


