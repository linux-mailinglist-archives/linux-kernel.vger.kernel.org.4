Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0206B6250
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjCLAn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLAn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:43:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FAB37F2C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 16:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=9iyeM+Y4AtaIo+y5uz1wBP7auctT+VwxsNrR8XsMzb4=; b=Ro9se53P+MNkQ48ki7Bb9T2+a3
        3moS30Bdh00cYrNlzPgkeKVOoqiBvzPjHJ12BHUQypveTtLWD2FL5soxzDXx2t7casr29NK3voOUN
        4z8QJyKKbnV0UZJ22Fvmv9ikkUze6kbNg0gQpp6xsY7XyRR0+GlGWFAV6MNcKkU3gJOcWGQGuzxTv
        jMgJYT+hkFHy1OaRtam9bK8KDP4YHzr3Yk8gQkwROMQB36SQ3snOCml327XP4HV76iIO7I9ReFd8a
        1KW5qdetjPWIQM9j1qvFavfY1AEpFZSb58W9IZwwUEEHKCyqsjnXdGUhiGK5iJhamyuLiyWAQsmMT
        vfnn3zog==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pb9oB-001Wx7-EU; Sun, 12 Mar 2023 00:43:31 +0000
Message-ID: <cf39523d-e801-5aa9-c8a2-fd77d2310d45@infradead.org>
Date:   Sat, 11 Mar 2023 16:43:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] x86: Fix W=1 kernel-doc warnings
Content-Language: en-US
To:     Anuradha Weeraman <anuradha@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jan Beulich <jbeulich@suse.com>, linux-kernel@vger.kernel.org
References: <20230311185725.51937-1-anuradha@debian.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230311185725.51937-1-anuradha@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/11/23 10:57, Anuradha Weeraman wrote:
> Fix W=1 kernel-doc warnings for:
>   - arch/x86/lib/insn-eval.c
>   - arch/x86/mm/pat/memtype.c
> 
> Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
> ---
>  arch/x86/lib/insn-eval.c  | 6 +++---
>  arch/x86/mm/pat/memtype.c | 1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index 558a605929db..0bc9d87ab95d 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -1129,15 +1129,15 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
>   * get_eff_addr_sib() - Obtain referenced effective address via SIB
>   * @insn:	Instruction. Must be valid.
>   * @regs:	Register values as seen when entering kernel mode
> - * @regoff:	Obtained operand offset, in pt_regs, associated with segment
> + * @base_offset:Obtained operand offset, in pt_regs, associated with segment

I would insert a space after @base_offset:
but ultimately it's up to the maintainers.

>   * @eff_addr:	Obtained effective address
>   *
>   * Obtain the effective address referenced by the SIB byte of @insn. After
>   * identifying the registers involved in the indexed, register-indirect memory
>   * reference, its value is obtained from the operands in @regs. The computed
>   * address is stored @eff_addr. Also, the register operand that indicates the
> - * associated segment is stored in @regoff, this parameter can later be used to
> - * determine such segment.
> + * associated segment is stored in @base_offset, this parameter can later be
> + * used to determine such segment.
>   *
>   * Returns:>   *
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 46a00aa858b6..380bec99fab5 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -700,6 +700,7 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
>  /**
>   * pat_pfn_immune_to_uc_mtrr - Check whether the PAT memory type
>   * of @pfn cannot be overridden by UC MTRR memory type.
> + * @pfn: page frame number
>   *
>   * Only to be called when PAT is enabled.
>   *

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.
-- 
~Randy
