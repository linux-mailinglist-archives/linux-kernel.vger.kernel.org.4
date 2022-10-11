Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E765FBCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJKVWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJKVWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:22:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C9659DA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:22:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p14so10352302pfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X5//nnddhuA0A63J+KXNngGxq36v5RM3F1cXAIMsfF4=;
        b=FeUttnrmqjceWWSW6SQqoEIZ4VxYVe6EBzHAdSc95ZGyvbmt+PX1PRrhB5H+hF1q3F
         BW8dg2bmDgh9AA0qX/VrzEqXf+0ezpSZe+q24auDSZQVaXlv2ahMlUcaOTpu9B+RW5KP
         ZLWgum7AStrRWsZoeQ3cW8Hzqi4FMDDp3d7Jaq2b3LtHkzhmf7vZTO4C8mgijkkurLN7
         1I9lBjTtU5G7bMrxd3nimIdYWGq3Gw6Uaoa3ilJf2ElTwPrKpAbin8szi9Cy4Ne7QVj2
         WfhgpfdoXhVIs34mmiw3O0YsnzGJ4gjCXc2iVTkbrTcXYwXbwsrNkA5nXpn7adxl2AAg
         fsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5//nnddhuA0A63J+KXNngGxq36v5RM3F1cXAIMsfF4=;
        b=Nrr24pnNgB+2N7DBe0aoez/fAhPT0w3PoopfLmNiTsch0D6YGCUl5O5VR6p8oFSJTL
         Fm+OpjOrMdEH+ucmcFtlA8AnZesKCo/OhMY1oE1sU6Y2XnnFStsSbBF1+MMwspuBnSmi
         kW7g/3IY1MrL7cRcJEomR9OhvsCGBtwd1Ct8Hfb49qf6Xw/p0VQUImtYd7CjW/p2cjz1
         RuVJzMyrQPGMrMhTvGuHXiU6+ZTpisJnBTwNHfmHqGNw/rupGnbNFFFdkdPSI1RV7DtP
         cj2JUISE/kjtuOOooqq02NqVdqRox4W/yX8bT03iKNhyMom5evcHt4pVy7XMfqB63349
         gfkQ==
X-Gm-Message-State: ACrzQf37KIZKAexuTEHaXO0kv2B44KOTcnSOrQ7VuykQKn7rRdlYv8ed
        GKZhumpuX9ddfTeJ7NQt8Mi47i3omhOlzo6wALxdXQ==
X-Google-Smtp-Source: AMsMyM6u40XmFDh/iYsEV1e5Cj1I3SzMOm8GNc18xQrWuzQE1aBl12BDNrXBP0oiYvTExIc+3WEyEO1IPnrVovu2LYY=
X-Received: by 2002:a63:1f5c:0:b0:469:d0e6:dac0 with SMTP id
 q28-20020a631f5c000000b00469d0e6dac0mr609704pgm.427.1665523350340; Tue, 11
 Oct 2022 14:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <202210090815.526C76396@keescook> <20221011012904.2330473-1-lizetao1@huawei.com>
 <20221011012904.2330473-2-lizetao1@huawei.com>
In-Reply-To: <20221011012904.2330473-2-lizetao1@huawei.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Oct 2022 14:22:18 -0700
Message-ID: <CAKwvOd=ASXzYmQzSVwa+e8X=H-pouPd8Owv14iHaAxjmMT+3tQ@mail.gmail.com>
Subject: Re: [PATCH -next v4 1/2] x86/boot: Remove unused variables
To:     Li Zetao <lizetao1@huawei.com>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, masahiroy@kernel.org, michael.roth@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, nathan@kernel.org,
        brijesh.singh@amd.com, peterz@infradead.org,
        venu.busireddy@oracle.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
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

On Mon, Oct 10, 2022 at 6:32 PM Li Zetao <lizetao1@huawei.com> wrote:
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index c93930d5ccbd..b9451761a69a 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -253,7 +253,6 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>  static void enforce_vmpl0(void)
>  {
>         u64 attrs;
> -       int err;

Just a thought but you could initialize attrs now on the same line.

I also ended up testing the whole series, so:

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
