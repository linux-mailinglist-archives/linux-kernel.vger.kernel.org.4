Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4674CC6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjGJFxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGJFxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DE6F9;
        Sun,  9 Jul 2023 22:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A2E60DF2;
        Mon, 10 Jul 2023 05:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BD98C433C7;
        Mon, 10 Jul 2023 05:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688968399;
        bh=8Rtzr2bgCsFLaSEyFR5Arhv8ANrKH57SdGC6I+92IvI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ovQhpQl9nT6kh9ewUFsyFQzJj5YANTT3AgZIRdpAOwBy0/IS1wMM+IszJtknylT3H
         n+Tc923a2XlbiljT06GCK7+8K72L9EeeUuN/9kaCqAo5fhfPMdVb2sz5hr4ui1cpyL
         eyECfz0odx9e6SlNHukexXZ1Nlw3U8Vfoa0rjuni8LOqrGHJWq5hNNhY60FRbHl+qI
         WClyzVt0C9uDms60XeAnVJdkc/se2dzkOcF619E8htek9v1Tzl7Q1RYwstx3GPRY1o
         X1/hYC/XKABk4PMDWqY9WFFVGJWrUfrqy7ORROhhIl+mib9Z3HL4bzmvfyJ9tl9y7l
         CSOGl2+lwzUTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09D21C395F8;
        Mon, 10 Jul 2023 05:53:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] usb: typec: mux: Remove the "svid" device property
 checks
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168896839903.3413.16844292204313046489.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Jul 2023 05:53:19 +0000
References: <20230526131434.46920-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20230526131434.46920-1-heikki.krogerus@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, andersson@kernel.org,
        chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Fri, 26 May 2023 16:14:32 +0300 you wrote:
> Hi,
> 
> The comment in the first patch is now fixed as requested by Bjorn. No
> other changes compared to v1.
> 
> Original message:
> 
> [...]

Here is the summary with links:
  - [v2,1/2] usb: typec: mux: Clean up mux_fwnode_match()
    https://git.kernel.org/chrome-platform/c/4aebc4f89f00
  - [v2,2/2] usb: typec: mux: Remove alt mode parameters from the API
    https://git.kernel.org/chrome-platform/c/3524fe31538c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


