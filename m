Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF386D077C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjC3N75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjC3N7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:59:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50997422C;
        Thu, 30 Mar 2023 06:59:54 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFE661EC0529;
        Thu, 30 Mar 2023 15:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680184792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RaCQbtJuOp6mvRaZEd/yxaaNx3ln6NDUmrn5m6jP5cQ=;
        b=AAMsLpcSo0OnfJr8XT2N2CxydGkTGtTH4OVDjce65Fv3r1awzQAnakR6nzpIVd8js7OM/k
        fJEkv6TbZxgp6j4Q8rh7jtCLkkAc+wDzulgG6zorzgoJ0OzkY7EiDUWKYBGhvISM9TKI5B
        O0bG89vw0sRleDbcY8db9jEv5UwdojA=
Date:   Thu, 30 Mar 2023 15:59:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chenhuacai@kernel.org, zhangqing@loongson.cn,
        kernel@xen0n.name, mingo@redhat.com, peterz@infradead.org,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/8] function_graph: Support recording and printing
 the return value of function
Message-ID: <20230330135948.GCZCWV1O/IjsxsBmN8@fat_crate.local>
References: <cover.1680176068.git.pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1680176068.git.pengdonglin@sangfor.com.cn>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:39:07AM -0700, Donglin Peng wrote:
> v9:
>  - Fix align issues in ARM asm code
>  - Fix align issues in LoongArch asm code
>  - Update commit messages
>  - Update comments for ftrace_return_to_handler
> 
> v8:
>  - Fix issues in ARM64 asm code
>  - Fix issues in selftest
>  - Add some comments on CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
>  - Make CONFIG_FUNCTION_GRAPH_RETVAL switable
>  - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL

Please control your spamming:

From: Documentation/process/submitting-patches.rst

Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
						     ^^^^^^^^^^^^^^^^^^^^^

one week before resubmitting or pinging reviewers - possibly longer during
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

busy times like merge windows.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
