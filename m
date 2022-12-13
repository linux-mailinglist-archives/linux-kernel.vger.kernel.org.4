Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161564B589
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiLMM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiLMM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:57:00 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD40E1CFE4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:56:57 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so2339969ooi.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zg6I1Rrlyh+xThqvnqNkyosSyJGrep07JtoqWe7Q9Ns=;
        b=RQdoSyaXQBbJe77r8scKfP7h+opt43/yGYxksBv4HQcY930Z4qdFgJIeqF40B21Nd6
         N1imK31IGnule2mm+03v6j5Vg2QGY+bVnqDVyTMKIeewYfUtmorYQnQRcrq8NiFX5T65
         sL/TGM1csOoeFhLShReRKhXu8yqwu8UKbB5sT1U3bnhNqz9FhyS5HH4OUIL54qYxLSP5
         jg+ELhFvCsYKsb/NLSye2Bl7yYGFo9AEYE/ToVXc3OQn1/Jx2Ky0nExku9qXRGdEn2Q1
         qX3WfBMNQQ/WtMfmETOaE4jALxoNnLbPN7aIxyq/KX6ex7/G1BmGE1Y/ERQ4oB0qVzQE
         hLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zg6I1Rrlyh+xThqvnqNkyosSyJGrep07JtoqWe7Q9Ns=;
        b=JKzdu4zdi/OJH/LGhYJO8F7bGPytT8xReFmefvWPnrZ5BjsdYwg1FngCQg9Pxrqbx6
         RSZKAVO++VTWMhLYjoJhvtS27RuFM2TwM538o6MWDmbQqcdgFDVSm8mQlNiqRnRxDczG
         ylMq7WpyMbtqv/Yud5d/VSIGaEYhfOiwtckd+Pn4VDeNfGXu4jIO1dPOveX+jg10Muye
         XAsZNW9J1qnrCia1dApb2FWyHj9BJUXLvrt917yPXnlmAxBg0zb1GBZW9heKkz/O8PFx
         X8vphA4SdQznqDVjKqXh8j5DKvZL4673/deNqQtbBpLSFhyhoBkDmXC2rkdupP9UtSmf
         A7Cw==
X-Gm-Message-State: ANoB5plU1XKvlde8Wc1OrexnqBgt9/jJfI9JuXr6D5HticxAw4PUWeL/
        KUDLqLk8g/3b95QF832YSb4=
X-Google-Smtp-Source: AA0mqf53XdMxmTbGmOVmS9yQH3TZR0OyW+tNRyWMtaMmlHE4jblQgmNPrdvP6/Hzp8LXHJIooz4khg==
X-Received: by 2002:a4a:37cb:0:b0:4a3:c0bd:5dbe with SMTP id r194-20020a4a37cb000000b004a3c0bd5dbemr8913142oor.2.1670936217141;
        Tue, 13 Dec 2022 04:56:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j2-20020a4a9442000000b004a083b965f3sm1108799ooi.29.2022.12.13.04.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:56:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Dec 2022 04:56:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to e240e53ae0ab ("mm, slub: add
 CONFIG_SLUB_TINY")
Message-ID: <20221213125655.GA3622514@roeck-us.net>
References: <Y5hTTGf/RA2kpqOF@debian>
 <CADVatmM4Xr7gKqkeNX90KjmhB-E6H8rSfsK_E+42wp8OmALbDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmM4Xr7gKqkeNX90KjmhB-E6H8rSfsK_E+42wp8OmALbDw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:39:30AM +0000, Sudip Mukherjee wrote:
> On Tue, 13 Dec 2022 at 10:26, Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi All,
> >
> > The latest mainline kernel branch fails to build xtensa allmodconfig
> > with gcc-11 with the error:
> 
> And, also powerpc allmodconfig with the error:
> 

Plus arm:allmodconfig, with gcc 11.3.

In file included from include/linux/string.h:253,
                 from include/linux/bitmap.h:11,
                 from include/linux/cpumask.h:12,
                 from include/linux/mm_types_task.h:14,
                 from include/linux/mm_types.h:5,
                 from include/linux/buildid.h:5,
                 from include/linux/module.h:14,
                 from drivers/crypto/caam/compat.h:10,
                 from drivers/crypto/caam/key_gen.c:8:
drivers/crypto/caam/desc_constr.h: In function 'append_data.constprop':
include/linux/fortify-string.h:57:33: error: argument 2 null where non-null expected [-Werror=nonnull]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
include/linux/fortify-string.h:469:9: note: in expansion of macro '__underlying_memcpy'
  469 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
include/linux/fortify-string.h:514:26: note: in expansion of macro '__fortify_memcpy_chk'
  514 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/crypto/caam/desc_constr.h:167:17: note: in expansion of macro 'memcpy'
  167 |                 memcpy(offset, data, len);
      |                 ^~~~~~
include/linux/fortify-string.h:57:33: note: in a call to built-in function '__builtin_memcpy'
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
include/linux/fortify-string.h:469:9: note: in expansion of macro '__underlying_memcpy'
  469 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
include/linux/fortify-string.h:514:26: note: in expansion of macro '__fortify_memcpy_chk'
  514 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/crypto/caam/desc_constr.h:167:17: note: in expansion of macro 'memcpy'
  167 |                 memcpy(offset, data, len);

Guenter
