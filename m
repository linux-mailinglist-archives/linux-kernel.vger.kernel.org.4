Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64E56D292A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjCaUJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjCaUJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:09:47 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB3D22214;
        Fri, 31 Mar 2023 13:09:44 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h187so8486875iof.7;
        Fri, 31 Mar 2023 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680293383; x=1682885383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NAz9S30aGFPtEuWfJEyiKcdkusKBbk0JyFKWd+aoVA=;
        b=G2WAtaKi4SqMg8ku//tzWr4dU1WOMosZlfN+GwaOHuWVINLMXHGKqsHCtByB+WJpJ2
         Vs3XtxJ1n9r1C+PFSKAggGuiSrU6Z7AXtOFOFEDntKZL9Ir9Fcup9O6xrNkB0kWv70se
         fTLrsCd8zdfnVfLcS9DYFRvKOV53+ZB90DmmlNMlVBCciz1wfJAkyZILgez2gQ1F5tbY
         HmnCEzViVy6O33SZC8HDtD92BPcl3Z+RhKx7u7yaNcu4JRkLAt604rML0XBydHPHcl0K
         U4Rh2DG2vnwEsZy9mlonDlq/JN30a0fOf7+ve0OK7eVEmnQNwKy/qIsgEhh6iQOpBh/u
         qfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680293383; x=1682885383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NAz9S30aGFPtEuWfJEyiKcdkusKBbk0JyFKWd+aoVA=;
        b=Kj5d8zocT7/zJd/Sx7+RWcGHGXgLotBRclYQVqc6yG49Jb4OOLbA9j4FZyVUhyPQbz
         x6HOtwU5+EyK3lZwUYb14Bl1Gi5mgdnRorvQHytqlQ9oHynU+XWH6S/8r4MasalQewiC
         nRTaFoiALsV08zK7ODMfMtNlW52Ub27XT/TK+kr5xVk13L0H4Z0EHNOiD03ScyPg4Tu8
         rjM7l8GvuKDtGfcxqBRv8tRNUxcnR186qPZKT5NjdGjUI4IeKxOs24BSJ7vJoFOR4zqJ
         FoHdGvANae2wyM2Hvjzv9EfizlMN+gj2ulyYfine8GfEvaW/KL5UPUbCWt9T+9qm2h7E
         Yj4w==
X-Gm-Message-State: AO0yUKV10f1VwWkv4lvQZx7gNXlSNLoyI9aoTMBcb0ZF+DN9iX+FddUO
        LPZ0cWekVaafKSiMteVhqdWVwMPK8uK7BqnrvfA6fAi/cd4JNA==
X-Google-Smtp-Source: AK7set/N3YGnS9ogYf8bW40PdxxrBzO9MUQuB3Lh+RxfeeKlwnhxk2YA2WgzehfEB2G8ERWuDMiioDseQ+shcBi6xvg=
X-Received: by 2002:a02:a182:0:b0:3c5:1971:1b7b with SMTP id
 n2-20020a02a182000000b003c519711b7bmr10783828jah.1.1680293383261; Fri, 31 Mar
 2023 13:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <b2dcda17-5850-47c1-94bc-4ca87f900581@spud>
In-Reply-To: <b2dcda17-5850-47c1-94bc-4ca87f900581@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 31 Mar 2023 20:09:16 +0000
Message-ID: <CA+V-a8s+=OY6CX4XTUwyAE9b=rdJZZfgAaY2nU+6aqnu=X9nxQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] RISC-V non-coherent function pointer based CMO +
 non-coherent DMA support for AX45MP
To:     Conor Dooley <conor@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Fri, Mar 31, 2023 at 7:05=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Mar 30, 2023 at 09:42:11PM +0100, Prabhakar wrote:
>
> > - This series requires testing on Cores with zicbom and T-Head SoCs
>
> I don't actually know if there are Zicbom parts, may need to test that
> on QEMU.
> I had to revert unrelated content to boot, but my D1 NFS setup seems to
> work fine with these changes, so where it is relevant:
> Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on D1
>
Thank you for testing this. By any chance did you compare the performance?

Cheers,
Prabhakar
