Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CC7403B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjF0TCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjF0TBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:01:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AD8116;
        Tue, 27 Jun 2023 12:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31CBF611FB;
        Tue, 27 Jun 2023 19:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8609DC433CA;
        Tue, 27 Jun 2023 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687892513;
        bh=pd5ltRiIOaj/yKrVyXhVz/cvhptO3VIDm67Rl/G6O3w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hu99a1SWwpcgIUDdVf7+kAjL0QITH77k2W2SSELAO6KDmkUvtU0rnRrwkXISvXaS2
         1+S9tUbZidslBPc7VO9enIKPIwC4VAuBpvuyZSHlU+JO9gOZsmK5Z5zXnYsBEH8pOA
         v08UdZMQi+L4/AhGcZKh0yDQ5v45TeLr7Bu/j2IDHqhrBoUZ3GlU8h9e9HpnhFjZAS
         /VPpaYooNuc5jyqCarUFfsJMOwYMX3IzXx/gJAbAj6jQ1Sufhfa0k+ebb0n6pjnd6u
         A6mp0Eww6G/vVF08cndZhzK1zYTfPIsALhJWOiHP8b4QW+LnvK6MO3Me0XFsZP5+lF
         hiKckaMgNmavQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 598EEC64457;
        Tue, 27 Jun 2023 19:01:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MAINTAINERS: add Devicetree bindings to Bluetooth
 drivers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168789251335.11348.15831606026121795757.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 19:01:53 +0000
References: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

This patch was applied to bluetooth/bluetooth-next.git (master)
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
    https://git.kernel.org/bluetooth/bluetooth-next/c/533bbc7ce562

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


