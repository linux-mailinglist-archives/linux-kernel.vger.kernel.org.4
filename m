Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519C3655F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 04:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiLZDcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 22:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiLZDcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 22:32:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA572630;
        Sun, 25 Dec 2022 19:32:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6390E60C7E;
        Mon, 26 Dec 2022 03:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADA36C43392;
        Mon, 26 Dec 2022 03:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672025549;
        bh=B8ik+QluhAQJI0owp6S/f/Ih/rBPIYryPaW/oltkjaU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eIyBgrnDo/03k3OsJhsmX7Bx1X43wI2U1ok27MvRE9EkztYmFqVIqaT9+rAegomqE
         cjPZ1CDZ6sB5Kc4pvJZHN5Gm/l26HbLFdqtSrYcrIjAbj2sz2HsLRmsrQM2Qggczxe
         Fo9hvfUZ175TgN4/0wJbXpOZSM2O1O9nyPJPbztktAdG5XBRPD0K8tWaY3cndWygA2
         Czm07JkXHz5hxhQ1PGE2tLexgsBhpKPfVA2/TE1EjivRuOhVdQcJp2maUQuIJ+5hQR
         N/5g0Wf50Wu6RpVMwEsZdxNF8Q+tKlwkQGIfbobkmr1E+Lv0u2SJwBSWHMkQlJSkV6
         z3LtS55JnG2qQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E551C395E0;
        Mon, 26 Dec 2022 03:32:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] platform/chrome: cros_ec_typec: Link PD object to
 partner
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167202554958.9518.17955521300304408883.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Dec 2022 03:32:29 +0000
References: <20221122220538.2991775-1-pmalani@chromium.org>
In-Reply-To: <20221122220538.2991775-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        gregkh@linuxfoundation.org, groeck@chromium.org,
        heikki.krogerus@linux.intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Tue, 22 Nov 2022 22:05:35 +0000 you wrote:
> This is a short series to link a registered USB PD object to its associated
> partner device. This is helpful for userspace services (the ChromeOS Type-C
> daemon, for example), to identify which Type-C peripheral a PD object belongs to,
> when a uevent for the PD object arrives.
> 
> The first patch adds a wrapper to the Type-C class code to register a PD object
> with a Type-C partner as its parent. The second patch uses that wrapper to
> register the Type-C partner USB PD object in the port driver code.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] usb: typec: Add partner PD object wrapper
    https://git.kernel.org/chrome-platform/c/032399819dd5
  - [v2,2/2] platform/chrome: cros_ec_typec: Set parent of partner PD object
    https://git.kernel.org/chrome-platform/c/ab3593eeef60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


