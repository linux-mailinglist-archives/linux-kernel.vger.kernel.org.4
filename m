Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5654C73AEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFWCa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjFWCaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3442C1BC1;
        Thu, 22 Jun 2023 19:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9703260FF1;
        Fri, 23 Jun 2023 02:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6920C433C8;
        Fri, 23 Jun 2023 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687487421;
        bh=3ZbCN/ViU53qsdRk8S7Lh80V0DgIwoSkPZYj9zk4rF8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GkPyq1+YJa/y9ww+1Iwh5AqHAzabdFG5FUPo67CpemxpivuxZOSrjth7PvgUIq9kf
         vqY+fiTBsLv10LGL8J3dvgJW0EnJqBaPaHgnBTYwnXED2fnqERUqnctOWQ75XgLVwS
         Fykz3QwMvTsHlY6fwXOyqVgRyvdhfsnKSV/OoK4W71PNP78s/ZWwE+VFFSEHhufcUG
         Uj9Ye7gazHq592Va3EW43f7Fvm5ImHJcp4D4gY9iocGqrArlKcZKHNx7KPxKysXLD3
         XbZR+amnu3C0oISCFKKrP1+34qu+BzMlgX3Dcrw+SWS/y4PuCNmdeb6JKkcXDJqLj0
         kN2bSOn303VTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0DD3C691EE;
        Fri, 23 Jun 2023 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MAINTAINERS: add Devicetree bindings to Bluetooth
 drivers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168748742078.21061.4290523785212356323.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 02:30:20 +0000
References: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 08:09:49 +0200 you wrote:
> The Devicetree bindings should be picked up by subsystem maintainers,
> but respective pattern for Bluetooth drivers was missing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - Bluetooth: MAINTAINERS: add Devicetree bindings to Bluetooth drivers
    https://git.kernel.org/netdev/net/c/533bbc7ce562

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


