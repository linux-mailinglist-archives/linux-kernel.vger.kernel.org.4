Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE474A4AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjGFUKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFUKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3168510EA;
        Thu,  6 Jul 2023 13:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3AB060AFE;
        Thu,  6 Jul 2023 20:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32ECBC433C8;
        Thu,  6 Jul 2023 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688674210;
        bh=D54HmKNlCZJP8gG/tN0i++QCT/lcaEW++j1X+T4nuEE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=asyEkFOoKNQXKHF7qjAWfH4xlkp8BD9xl/+iVOykOga5julQA7YMNMdkXudMWLpRY
         VPh/dBJ44RqyhLBY2N26bKIecL2pM5uYo+1q6YL7Jk8dt8a/jMck4e2RwRTHSAwJWt
         hp0BRILdaV6DTVlf1SeRbgVaZR9A68dDJiimCc1lYgstoQLrnB5MMFTEGDOcNp68fD
         YNXEbh28ng1dngSL186GysbxZA6v7HeizDzLdEjcHBzdLIlRzOtkIsfNLgH5wlV7Cm
         OccE6kDlSJ/+9FkXsLm9mGY9Be0cxveuUqw81hTQ4d+7hKlydqoyajWce+ccGplix1
         We7C/WBCh51NQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19484E53801;
        Thu,  6 Jul 2023 20:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168867421010.27620.7433022824880919772.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 20:10:10 +0000
References: <20230706191035.736632-1-valentin.david@gmail.com>
In-Reply-To: <20230706191035.736632-1-valentin.david@gmail.com>
To:     Valentin David <valentin.david@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu,  6 Jul 2023 21:10:18 +0200 you wrote:
> Asus ROG Ally gaming computer has a MediaTek MT7922 chip that uses USB id
> 0489:e0f5 and needs to be added to the table. Without this, the device is
> not usable and gives the following error:
> 
> Bluetooth: hci0: Opcode 0x c03 failed: -110
> 
> Output from /sys/kernel/debug/usb/devices:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
    https://git.kernel.org/bluetooth/bluetooth-next/c/65f2a9a7d004

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


