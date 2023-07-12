Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308EB7509F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjGLNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGLNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F25E8;
        Wed, 12 Jul 2023 06:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CA28617C9;
        Wed, 12 Jul 2023 13:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2C1BC433C9;
        Wed, 12 Jul 2023 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689169821;
        bh=0wFk1A/aNUUTpjvhGUBpRWPsahwPmj+gEshvobF0bE8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IMl2jc9KaRv0leEA0CFOdFBQ9YH99BxBnfhVcNFs23Fu66Cp2ebzp2XnMnufb29yX
         3hzEPYEbhZxoox/hFBTmSFYAo5ERYWdB8FNiZkZB9UBKb8nXr2LIUe1FYqfGvN/pW2
         RJ9JhghgaHWcbB6YO03g/kstgbfp3za9Q863r1nEO5PCuHByLKKie7VHbwiHrWgbCU
         KY/8fDMqkw1+o3sjdOJjhJ76bB6tb7xojpdZgEqe9gcWTFfhSY1OHc18VzF8UQV36H
         p6jEBp5BsB3mYtcypgz9mfMgr5VZVAoV+Puqybqe0gadPB4CbEd4kFgls4+sc5n3xA
         ghuXJzuEGPOhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C66C1C04E32;
        Wed, 12 Jul 2023 13:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Documentation: RISC-V: hwprobe: Fix a formatting error
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168916982180.8919.16048088678378231987.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 13:50:21 +0000
References: <20230710193329.2742-1-palmer@rivosinc.com>
In-Reply-To: <20230710193329.2742-1-palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, corbet@lwn.net,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        evan@rivosinc.com, heiko@sntech.de, andy.chiu@sifive.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 10 Jul 2023 12:33:30 -0700 you wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I'm not sure what I was trying to do with the ':'s, but they're just
> rendered to HTML which looks odd.   This makes "fence.i" look like
> "mvendorid" and such, which is seems reasonable to me.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - Documentation: RISC-V: hwprobe: Fix a formatting error
    https://git.kernel.org/riscv/c/d6e724d3ef0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


