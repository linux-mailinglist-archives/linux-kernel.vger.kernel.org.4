Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535025F3992
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 01:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJCXHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJCXHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:07:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F6F24083
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 16:07:34 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o123so14884811yba.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 16:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nYrIZRovtEchDOXqockApvltsCTO8n79eb3xFqi9gPE=;
        b=mA5WDoLZdqwCsRey82cM7gwLGf297YOkY4UB2ETtAun+mWB0DS4nrOSBfn9/Q0GG1D
         LrEV/gsLjx/JleJeKHQS0niCdbNbAJ+rTzufd7vkHLnyZCYF8L14T75p7/qvtMg5mqQB
         q/oR5/2LT0h5O42kFdQCMid/m/YBp1d363Y5b+lVDHb7CCUA0GATJuGrO0iXdPEttuZP
         21mef1LHTKUMxwKDt0BVWJzOz+W50r+CotTZmacydSAKWlWqroE7T7x8mr9IXnSusotG
         eSeZsgawe2FR4lgl/NNSM2imE3+D7Q+5VMF122gCHHXlaBRcYZdqgnWhtxH1g6zBviCn
         HGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nYrIZRovtEchDOXqockApvltsCTO8n79eb3xFqi9gPE=;
        b=F9v8OhQ0g5VT/0pz/AvZgDGGzFIba/dZSnRvu9c4OHF9EJYzcBgXQy8pPHKQgBCBR9
         9luY/AK4ua6XvltgvikN7Sx+44evo9M90MOAygZtI+P60maIlVHsGG7fR3xHAyRhFctc
         uh2D50aN2AsAaz5OyM3XIJYGSIqKm8A33nQC1gdy991Y10lRSTyUjc69GPriBa6hC/NF
         Wafcafgixuw3N8cghD50gGphR8WWT3bPWCyeMg10WnM+zJNJi42VfTf7CJESZLGj2uTj
         W4krJ14lSLV4scJ1N1KaPCdxv6hwnae/rba9w/ZtY+lGZul8gGQxgMuNDkZnegXMr7nS
         n1yw==
X-Gm-Message-State: ACrzQf2xwFiOSIoLotGWJtD4fNPvs24ZAcVzbrO+C7k3RucANt9CvHJm
        GQi6cpw8PJne2YOhNyQeR3tMlfAq6jAv+LrO3UZzyQ==
X-Google-Smtp-Source: AMsMyM6r56jjoOvWBxUy3wjHa+rN57t0o+kMf2HaNDxnvEYCFqqrSL2kmOErw4q38/T5BZWBFejAqoxOi9KlrGM6SAg=
X-Received: by 2002:a25:328c:0:b0:6be:2d4a:e77 with SMTP id
 y134-20020a25328c000000b006be2d4a0e77mr457836yby.407.1664838453641; Mon, 03
 Oct 2022 16:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220812183501.3555820-1-acdunlap@google.com> <20220908170456.3177635-1-acdunlap@google.com>
 <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com>
 <2625dbfa-434c-7d55-6469-9d9e89397e8f@intel.com> <YyH/tOqrl8pZmoub@google.com>
 <CAMkAt6p2Y=6sBB1JiZ2FovYXme9QBFWFu+EtnNyuQ3Db3ZhBSg@mail.gmail.com> <CAMBK9=YB=8EQymDUda300qPFAL1=7dzC61c0pshrWEC5ibrUfQ@mail.gmail.com>
In-Reply-To: <CAMBK9=YB=8EQymDUda300qPFAL1=7dzC61c0pshrWEC5ibrUfQ@mail.gmail.com>
From:   Adam Dunlap <acdunlap@google.com>
Date:   Mon, 3 Oct 2022 16:07:22 -0700
Message-ID: <CAMBK9=a4mR65urS3f7=V-Ukpaeqpem2M7B2B22VPC1ufES4iXg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
To:     Peter Gonda <pgonda@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Jacob Xu <jacobhxu@google.com>,
        Alper Gun <alpergun@google.com>, Marc Orr <marcorr@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resent with plain text]

Thanks for all the responses. Is the consensus that we should use the
readl function here or instead use inline assembly directly as in the patch
I originally sent out:

asm_inline("movl %1, %0" : "=r"(out) : "m"(*addr));

? The readl function has this exact same code, I'm just not sure
which version fits better stylistically.


On Mon, Oct 3, 2022 at 4:01 PM Adam Dunlap <acdunlap@google.com> wrote:
>
> Thanks for all the responses. Is the consensus that we should use the
> readl function here or instead use inline assembly directly as in the patch
> I originally sent out:
>
> asm_inline("movl %1, %0" : "=r"(out) : "m"(*addr));
>
> ? The readl function has this exact same code, I'm just not sure
> which version fits better stylistically.
