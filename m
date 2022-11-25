Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C346D6386F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKYKDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiKYKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:02:50 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD3625C61;
        Fri, 25 Nov 2022 02:02:49 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s5so5660372edc.12;
        Fri, 25 Nov 2022 02:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHVG/ftyLvsI2SLH3rhoCHZquoZnr7zU2xMaBrAelgg=;
        b=nBSz6UY3qO3u7pzvCu/9sA4R5b3f0sCG0JEJ6y5sDJmo4jOuZljZSY5Kx85GcQBqUH
         u7+e9RK1KwZnZHpTcDlT9gYxMmCQL2AfWK/E5W4fh98OKTdQEpPPCjGQg035INwJVfnZ
         jukZLROa1+QwmCyRT8jtBdW8sfUBvhYjVwdA/ghxCPDp8stJxjhLb8n8/h9GyIARHNqv
         syA/KbDn+Oxd57kaAbwCdPZaJhklrLgy4mtczKkR3d1R67fIjJVMsctbq5wcomOqnblG
         FpSCcjWxeUtKlvLSNpJyt7YzfT9S42QEdDeKtBmAmZTVpxiBrcWvho5guuA1hauRwJwR
         f75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHVG/ftyLvsI2SLH3rhoCHZquoZnr7zU2xMaBrAelgg=;
        b=8ByzG+Z1QeXoMaxd2C+MrFj6ECffwwLry48VXFx8qvi1KeeH6UgP+p8X2SoNfpsEzg
         fK5uaHW5ytlNWcNbTX4CnlaqxnriL5sI4L0ZreXJbCp+Z0HEu12pQNfwzgkHD10Ls2A/
         o1ry6YdzLfxuQsDYDf79HdPV26VoU4c2At/A4dtT8bjCTufbN6O4VWpCY78tn+LRSkA4
         a04KGY0JcaKxzngo2HWOyjGUSauUhTFTuSKy+H8vENgT7qCKaWKA/ucSvR+mfEOyL8BP
         gKA1c1Nuzc0dMnlSWgTE+k8TskG2x90ELzt5oJbDRBbYecmkRdbC+xBiYw4DGwd8aqoQ
         AnUg==
X-Gm-Message-State: ANoB5pkSZ+kq3QJIV4xXc8Z2NkHHXockx7DQvMZ2ecB89WIKTOLs7oxZ
        6h7roCL5UR/709f6Aorz/Vl6aH3CmDjaSYVhzno=
X-Google-Smtp-Source: AA0mqf6qdSUyHdl8QC7NBwyDgjeso78W0GVOCIlAOjzRLR1Pa8cTfhmrPWjNmHdP97HIJya+K4baeTLeV83DY1C7pMo=
X-Received: by 2002:a05:6402:2987:b0:45c:a9d3:d535 with SMTP id
 eq7-20020a056402298700b0045ca9d3d535mr33749986edb.0.1669370568259; Fri, 25
 Nov 2022 02:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3/LgZkR1hkblJ8D@spud> <4801607.MHq7AAxBmi@diego>
In-Reply-To: <4801607.MHq7AAxBmi@diego>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 10:02:21 +0000
Message-ID: <CA+V-a8sT8VxpeM=eBgmDeojOka-LDmvP4JkhVfEDKi3D3VOsmw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Thu, Nov 24, 2022 at 7:58 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 24. November 2022, 20:52:33 CET schrieb Conor Dooley:
> > On Thu, Nov 24, 2022 at 05:22:01PM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Introduce ALTERNATIVE_3() macro.
> >
> > Bit perfunctory I think! There's a lovely comment down below that would
> > make for a better commit message if you were to yoink it.
> > Content looks about what I'd expect to see though.
>
> Also both the comment on the original ALTERNATIVE_2 and the new ALTERNATI=
VE_3
> should probably be merged into a single comment explaining this once for =
all
> ALTERNATIVE_x variants.
>
> Especially with the dma stuff, I'm pretty sure we'll get at least an ALTE=
RNATIVE_4
> if not even more ;-) . So we defnitly don't want to repeat this multiple =
times.
>
Do agree. How about the below?

/*
 * Similar to what ALTERNATIVE_2() macro does but with an additional
 * vendor content.
 */

So the other ALTERNATIVE_2+() macros will keep on building on it.

Cheers,
Prabhakar
