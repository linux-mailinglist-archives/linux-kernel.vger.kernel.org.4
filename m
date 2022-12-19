Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449AE65104F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLSQZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiLSQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:25:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9447A295;
        Mon, 19 Dec 2022 08:25:04 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id d20so13699033edn.0;
        Mon, 19 Dec 2022 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ/xV5kYQm2Hd1j/xGG28n/3bJ/6B0VUoXU4GtRHvxQ=;
        b=gRCkCjzAfQU2xDRo530vIc++qERe/p8Qa4h36hfPb032x+8B3EhQuF1VlIhvFm7yay
         Gt3angQhAw2o9dwLkK5Cmpu8Wi3i6MUfEVWdUqR1cohlACLZOOiLXNX/pt4eqnkmIdcJ
         VpPk7ifEtMfYYsU2/6IXuS2i7or0b4C4CvAQj5IB6WY6d+vcC7JKLFk0MuIuJ7GXmN2v
         eSoLeB0KL1oYwUhOQ7W5JdpkVLzJE62iHHQgVm4ezclp2R5PkYfsodKgJC+3Ddh1uzwc
         bopYe7yesuBFOVt8KYv1kcU7NRgOeaGykUbNrUrLiDlgb/vYH5m+vSXduN3Sj4gLyNr9
         qMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ/xV5kYQm2Hd1j/xGG28n/3bJ/6B0VUoXU4GtRHvxQ=;
        b=n/qyM9OAnLB0iWzIpY6bGVRwbpLRfPIZLdcUHhc7OwzchsLwSfk5ADhfMSyNXFv0qs
         5M8FIr3rB5rMjgPaMPTT3P0veBxzgXegThdioQvLBAzctjEmOYsX8zDC+pppu0446UJH
         4AlXQG6HLRVL/Z86E6fcmCsf4xmEdLNNf7OhsQk1i8pvAx3JYI7TfeXxYRJrSnDi4qRK
         n2oOHnXnexi/JR+OceluaU8czglVZM28zIW91TsuTTsN6lTN7avItTpT5cDfsLizjnZu
         4BcnCxzuUvcCwWTewdGdMl3FX7qcurcI9h4vu5uYhecpPtz9c0OG//XlWmZ5YYsSNKCc
         0afA==
X-Gm-Message-State: ANoB5pn3QzvrZBKdQp81DakBR6fsdzE4wtTE3oS2PCXYLyladYGVZh3W
        j5+AX3HLsWJs01fKCYpRq+x3b4JqFIvE+9KmSMY=
X-Google-Smtp-Source: AA0mqf7aVrHznra9kq/5XUrQB90yNi4CxyEpOTVvZ+vPVEVdi8+cSqciLRch31jkEUfirRoL6cZSo8HHHkABRgtoiNY=
X-Received: by 2002:a05:6402:2987:b0:45c:a9d3:d535 with SMTP id
 eq7-20020a056402298700b0045ca9d3d535mr41995467edb.0.1671467103114; Mon, 19
 Dec 2022 08:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y543kM4070CSDtZi@spud> <CA+V-a8ss0idLDoc+J8-Undqd+DUGrpeytenzSxV8xMs2N3dh1g@mail.gmail.com>
 <Y6CP2VhKUPZixQ8r@spud>
In-Reply-To: <Y6CP2VhKUPZixQ8r@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Dec 2022 16:24:36 +0000
Message-ID: <CA+V-a8uHREVYp1xCK-ed4j6xFw9LpV33xJg3MFdiJ5cvhneGqQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Conor,

On Mon, Dec 19, 2022 at 4:22 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Dec 19, 2022 at 11:15:17AM +0000, Lad, Prabhakar wrote:
> > > On Mon, Dec 12, 2022 at 11:55:00AM +0000, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Introduce ALTERNATIVE_3() macro.
> > > >
> > > > A vendor wants to replace an old_content, but another vendor has used
> > > > ALTERNATIVE_2() to patch its customized content at the same location.
> > > > In this case, this vendor can use macro ALTERNATIVE_3() and then replace
> > > > ALTERNATIVE_2() with ALTERNATIVE_3() to append its customized content.
> > > >
> > > > While at it update comment above ALTERNATIVE_2() macro and make it generic
> > > > so that the comment holds good for any new addition of ALTERNATIVE_X()
> > > > macros.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > > + *
> > > > + * Usage:
> > > > + *   ALTERNATIVE_x(old_content,
> > > > + *      new_content1, vendor_id1, errata_id1, CONFIG_k1,
> > > > + *      new_content2, vendor_id2, errata_id2, CONFIG_k2,
> > > > + *      ...
> > > > + *      new_contentx, vendor_idx, errata_idx, CONFIG_kx)
> > > >   */
> > > >  #define ALTERNATIVE_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,              \
> > > >                                  new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)         \
> > > >       _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,    \
> > > >                                       new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)
> > > >
> > > > +#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,              \
> > > > +                                new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,         \
> > > > +                                new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)         \
> > > > +       _ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,  \
> > > > +                                       new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,  \
> > > > +                                       new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)
> > >
> > > btw, why is this indented with spaces when the line above it is indented
> > > with tabs? (At least, that is how it appears in mutt).
> > >
> > I'll update it with spaces.
>
> The file uses tabs, so it'd be switching the spaces you added with tabs,
> right?
My bad that was a typo, I meant tabs :p

Cheers,
Prabhakar
