Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFEF74920F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjGEXu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjGEXuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA13D1732;
        Wed,  5 Jul 2023 16:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DF8E6181A;
        Wed,  5 Jul 2023 23:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC4A4C433C9;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688601022;
        bh=BgODPXLPTsaU0wj68dFe2wWU/mnAmoYudmtTIg9uug4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aq+2KA2q3s3qQaEOMbkSETl+1X+mfs637M/CazsUgB4O2lm21KaVSxkSNcAwixCc0
         SgTYm68ui15/f0GFRRZ++yRyK17iqs/kqqD5nA8yrFC1a70mI5Ygp+GD5az4U/ujdB
         sD4uRZffzhEmiHhAs1dK5nZiLkXRW8/sjPpUXcM6iqk9AzpP1fHH6wip8FMHFhgjRg
         yUo71RvQ0qEbMIqqrbWyMCnGjxv3mKTFek7KrCyi67lX95wy3H+WPsLbKXkIm9iKQr
         mLWia703Eh0HuzmJQXjHEe2hp8A7k+dPBDvHFsp4mPfpgvlirV2iFg/w5IKxaY/5JG
         wXxvj9iQvk2iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B68EC6445A;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] dt-bindings: riscv: deprecate riscv,isa
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168860102263.23922.9146715518598128204.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:50:22 +0000
References: <20230702-eats-scorebook-c951f170d29f@spud>
In-Reply-To: <20230702-eats-scorebook-c951f170d29f@spud>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        conor.dooley@microchip.com, paul.walmsley@sifive.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alistair.francis@wdc.com, ajones@ventanamicro.com,
        apatel@ventanamicro.com, atishp@atishpatra.org, jrtc27@jrtc27.com,
        rick@andestech.com, ycliang@andestech.com,
        oleksii.kurochko@gmail.com, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@rivosinc.com, robh@kernel.org
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun,  2 Jul 2023 00:10:01 +0100 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> intro
> =====
> 
> When the RISC-V dt-bindings were accepted upstream in Linux, the base
> ISA etc had yet to be ratified. By the ratification of the base ISA,
> incompatible changes had snuck into the specifications - for example the
> Zicsr and Zifencei extensions were spun out of the base ISA.
> 
> [...]

Here is the summary with links:
  - [v5] dt-bindings: riscv: deprecate riscv,isa
    https://git.kernel.org/riscv/c/aeb71e42caae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


