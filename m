Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F66FC2A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjEIJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjEIJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B12100E2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1B436450F
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C4F0C433D2;
        Tue,  9 May 2023 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683624021;
        bh=q+zzx59V7sYAAa3SJdpVpIhmQSecuIksyTjzjeayP/g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dtElA7KwfNXbOzBp/WwEIikVzmOYzcrKyRH5wsBC9mdNXFha5JtaDRooPLM1PqKTq
         WmEsIqJMPp5sm6AfgVMFV/pKlV0MIgw1F10kAoGQFPLYbYrrviqgtuDHV+Pstd9joJ
         HywxnkPHmcv64XeOfdvZiys3/E6HUdyREsWAEsHEqTgc9FQGWck9Cj+PrmwgZwXq8P
         z9/gtmSpJftt9PD4xP5FPBZQd7uJ1wfQrcFUQDnkrkLe6qtPrwWhcwzpwIclBazUlq
         WHZQhVJGIyUw0WSa6b5RRUjqpOmqYDuprblE2noeS3/Gb+LPOKFyU1J/FINQ32Q2lX
         QAs9GUrTQTBow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F33BBE26D23;
        Tue,  9 May 2023 09:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] linux/dim: Do nothing if no time delta between samples
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168362402099.5178.2587927505400570071.git-patchwork-notify@kernel.org>
Date:   Tue, 09 May 2023 09:20:20 +0000
References: <20230507135743.138993-1-tariqt@nvidia.com>
In-Reply-To: <20230507135743.138993-1-tariqt@nvidia.com>
To:     Tariq Toukan <tariqt@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, john.fastabend@gmail.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
        gal@nvidia.com, talgi@nvidia.com, leonro@nvidia.com,
        royno@nvidia.com, ayal@nvidia.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 7 May 2023 16:57:43 +0300 you wrote:
> From: Roy Novich <royno@nvidia.com>
> 
> Add return value for dim_calc_stats. This is an indication for the
> caller if curr_stats was assigned by the function. Avoid using
> curr_stats uninitialized over {rdma/net}_dim, when no time delta between
> samples. Coverity reported this potential use of an uninitialized
> variable.
> 
> [...]

Here is the summary with links:
  - [net] linux/dim: Do nothing if no time delta between samples
    https://git.kernel.org/netdev/net/c/162bd18eb55a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


