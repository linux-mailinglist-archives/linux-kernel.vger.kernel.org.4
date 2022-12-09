Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CF5647B72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLIBaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLIBaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99086801E4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39CC0B82666
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD258C433F0;
        Fri,  9 Dec 2022 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670549418;
        bh=K0icfcWXctigWWVx3ADmDqvIRURr0H+ejPlG7fwXulw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ruR/saYEQ8/sPSnWWkoEOfCTVZRKvI7UT3oxl7qE/KCFfL675z/I9DZLWPElyaqSo
         UcjcNVkmpu7+Sh5cZ4KTQRKqrj10o4EWzpo9F9NfMet8ctPlqrOoPOtrCZ95UO59Ak
         Am91RkFkb4JjYRVWUoFLGzHwkM03iCcNKmUUxMHQWf6QlBiV0A1G0ZFu8WtaRNvz4p
         etOwD62wCCSd+LAa0dxZQ/SvlsV8v53ZZN088Je+c+OX5KgsboOY0qg0NhRdIfyy2Y
         P3ZQDww4T9xifw5rP4F79u3PsCUjj0Z3SCDguSi+OzqdQWmgkKi30rjNuCh7JSZkBF
         Sa7d0uw2psQqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3468E1B4D8;
        Fri,  9 Dec 2022 01:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: boot: add zstd support
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167054941879.3046.3791891123009116103.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 01:30:18 +0000
References: <20221123150257.3108-1-jszhang@kernel.org>
In-Reply-To: <20221123150257.3108-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, terrelln@fb.com,
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 23 Nov 2022 23:02:57 +0800 you wrote:
> Support build the zstd compressed Image.zst. Similar as other
> compressed formats, the Image.zst is not self-decompressing and
> the bootloader still needs to handle decompression before
> launching the kernel image.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> [...]

Here is the summary with links:
  - riscv: boot: add zstd support
    https://git.kernel.org/riscv/c/de59b6ed0618

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


