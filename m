Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB4737436
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjFTSag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjFTSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8410C2;
        Tue, 20 Jun 2023 11:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC82361419;
        Tue, 20 Jun 2023 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB414C433CC;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687285824;
        bh=7OwOGLQFcN6UAD5gG3llvfw0/Qbty3YbeiYZ3Qgx99Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uqs5Z6TRJh+sV2GOMBzQj6s3Id+SKLSofiE43fqIsr2Sv1vTFkgHrTzGCzmnuAd04
         82Jr6B7Mun/N0NR/mC2PVLGMyPa/3qqK7gMuxshTBOPnWRza7p5MmLGTGU6khtiNGB
         dlrV6BrBh4jDn2VfEqNB4adY6kZBLZPQ2DsBnLr24mOQ6AukfFv4Y8AAe0FVuKXStu
         4863BzDZxJVJ1VPN663Ri3ctTQAkUE2z+kN8U9ov1Pa5bcTac0LyVlIwScxp4STPnE
         relP+XH6zGiL0g5m/0LZ3jDqxfRE94s698xnMfcnv08tvHTXD0nRt+IjutVhnmQNnP
         PFK+vrjikbiVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9558CE21EDF;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v3 1/2] Bluetooth: hci_qca: Add qcom devcoredump sysfs
 support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168728582460.12887.9103849630232746258.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 18:30:24 +0000
References: <1686718695-31734-1-git-send-email-quic_saluvala@quicinc.com>
In-Reply-To: <1686718695-31734-1-git-send-email-quic_saluvala@quicinc.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        jiangzp@google.com, mmandlik@google.com
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

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 14 Jun 2023 10:28:15 +0530 you wrote:
> This patch implements the hci_qca driver side .coredump() callback to
> trigger a devcoredump via sysfs.
> 
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> 
> v2 -> V3:
> 
> [...]

Here is the summary with links:
  - [RESEND,v3,1/2] Bluetooth: hci_qca: Add qcom devcoredump sysfs support
    https://git.kernel.org/bluetooth/bluetooth-next/c/79e5531b19fa
  - [RESEND,v3,2/2] Bluetooth: hci_qca: Add qcom devcoredump support
    https://git.kernel.org/bluetooth/bluetooth-next/c/97604e9492ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


