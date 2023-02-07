Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489A268DED9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjBGRZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjBGRZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:25:45 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CF8126C4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:25:37 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id cz15so7403770vsb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D/BcHWrx4Kj+87bqftvm+l0WaUTrm7SbGz6u55o5gw8=;
        b=AxYpztFQNf6RBscWYrn/sCD0VhszWHIlsJsbTqrvMarIYaLDYoH60g20D7cMtj0Gmm
         vh6yK+EL8yG1Ter9R6PbEvcPJi0KdnS9ZTS9Z+kvx2xkuQBJii6P2T3tbXEk6dLDITvu
         m8rWpKy4SSReADrHx/lLtnqS6YedF64/eXunjuNYCqm6GIW/O4Obfn58AqbIfo8oiyBM
         i9Ihocd2hwCcHDOht+BUou08jozfCKH4fyiYd/wo2bAUjvP4MIDiG0Ee9t8Df9eMcEXb
         EdfgaCLsNKVDmce4rsUPY7+YPFmMr2WK6iBOv/D2zC7+m1sx9tWRag7TYe+B9X0+BJwZ
         zq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/BcHWrx4Kj+87bqftvm+l0WaUTrm7SbGz6u55o5gw8=;
        b=tkSu0AGY/xJ/n3Mm188nBlf5LhmB3AeQty4k9DVW9488dHSTW4b8aPejWeBs3+UyDj
         BhfXwIkBwy5L5mWJ0kHdGfby4CCU+ew9cb6N5feyYjcgKVTxwf0vdI1qbIXK69OkliER
         xjyNiVSg9o1Qvfh9/phlm4ywom8ivot1U3E2ZhyCq6QXqXQVcvLfL/3k2brxtl5tMebK
         ryK0glI8FGPW3opqdiHurLZyN7SZ72t577NYKvXHkkr5vgCSW8zHYJ6epNZAW4HYw0v+
         5n0VA33Tz/PFSmvv47DPuvkkwUjpQm/RHQlxWAU/ySAykD5oKDEh4C7k1MHrIDnYQmLe
         21qw==
X-Gm-Message-State: AO0yUKUGBGeWme3H8uhhEK1aHXqPCLC0lDGxPp5bewtlzSG0M2E4KdXW
        nfwK5EfK2NJtseHANvIRfR2paNi+8wS0Zf2QL/awSw==
X-Google-Smtp-Source: AK7set9bNSt5xjr6xHdtjJgru9nyPfJ0WS5zOVzwgAyjK0IennvJ1JX+5l/AqqHqkA0zrKFDEQSzFcaKF7Ps8YDqhdE=
X-Received: by 2002:a67:15c2:0:b0:3e9:e5ce:b491 with SMTP id
 185-20020a6715c2000000b003e9e5ceb491mr875595vsv.13.1675790736991; Tue, 07 Feb
 2023 09:25:36 -0800 (PST)
MIME-Version: 1.0
References: <202302072055.odjDVd5V-lkp@intel.com>
In-Reply-To: <202302072055.odjDVd5V-lkp@intel.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 7 Feb 2023 09:25:10 -0800
Message-ID: <CALzav=dGuJDdr6s8XoaW8r2U-Fyi1VWoVxe5dOKLam1mJ7k7hg@mail.gmail.com>
Subject: Re: [linux-next:master 911/10933] arch/x86/kvm/mmu/mmu.c:102:22:
 sparse: sparse: symbol 'tdp_mmu_allowed' was not declared. Should it be static?
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kai Huang <kai.huang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 4:51 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   49a8133221c71b935f36a7c340c0271c2a9ee2db
> commit: 3af15ff47c4df3af7b36ea8315f43c6b0af49253 [911/10933] KVM: x86/mmu: Change tdp_mmu to a read-only parameter
> config: x86_64-randconfig-s023-20230206 (https://download.01.org/0day-ci/archive/20230207/202302072055.odjDVd5V-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=3af15ff47c4df3af7b36ea8315f43c6b0af49253
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout 3af15ff47c4df3af7b36ea8315f43c6b0af49253
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> sparse warnings: (new ones prefixed by >>)
> >> arch/x86/kvm/mmu/mmu.c:102:22: sparse: sparse: symbol 'tdp_mmu_allowed' was not declared. Should it be static?

Yes it should be static. I'll send a patch.
