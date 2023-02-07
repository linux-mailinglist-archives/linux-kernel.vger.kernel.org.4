Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB3D68DE7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjBGRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjBGRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:06:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456303C282
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:06:03 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id r17so1915918pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a7s5BdNztvH3Hr3AKRFoBTusAbY6jn+uBzEZI75Vbrg=;
        b=agPD4pmg6rcj6WLSj5/G5hNCDdxsdTXDPVEYm//Gk5Sn3KbH7pAQEUq4uUJokFOJQD
         KyY1RkmsM4cVU6bQ6vn7IvEx8+J0TaT9DJXEU4tCWEv2g8rqPl5y+6eOM1X3azDi5QTk
         /IflrOnLIzyerBkoWnKmWQVxzdW6vTFV2LyLSsOAzVHd20/k9ARqO4Akm6Wxc78kZ4Ce
         FxuLuSNhiSgpk6Ih9AK915xIfVl1DnVnt0FPXMTIhJTgKwGKGxy1VKr4Kxqggn2OlTHO
         DfTvpvJa6Td/ilzozxVlOIKNe9vR72GbT3Vmb2Hatyli4gOcDz3bD1ghS6GX/XMEN7Ra
         lQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7s5BdNztvH3Hr3AKRFoBTusAbY6jn+uBzEZI75Vbrg=;
        b=X/tQdcr3FiMKzytjtSIS1Dh1ef1MBo6vFplT/5jlxHI9qpq137cGwQ4vGDCHrUYnkD
         mR0f09G5ryYK4fBsEMj1ATdZX+IIts4Y08vA+h6KjwJefATfBfJHQkktawcXTzSK7fcb
         solX49JV6p3FK6lJBotAaHqcStNlUPvuHd6y9aySjga3zlxhSLpeJlpoyGXDd87ze3Ht
         VxS+c+9hmyPSn/92XVzh4bnUSFIFwM0t307Ew2ByAAFjwiLvrTdwkfhGOqrmqobb1Yza
         RLrERd6mag6d0XxFVT/kAHe8RDJw16ZaU+zeEy+dDnos8pOvVftuz/yaCBpSHzDvI7CN
         W5dA==
X-Gm-Message-State: AO0yUKWD0o/8h2ssVUN+6b+zrxK0+JYSBZTI0Y8vXM6AmFkmFVRXmqWQ
        IUf0pWxmfeSlXgbZErJTF7FF1N0ZuCNCI3Dehznf9XTjLT1C20GzyYI=
X-Google-Smtp-Source: AK7set8WIdI9JnR5RiwV9Cup3dXh9uTQc9QthQ9jdnKWuNs4yR+YhHtNKNPtWhFUjJpmdO1N3gSsJfD9yjB1Z+KReTg=
X-Received: by 2002:a62:1bc2:0:b0:593:b16e:52b9 with SMTP id
 b185-20020a621bc2000000b00593b16e52b9mr946010pfb.17.1675789562352; Tue, 07
 Feb 2023 09:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20230206142714.4151047-1-liumartin@google.com> <CAL_JsqKA8pBess-zLA_2n0p8q=NBuY0EGA7qALKabwJA8ZRwrA@mail.gmail.com>
In-Reply-To: <CAL_JsqKA8pBess-zLA_2n0p8q=NBuY0EGA7qALKabwJA8ZRwrA@mail.gmail.com>
From:   Martin Liu <liumartin@google.com>
Date:   Wed, 8 Feb 2023 01:05:25 +0800
Message-ID: <CAASV4h5ANYTJUN3gQxuLxeKMknyoyt7-YTxRRMcjrQXRrVRi5Q@mail.gmail.com>
Subject: Re: [PATCH] of: reserved-mem: expose reserved-mem details via debugfs
To:     Rob Herring <robh+dt@kernel.org>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, surenb@google.com,
        minchan@kernel.org, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 11:12 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Feb 6, 2023 at 8:27 AM Martin Liu <liumartin@google.com> wrote:
