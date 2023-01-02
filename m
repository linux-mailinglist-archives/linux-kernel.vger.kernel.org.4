Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE2465AE3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjABIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjABIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:38:01 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD5FDB3;
        Mon,  2 Jan 2023 00:38:01 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id bp44so19416724qtb.0;
        Mon, 02 Jan 2023 00:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jo2CI5pKv7C2jtNLeQsFhlozXL/lFYNzin08UvE0x2c=;
        b=xbgtQV+wPHPwDIM93AuAvm6WX6cGoQ1F4KIkbImS7rbjacPg0vKFBq4dxC58yjG8Mx
         nIUSNFYwJbl7uPNcHqSDllfZYyOy06mtvncHJc0UuhGQNBQ5JczHS9Df6w48u8eZUzSp
         TniX6oFCsLk7mSKnIPEkCvDufW/Kl2ChooylfZBACcQhF3dfzfmp7XFudVJ0fgT1AW+w
         olBLlM2oz9KUSJNOvkpVgkYNYhsRNWl0SRBaEvbOMlm3vNZ6L/+v1VkCVj4yBUy2T8Fm
         06GLJ8CX/bmFj94jcWysm+KJ7cj4j1WgF9OwIub3Rqxa5Z4WDtNbYXZ7VInQqEDv3x9x
         AJgA==
X-Gm-Message-State: AFqh2kq6SDiiBGvB2sRSZkgkOpV7zzeXBk8WjBOEGdI/e7rV1FXYUmKh
        02pkriV6eTwkcy3mdezcl0xJM5Cqp8oEUA==
X-Google-Smtp-Source: AMrXdXvvdSLfHxpqthAsfcybCi8mKs5HRIENs/LRGUqFwoQGphvc9t711phFovUpA1CbhJ28EYPN5g==
X-Received: by 2002:ac8:785:0:b0:3a7:eab2:e461 with SMTP id l5-20020ac80785000000b003a7eab2e461mr42688176qth.25.1672648680473;
        Mon, 02 Jan 2023 00:38:00 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id fb25-20020a05622a481900b003a5430ee366sm15917725qtb.60.2023.01.02.00.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 00:38:00 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id e141so29641506ybh.3;
        Mon, 02 Jan 2023 00:38:00 -0800 (PST)
X-Received: by 2002:a25:d243:0:b0:702:90b4:2e24 with SMTP id
 j64-20020a25d243000000b0070290b42e24mr2730771ybg.365.1672648260480; Mon, 02
 Jan 2023 00:31:00 -0800 (PST)
MIME-Version: 1.0
References: <78b23407-bdd0-4b1b-bf6e-ecd4c00294ab@app.fastmail.com> <20221229113338.2436892-1-andrzej.hajda@intel.com>
In-Reply-To: <20221229113338.2436892-1-andrzej.hajda@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jan 2023 09:30:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaq9Xg3HrqLo1x5SCuwtJBsczLjWAWmH=23ZtNf_e9hQ@mail.gmail.com>
Message-ID: <CAMuHMdVaq9Xg3HrqLo1x5SCuwtJBsczLjWAWmH=23ZtNf_e9hQ@mail.gmail.com>
Subject: Re: [PATCH v2] arch: rename all internal names __xchg to __arch_xchg
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 12:34 PM Andrzej Hajda <andrzej.hajda@intel.com> wrote:
> __xchg will be used for non-atomic xchg macro.
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
