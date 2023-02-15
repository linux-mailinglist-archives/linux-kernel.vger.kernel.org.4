Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF70697F00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBOPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBOPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:00:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4617695;
        Wed, 15 Feb 2023 07:00:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DBD761A53;
        Wed, 15 Feb 2023 15:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A3A8C4339C;
        Wed, 15 Feb 2023 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676473220;
        bh=vIvNdQMQXrgoAxwdaaKi3PizO4j+e1b0mdibYmVrxZA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=otkUonvqZM/arFi6I9XK/hejDvguVhaRVTPQk6hQXVk95hsmyMv57M8a71vmhUSRR
         RzaYMdISYjh6mikHtbRljEk6Bn9uQOofu5OgXvYC8dbrarQDSqM6URTLoYlFSa+tD1
         +E2QPq4IYX6H3ozZkCwZZGEoWZSrkIlteXYXZJAey8KsIRr1v6L7PEX9grKpWDOqhz
         b08VUigHnykM7DUBj2bs0mKiF24U7mqjVaWisJkshVUF6rcHAmZy/pJarI9AVkWtVa
         8JOuAMw0IZ6H6sqxp8VPvboc+fwhh4cpTblfwGLqQYOaqP5TosTL3zgGS2+ZHa3aq5
         vu+LKuHSxvl/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76187C4166F;
        Wed, 15 Feb 2023 15:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/2] dt-bindings: Add a cpu-capacity property for RISC-V
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167647322047.11521.3970704369661052762.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Feb 2023 15:00:20 +0000
References: <20230104180513.1379453-1-conor@kernel.org>
In-Reply-To: <20230104180513.1379453-1-conor@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        conor.dooley@microchip.com, leyfoon.tan@starfivetech.com,
        sudeep.holla@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        alexs@kernel.org, siyanteng@loongson.cn, lpieralisi@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  4 Jan 2023 18:05:12 +0000 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey,
> 
> Ever since RISC-V starting using generic arch topology code, the code
> paths for cpu-capacity have been there but there's no binding defined to
> actually convey the information. Defining the same property as used on
> arm seems to be the only logical thing to do, so do it.
> 
> [...]

Here is the summary with links:
  - [v1,1/2] dt-bindings: arm: move cpu-capacity to a shared loation
    https://git.kernel.org/riscv/c/7d2078310cbf
  - [v1,2/2] dt-bindings: riscv: add a capacity-dmips-mhz cpu property
    https://git.kernel.org/riscv/c/991994509ee9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