> >
> > It's important to know reserved-mem information in mobile world
> > since reserved memory via device tree keeps increased in platform
> > (e.g., 45% in our platform). Therefore, it's crucial to know the
> > reserved memory sizes breakdown for the memory accounting.
> >
> > This patch shows the reserved memory breakdown under debugfs to
> > make them visible.
> >
> > Below is an example output:
> > cat $debugfs/reserved_mem/show
> > 0x00000009fc400000..0x00000009ffffffff (   61440 KB )   map     reusable test1
> > 0x00000009f9000000..0x00000009fc3fffff (   53248 KB )   map     reusable test2
> > 0x00000000ffdf0000..0x00000000ffffffff (    2112 KB )   map non-reusable test3
> > 0x00000009f6000000..0x00000009f8ffffff (   49152 KB )   map     reusable test4
> > ...
> > 0x00000000fd902000..0x00000000fd909fff (      32 KB ) nomap non-reusable test38
> > 0x00000000fd90a000..0x00000000fd90bfff (       8 KB ) nomap non-reusable test39
> > Total 39 regions, 1446140 KB
>
> This information is pretty much static, why not just print it during
> boot? It's also just spitting out information that's straight from the
> DT which is also available to userspace (flattened and unflattened).

IIUC, for dynamic allocation cases, we can't get actual allocation layout
from DT.  Also, there could be some adjustment from memblock
(ex. alignment). Therefore, printing it out from the reserved_mem would
be more clear.

However, as you mentioned, once the allocation is done, it should be pretty
static. Thus, printing it during boot should be reasonable. If so, we
could print
them out in fdt_init_reserved_mem() like below. Is my understanding correct?
Thanks :)

@@ -285,6 +285,14 @@ void __init fdt_init_reserved_mem(void)
                                else
                                        memblock_phys_free(rmem->base,
                                                           rmem->size);
+                       } else {
+                               phys_addr_t end = rmem->base + rmem->size - 1;
+                               bool reusable =
(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+                               pr_debug("init reserved node: %pa..%pa
( %lu KB) %s %s %s\n",
+                                        &rmem->base, &end, (unsigned
long)(rmem->size / SZ_1K),
+                                        nomap ? "nomap" : "map",
+                                        reusable ? "reusable" : "non-reusable",
+                                        rmem->name ? rmem->name : "unknown");
                        }
                }
        }
>
> Is there not something in memblock that provides the same info in a
> firmware agnostic way?

memblock doesn't save request's name so we couldn't count for the
memory owner.
>
>
> > Signed-off-by: Martin Liu <liumartin@google.com>
> > ---
> >  drivers/of/of_reserved_mem.c | 39 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > index 65f3b02a0e4e..a73228e07c8c 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/kmemleak.h>
> >  #include <linux/cma.h>
> > +#include <linux/debugfs.h>
> >
> >  #include "of_private.h"
> >
> > @@ -446,3 +447,41 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
> >         return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
> > +
> > +#if defined(CONFIG_DEBUG_FS)
> > +static int of_reserved_mem_debug_show(struct seq_file *m, void *private)
> > +{
> > +       unsigned int i;
> > +       size_t sum = 0;
> > +
> > +       for (i = 0; i < reserved_mem_count; i++) {
> > +               const struct reserved_mem *rmem = &reserved_mem[i];
> > +               unsigned long node = rmem->fdt_node;
> > +               phys_addr_t end = rmem->base + rmem->size - 1;
> > +               bool nomap = (of_get_flat_dt_prop(node, "no-map", NULL)) != NULL;
> > +               bool reusable = (of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
>
> There is no reason to read the flat DT at this point in time after we
> have an unflattened tree.

Ack.
>
> > +
> > +               sum += rmem->size;
> > +               seq_printf(m, "%pa..%pa ( %7lu KB ) %5s %12s %s\n", &rmem->base,
> > +                          &end, rmem->size / 1024,
> > +                          nomap ? "nomap" : "map",
> > +                          reusable ? "reusable" : "non-reusable",
> > +                          rmem->name ? rmem->name : "unknown");
> > +       }
> > +       seq_printf(m, "Total %d regions, %zu KB\n",
> > +                  reserved_mem_count,
> > +                  sum / 1024);
> > +       return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(of_reserved_mem_debug);
> > +
> > +static int __init of_reserved_mem_init_debugfs(void)
> > +{
> > +       struct dentry *root = debugfs_create_dir("reserved_mem", NULL);
> > +
> > +       debugfs_create_file("show", 0444, root,
> > +                           NULL, &of_reserved_mem_debug_fops);
> > +       return 0;
> > +}
> > +device_initcall(of_reserved_mem_init_debugfs);
>
> We already have a DT init hook, don't add another random one. Plus,
> why does this need to be an early device_initcall?

Got it. As we could print them during boot, we probably don't need this. Thanks.
>
> Rob
