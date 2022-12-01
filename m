Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFB63EF7E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiLALal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiLALai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:30:38 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2225436A;
        Thu,  1 Dec 2022 03:30:37 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so3492357ejc.4;
        Thu, 01 Dec 2022 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hy0z9fn6yutvc+dvThk/Y1SdzeHn9pxlN9/eh5uO3cs=;
        b=YkIRhmkvgKI5VeByBYmm1jWJDDZCuPl51QhLM+LBFmLqimdlWo+pj+K+fPMT+zPB0F
         AMa8LRhqkrmuqzMZRiLjbwdeseLHv66UO7WSVX6vd9Tnttvwc9+vd9GREUtc8R3Y1kaM
         j/a84exSdT20BTPXJRti561tqcGWWyMI7oQxb/xrq++ienrgX3hoF1tsCa+fRtElpg5G
         a3F0Qu2FLENR/gzMY0IQyTfBWdD7Fl439e4rIMO+X9WvViIIDIRVcpyISqZJ2GBRs6GA
         Ns+gcbiqFopKXHlwt3rW8MXX1HwtL0dQ5byHH+v3+zD2nhNGRMGcvrBJ4rOPWOyUQjbm
         xlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hy0z9fn6yutvc+dvThk/Y1SdzeHn9pxlN9/eh5uO3cs=;
        b=Ozpa+/kV4xOsOtQGMFeVHTqy8XPqvf1cyo2FUoDXEfEBjSMteXEHje60cyUpfoI/0q
         r+02mifOAuQpz5c7XJW3SahAc/1nJrnTy0EtRiyF0FEk2simt2t/6H1rv/iMnRB5YZbC
         8AbOIFQaOHS/LJwdNydZ0gi990A42VPpoDjPtxJG7PREG5q4TIL9t2zAH2Uz0o20jvDP
         7+qmFeGSh27ll+SDVvo9/SbrMI7s6SYYvhlmmPuZ/WmyPuB7bkhwrFLf8BFSxEhuqYel
         IaHMqMHryGF06JMgEfo5ioZWxsXG9hONsigdeG2jeq62zIhu7PNup21qBQa3dP/cQrzc
         taVA==
X-Gm-Message-State: ANoB5plG/lz+DLvf4GfqNuqFTdfb8eD4TyfhC4SBSfs8cGhPUQdUovRz
        Sm9H5IKfztpI83hwwLTu+8n2sUoiYroXZpPO6V0=
X-Google-Smtp-Source: AA0mqf7/0JyuhpFTobymLKciVFxPGTz54M/o8dTWiasg+0bDb9chiSoyVVDommRlVqB41SoDJUohNZGrny6505ZBHmM=
X-Received: by 2002:a17:906:79c4:b0:778:e3e2:8311 with SMTP id
 m4-20020a17090679c400b00778e3e28311mr42171491ejo.342.1669894234898; Thu, 01
 Dec 2022 03:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <bf8e33fd-a752-d5d5-859e-14302d069f2d@sholland.org> <CA+V-a8sz4i_wenTyA5tVTVB8dQWLmuXCf3CGYOPC+C07GJ8WTw@mail.gmail.com>
 <565e1861-7052-9bd3-e7ba-e590bd91cf20@sholland.org>
In-Reply-To: <565e1861-7052-9bd3-e7ba-e590bd91cf20@sholland.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 1 Dec 2022 11:30:08 +0000
Message-ID: <CA+V-a8uuAqrtVEB1GqFicQjRvkPGpG5788oNSzCp1LNyoUNmXQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five SoC
To:     Samuel Holland <samuel@sholland.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Tue, Nov 29, 2022 at 5:58 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 11/26/22 15:09, Lad, Prabhakar wrote:
> >>> +     if (!ax45mp_priv->l2c_base) {
> >>> +             ret = -ENOMEM;
> >>> +             goto l2c_err;
> >>> +     }
> >>> +
> >>> +     ret = ax45mp_configure_l2_cache(np);
> >>> +     if (ret)
> >>> +             goto l2c_err;
> >>> +
> >>> +     ret = ax45mp_configure_pma_regions(np);
> >>> +     if (ret)
> >>> +             goto l2c_err;
> >>> +
> >>> +     static_branch_disable(&ax45mp_l2c_configured);
> >>
> >> Instead of enabling this before the probe function, and disabling it
> >> afterward, just enable it once here, in the success case. Then you can
> >> drop the !ax45mp_priv check in the functions above.
> >>
> > I think I had tried it but static_branch_unlikely() was always returning true.
>
> You use DEFINE_STATIC_KEY_FALSE above, so static_branch_unlikely()
> should return false until you call static_branch_enable().
>
OK, got that.

> >> And none of the functions would get called anyway if the alternative is
> >> not applied. I suppose it's not possible to do some of this probe logic
> >> in the alternative check function?
> >>
> > you mean to check in the vendor errata patch function to see if this
> > driver has probed?
>
> I meant to do the equivalent of:
>
> +     ax45mp_priv->ucctl_ok = ax45mp_cpu_cache_controlable();
> +     ax45mp_priv->l2cache_enabled = ax45mp_cpu_l2c_ctl_status() &
> AX45MP_L2_CACHE_CTL_CEN_MASK;
>
> in the errata function, since that decides if the cache maintenance
> functions actually do anything. But ax45mp_cpu_l2c_ctl_status() gets the
> MMIO address from the DT, and trying to do that from the errata function
> could get ugly, so maybe it is not a good suggestion.
>
Actually I did think about this and the best approach is to do it in
errata only as you suggested. So here's my approach for dropping the
above checks is to introduce vendor specific SBI EXT
(RZFIVE_SBI_EXT_IOCP_SW_WORKAROUND) which will check both the above
conditions and only apply the errata on success and hence avoid the
"if" checks every time in the sync operation.

Cheers,
Prabhakar
