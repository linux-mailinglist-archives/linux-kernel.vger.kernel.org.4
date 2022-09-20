Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241555BEEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiITVEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITVEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:04:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DF6E86;
        Tue, 20 Sep 2022 14:04:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u9so9218679ejy.5;
        Tue, 20 Sep 2022 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LQKJvmVCX4rlGOfpYSKHs7yHs8plwdYfuIGRLcR33M0=;
        b=VIQDoyBGKzhGzQsobeQrVMEAFCPorZ0mbt1iKUUX8YCQ9Nm31UsWaLEhMuZkz8ZU6k
         oeQyg3z03Qd8841DMo3hnAKxYF41CS7MuNeLdFqNCF8jixRL5oSQCNJYwSKA/hDseHtU
         t09vJ1RNlqxvF0WLiAfRahLtIso5sy4QcDlr8551WQGIU08jk9hg+DGP2g2t1vMjAu9n
         v908BdOJGlAgf4SrY+EAJPOLuh48n4tWfiNf0pgEN0UUV9b5vKBaicMce8OkGdoZS3Gr
         pyIn4EgwrR4ZL2WqSMx9DHQN3lRMhl7GHvSPSStF0nLSMJTgVSUcPOEU55bw21jsE44i
         3+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LQKJvmVCX4rlGOfpYSKHs7yHs8plwdYfuIGRLcR33M0=;
        b=RxTOca8A86GMeqTOKo+OGqnTrHlKxSJsOStGJRibKBj2oFmUUbTZ8YIAy0ZsOZihWR
         FJjohID745WXlNI7/IXEoKaSkEkoM7JRG7rYQ/SiQYWw0djOYOtJRM/45wETRX8UXuQy
         r7TnUqEIH1YODiLCXSnP/AFVjUecm1mhzqwJYTdkkoedEqpZQ3MTVFKg4zi3a9w6EIx5
         f6QN2vISGkr9YO8+T9I5TOEyD4v9HGXRKixd4PudlxKpDBUVyja1dSKT+VVQfAjKULS6
         q871xcAaytN9U8IP5CJdxHL9exVRXhxEoi6VA4szPAQpMsQyioVWNtUReMaLJfBa5Non
         G1iw==
X-Gm-Message-State: ACrzQf35ucAL02Z6by6L/7LjF3qbRD5EtAyRbM2ZYSs76KzAj//aW9H+
        IxtnRZRgxnnFYQcXcss49thoULjcH/8DiC002zw=
X-Google-Smtp-Source: AMsMyM7JokOCPlBoWvkF7CKtlvIFY7k7VeHz/+DBFNANwsdIaa9+wtHP74h8vZeP8b8D2W3XEgQajMWwmTNFmvwgHGc=
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id
 ww7-20020a170907084700b0077ff489cc25mr18164724ejb.80.1663707873691; Tue, 20
 Sep 2022 14:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220920184904.90495-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <YyoOv9Jx+h0JzfX0@spud>
In-Reply-To: <YyoOv9Jx+h0JzfX0@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 20 Sep 2022 22:04:06 +0100
Message-ID: <CA+V-a8s8Nr-RUabiLA5PhHLVQQxsBPpjX_7f7ANZoGGFfOGJVQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
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

Thank you for the review.

On Tue, Sep 20, 2022 at 8:04 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Sep 20, 2022 at 07:48:59PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add ARCH_RENESAS config option to allow selecting the Renesas RISC-V SoCs.
> > We currently have the newly added RZ/Five (R9A07G043) RISC-V based SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v3 -> v4
> > * Dropped SOC_RENESAS_RZFIVE config option
> > * Dropped explicitly selecting SOC_BUS/GPIOLIB/PINCTRL configs
> >   under ARCH_RENESAS
> > * Updated commit message
> > * Dropped RB tag
> > * Used riscv instead of RISC-V in subject line
> >
> > v2 -> v3
> > * Included RB tag from Geert
> >
> > v1 -> v2
> > * No Change
> > ---
> >  arch/riscv/Kconfig.socs | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 69774bb362d6..5c420ed55ef9 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -80,4 +80,9 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >
> >  endif # SOC_CANAAN
>
> I am not asking for a respin for this since no-one likely cares, but
> I think a future goal would be to sort the file alphabetically. I'll
> probably do it with the other 30-something patches my Kconfig.socs
> rework series has got to now - but if you *are* respinning sorting
> alphabetically (ignoring the CANAAN) would reduce future churn.
>
To clarify, shall I add ARCH_RENESAS to the beginning of the file or
after the SOC_MICROCHIP_POLARFIRE config?

As rest of the configs start with SOC and for Renesas it starts with
ARCH, so to avoid another re-spin hence this query.

Cheers,
Prabhakar
