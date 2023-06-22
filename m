Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1173937B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFVACV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjFVACS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6266B1BE6;
        Wed, 21 Jun 2023 17:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09D556171B;
        Thu, 22 Jun 2023 00:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 568A3C433CA;
        Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687392021;
        bh=C5BkJXS6Vgw04VtsKDnyCQbmDTblMR1v9dWpWQr/0uY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cIHRsngolwud2asdbOkq6gslIDQe9iPWOypw3fAtQLCqFWdqdNo68S+7OWGJnOKoR
         x0LyBxRkRNWjtot7fHzqXH+isRfhNVo4Dks19oWl42QpoKyv73sQSorNDwxRBFCwCi
         AL1s132ehdOKABA4SRVCeSpjQWyyagcBnmVFxTPkXME4EFcENg4hrCyrceUAMHTI4V
         UoMmOP5sk9Xlu8KyU4fq/freTy483x4B/gnPtDrg/7a1YgwShRvqHXkmzGb76fkKeT
         FqLTnIy/A+024/3dBVUpvtEF8jIdjCOrGjuLxJs9OpbeMeL7bC5BJmpMH8SCgLd8tU
         SpuQAbJn0rNvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34BA8C395F1;
        Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: bluetooth: qualcomm: document
 VDD_CH1
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168739202121.22621.9813816851269923496.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 00:00:21 +0000
References: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bgodavar@codeaurora.org, rjliao@codeaurora.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Jun 2023 18:57:16 +0200 you wrote:
> WCN3990 comes with two chains - CH0 and CH1 - where each takes VDD
> regulator.  It seems VDD_CH1 is optional (Linux driver does not care
> about it), so document it to fix dtbs_check warnings like:
> 
>   sdm850-lenovo-yoga-c630.dtb: bluetooth: 'vddch1-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: bluetooth: qualcomm: document VDD_CH1
    https://git.kernel.org/netdev/net-next/c/6a0a6dd8df9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


