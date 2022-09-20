Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48C05BE540
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiITMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiITMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:08:39 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0849A66110;
        Tue, 20 Sep 2022 05:08:38 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id g2so1431104qkk.1;
        Tue, 20 Sep 2022 05:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Nzu6kCwqk+cs06IVV+BbpSyucH7pJu1yrAhFxm/Mxog=;
        b=YOybfS2/EZkxNJORlvERQbyvLvuX+G1lTCGjgb3ac14OrOn7f0rY1KvglGAkr1+NVf
         GSekomeLUZTYWgw19+PtDm85KUuyXv/tRoGr9JxAaRd7kLyoHbcUs6HSPgL/EBvZ4bvK
         zmdPICx92ZXIRdCXY03W2ErRmii6zitV1De/To5xgCnhwHftBtx7b+uXRxVdRhtQm6mG
         1kKJw4kEQ9HUIP18AW7MKyet1VlGITx1S+K5gzl1dMgcxzt04KwjxEFEzzneSI7H0axA
         XFXarYMRB5fhdPamRDMPh5C7jMVZqYr9fPpsQJ4vh11Vj4zur2SOgv+K4g+Q0Q0tffQH
         zhNQ==
X-Gm-Message-State: ACrzQf2Z64p3TrK9DgZOn6/+2G2fud7wK80S1drlZpI8gmI+1q9jON4s
        XwIMDqmuqpXEYDg6hmezbesyJ6dM/Y7uxQ==
X-Google-Smtp-Source: AMsMyM77mMBs7h7GADe/QYH+okjlEiBJSA2KPldEIgGOAnTD61fEgNZ/jaTskwc/6JRqFZL9UMIIRw==
X-Received: by 2002:a05:620a:2214:b0:6ce:3426:1363 with SMTP id m20-20020a05620a221400b006ce34261363mr15786495qkh.662.1663675717011;
        Tue, 20 Sep 2022 05:08:37 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id h8-20020a05620a244800b006bbc09af9f5sm908429qkn.101.2022.09.20.05.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 05:08:36 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 130so3025995ybz.9;
        Tue, 20 Sep 2022 05:08:36 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr18450435ywe.283.1663675240491; Tue, 20
 Sep 2022 05:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220915181558.354737-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915181558.354737-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Sep 2022 14:00:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnrJuPUM9=-b1i8yWvBtVzDm8GNMXdbyNb3KFpK87cLw@mail.gmail.com>
Message-ID: <CAMuHMdVnrJuPUM9=-b1i8yWvBtVzDm8GNMXdbyNb3KFpK87cLw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: soc: renesas: Move renesas.yaml
 from arm to soc
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Thu, Sep 15, 2022 at 8:17 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> renesas.yaml lists out all the Renesas SoC's and the platforms/EVK's which
> is either ARM32/ARM64. It would rather make sense if we move renesas.yaml
> to the soc/renesas folder instead. This is in preparation for adding a new
> SoC (RZ/Five) from Renesas which is based on RISC-V.
>
> While at it drop the old entry for renesas.yaml from MAINTAINERS file and
> there is no need to update the new file path of renesas.yaml as we already
> have an entry for Documentation/devicetree/bindings/soc/renesas/ folder.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> rename from Documentation/devicetree/bindings/arm/renesas.yaml
> rename to Documentation/devicetree/bindings/soc/renesas/renesas.yaml

Fine for me.  With the yaml path inside fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
