Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BE96DA44B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbjDFVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjDFVAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EB77683;
        Thu,  6 Apr 2023 14:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E5A64CB9;
        Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0160EC433AE;
        Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814821;
        bh=52hhJd10bJPu8kNfWasMUwBBnzQ0A52X8G3iLxkPtxc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RmCUhjswF86wj/SGnJWMjrZIv36AW0QF0yFZAASVlg5rr4FYgljY4StEDYp73wSk0
         B7/T+Ir78sj2OvGrX7fmD8cb4Odl+gcg0t/ATcAw7T4zDJf6WmlKLonL8iJT9sXruD
         Dw2ugAx8tDh/frFxIIBzPOv7f5nA2xEgoE7+RXziSv479zUUH3+WZ1kMVfBjGTCNPX
         zwborLwAXkuV1/kkP4PvwYSU5CoAaQLun4/Vv2wJAV2P2YiNQBGVXWJgJlgVdH6TFc
         VrLYkDtUCRq3HR1fXG4ElwyMK2cGYxr9Y9+x3f+QXG/bpZTIzNiB1JmpjnFntV+PNA
         GjnhS49mvhXHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF644E4F153;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Add support to download helper FW
 file for w8997
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482090.2619.13402073231475629702.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:20 +0000
References: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Apr 2023 17:54:27 +0530 you wrote:
> This adds support to download helper FW file for the legacy NXP chipset
> 88w8997 for the btnxpuart driver. This helper FW file is necessary to
> set the bootloader baudrate to 3000000 after which the actual BT FW file
> can be downloaded. This change helps bring the FW download time from
> around 10 sec to less than 2 sec for 88w8997 chip. For newer chipsets,
> both V1 and V3 bootloader, driver sends the cmd5 and cmd7 to the chip
> bootloader, and does not need a helper FW file.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btnxpuart: Add support to download helper FW file for w8997
    https://git.kernel.org/bluetooth/bluetooth-next/c/e68e21986cfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


