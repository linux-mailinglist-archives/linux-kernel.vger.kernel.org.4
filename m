Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027BE7379E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFUDuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFUDud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF37F1A1;
        Tue, 20 Jun 2023 20:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 645EB61466;
        Wed, 21 Jun 2023 03:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B514DC433C0;
        Wed, 21 Jun 2023 03:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687319425;
        bh=D35HmKlZtJ5h1JeXspSb0lCLLuaJdO/xC8NRMTwz20s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r82mCGXv0GiHbdJSJF0qAiJiiz1KqxFHmFrncm65vQrSZwFmyyLV5bNQL0J5zs2Sr
         +Is7zkoBtJE18tCoMEnIVSIx8A2kQPrGFbcIOSLDqTCGSBv5ZxR1doJslEKc9TXYGa
         qhEBJ453ewI1hcGemB6a/gEqFk8L3ylZPC5Oz5V95FIkbSgG7yuPTHsUA32nvqin10
         ODyUSf9x/lADdDnqS4CX10IBkAztrdM5L/Ndd5PexQOw7utT33lpL+Tme4jUaJAoAk
         i6BKEqYQt5jwpvox8FWyUc/i/RojYk+DtYNr9bE5W9vBbUqFG+kd1HGGSGYs76IqA+
         JwZpznrNuR2Rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F2C3C4166E;
        Wed, 21 Jun 2023 03:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next v2 00/14] net: stmmac: dwmac-qcom-ethqos: add
 support for EMAC4
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168731942557.12823.16246597315060099180.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 03:50:25 +0000
References: <20230619092402.195578-1-brgl@bgdev.pl>
In-Reply-To: <20230619092402.195578-1-brgl@bgdev.pl>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     vkoul@kernel.org, bhupesh.sharma@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        ahalaney@redhat.com, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        bartosz.golaszewski@linaro.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 11:23:48 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Extend the dwmac-qcom-ethqos driver to support EMAC4. While at it: rework the
> code somewhat. The bindings have been reviewed by DT maintainers.
> 
> This is a sub-series of [1] with only the patches targetting the net subsystem
> as they can go in independently.
> 
> [...]

Here is the summary with links:
  - [RESEND,v2,01/14] net: stmmac: dwmac-qcom-ethqos: shrink clock code with devres
    https://git.kernel.org/netdev/net-next/c/9fc68f23a6d3
  - [RESEND,v2,02/14] net: stmmac: dwmac-qcom-ethqos: rename a label in probe()
    https://git.kernel.org/netdev/net-next/c/9bc580609139
  - [RESEND,v2,03/14] net: stmmac: dwmac-qcom-ethqos: tweak the order of local variables
    https://git.kernel.org/netdev/net-next/c/7b5e64a93825
  - [RESEND,v2,04/14] net: stmmac: dwmac-qcom-ethqos: use a helper variable for &pdev->dev
    https://git.kernel.org/netdev/net-next/c/302555a0ae33
  - [RESEND,v2,05/14] net: stmmac: dwmac-qcom-ethqos: add missing include
    https://git.kernel.org/netdev/net-next/c/ee8dacca2fd3
  - [RESEND,v2,06/14] net: stmmac: dwmac-qcom-ethqos: add a newline between headers
    https://git.kernel.org/netdev/net-next/c/97f73bc59e16
  - [RESEND,v2,07/14] net: stmmac: dwmac-qcom-ethqos: remove stray space
    https://git.kernel.org/netdev/net-next/c/f2b1758554eb
  - [RESEND,v2,08/14] net: stmmac: dwmac-qcom-ethqos: add support for the optional serdes phy
    https://git.kernel.org/netdev/net-next/c/0dec3b48aa4e
  - [RESEND,v2,09/14] net: stmmac: dwmac-qcom-ethqos: add support for the phyaux clock
    https://git.kernel.org/netdev/net-next/c/feeb27165c46
  - [RESEND,v2,10/14] net: stmmac: dwmac-qcom-ethqos: prepare the driver for more PHY modes
    https://git.kernel.org/netdev/net-next/c/25c4a0769443
  - [RESEND,v2,11/14] net: stmmac: dwmac-qcom-ethqos: add support for SGMII
    https://git.kernel.org/netdev/net-next/c/463120c31c58
  - [RESEND,v2,12/14] net: stmmac: add new switch to struct plat_stmmacenet_data
    https://git.kernel.org/netdev/net-next/c/aa571b6275fb
  - [RESEND,v2,13/14] dt-bindings: net: qcom,ethqos: add description for sa8775p
    https://git.kernel.org/netdev/net-next/c/d0e3d29f8771
  - [RESEND,v2,14/14] net: stmmac: dwmac-qcom-ethqos: add support for emac4 on sa8775p platforms
    https://git.kernel.org/netdev/net-next/c/8c4d92e82d50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


