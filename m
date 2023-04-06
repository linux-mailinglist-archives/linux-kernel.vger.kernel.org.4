Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287846DA43E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjDFVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDFVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF9B768B;
        Thu,  6 Apr 2023 14:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 464C464BE1;
        Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEA5BC433EF;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814820;
        bh=3AsPzO1Lcn3gkRBA53VbVGPripY9CGNKCaBwTdvHPzI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H9hO3RPMRjFY3ubYzhxJCnGMdr/DbSE3/ABl8aFdr3WYdzVTVmhqZndnNIBvT7QqN
         dztv+cqtkGlYCC3IBJvFID/DgDalLieI6k23JsRmw6DybA1avjnbid0SomGee7PeIO
         gZo55x8bNV3wgnUbhg/1jQlJXkttJmVeCbQ/3nH+j75n6As+uy+yii6MJEFtQKlzVP
         rxgOX1o+3s4nmKJcIv9vFAjnwVdC5wsokPL7mbSAEhxWXv276QhMOCAFJDJlq6LJCB
         5tvvaX8N4IbUpmmZkuWm8lX9J0GcBuO+fWf/4yH1M9YsxQqWmj7dSP9hTEobGTmTO1
         Fv5/W5CRMOF1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E117E4F155;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Disable Power Save feature on
 startup
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482057.2619.5043442116700132701.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:20 +0000
References: <20230403122430.1024235-3-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20230403122430.1024235-3-neeraj.sanjaykale@nxp.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Apr 2023 17:54:29 +0530 you wrote:
> This sets the default power save mode setting to disabled.
> With this setting, this driver will behave like a normal h4 driver.
> If user needs to use the power save feature, it can be enabled
> using the following vendor command:
> hcitool cmd 3f 23 02 00 00 (HCI_NXP_AUTO_SLEEP_MODE)
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btnxpuart: Disable Power Save feature on startup
    https://git.kernel.org/bluetooth/bluetooth-next/c/3f8dae828fb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


