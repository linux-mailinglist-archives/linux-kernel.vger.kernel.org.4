Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489855EAE88
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIZRuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiIZRtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:49:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713168C026
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:21:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so7584755pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2CJsPJIcF/q9pqyQSpQuHmSgCKTw7oUJXNHq7eoyKcc=;
        b=e3wYABcOj+RAraSEfu1QgnIP34RJFOGWgA0ym+WGJ1XI86WsvtMUaFSMSTdjbsVAlL
         F511Dqld206SUDR32cLXZhMbc10BlQI8eFIc429dNGvxQwuAhar9v/RttRdOBX8JxxJb
         mlEwZoODLkO693BQG+mvCXquhER7IFVHbH4/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2CJsPJIcF/q9pqyQSpQuHmSgCKTw7oUJXNHq7eoyKcc=;
        b=gVMsBMw0I+cIyXt4yPMgYvukp7d3QNRaw9RZrkTTeffg3y/ch314PPxBdSsDQccBgy
         Z0pFSPDtogvN6MzjB6e1ehVmwYDrz06Bv0sop9Qmw2wOCoL7HplekNNAsNQur0q2GgR5
         R8w2+uKnLrUeafKgceWmKH5TTlTUhvhZN4ddrOd8+Qs5Lum/UfH7xWNUe77cqw5KdnbM
         idWO5wkaDKc2ITXeAASsROa1EDp1FWZVEzDVp8/q7/jOPkvlEd7hsljH4C9zYHecys4h
         EYMbb6Gs6xBFRg9AFJ1o2oPpvIz2mzbFvPIct9m9wNHp04rrRzn6fUNksP8yCTkQOcwT
         s5SQ==
X-Gm-Message-State: ACrzQf1fpQbkSye5HIUDEXiX110ySDs2dJh3iWRNcS7WnBSX+uKeJjjQ
        xLHrclZ3evttLFVgLL8t2NPQDA==
X-Google-Smtp-Source: AMsMyM6MNzJnJDFcVo7NAG20x6qNWKBZZfRWFcTAI8Fj9D7jTdDe6fGKZ8OBE2Okxjc91RIlf96HMA==
X-Received: by 2002:a17:902:7c11:b0:178:a6ca:4850 with SMTP id x17-20020a1709027c1100b00178a6ca4850mr23963352pll.111.1664212896926;
        Mon, 26 Sep 2022 10:21:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik27-20020a170902ab1b00b001732a019dddsm11484682plb.174.2022.09.26.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 10:21:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     samitolvanen@google.com, peterz@infradead.org
Cc:     Kees Cook <keescook@chromium.org>, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        joao@overdrivepizza.com, nathan@kernel.org, sedat.dilek@gmail.com,
        llvm@lists.linux.dev, mark.rutland@arm.com,
        linux-hardening@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>, catalin.marinas@arm.com,
        rostedt@goodmis.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/22] KCFI support
Date:   Mon, 26 Sep 2022 10:20:30 -0700
Message-Id: <166421282763.1683223.5035885857817205401.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
References: <20220908215504.3686827-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 14:54:42 -0700, Sami Tolvanen wrote:
> KCFI is a forward-edge control-flow integrity scheme in the upcoming
> Clang 16 release, which is more suitable for kernel use than the
> existing CFI scheme used by CONFIG_CFI_CLANG. KCFI doesn't require
> LTO, doesn't alter function references to point to a jump table, and
> won't break function address equality.
> 
> This series replaces the current arm64 CFI implementation with KCFI
> and adds support for x86_64.
> 
> [...]

I assume that Peter's Ack means I should carry the tree, so, to that end:

Applied to for-next/kcfi, thanks!

[01/22] treewide: Filter out CC_FLAGS_CFI
        https://git.kernel.org/kees/c/f143ff397a3f
[02/22] scripts/kallsyms: Ignore __kcfi_typeid_
        https://git.kernel.org/kees/c/d0f9562ee43a
[03/22] cfi: Remove CONFIG_CFI_CLANG_SHADOW
        https://git.kernel.org/kees/c/9fca7115827b
[04/22] cfi: Drop __CFI_ADDRESSABLE
        https://git.kernel.org/kees/c/92efda8eb152
[05/22] cfi: Switch to -fsanitize=kcfi
        https://git.kernel.org/kees/c/89245600941e
[06/22] cfi: Add type helper macros
        https://git.kernel.org/kees/c/e84e008e7b02
[07/22] lkdtm: Emit an indirect call for CFI tests
        https://git.kernel.org/kees/c/cf90d0383560
[08/22] psci: Fix the function type for psci_initcall_t
        https://git.kernel.org/kees/c/44f665b69c67
[09/22] arm64: Add types to indirect called assembly functions
        https://git.kernel.org/kees/c/c50d32859e70
[10/22] arm64: Add CFI error handling
        https://git.kernel.org/kees/c/b26e484b8bb3
[11/22] arm64: Drop unneeded __nocfi attributes
        https://git.kernel.org/kees/c/5f20997c194e
[12/22] init: Drop __nocfi from __init
        https://git.kernel.org/kees/c/5dbbb3eaa2a7
[13/22] treewide: Drop function_nocfi
        https://git.kernel.org/kees/c/607289a7cd7a
[14/22] treewide: Drop WARN_ON_FUNCTION_MISMATCH
        https://git.kernel.org/kees/c/4b24356312fb
[15/22] treewide: Drop __cficanonical
        https://git.kernel.org/kees/c/5659b598b4dc
[16/22] objtool: Preserve special st_shndx indexes in elf_update_symbol
        https://git.kernel.org/kees/c/5141d3a06b2d
[17/22] objtool: Disable CFI warnings
        https://git.kernel.org/kees/c/3c68a92d17ad
[18/22] kallsyms: Drop CONFIG_CFI_CLANG workarounds
        https://git.kernel.org/kees/c/dfb352ab1162
[19/22] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
        https://git.kernel.org/kees/c/ca7e10bff196
[20/22] x86: Add types to indirectly called assembly functions
        https://git.kernel.org/kees/c/ccace936eec7
[21/22] x86/purgatory: Disable CFI
        https://git.kernel.org/kees/c/a4b7a12c5594
[22/22] x86: Add support for CONFIG_CFI_CLANG
        https://git.kernel.org/kees/c/3c516f89e17e

-- 
Kees Cook

