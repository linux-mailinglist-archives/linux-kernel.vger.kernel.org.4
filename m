Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B785F52E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJEKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJEKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B1E2BB3B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1065461632
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75DDC433C1;
        Wed,  5 Oct 2022 10:52:04 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH -next] arm64: alternatives: Use vdso/bits.h instead of linux/bits.h
Date:   Wed,  5 Oct 2022 11:52:02 +0100
Message-Id: <166496711025.2001365.13537270365184186055.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221003193759.1141709-1-nathan@kernel.org>
References: <20221003193759.1141709-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 12:37:59 -0700, Nathan Chancellor wrote:
> When building with CONFIG_LTO after commit ba00c2a04fa5 ("arm64: fix the
> build with binutils 2.27"), the following build error occurs:
> 
>   In file included from arch/arm64/kernel/module-plts.c:6:
>   In file included from include/linux/elf.h:6:
>   In file included from arch/arm64/include/asm/elf.h:8:
>   In file included from arch/arm64/include/asm/hwcap.h:9:
>   In file included from arch/arm64/include/asm/cpufeature.h:9:
>   In file included from arch/arm64/include/asm/alternative-macros.h:5:
>   In file included from include/linux/bits.h:22:
>   In file included from include/linux/build_bug.h:5:
>   In file included from include/linux/compiler.h:248:
>   In file included from arch/arm64/include/asm/rwonce.h:71:
>   include/asm-generic/rwonce.h:67:9: error: expected string literal in 'asm'
>           return __READ_ONCE(*(unsigned long *)addr);
>                 ^
>   arch/arm64/include/asm/rwonce.h:43:16: note: expanded from macro '__READ_ONCE'
>                   asm volatile(__LOAD_RCPC(b, %w0, %1)                    \
>                               ^
>   arch/arm64/include/asm/rwonce.h:17:2: note: expanded from macro '__LOAD_RCPC'
>           ALTERNATIVE(                                                    \
>           ^
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: alternatives: Use vdso/bits.h instead of linux/bits.h
      https://git.kernel.org/arm64/c/d2995249a2f7

-- 
Catalin

