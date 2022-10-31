Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D3612F73
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 05:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJaEKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 00:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJaEKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 00:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0333FA1BD;
        Sun, 30 Oct 2022 21:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BC6E60F9A;
        Mon, 31 Oct 2022 04:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2F29C433D7;
        Mon, 31 Oct 2022 04:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667189415;
        bh=98IPoPC1iu1/QYau2t3pixc7zFRlHs5420vy0HvPhfA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ej/GeSJAuF2JVtcADveQ5KUHxFdSWSN1F8/knq3EFnVee+aaOVzEMF3wiHV3sr2N5
         69Q9gCz4TNzUKu42lJkzxnqr8voSK/9qwDt47Qb/JZP78xdhsxedY1nlOALPyFB4EK
         GoQR8sb+kuWdpinR0+OXSVPXIBrE0jRzoJzwT+qBLW7BNZgRQp/SHDprWOPnBanVOy
         MaQxJFQsBik1s5uWx9PC5Z07fBuD/4TZreF7Vxipo+uWMDlIM38LTzBdISiU9htMK2
         kBVcM8MLh8wSehgPJnCfpBWc0nSpDToU8FBEnaspDnMd2+oL9mE4ni/xRDw8n35S7Z
         KNpuTUZey2iPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D048EE4D03A;
        Mon, 31 Oct 2022 04:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/2] dt-bindings: cros-ec: Update for fingerprint devices
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166718941584.790.602379860967156019.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Oct 2022 04:10:15 +0000
References: <20221026003641.2688765-1-swboyd@chromium.org>
In-Reply-To: <20221026003641.2688765-1-swboyd@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        groeck@chromium.org, dianders@chromium.org, hesling@chromium.org,
        tomhughes@chromium.org, amstan@chromium.org, tzungbi@kernel.org,
        mka@chromium.org, bleung@chromium.org, lee.jones@linaro.org
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 25 Oct 2022 17:36:39 -0700 you wrote:
> This patch series introduces a DT binding for chromeos fingerprint
> devices. The first patch tightens up the existing cros-ec binding and
> the second patch introduces the fingerprint binding. As there aren't any
> driver patches this can go directly through the chrome platform
> tree or the dt-binding tree or the mfd tree. I sent it to the binding
> maintainers in hopes it can go there directly but it doesn't really
> matter.
> 
> [...]

Here is the summary with links:
  - [v7,1/2] dt-bindings: cros-ec: Reorganize and enforce property availability
    https://git.kernel.org/chrome-platform/c/7a2f36828c7b
  - [v7,2/2] dt-bindings: cros-ec: Add ChromeOS fingerprint binding
    https://git.kernel.org/chrome-platform/c/e068bc0b01cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


