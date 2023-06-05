Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43858722FF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjFETkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjFETkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF50EF1;
        Mon,  5 Jun 2023 12:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C4D0629C9;
        Mon,  5 Jun 2023 19:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8D86C4339C;
        Mon,  5 Jun 2023 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685994021;
        bh=oRAt9LRIZf64qXrXghsMGNIfmTnUIFazbDZcsKg6jl8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OuZibhFb4jwS/M69tdtGt8iJcOKoT75sSbAZIjvXcEQ/SgZAhhvk9dTL+y6TE4I2H
         O7hWXMgT8yWgxWQpXvhVM3MLV08B3pr7BQP9CBxNhTRvlYNhezSJdj0S/zuVvHyE0W
         cPwukgr90NQsO02oPDFVGdd94yk3pO3lNtk5RCfdjcQ1bZJbMv5NB8K8Evo/uVT12S
         9Cg0NtRB3vwerMGyZsTFIHgfhKrZTv046PZkGEFH/bRJlafU1Hqj7+tdaLqnW74Iix
         j4cbYPV9eeOIqN5nJTOk1IvkdymDCReSN6a1OkU+Ws2hAGhweBu5oNJqHg0HccZDNA
         Ctao1w+gRli7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B2D6E4F0A8;
        Mon,  5 Jun 2023 19:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: Correct the length of the HCI command for
 drop fw
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168599402156.27522.5375572234427339145.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Jun 2023 19:40:21 +0000
References: <20230530083420.6876-1-max.chou@realtek.com>
In-Reply-To: <20230530083420.6876-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 May 2023 16:34:20 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> The original code did not determine the length value of the HCI command
> for drop fw even there's no parameter needed. In this commit, use struct
> hci_command_hdr to manage opcode and length. It would be more regular and
> more readable.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: Correct the length of the HCI command for drop fw
    https://git.kernel.org/bluetooth/bluetooth-next/c/a332208e733b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


