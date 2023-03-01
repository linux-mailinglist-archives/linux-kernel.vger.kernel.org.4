Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96226A7006
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCAPnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCAPnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:43:20 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2410438
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:43:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id ky4so14441630plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 07:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677685399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jk1CWGRa3kTQ1gWjtQmCrZaMDysdPjD2ahhPP4P+cE4=;
        b=ug1XGeE7iC8LpsVCZd0DbykTPtEnDqjJ1yoKa99KHOYkuNK0+rPf+PfOpGKU1k373B
         MydjpHWbfYsd2X/mu+irks0cPlpteuOxWdnypj1j9dx8SCVDnoB6JvTyTYnOVacb9p1E
         PChqxk62yZK6sPgOS5IqMfafa2AJbkCped3eGbQh2rqoJP3zyUKaf4VSFG5YfOE/+ld/
         +2FiubSXkAwReCibyX5oZ7Kr8TaK9l+8jwiBcaG01SgtzbQH++8gKEA3Z8/MXjsB5VrV
         2rnuJd548h43t8eIMFAB2MsHtfgT4SRS4oFx2AIOMNLol6otvCCEm5y0U+dRDDtE7aR3
         aCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677685399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk1CWGRa3kTQ1gWjtQmCrZaMDysdPjD2ahhPP4P+cE4=;
        b=Qi+dgQcl2uekFhgWW2ISux4O4YahVqvUPV1Q6upVjniAgsjYhQPEFN+HSZ8mybZ7DO
         E7JcCSgex8QebGKTwAunQuymMyE71h6FMP5rUxGcmw0z6y+T96NrEGeqszdwF5jS61Vl
         ubhI/ypHDqI7bps0Ejx+aMT6jxlS1gi9U0bQ6LdsjGX13XmPJec1Dl00bZF3tEF9PTT0
         e3IoqZGEwLthDMBcPjMP2n2456eapIzdGU0u76xOS+2+GJowS9LwIXFKSke2w1TuQ4Op
         FfBc5zLjqF7MEUR8VyaTRESN8jPJ+XBugIwBMNd2eAzxk7Pgz68gyGR3+6x7+jqW8oyq
         Plsg==
X-Gm-Message-State: AO0yUKVxIufu9+kLO8PtsocfInUHOEKPVkk/FgG+VZnUTpBS5Uqch7Oh
        XbgBsf1b9hUmXB+ZRf2BItHqlg==
X-Google-Smtp-Source: AK7set+fuMNisfM0WBwYC+EByMgjJsGThlfCcPJ0YdCBsPkhFhVceqUj2X3JoyoEZocv3WGD+ka0vA==
X-Received: by 2002:a17:903:1111:b0:19d:778:ff5 with SMTP id n17-20020a170903111100b0019d07780ff5mr7622440plh.15.1677685398868;
        Wed, 01 Mar 2023 07:43:18 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b0019a87ede846sm8577709plx.285.2023.03.01.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 07:43:18 -0800 (PST)
Date:   Wed, 1 Mar 2023 07:42:58 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com
Subject: Re: [PATCH v6 20/41] x86/mm: Teach pte_mkwrite() about stack memory
Message-ID: <20230301154258.GC3505369@debug.ba.rivosinc.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-21-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-21-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:12PM -0800, Rick Edgecombe wrote:
>If a VMA has the VM_SHADOW_STACK flag, it is shadow stack memory. So
>when it is made writable with pte_mkwrite(), it should create shadow
>stack memory, not conventionally writable memory. Now that pte_mkwrite()
>takes a VMA, and places where shadow stack memory might be created pass
>one, pte_mkwrite() can know when it should do this.
>
>So make pte_mkwrite() create shadow stack memory when the VMA has the
>VM_SHADOW_STACK flag. Do the same thing for pmd_mkwrite().
>
>This requires referencing VM_SHADOW_STACK in these functions, which are
>currently defined in pgtable.h, however mm.h (where VM_SHADOW_STACK is
>located) can't be pulled in without causing problems for files that
>reference pgtable.h. So also move pte/pmd_mkwrite() into pgtable.c, where
>they can safely reference VM_SHADOW_STACK.
>
>Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>

Acked-by: Deepak Gupta <debug@rivosinc.com>
