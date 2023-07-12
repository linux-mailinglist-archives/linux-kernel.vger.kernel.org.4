Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD357502EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGLJVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjGLJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41B51726;
        Wed, 12 Jul 2023 02:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17CCB616F6;
        Wed, 12 Jul 2023 09:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B844C433C7;
        Wed, 12 Jul 2023 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689153621;
        bh=Ex71MzvqnoPSUmJRcXm5WZyi4T6gvlCMkVAhvg0LzGE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P2zHdNl2EydNK3q5sGc+nCH2LtNPsa7JIIjoTAxTlKKh7qQ07gNuX6wUisB9DoVQl
         ENjdh05laikc2HkDUjtU7cMbtKj7eEQ9uqVDmfk5khfmej5ymKVwe/u0C9BaK4yAHb
         oUD6ujNzjFukKAZgg9IcurQYyyPx78FEKUsaDX/q90pS3f9EpBA5TnZ7RfdrvZrGYh
         M9bZqdA3aBKhP1bLtCyGjciDzFohNdIJO7ZPKYpeHQ1kaSvI3tyBJWwfPUhkcnsTk1
         hI89322GvO7MdbIPsy4Gi2916nDEb2ydr8eVbynXyDDuoLMz91KWazPkk620WNtl/G
         +4jUjPfrA1mEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47AD5E29F44;
        Wed, 12 Jul 2023 09:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: stmmac: dwmac-qcom-ethqos: Improve error
 handling
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168915362128.1981.13684727730813685010.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 09:20:21 +0000
References: <20230710201636.200412-1-ahalaney@redhat.com>
In-Reply-To: <20230710201636.200412-1-ahalaney@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, andrew@lunn.ch,
        simon.horman@corigine.com
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 10 Jul 2023 15:06:36 -0500 you wrote:
> This series includes some very minor quality of life patches in the
> error handling.
> 
> I recently ran into a few issues where these patches would have made my
> life easier (messing with the devicetree, dependent driver of this
> failing, and incorrect kernel configs resulting in this driver not
> probing).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: stmmac: dwmac-qcom-ethqos: Use of_get_phy_mode() over device_get_phy_mode()
    https://git.kernel.org/netdev/net-next/c/a8aa20a64ef2
  - [net-next,v2,2/3] net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/b2f3d915b4fe
  - [net-next,v2,3/3] net: stmmac: dwmac-qcom-ethqos: Log more errors in probe
    https://git.kernel.org/netdev/net-next/c/27381e72a2db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


