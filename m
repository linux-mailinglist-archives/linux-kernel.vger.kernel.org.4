Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5096E861E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjDTAAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDTAAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6634ED0;
        Wed, 19 Apr 2023 17:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E019642C7;
        Thu, 20 Apr 2023 00:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72740C4339E;
        Thu, 20 Apr 2023 00:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681948819;
        bh=uXqMIJfAnfiy4UDaL0GaTyMhYYQTl1rYstTqmzzjlV4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kidaKng70AQ5zG4vIfkyl8XQ1I/1X7Gn1g/9nS3r4mRngQldlbvsrC4DcyG89KAkj
         DV6YucgM8VS3wyKyLvuujlZ3G250GdfCGrvbzF8S6FRLWk0HeSNsVcbq5RuAOJ9wtv
         Lv2XIhZ4zs73E2fVKaIEPmmLqqTNbUFq47H6D7nr5Ks6+x9nquJTyfV0x3pRxMqYCy
         0yrGslHk8i9qZs6wkHkR3Y/vmVhD8Y2u0I5iTxnD7wbimhljm4mcCwolQum1rs4qJ7
         k9hh5TgCAx0yHWavBTWw+sJTK0apCUub+j81GB1Mp/e+Ws/Prt60iCXVsa6TRhajLD
         UUsJjVlqQQ9+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51B75C395EA;
        Thu, 20 Apr 2023 00:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: Add the support for RTL8851B
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168194881933.25355.385268394450950543.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Apr 2023 00:00:19 +0000
References: <20230418054354.5452-1-max.chou@realtek.com>
In-Reply-To: <20230418054354.5452-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, karenhsu@realtek.com
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

On Tue, 18 Apr 2023 13:43:54 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> Add the support for RTL8851B BT controller on USB interface.
> The necessary firmware will be submitted to linux-firmware project.
> 
> Note that the Bluetooth devices WITH the VID=0x0bda would be set the
> feature quirk in btrtl_setup_realtek(). It's able to ignore the
> feature flag set for the specific VID and PID in blacklist_table[] of
> btusb.c. (check [1])
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: Add the support for RTL8851B
    https://git.kernel.org/bluetooth/bluetooth-next/c/9b4f511443f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


