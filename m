Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245635BEEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiITUwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiITUwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:52:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC552FDA;
        Tue, 20 Sep 2022 13:52:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l14so9109619eja.7;
        Tue, 20 Sep 2022 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KmHiTHNMTP8biWsAP8daQYj5OY7BVwVRM9tvvWtd+NA=;
        b=bGz7v3TaL9xqwNaEzzhpRePNJl3nR2v8fyy/tdpfj8ORs8A+tKuV2ErqZkEXznE4zE
         +KE1X/eI3TP2EtvYb5jzlnwfEDi/0wI2sFh64PIGZiKE8rSfv5J+CNfRZvpHPkwTvJmw
         sB3PUgynTa0cuRCC0zcyM0msRKssfEEA+QhMkZDvdKisHGwoKTuZLJKoyc/aefYF1E50
         tvDpXFQ+0Xvb+EvZ6zm3eJxS6/p5OUzjUqNHta4yxPnstaHc5B518gi42G9L5mGSzK51
         U+uO4xxRqLtpJNEGBu6MHxaoPsLKc3va1Qu/ipdlM3Hp2do0Au8MD7fMVq6tjSoaHnUX
         YfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KmHiTHNMTP8biWsAP8daQYj5OY7BVwVRM9tvvWtd+NA=;
        b=oAzR4A6K/zrGY4r1HA78a4AZ9GDtmAgFPhIXu+bmVrcNrFnhYp32tQul+yCrzBTm2n
         eeQfusi2vNXIkXbxDdLR3TH3KYR6zGnd1OlRMPeQtAkRG6StfDqaVeoQ1tYwH0k+/ZUm
         16jpbjB4Jg1RpjaIr/BW2d3ELf2kE+1wSK8GIbvmFnmh5myqazFDKhasidNWOy3g8W+8
         jHJpY0+zA2ksOpoUld2totaCN3sIGUMGgFqUbLiaWxoCz8ATMo02tekbXjPxsf7rL17F
         0UweRJy0fet2qHFHmkXbQSZDfZmIcVWkKQdMR1ZXS147aXmgxXlngbahfuF30kWP2hMS
         JNXg==
X-Gm-Message-State: ACrzQf0mY/XvElueBcMw0JHCWnd5whYaeNdVfVBpmGcvngVyd6uNBntW
        pBXr76dEbwSJRRkqVWKgL+bQEFNrCuwnTqoOEbY=
X-Google-Smtp-Source: AMsMyM6Urbztzi3kgvmdlXK/pPcCUmXSDTtGMUd+8QRzEyTzqJlbCLQ+Xv/h1Fp5zCLZ+Wv/N+Z0CaoNNcKWWwG+LIM=
X-Received: by 2002:a17:907:2c41:b0:77d:8aed:cf7c with SMTP id
 hf1-20020a1709072c4100b0077d8aedcf7cmr18383110ejc.447.1663707128951; Tue, 20
 Sep 2022 13:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220920184904.90495-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922AFDAFE3DEBBFFF875875864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59224D591B8A227A5655ECDE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59224D591B8A227A5655ECDE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 20 Sep 2022 21:51:42 +0100
Message-ID: <CA+V-a8s-6FLu-5D44-Szt8eN1V0rhPxm+cO4OrcKmT90O8LoXg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] riscv: dts: r9a07g043: Add placeholder nodes
To:     Biju Das <biju.das.jz@bp.renesas.com>
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
        Atish Patra <atishp@rivosinc.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Biju,

On Tue, Sep 20, 2022 at 8:26 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
>
> Just ignore my mail, As I realised IRQ property in each node will be a problem.
>
Yes the IRQ numbers are different (offset of 32) along with the IRQ parent.

Refer this thread [0] where other SoC vendors have similar issues,
maybe in future when DTC becomes more clever we can use single SoC
DTSI for both.

[0] https://lore.kernel.org/lkml/CAMuHMdUMM9H4jLJ8-zOz9SXoqmK-s4zRWzGCsU8jt_sDgY1h+Q@mail.gmail.com/

Cheers,
Prabhakar
