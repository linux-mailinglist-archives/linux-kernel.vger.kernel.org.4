Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C78C5FE541
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJMWaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJMWaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F2520BE;
        Thu, 13 Oct 2022 15:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCEF1B82161;
        Thu, 13 Oct 2022 22:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F7F0C433B5;
        Thu, 13 Oct 2022 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665700215;
        bh=I3emhh6Pc3wWCJri4Yae0xw1/9tvk28Z7Kj0e4A9W60=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AMjO8nMKqSvQEGK0rIhleFfxZN1OnCxHb9/Fz79bF7CAcnkmDqZ30aVhmXQOyeVSt
         IzynlnSmhxk3NCUTKgFtdYMQja3vv0BZrb4nkC18CreyIMXNIuR+S8xg1nnDgRGgAW
         ubNXh8t2HTeMdXVI+/DtnaDF7jboB8zmGPENFBSqS+PHWaBLFR40w3UEN5J+y90y+D
         bwwl1++8UiH9n1sKOYVpBrg+5eMJgxHGBvl2iV81G/y+5Zk/YbLgCDAvSb5fLvu15H
         DQ8ShemUNh0trOa8aI0SM8vOoHFqUNtHOFh5gS9t2m6p2SmbHCremPbq6YprdoE2uf
         rWiI8XaiWRQzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76754E29F30;
        Thu, 13 Oct 2022 22:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/1] Bluetooth: hci_qca: only assign wakeup with serial
 port support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166570021547.5001.4551865478943304906.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Oct 2022 22:30:15 +0000
References: <20221013214508.2195347-1-jiangzp@google.com>
In-Reply-To: <20221013214508.2195347-1-jiangzp@google.com>
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Oct 2022 14:45:07 -0700 you wrote:
> This patch will check if the serial port supports wakeup before assigning
> the hdev->wakeup callback. After landing the 'commit c1a74160eaf1a
> ("Bluetooth: hci_qca: Add device_may_wakeup support")', the wake-on-bt
> was broken in Jacuzzi because the qca_wakeup returns false. In this case
> it will fall back to the default hci_uart_wakeup.
> 
> Changes in v1:
> - Check serial port support before assigning wakeup callback
> 
> [...]

Here is the summary with links:
  - [v1,1/1] Bluetooth: hci_qca: only assign wakeup with serial port support
    https://git.kernel.org/bluetooth/bluetooth-next/c/9fe208c7117d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


