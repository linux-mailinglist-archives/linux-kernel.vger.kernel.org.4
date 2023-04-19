Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EAE6E7CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjDSOar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjDSOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F3B459
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A220611F1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ABF9C4339C;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914622;
        bh=VZxl14Tb5yyIRkuvHwe5N/hFs9h+A+yfCS95wDv+H8s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jKtMDx3Q+Ndv0cufNmrwuNg5bl/xbSZ162fA/6acYaeIGz+DOdouXraycBQTxYS+R
         B4c4ZzuZOts1ZVrJquS5bXQ5HcEBAqrd+tlDXf+76bJxEn81G2Ey4MQianIbqbcBWf
         Tt3nedVJsfAyWrcBbOzY8vu7af9UtCBQRzIhpOqGbY5OYnn5ea1TfcFyRMF0gw1ipR
         8unBTqhhkwQ6+gjrG8pT7w6z/mqFEZjlJUpDTKrxWcKrhOCog70koGQd3FvK2f2UGK
         C12Bt2SDB1AQTrluvDBFCEaRgIl3nq0qiA4W+eigZ9U1DROIHl3yQzLsYvMEqJhuuH
         hYSDfG8vzWi2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EB90E3309C;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 1/6] RISC-V: Move struct riscv_cpuinfo to new header
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168191462224.22791.2281450562691381145.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Apr 2023 14:30:22 +0000
References: <20230407231103.2622178-2-evan@rivosinc.com>
In-Reply-To: <20230407231103.2622178-2-evan@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        apatel@ventanamicro.com, aou@eecs.berkeley.edu, heiko@sntech.de,
        atishp@rivosinc.com, vineetg@rivosinc.com,
        linux-kernel@vger.kernel.org, conor@kernel.org,
        conor.dooley@microchip.com, palmer@dabbelt.com,
        slewis@rivosinc.com, paul.walmsley@sifive.com,
        heiko.stuebner@vrull.eu, ajones@ventanamicro.com
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

On Fri,  7 Apr 2023 16:10:58 -0700 you wrote:
> In preparation for tracking and exposing microarchitectural details to
> userspace (like whether or not unaligned accesses are fast), move the
> riscv_cpuinfo struct out to its own new cpufeatures.h header. It will
> need to be used by more than just cpu.c.
> 
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
> 
> [...]

Here is the summary with links:
  - [v6,1/6] RISC-V: Move struct riscv_cpuinfo to new header
    https://git.kernel.org/riscv/c/ff77cf5b2e03
  - [v6,2/6] RISC-V: Add a syscall for HW probing
    https://git.kernel.org/riscv/c/ea3de9ce8aa2
  - [v6,3/6] RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
    https://git.kernel.org/riscv/c/00e76e2c6a2b
  - [v6,4/6] RISC-V: hwprobe: Support probing of misaligned access performance
    https://git.kernel.org/riscv/c/62a31d6e38bd
  - [v6,5/6] selftests: Test the new RISC-V hwprobe interface
    https://git.kernel.org/riscv/c/287dcc2b0c83
  - [v6,6/6] RISC-V: Add hwprobe vDSO function and data
    https://git.kernel.org/riscv/c/aa5af0aa90ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


