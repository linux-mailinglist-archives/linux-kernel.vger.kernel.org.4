Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623736D4D70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjDCQWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjDCQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:21:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26242710
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:21:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so119604020edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680538908; x=1683130908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFwQPWx8Ux6bh8rA+x2qSR6v2JLfRrPIjTrTWUE6sUM=;
        b=ENGJ8avArfyET27ycBUe9OwP9G5sEQAmMsBbS80rXSTWqWIMm1MBXCHjxpwZPAQafC
         PSh2T6xEQUIhzbczONjNgjv/ijWV54F+WCaSvNJ71SVJqRx/a2iT1QTRCQIbUcpqpBbC
         XgQH4i5o1DUUgJfHz/1iyxfEEQW0htHa/oWx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680538908; x=1683130908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFwQPWx8Ux6bh8rA+x2qSR6v2JLfRrPIjTrTWUE6sUM=;
        b=dD7TyFoLj+SPEtSjaO89ry/4svYU4YZcA3fESdaDOQbrtMOmmGE1Z2OneZGhYDzuY5
         nvjv4+K79nXO7BxbUequaKtrY54AZ8jRpamgat5kA8KZ4Kq3bKkFN5lO8xtO0Jhxesuu
         a9DMuF8ffv6WATe6weV2yUiYWASMYC/N5FH0O6uqtg9tBhwrEuhOHzQc1nYgXm/iZprD
         r0YE4vy7qROXuZB9mhyZIs7XmYvIkbDm9tmhiKG5tSf1pPqtCH4wN54+BVXodWFwmHBF
         26E3SBOc+0VwBLtVFeNjZBogs0Y8u7sI5DzayWInLmBphZXM1qVTNS0moVOwBX1wiF8s
         8vqQ==
X-Gm-Message-State: AAQBX9c0RycVrv9oqNnraZhv+RuP6xBL9OEIISZ0ga4w1PrWhcDzOGop
        eGMoR3jgHfy6egyXz7G2S3dQnaB1HZPPamGehHWlxA==
X-Google-Smtp-Source: AKy350b7GHrd9acQS6qYefXsi4zFzi0d8fYy/Bvs/jhS1hrQi+PUMQZcC8B5DmoVqFa1hvMAFKx+yA==
X-Received: by 2002:a05:6402:1acf:b0:502:9289:51e5 with SMTP id ba15-20020a0564021acf00b00502928951e5mr6822590edb.14.1680538908044;
        Mon, 03 Apr 2023 09:21:48 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id c30-20020a50d65e000000b004af70c546dasm4812549edj.87.2023.04.03.09.21.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 09:21:46 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id cn12so119599758edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:21:45 -0700 (PDT)
X-Received: by 2002:a17:907:3e16:b0:932:da0d:9375 with SMTP id
 hp22-20020a1709073e1600b00932da0d9375mr11670367ejc.4.1680538904942; Mon, 03
 Apr 2023 09:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230403140605.540512-1-jiangshanlai@gmail.com> <20230403140605.540512-3-jiangshanlai@gmail.com>
In-Reply-To: <20230403140605.540512-3-jiangshanlai@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Apr 2023 09:21:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whY8tkKJoFjzP1-kR5rqCmgTEiX2i+GJgjdJcn+q+3HTQ@mail.gmail.com>
Message-ID: <CAHk-=whY8tkKJoFjzP1-kR5rqCmgTEiX2i+GJgjdJcn+q+3HTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] x86/entry: Add IST main stack
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Cfir Cohen <cfir@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Kaplan <David.Kaplan@amd.com>,
        David Rientjes <rientjes@google.com>,
        Dirk Hohndel <dirkhh@vmware.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 7:05=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.co=
m> wrote:
>
> diff --git a/Documentation/x86/kernel-stacks.rst b/Documentation/x86/kern=
el-stacks.rst
> index 6b0bcf027ff1..be89acf302da 100644
> --- a/Documentation/x86/kernel-stacks.rst
> +++ b/Documentation/x86/kernel-stacks.rst
> @@ -105,6 +105,8 @@ The currently assigned IST stacks are:
>    middle of switching stacks.  Using IST for MCE events avoids making
>    assumptions about the previous state of the kernel stack.
>
> +* ESTACK_IST. bla bla
> +
>  For more details see the Intel IA32 or AMD AMD64 architecture manuals.

Maybe the cover letter description could be used here, rather than the
"bla bla" placeholder?

              Linus
