Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504536FFBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbjEKVVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbjEKVU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814B2D62
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43E35617D9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A78F7C433A4;
        Thu, 11 May 2023 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683840021;
        bh=+kWr5awvblWfg9fmIl9fQAxXnQ755fWIGoy115uhLvc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JNdXmZrzlobvY3A0SSrtgq9+5kWRIwCVKW5FRAIIEk1X8H6GQB6dgmNIexiHNu+67
         +d3xF0EwwSNYpcbykcxiHQ1IqMvdQj14gTOj14cObYfTHK56DXYokS1NYGsTUPna2s
         fEc/IWHnkpPW11bQxGbcokQLoB8ri4RZILSRkDabuZEr71j6xzwIqWyqmX05hDKUR0
         My25Q9BNyvtQQ3YWv862j9IFZp9XTJeBBlueNS/Vz+CUc+piHU2/xdB6KTyzPotpr9
         kanO97Tum4gc+YiweG2USe8kaE7btxnDjzTiKVoyKfS+LJaQCWB2Up18U33w+NDu1Q
         k2nVCw0KnLREA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95F36E49F61;
        Thu, 11 May 2023 21:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_typec_switch: Add Pin D support
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168384002161.32472.7878216768221766007.git-patchwork-notify@kernel.org>
Date:   Thu, 11 May 2023 21:20:21 +0000
References: <20230508183428.1893357-1-pmalani@chromium.org>
In-Reply-To: <20230508183428.1893357-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, heikki.krogerus@linux.intel.com
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Prashant Malani <pmalani@chromium.org>:

On Mon,  8 May 2023 18:34:27 +0000 you wrote:
> The ChromeOS EC's mux interface allows us to specify whether the port
> should be configured for Pin Assignment D in DisplayPort alternate mode
> (i.e 2 lanes USB + 2 lanes DP). Update the function that determines mux
> state to account for Pin Assignment D and return the appropriate mux
> setting.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_typec_switch: Add Pin D support
    https://git.kernel.org/chrome-platform/c/c9f9c6c875d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


