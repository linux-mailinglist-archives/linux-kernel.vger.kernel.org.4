Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA3467A603
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjAXWkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjAXWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:40:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCBC10F7;
        Tue, 24 Jan 2023 14:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FFC9B81614;
        Tue, 24 Jan 2023 22:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CCEBC433EF;
        Tue, 24 Jan 2023 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674600018;
        bh=UZ1bbTP9wKTGHzz4tz3N2CqqtNbE/N6eI+d92JGLXUU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JfSCZo5+sRU0U/bALY3HMljBvquH4FdUnYEM2gl0MaFmQvfRmv+4aKY259UHNywCC
         +WjGlgPuoPW0qJVDVlEXoR4cPYZN5Ac6j8YQWY7W9UvcAeadZgmrXYLAmxRRYK+VkO
         c57+R7uav5X0IG5aa5Qprx4tHZkz8yrHSDrDQrNWKRPvn9pF+qWxe+HHa96t9Cb5bS
         rGQ0zo0SRbMrrN638/jJnOp9Qogoz8QQL2ggo/A2epyQQLEpcvUouQDK3iPxoB8TQq
         hOpyecPcGbVfnCwZ3XE5uOugXxQ0BpwpN210VCnExS1KrXKJY1TPTAQpeC35SUFyMB
         VURuSMlzUwkzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17520C5C7D4;
        Tue, 24 Jan 2023 22:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] riscv,isa fixups
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167460001809.14719.16320756846682473720.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Jan 2023 22:40:18 +0000
References: <20221205174459.60195-1-conor@kernel.org>
In-Reply-To: <20221205174459.60195-1-conor@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        conor.dooley@microchip.com, jrtc27@jrtc27.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, heiko@sntech.de, ajones@ventanamicro.com,
        guoren@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  5 Dec 2022 17:44:58 +0000 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> I noticed ~today~ while looking at the isa manual that I had not
> accounted for another couple of edge cases with my regex. As before, I
> think attempting to validate the canonical order for multiletter stuff
> makes no sense - but we should totally try to avoid false-positives for
> combinations that are known to be valid.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] dt-bindings: riscv: fix underscore requirement for multi-letter extensions
    https://git.kernel.org/riscv/c/ec64efc4966e
  - [v3,2/2] dt-bindings: riscv: fix single letter canonical order
    https://git.kernel.org/riscv/c/a943385aa801

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


