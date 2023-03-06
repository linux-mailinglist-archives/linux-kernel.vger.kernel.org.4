Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0520E6AB4BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCFCxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFCxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:53:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0367EC9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:53:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81D9160B54
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBAB0C4339B;
        Mon,  6 Mar 2023 02:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678071224;
        bh=UEhFA8dJmKIlxizlhNq5uXSU+WjBJR3dAHgwGwdyMIg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HHtURbOvDzz9IjS8ABX7OfQ88J3cuv7uXKHOtOsad/hIiKwpm2/MpuRZ2SQmCo6k9
         P8P7ZqHlEqyevIIfeO9Y+ZAPsDR1yoFbU9kyfEunh3z9S4x4ajqGf1RnOnL7P2qCPr
         mo7OLKLI7ssk9qecXfZ9LUwLnoTNj/Slhhy2X+VJ+E2tEeoTao0auKDCnamDXIM3mm
         Usb2r6E3gCs0bw/cPWuZ5Kx+9ZqmS60dFBgW8Suk1FPpZiu1/tNQ7Br1wQ8SlTp3yF
         6rBPiHe6LqhUK4MLYxA9R8f90/c7YO7rgDQ/2ijTsR+6+EmW7K48Iu2ElJJyzQghQT
         Ex2jSOIB9vFEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2A45E55B14;
        Mon,  6 Mar 2023 02:53:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] firmware: coreboot: Remove GOOGLE_COREBOOT_TABLE_ACPI/OF
 Kconfig entries
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167807122479.10312.14973528180299232858.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Mar 2023 02:53:44 +0000
References: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
In-Reply-To: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     bleung@chromium.org, gregkh@linuxfoundation.org,
        jwerner@chromium.org, davidgow@google.com, jrosenth@chromium.org,
        chrome-platform@lists.linux.dev, swboyd@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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


