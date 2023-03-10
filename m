Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799336B3C87
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCJKm1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 05:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCJKmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:42:24 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A1F5FCC;
        Fri, 10 Mar 2023 02:41:57 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id m4so3342962qvq.3;
        Fri, 10 Mar 2023 02:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678444914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArWKK4kIoJ2P09oAJ7o5KooW+KJp4qT/SfAsM2P6J9E=;
        b=oIt+4vccCh1tetH/tjaal6J6dKblGjj1BkZJeb4yZaPKNFapvShTzfRY7v0sN/ffMt
         rstzw3TuA1SA7IU8SleGFeBIYF45kRGpKVMzT3M6P1qtXbDmGs57G+z3TpLUNoK0eh8Z
         P8/3A7EAWKEsrbdsE0VnLPy0sW+C79iWjVB66+3FPA1jcjPshv0xfSr9IiLDlVrcJYsR
         l5CPMDvTWbDBl4GMBrJQFrDmnntzS1QAi3kamfr9OpC2vt8BYgStOjx+RKZsdSlwfUYY
         q+IYqvxQHd7Bjy3O2UfKUEmDs34/y4BtOVNP2CX+S0Knv2+19USlfEWis1bcRr1plZek
         BNGg==
X-Gm-Message-State: AO0yUKXAHoTYVF5IEBi5Zg9AHpchQ1f+MfnJdCmKLKFXmPUnvXiaaQbQ
        MX1NhghNNNKgwBSwZvRE04pKHdmi4YzCtA==
X-Google-Smtp-Source: AK7set/GtL7xqKMU2ZaFLyKTUQ6Pk2VxIKiSgfMEYQt1fO3qQSqzrn91eYXDYz8rpiyNq7GHv15aBA==
X-Received: by 2002:a05:6214:250e:b0:56e:bdfb:f4c5 with SMTP id gf14-20020a056214250e00b0056ebdfbf4c5mr17094238qvb.36.1678444914398;
        Fri, 10 Mar 2023 02:41:54 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a048b00b007339c5114a9sm1056949qkr.103.2023.03.10.02.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:41:53 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id e194so4823076ybf.1;
        Fri, 10 Mar 2023 02:41:53 -0800 (PST)
X-Received: by 2002:a05:6902:208:b0:a98:bd27:91de with SMTP id
 j8-20020a056902020800b00a98bd2791demr15376283ybs.7.1678444913472; Fri, 10 Mar
 2023 02:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdX3OHuq15m=g56faaU6EySYeKmRvbmJdty1xZ6JOu-yzg@mail.gmail.com>
In-Reply-To: <CAMuHMdX3OHuq15m=g56faaU6EySYeKmRvbmJdty1xZ6JOu-yzg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Mar 2023 11:41:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVB13VX32Qi3Y5pTWA1j6yODFohrNArhRvdVUQX085sWw@mail.gmail.com>
Message-ID: <CAMuHMdVB13VX32Qi3Y5pTWA1j6yODFohrNArhRvdVUQX085sWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Share RZ/G2L SoC DTSI with RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Feb 13, 2023 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Jan 31, 2023 at 11:42 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > This series aims to reuse RZ/G2L SoC DTSI with RZ/V2L as both the SoCs are
> > almost identical.
> >
> > v1 -> v2
> > * Patch 1/2 unchanged, for patch 2/2 sorted the nodes based on the names.
> >
> > v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230127133909.144774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > Cheers,
> > Prabhakar
> >
> > Lad Prabhakar (2):
> >   arm64: dts: renesas: r9a07g044: Use SoC specific macro for CPG and
> >     RESET
> >   arm64: dts: renesas: r9a07g054: Reuse RZ/G2L SoC DTSI
> >
> >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi |  254 ++---
> >  arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 1149 +++-----------------
> >  2 files changed, 256 insertions(+), 1147 deletions(-)
>
> Do you have an opinion on this series?
> Is this acceptable for you?
> The final generated DTBs are identical to before.

Given the feedback from Krzysztof and Rob on patch 1, and on IRC,
I'm rejecting this series.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
