Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4A67EF01
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjA0T7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjA0T73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:59:29 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6888D410
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:57:40 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id u18so1887641qvv.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCbWVDeCBmv0tLQetS3EwIRtSgUEsqrpXNIcWwZitCE=;
        b=Oq2KyBNFkKCXFSiv7V8jYK5N7BWEm+bEaPdyaX7pikQru8J5TXsKu7vUcBAug4HHGl
         wqfILDWXVPjBz2g10jTsfA7RHNmqeO8+n9fL6BvMP5T2d6yR1Fd0NeScYNFNExZmRiPp
         FG7Qf0o52jSY4m401DXdfWpolnC9HTglszHWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCbWVDeCBmv0tLQetS3EwIRtSgUEsqrpXNIcWwZitCE=;
        b=8FDF1D13HFqpyYkLTDcbRQQuOf+Dwbb9HAxAHDl7qVz9EwpnScvB7cbEJ5pf3fJqOw
         jOhGGQo7OPuwp0dTfCZiaD4+qO8nQab8SQ2LZ5meIHmtPtPPJ314PcHgt65BPYqIHa0w
         l6iLtfV5S5T6rUA1GU0utWYpaoq89s5CaWfnYj4QN72M4FL3wBOLTV/6/ji2pRkRF/Tb
         rQ6eYRWKsEzfRe4FotEEjeBxcYAfl39g8HM8CLPwAMYfitqM6TWPJlzbdkfGnEUyM1wE
         vQl1vdl+FoMf1i8jgjhnUyONQVE5h43pKtWSg0hhErloAwJtygrLBG/jU81yuSTdNM9K
         O05Q==
X-Gm-Message-State: AO0yUKV/vA4ymjuljzbaWXWM6wes1gWWmnSH5lfrmVgd8tbd47iZKhXS
        CnXeaD3lBizCmiohk7H/83m2uFl+ktcIZn+A
X-Google-Smtp-Source: AK7set9701lFYJloTnasN/YHIzeLJ41Q0Ii7zI4q0jj6SS2KU0q1aZohz1YubDz5Xez2Pa2deR4L+g==
X-Received: by 2002:a17:903:2345:b0:196:5d8d:2d6f with SMTP id c5-20020a170903234500b001965d8d2d6fmr2292522plh.13.1674848860829;
        Fri, 27 Jan 2023 11:47:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1-20020aa79461000000b0058da7e58008sm3016917pfq.36.2023.01.27.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:47:40 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:47:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ACPICA: Replace fake flexible arrays with flexible
 array members
Message-ID: <202301271146.7DC8CAE113@keescook>
References: <20230127191621.gonna.262-kees@kernel.org>
 <CAJZ5v0iV5wK4gsoadmWOyof_vzaAOx8oX0DJu+1-bCQNdNJtBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iV5wK4gsoadmWOyof_vzaAOx8oX0DJu+1-bCQNdNJtBQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:43:05PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 27, 2023 at 8:16 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > One-element arrays (and multi-element arrays being treated as
> > dynamically sized) are deprecated[1] and are being replaced with
> > flexible array members in support of the ongoing efforts to tighten the
> > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> >
> > Replace one-element array with flexible-array member in struct
> > acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> > padding in a union with a flexible-array member in struct
> > acpi_pci_routing_table.
> >
> > This results in no differences in binary output.
> >
> > Link: https://github.com/acpica/acpica/pull/813
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > v2: include stddef.h and switch to __DECLARE_FLEX_ARRAY()
> > v1: https://lore.kernel.org/lkml/20221118181538.never.225-kees@kernel.org/
> > ---
> >  include/acpi/acrestyp.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
> > index a7fb8ddb3dc6..250046a7c870 100644
> > --- a/include/acpi/acrestyp.h
> > +++ b/include/acpi/acrestyp.h
> > @@ -10,6 +10,8 @@
> >  #ifndef __ACRESTYP_H__
> >  #define __ACRESTYP_H__
> >
> > +#include <linux/stddef.h>
> > +
> >  /*
> >   * Definitions for Resource Attributes
> >   */
> > @@ -332,7 +334,7 @@ struct acpi_resource_extended_irq {
> >         u8 wake_capable;
> >         u8 interrupt_count;
> >         struct acpi_resource_source resource_source;
> > -       u32 interrupts[1];
> > +       u32 interrupts[];
> >  };
> >
> >  struct acpi_resource_generic_register {
> > @@ -679,7 +681,10 @@ struct acpi_pci_routing_table {
> >         u32 pin;
> >         u64 address;            /* here for 64-bit alignment */
> >         u32 source_index;
> > -       char source[4];         /* pad to 64 bits so sizeof() works in all cases */
> > +       union {
> > +               char pad[4];    /* pad to 64 bits so sizeof() works in all cases */
> > +               __DECLARE_FLEX_ARRAY(char, source);
> > +       };
> >  };
> >
> >  #endif                         /* __ACRESTYP_H__ */
> > --
> 
> With this applied I get:
> 
> rafael@gratch:~/work/linux-pm/tools/power/acpi> make
>  DESCEND tools/acpidbg
>  MKDIR    include
>  CP       include
>  CC       tools/acpidbg/acpidbg.o
> In file included from
> /scratch/rafael/work/linux-pm/tools/power/acpi/include/acpi/acpi.h:27:0,
>                 from acpidbg.c:9:
> /scratch/rafael/work/linux-pm/tools/power/acpi/include/acpi/acrestyp.h:686:3:
> error: expected specif
> ier-qualifier-list before ‘__DECLARE_FLEX_ARRAY’
>   __DECLARE_FLEX_ARRAY(char, source);
>   ^~~~~~~~~~~~~~~~~~~~
> make[1]: *** [../../Makefile.rules:25:
> /scratch/rafael/work/linux-pm/tools/power/acpi/tools/acpidbg/
> acpidbg.o] Error 1
> make: *** [Makefile:18: acpidbg] Error 2
> 
> The tools build successfully without it.

I think a "make clean" is needed first? It builds for me...

-- 
Kees Cook
