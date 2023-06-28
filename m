Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524317411DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjF1M6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjF1M6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:58:09 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45821FFE;
        Wed, 28 Jun 2023 05:58:07 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-77a62a84855so237979339f.1;
        Wed, 28 Jun 2023 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687957087; x=1690549087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmAJ4kybVwJdt2vlA7P+ww38r+1sb7umIggV1gZPfIc=;
        b=TH62gIf3kGj2Mt+ts7Y630wN71DXW47CEhU3g2Pwmabuz3PXytPQ+L5Z5vUmfzd6tq
         XX0K8zmrpoR4BlYFswV/u0sf4deJ+qP51K5HmjwsQUKQbe8NWmP8rAMTv/y1qvlfhswi
         7CW3NrPDN3CvIDMFcbjXS0c4nN1j+Cca6liM/YmFCe/6hiOwC9Uid2twZQmsbo66y65p
         tjEXGKewk/oH/q31S0lN7KDx2E9WT4nFBWDXkAIK4wAt9D4gmsPinno/+w3jHdTsWKvF
         sEToXu2u7v6U1qdh32oUFrXkeMs0SW64cwg0f8r8L+RH6/dqj9BC6o4rrMLkjw8XfNzl
         7dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687957087; x=1690549087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmAJ4kybVwJdt2vlA7P+ww38r+1sb7umIggV1gZPfIc=;
        b=Dsmz1dweJyMZv/X6IUyqHL4jBX5NK+W3t07y0N+Hn+sZYeK5z4vFCecnBrAActMgdi
         N/MrAVMj9ZEzaTvTx0+8m9D7I/v9ktsJhvp9vnAlMUuqUQrSRW6nYkp41k2mWK1xAiSE
         Dn5HY4HxPjFM/bA3wo8kbOex2ZkyAYHqbsHbZxdLYhONLl2lD0Nc0sy1yXVhTAynY7Up
         2KYo7vq/BFJiXyRZF66mgot0eNdgY0OXtEGCWeXGMLiLyhRxYUq5USJ4SNrnXDRUAMxA
         /CW36bU+XENzpeaZgKQeANaA7IES/NoagIhIlOQEMQ9rxmVc1BY9hXsAeto91qi6WWKf
         hB7g==
X-Gm-Message-State: AC+VfDyM9N8Vs3ASGn2OrCfxqwPfCqgI8XKal1pMKNRqAvvSkj1uEUAm
        Lb5AfTBXWTHqJDHkRN8q3uDbSWYuhEDX8jn+jQ8=
X-Google-Smtp-Source: ACHHUZ6wS3W3zO8LM9C9sDqMZ4ikRUkeGGgbR0c2UtDxGwWsiO7g3opU34oKoYpfnXFkZ40VN/fauhQQUj3llWYZ3Z8=
X-Received: by 2002:a6b:f203:0:b0:783:7298:55ef with SMTP id
 q3-20020a6bf203000000b00783729855efmr5556608ioh.11.1687957087169; Wed, 28 Jun
 2023 05:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230614104759.228372-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <20d4d296-14d7-467d-826c-b5c9cdf4599a@app.fastmail.com>
In-Reply-To: <20d4d296-14d7-467d-826c-b5c9cdf4599a@app.fastmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 28 Jun 2023 13:57:40 +0100
Message-ID: <CA+V-a8tMcNnx3AK69KeFaNLvgt4yhy0wKdKdjR=AvuUwZNM-RA@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the review.


On Wed, Jun 14, 2023 at 2:11=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jun 14, 2023, at 12:47, Prabhakar wrote:
>
> > +static void ax45mp_dma_cache_inv(phys_addr_t paddr, unsigned long size=
)
> > +{
> > +     unsigned long start =3D (unsigned long)phys_to_virt(paddr);
> > +     char cache_buf[2][AX45MP_CACHE_LINE_SIZE];
> > +     unsigned long end =3D start + size;
> > +     unsigned long old_start =3D start;
> > +     unsigned long old_end =3D end;
> > +     unsigned long line_size;
> > +     unsigned long flags;
> > +
> > +     if (unlikely(start =3D=3D end))
> > +             return;
> > +
> > +     line_size =3D ax45mp_priv.ax45mp_cache_line_size;
> > +
> > +     memset(&cache_buf, 0x0, sizeof(cache_buf));
> > +     start =3D start & (~(line_size - 1));
> > +     end =3D ((end + line_size - 1) & (~(line_size - 1)));
> > +
> > +     local_irq_save(flags);
> > +     if (unlikely(start !=3D old_start))
> > +             memcpy(&cache_buf[0][0], (void *)start, line_size);
> > +
> > +     if (unlikely(end !=3D old_end))
> > +             memcpy(&cache_buf[1][0], (void *)(old_end & (~(line_size =
- 1))),
> > line_size);
> > +
> > +     ax45mp_cpu_dcache_inval_range(start, end, line_size);
> > +
> > +     if (unlikely(start !=3D old_start))
> > +             memcpy((void *)start, &cache_buf[0][0], (old_start & (lin=
e_size -
> > 1)));
> > +
> > +     local_irq_restore(flags);
> > +}
>
> I'm not quite sure what this does, maybe some comments would help.
>
> This looks like a novel method of preserving partial cache lines
> at the beginning (but not the end?) of an unaligned area.
>
I missed this earlier, (I removed the preserving of cache line from
then end and left the beginning part. Samuel pointed to earlier on
these patches if the cache-line-size is 64 we dont need to do this).
Preserving cache lines is not needed at all,  Ive verified this and
just doing a _inval() is sufficient. I'll update this and send a new
version.

Cheers,
Prabhakar

> As far as I can tell, most dma_mapping implementations don't
> even try to do that at all, but the ones that do take a different
> approach by calling _wback_inv() on partial cache lines instead
> of calling _inv().
>
> I'd say this does not belong into the low-level operations
> here, especially since the ZICBOM variant doesn't do this either.
>

>       Arnd
