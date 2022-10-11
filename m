Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7E15FB1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJKLzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKLzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:55:51 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C87F26F;
        Tue, 11 Oct 2022 04:55:51 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d14so7018718ilf.2;
        Tue, 11 Oct 2022 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X9ELJWsFEOA9ZjR8vqRc+1/Kb4xOZiuQUQY31p1h+Q8=;
        b=DZszs+gH1es+xg6y+a7l0fAdLt1s52gSgAZiIDQumcRtKI4eEhlGm+9JR8DSEWZR7t
         I8sigBB0KtgDK6bFwuAQbJ6nT2M0FgHcR93WYRgrV9HcCYk4FmCdYeksFA4Q/AoLgGt+
         3C4/KXreibaj3FvFT4nynzieUW3Hsuk7PVMTZRA/3WrfBnlKy+KUYHcIOaoIgq21QAqF
         Gp45E8UcByMRn8YstbmTXUQ/c19HZIhtTlxc1jD9CxuyPT7l37ZuBk14F6ZOm3pM/oOt
         kh3DASTrFByWwriz90Cvt3/a38lVOCpTXRcI4McEVEutLlAVrRouROph3+xL2iHzkU4w
         wf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9ELJWsFEOA9ZjR8vqRc+1/Kb4xOZiuQUQY31p1h+Q8=;
        b=6gkVtOts6FCpKNKjm9yq+zdRp9YIYULMaQWpcjEJ7TFpfKCID685kEyJZ4mb5oTjyB
         g7a12GF1xombz1cEnHLe4cu+jnD0H2h+D0iTZkn8NzWCZHu16pB3A6zmw2bK5L2aP1xR
         HQCw2HCv+4M985PUuVxtYpzpmDpz5uCbC51mIGejlT4bjvCYFczZgyrBpkIa3iIBK6p/
         +wCWP98tVSmimSlD8qQcdZRNkOdimbKEv6582hjwM1rkMcJtdJ9eHu4rRzVzCRSUdUCz
         dI0XnlwD8Ga0a+FV2TGS32VET7kcTd7h72Rw7TsjeLECz8lnFq5FBjsUsqYsOL6ftAmA
         aLUw==
X-Gm-Message-State: ACrzQf1XC+yN3OhWeF3tVhzCwFr0ISRYZ9ICDIcjVlZvhY7E5iHbz4Wk
        H2F/083EN5uIX37YlyPFoSWPr/GSWxa8V/aDPpo=
X-Google-Smtp-Source: AMsMyM5+gu5fEJL3u/z9fh5zuGtorQ255IKQ4OfCeJYH5cGS9UtuhnZ0j68AmjbTrs1kGnaP/bv1mWaQfSHEJHHX7Pc=
X-Received: by 2002:a05:6e02:b2d:b0:2f9:e735:a010 with SMTP id
 e13-20020a056e020b2d00b002f9e735a010mr11659127ilu.151.1665489350477; Tue, 11
 Oct 2022 04:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221011031843.960217-1-masahiroy@kernel.org>
In-Reply-To: <20221011031843.960217-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Oct 2022 13:55:39 +0200
Message-ID: <CANiq72k9wAVCbHKVZFE=E3xv+2ZamUMsJ=uV43NxsSUQ4wXGdw@mail.gmail.com>
Subject: Re: [RFC PATCH] Remove Intel compiler support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 5:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>  include/linux/compiler-intel.h            |  34 -----
>  include/linux/compiler_types.h            |   2 -

You can also remove a few lines from `compiler_attributes.h`:

    * Optional: not supported by icc

Thanks for this!

Cheers,
Miguel
