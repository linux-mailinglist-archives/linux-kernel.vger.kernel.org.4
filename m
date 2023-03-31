Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163D06D145C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCaAue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCaAuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:50:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EA311EB9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 306F1B82B0C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5D58C4339B;
        Fri, 31 Mar 2023 00:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680223817;
        bh=5R/8vqj7X/4FXlzrWJR/6Vkxkbq4c9el6EjT8HnT6/I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WMZWFHNBGy7Pq8jwg/1U6n36kRBEeNw3F61mPelbSHNxQf41e16ToJ3GWrL0H/ClE
         vTM13U8hNuRIZdBXYin1eGZ6mU0VBy+9R1bCKg0R+y7oEKv8sKV2r5Xj/MJSRJ5HJO
         NQSU1fip5CTBkkL2B8+bKAuClRnNvD48HsGQ8n9Yv1YZdO922zqYAVRG+fFfs3+vEA
         Dxle5vhzF/fpI5j2L+aAErHKE+zgLK+ryHByHWXRRnl01jBI98k6a9dW2OpZfd4zp1
         /TswbOwFCpUd+FyjjFk+zfnHoOlgEWSknxEbo8iKHeH6t4HveWSl3oqjgMyKXNeSDV
         CvR4sC4JN6OQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6761E49FA7;
        Fri, 31 Mar 2023 00:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] RISC-V: convert new selectors of RISCV_ALTERNATIVE to
 dependencies
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168022381767.20027.13723928750136260683.git-patchwork-notify@kernel.org>
Date:   Fri, 31 Mar 2023 00:50:17 +0000
References: <20230324121240.3594777-1-conor.dooley@microchip.com>
In-Reply-To: <20230324121240.3594777-1-conor.dooley@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        conor@kernel.org, ajones@ventanamicro.com, Jason@zx2c4.com,
        apatel@ventanamicro.com, heiko.stuebner@vrull.eu,
        jszhang@kernel.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 24 Mar 2023 12:12:41 +0000 you wrote:
> for-next contains two additional extensions that select
> RISCV_ALTERNATIVE. RISCV_ALTERNATIVE no longer needs to be selected by
> individual config options as it is now selected for !XIP_KERNEL builds
> by the top level RISCV option.
> These extensions rely on the alternative framework, so convert the
> "select"s to "depends on"s instead.
> 
> [...]

Here is the summary with links:
  - [v1] RISC-V: convert new selectors of RISCV_ALTERNATIVE to dependencies
    https://git.kernel.org/riscv/c/d34a6b715a23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


