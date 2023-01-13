Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF3166A512
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjAMVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjAMVVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:21:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0DE15F22
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC30FB82205
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 21:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 764A3C433A1;
        Fri, 13 Jan 2023 21:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673644856;
        bh=P3p4lAttGXWK5Zjf3Dzui7xxuzBuF9vEYkXO8RNMgzQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TuSIhAJVsf01EDO8WwwH+oZd9j6C4yXJ4KVPCPeCK5FnJCttPPynOdIpEkW7e14h2
         hN4hh1GCOn0F0BrfsbBVtekFmTe4AaJgqc7rLHaTvhyVRvM5iPy4/yXYPYK+DR6H+a
         vRy+QZhGK61KURBKvtQPq/M1e9NoPiUSxh2isDmu0hUL/HPd3nr8eYMkDDkoIoWiaY
         pbsf4lv8pMM79Vx0iRMXzVF//6iTIpkMNMnhB3c7W2upSSmVVNI2XAsR/AZ92gG2R6
         ROihJ3dYwDrKVqbkrqIRwKlc00ibJPCCE9jfktZPJWtnfpLfubVgKP1F7n67vtPapp
         OnMUcixKVcYFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61A6EE270DD;
        Fri, 13 Jan 2023 21:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] platform/chrome: cros_typec_switch: Use fwnode* prop
 check
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167364485639.21086.3086760523982737286.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Jan 2023 21:20:56 +0000
References: <20230104060846.112216-1-pmalani@chromium.org>
In-Reply-To: <20230104060846.112216-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org
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

On Wed,  4 Jan 2023 06:08:44 +0000 you wrote:
> Using device_property_present() multiple times on an ACPI device
> leads to kernel panics on Chromebook systems. This happens when there
> is > 1 boolean property in an ACPI device which is created dynamically
> by the BIOS as part of SSDT[1] on Chromebook systems
> 
> Since fwnode_* can handle simple device tree properties equally
> well, switch to using the fwnode_property_present() function
> version. This will avoid panics and make the usage consistent
> when we introduce a check for the 2nd property in a subsequent patch.
> 
> [...]

Here is the summary with links:
  - [1/2] platform/chrome: cros_typec_switch: Use fwnode* prop check
    https://git.kernel.org/chrome-platform/c/ef9c00dbd383
  - [2/2] platform/chrome: cros_typec_switch: Check for retimer flag
    https://git.kernel.org/chrome-platform/c/441529bed41c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


