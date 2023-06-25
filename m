Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDAE73D548
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjFYXUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFYXU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BAFE4C;
        Sun, 25 Jun 2023 16:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7826F60C55;
        Sun, 25 Jun 2023 23:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D49F7C433CC;
        Sun, 25 Jun 2023 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687735223;
        bh=gagWmDDmJDWh5KRnFaIWUefc8TSh7VfmTp4h0BJ3A3U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BsqL/Cr2+wxAhY2pBMHaTW9gn1+N0Zxr7bERHmmV53dwdavZiipk26DK4BfGZfIXr
         cDarj/r0hkn8qzbxsxzv6N5jp7rZwAaVcL/cd/OYkBAydLmVP79EpU+qXwiiKY2yFE
         Lp16tS7WheKIeE0lqOg47Rf2FWQKQOuVWIwTqH2xxE+sNFxfV4UlJ0qjRFJf0e6U3I
         GBZk9a5O0KoWG3PA6I0fnRLdC2uMAeTtwz2ZrDRH5R3YtKrD6wmCyYESL+Z+CaKtPZ
         rqeko1UBt4EAb7F4epr7nakTJCZ0Nn9BMhVR40EUFqDXs+5BNdPJb6C9Y8YsQyh15y
         fVDdifylmyKyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3DE1C691EE;
        Sun, 25 Jun 2023 23:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] dt-bindings: riscv: cpus: switch to
 unevaluatedProperties: false
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168773522373.24181.11034691970216052141.git-patchwork-notify@kernel.org>
Date:   Sun, 25 Jun 2023 23:20:23 +0000
References: <20230615-creamer-emu-ade0fa0bdb68@spud>
In-Reply-To: <20230615-creamer-emu-ade0fa0bdb68@spud>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
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

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 15 Jun 2023 23:50:13 +0100 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Do the various bits needed to drop the additionalProperties: true that
> we currently have in riscv/cpu.yaml, to permit actually enforcing what
> people put in cpus nodes.
> 
> Changes in v2:
> - drop patches 2 -> 5, they're now standard in dt-schema
> 
> [...]

Here is the summary with links:
  - [v2,1/2] dt-bindings: riscv: cpus: add a ref the common cpu schema
    https://git.kernel.org/riscv/c/3c1b4758a954
  - [v2,2/2] dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
    https://git.kernel.org/riscv/c/1ffe6ddc5c64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


