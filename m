Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6003D66BB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjAPKBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAPKAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:00:49 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17537A5D4;
        Mon, 16 Jan 2023 02:00:48 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id qb7so19259374qvb.5;
        Mon, 16 Jan 2023 02:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcfbiaOtd0rIUu3J0LzMQ7r+7EcuQP5IsDRStK58JTY=;
        b=Iw+E2l7iP+BBT8wRY6KgUlaJY+XOp81ebji0YGTQl0mfalLqk8KwdJH/d4pLncKqtJ
         y7I1g+kIcwfV5SRNRr99uL6HX4rfWdDoHawXeeUShcqBPugheTY+yc+BpLVKvszGo3j7
         FBaecPSOf17aKObAFZ8+trpHDKjtMBWIGSQYFeAm0J7aFndDMbsTPd20s1EsKvs52dLQ
         FZuMmDD/eWn9xeXJeKO6l97CWw5XGO6MN8JAENZZb39tEsWKkIMAIhFmkTVd/UP+3C+v
         LU1gHqwWZmZyTVa9ajp81qJFoYuKkURzSnoXXGP6mKuJzlYde1wRQQZZwsbnALZP6TVE
         gZwQ==
X-Gm-Message-State: AFqh2kqbRoHXRslXHqm+0ZvAGJVODn7P3DztMINdEfkYbY5h0sFOYr5X
        vLxwZY9qiX70ef99uheXcIMU7QiqujjkYA==
X-Google-Smtp-Source: AMrXdXuiuftiU4iE277WG3SmWjPXImBlsWEUzPQF8WNXLe8Y4WX4/6CWP8AJZgR2D+F1RJx2UMKg6A==
X-Received: by 2002:a0c:fb44:0:b0:532:21bf:bb41 with SMTP id b4-20020a0cfb44000000b0053221bfbb41mr46054145qvq.18.1673863246977;
        Mon, 16 Jan 2023 02:00:46 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006fbaf9c1b70sm2819430qko.133.2023.01.16.02.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:00:46 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id d62so13502101ybh.8;
        Mon, 16 Jan 2023 02:00:45 -0800 (PST)
X-Received: by 2002:a25:46c6:0:b0:7b8:a0b8:f7ec with SMTP id
 t189-20020a2546c6000000b007b8a0b8f7ecmr4703291yba.36.1673863245804; Mon, 16
 Jan 2023 02:00:45 -0800 (PST)
MIME-Version: 1.0
References: <Y7P9IcR7/jgYWMcq@osiris> <20230105095426.2163354-1-andrzej.hajda@intel.com>
In-Reply-To: <20230105095426.2163354-1-andrzej.hajda@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jan 2023 11:00:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUhPjya8zWMxEN8U8pjf4M2u_+HOfxQ2NP1XOcX9EpAKg@mail.gmail.com>
Message-ID: <CAMuHMdUhPjya8zWMxEN8U8pjf4M2u_+HOfxQ2NP1XOcX9EpAKg@mail.gmail.com>
Subject: Re: [PATCH v4] arch: rename all internal names __xchg to __arch_xchg
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 10:54 AM Andrzej Hajda <andrzej.hajda@intel.com> wrote:
> __xchg will be used for non-atomic xchg macro.
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: squashed all arch patches into one
> v3: fixed alpha/xchg_local, thx to lkp@intel.com
> v4: adjusted indentation (Heiko)

>  arch/m68k/include/asm/cmpxchg.h      |  6 +++---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
