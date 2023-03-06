Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7D46AB4B4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCFCnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFCni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:43:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21CD51F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:43:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4697B60B4A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 962C2C4339B;
        Mon,  6 Mar 2023 02:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678070616;
        bh=Y2qaLUUhqYXtAV06LtKJTSd1NYlNOd5OCdF12v5jGV0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tNPIvsB9McRAcbxYbJgH6imi6lSidkMo2SOiWM9BO9kD/12CgW2vvchpgB+E57qln
         te+McLnKMz5U9dHza0aQw0dVu5UhiOIOXSylEvdtKgdMCK6dwLh5Cfj9cQ+T5KM+xm
         FAi4DxvtcFblfi4HqvV/YLk1JZxcUwuvbUZ+TmPORLs95rw5MMam4RP6dcNbZOxGgt
         deGp098+BiyscjxpncRJNgczsuSv4OATg5vRUCMLmHWZxP6pOkrQ5WORXWfEMHvAcx
         0OQe42sr7qSPwS6dBUlM58XuhP/W32rluhskLxDPovBEwmT3NKXublMxkVNbzUTNEU
         WvCnI4d33x15Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BFADE55B23;
        Mon,  6 Mar 2023 02:43:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] firmware: coreboot: Remove GOOGLE_COREBOOT_TABLE_ACPI/OF
 Kconfig entries
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167807061650.10312.8220995754030944031.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Mar 2023 02:43:36 +0000
References: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
In-Reply-To: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     bleung@chromium.org, gregkh@linuxfoundation.org,
        jwerner@chromium.org, davidgow@google.com, jrosenth@chromium.org,
        chrome-platform@lists.linux.dev, swboyd@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Tue,  7 Feb 2023 08:12:00 -0800 you wrote:
> Ever since commit a28aad66da8b ("firmware: coreboot: Collapse platform
> drivers into bus core") the Kconfig entries GOOGLE_COREBOOT_TABLE_OF
> and GOOGLE_COREBOOT_TABLE_ACPI have been dead. They have no "help"
> text and thus aren't user choosable. They also aren't "select"ed by
> anything. They also control the compilation of no code.
> 
> Let's remove them.
> 
> [...]

Here is the summary with links:
  - firmware: coreboot: Remove GOOGLE_COREBOOT_TABLE_ACPI/OF Kconfig entries
    https://git.kernel.org/chrome-platform/c/e42af72223fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


