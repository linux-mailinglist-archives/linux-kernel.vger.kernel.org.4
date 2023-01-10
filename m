Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B0664BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbjAJSxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbjAJSxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:53:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05104C47
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:50:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B35C0B81923
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BFE4C433F1;
        Tue, 10 Jan 2023 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673376620;
        bh=YO9gIfxGjwUCdoC0nmnhiPhytr4tJg826QKNf4k1PNw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FEWHgjSFBlCoBIZeYZA3puFrcEJIr4PSM56ZEc8eyGLw33360GtS/3RLMSz8mIuRK
         n7cxxN7mylQen4fwuIxkJRlGMLB6/+pn/ZT3gn1Y5LzkuJZ+NJealCPv85/KKPjjfu
         iVNmuAVa24+jDLxMNOlZbrpVlrEA9hlEdbhLApg0/WZspirvnjQ5hUNrA4KVbAtAJQ
         lV/o3ysPZMhcwBUGevBfNkjH0xtScIMXH47mRMnH+X1xlOhjK+N4AK/i40xEDd/I4Y
         DwA9I5kqAOZ4WmVOpVphB/DcYe9B+7TRIVYu6EatlbALbk3T9Pq9qNrQGrerLI7mZw
         rl4dTNtMBpD4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EFE0E21EEA;
        Tue, 10 Jan 2023 18:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/10] platform/chrome: cros_ec_typec: VDM support
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167337662025.1026.16587608589588536496.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Jan 2023 18:50:20 +0000
References: <20221228004648.793339-1-pmalani@chromium.org>
In-Reply-To: <20221228004648.793339-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        heikki.krogerus@linux.intel.com, bleung@chromium.org,
        dnojiri@chromium.org, dustin@howett.net, evgreen@chromium.org,
        gregkh@linuxfoundation.org, groeck@chromium.org,
        gustavoars@kernel.org, keescook@chromium.org, lee.jones@linaro.org,
        lee@kernel.org, sebastian.reichel@collabora.com,
        swboyd@chromium.org, tinghan.shen@mediatek.com, tzungbi@kernel.org,
        wangxiang@cdjrlc.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Prashant Malani <pmalani@chromium.org>:

On Wed, 28 Dec 2022 00:45:03 +0000 you wrote:
> This series adds support for sending and receiving USB PD Vendor
> Defined Messages (VDMs) between the Application Processor's Type-C
> ports and connected peripherals.
> 
> Thir enables the Application processor to enter alternate modes and
> process VDMs directly, instead of relying on state machines that exist
> inside of co-processors like the ChromeOS Embedded Controller (EC).
> 
> [...]

Here is the summary with links:
  - [01/10] Revert "mfd: cros_ec: Add SCP Core-1 as a new CrOS EC MCU"
    https://git.kernel.org/chrome-platform/c/0ac7200e3317
  - [02/10] platform_chrome: cros_ec: Add Type-C VDM defines
    https://git.kernel.org/chrome-platform/c/0e0dba884c43
  - [03/10] platform/chrome: cros_ec_typec: Stash port driver info
    https://git.kernel.org/chrome-platform/c/4dc9355cef4f
  - [04/10] platform/chrome: cros_ec_typec: Set port alt mode drvdata
    https://git.kernel.org/chrome-platform/c/c856e3ff98bb
  - [05/10] platform/chrome: cros_ec_typec: Update port DP VDO
    https://git.kernel.org/chrome-platform/c/8d2b28df6c3d
  - [06/10] platform/chrome: cros_ec_typec: Move structs to header
    https://git.kernel.org/chrome-platform/c/690580965153
  - [07/10] platform/chrome: cros_ec_typec: Alter module name with hyphens
    https://git.kernel.org/chrome-platform/c/e5eea6a3319f
  - [08/10] platform/chrome: cros_ec_typec: Add initial VDM support
    https://git.kernel.org/chrome-platform/c/493e699b9934
  - [09/10] platform/chrome: cros_typec_vdm: Add VDM reply support
    https://git.kernel.org/chrome-platform/c/50ed638bbc47
  - [10/10] platform/chrome: cros_typec_vdm: Add VDM send support
    https://git.kernel.org/chrome-platform/c/40a9b13a09ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


