Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6AD67EEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjA0T6q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Jan 2023 14:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjA0T62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:58:28 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC86ACB6;
        Fri, 27 Jan 2023 11:56:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id v6so16567690ejg.6;
        Fri, 27 Jan 2023 11:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6wwNzY9Gy+/3kYmun+0BUOC04wBgLJ62yyheIaBjak=;
        b=MLwJnz5/hvd7InZHvpMdNMdI0W4M2KaQZFBozyfPba5IulU94MBl8Gkt+SesR7x4Xn
         0T7nSUyapTZxTkHd/dDILOhFbS5c4tX7Gzra6eLdQqaurJFcCjOguYPWPNVIMKkXKyil
         l+7CcJkZ1l4t7XZLX/SGf7UDNQbYA5aDuTSmCKF1akeLdWVmvgouoYqsDKsU/qBcNAjZ
         40tdRDcs4HWltyc8A1qRu/WZNq3VSAKY0SfNOtLdN3umUG6s/f/3KGd9vjbXrqHnImXF
         DFBqYgDM40UhIT/VIn8c5prvn0oL2NYY0B6wNIgRP0CixM3KR6Yi2o3znk/dDBC9JTF6
         0jcA==
X-Gm-Message-State: AFqh2krbYixWCB5mH0dNNJdVc+p0rsCZr9PQf9zviq1za7IPoXimwAZ0
        3bhtN/WR2YPMjyXuFNkm6m69NdT88DQ3kfBJqVU=
X-Google-Smtp-Source: AMrXdXuGBUxl17CbQphT92m7PgPfmV0Zv4z35BMaCNMv5Z7PNBczayF+XMnTk/vGVudQ2iV572plL2PZXTma8OtosMA=
X-Received: by 2002:a17:906:70d2:b0:844:44e0:1c4e with SMTP id
 g18-20020a17090670d200b0084444e01c4emr6326919ejk.291.1674849081344; Fri, 27
 Jan 2023 11:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20230127191621.gonna.262-kees@kernel.org> <CAJZ5v0iV5wK4gsoadmWOyof_vzaAOx8oX0DJu+1-bCQNdNJtBQ@mail.gmail.com>
 <202301271146.7DC8CAE113@keescook>
In-Reply-To: <202301271146.7DC8CAE113@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Jan 2023 20:51:10 +0100
Message-ID: <CAJZ5v0g9UjZ0AaPy6MeaE06Z39zqJkZ0C4chizyauFtMsdEaVQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Replace fake flexible arrays with flexible
 array members
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 8:47 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 27, 2023 at 08:43:05PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Jan 27, 2023 at 8:16 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > One-element arrays (and multi-element arrays being treated as
> > > dynamically sized) are deprecated[1] and are being replaced with
> > > flexible array members in support of the ongoing efforts to tighten the
> > > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> > >
> > > Replace one-element array with flexible-array member in struct
> > > acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> > > padding in a union with a flexible-array member in struct
> > > acpi_pci_routing_table.
> > >
> > > This results in no differences in binary output.
> > >
> > > Link: https://github.com/acpica/acpica/pull/813
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > > v2: include stddef.h and switch to __DECLARE_FLEX_ARRAY()
> > > v1: https://lore.kernel.org/lkml/20221118181538.never.225-kees@kernel.org/
> > > ---
> > >  include/acpi/acrestyp.h | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
> > > index a7fb8ddb3dc6..250046a7c870 100644
> > > --- a/include/acpi/acrestyp.h
> > > +++ b/include/acpi/acrestyp.h
> > > @@ -10,6 +10,8 @@
> > >  #ifndef __ACRESTYP_H__
> > >  #define __ACRESTYP_H__
> > >
> > > +#include <linux/stddef.h>
> > > +
> > >  /*
> > >   * Definitions for Resource Attributes
> > >   */
> > > @@ -332,7 +334,7 @@ struct acpi_resource_extended_irq {
> > >         u8 wake_capable;
> > >         u8 interrupt_count;
> > >         struct acpi_resource_source resource_source;
> > > -       u32 interrupts[1];
> > > +       u32 interrupts[];
> > >  };
> > >
> > >  struct acpi_resource_generic_register {
> > > @@ -679,7 +681,10 @@ struct acpi_pci_routing_table {
> > >         u32 pin;
> > >         u64 address;            /* here for 64-bit alignment */
> > >         u32 source_index;
> > > -       char source[4];         /* pad to 64 bits so sizeof() works in all cases */
> > > +       union {
> > > +               char pad[4];    /* pad to 64 bits so sizeof() works in all cases */
> > > +               __DECLARE_FLEX_ARRAY(char, source);
> > > +       };
> > >  };
> > >
> > >  #endif                         /* __ACRESTYP_H__ */
> > > --
> >
> > With this applied I get:
> >
> > rafael@gratch:~/work/linux-pm/tools/power/acpi> make
> >  DESCEND tools/acpidbg
> >  MKDIR    include
> >  CP       include
> >  CC       tools/acpidbg/acpidbg.o
> > In file included from
> > /scratch/rafael/work/linux-pm/tools/power/acpi/include/acpi/acpi.h:27:0,
> >                 from acpidbg.c:9:
> > /scratch/rafael/work/linux-pm/tools/power/acpi/include/acpi/acrestyp.h:686:3:
> > error: expected specif
> > ier-qualifier-list before ‘__DECLARE_FLEX_ARRAY’
> >   __DECLARE_FLEX_ARRAY(char, source);
> >   ^~~~~~~~~~~~~~~~~~~~
> > make[1]: *** [../../Makefile.rules:25:
> > /scratch/rafael/work/linux-pm/tools/power/acpi/tools/acpidbg/
> > acpidbg.o] Error 1
> > make: *** [Makefile:18: acpidbg] Error 2
> >
> > The tools build successfully without it.
>
> I think a "make clean" is needed first? It builds for me...

I think that the default user space header files on this machine may
not be up to date.

I'll apply the v2, thanks!
