Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242696111CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJ1MpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ1MpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:45:06 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129C4C62F;
        Fri, 28 Oct 2022 05:45:05 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id b25so3297291qkk.7;
        Fri, 28 Oct 2022 05:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5L/coRKTHoItE23ReDb1PV3s90z+puDyMQpN9g990M=;
        b=a3RBMBN3/FDng7LPU8cUjxhYpgnkS+CRVxacsjtgsOAOjEL2w7xwKGlD9UD9WbtCLy
         JiEbONhz3pKDrxw/B1ysIiELluLgTlFmSP04CyP62umHgsH93YtTNMefAM/b0mQb07GT
         uTWl73fOn6cR/waaUD8MRgTWQLovLyrzsxMcBTI1Lr9abvJ8ZoHguxAPRDEQj0zhvq6N
         Yoqhx3XPLrh79Mf/NukxYPVJdS/CgYX+tycmM0CgAOVQq/8srsS5dIFhHTwK4jgraqJR
         RRjHZa2a730A2SB4hojjQU9nwcTAZNUkXvtAPpxsTuyUN92KjYWzx7YAlcepI4AjsORG
         uDrw==
X-Gm-Message-State: ACrzQf1dVPG5/iRfO95lEauSuUkzE3DvQxIaeFOHjbN7DtHAa+SeqJ9R
        Vk0L+8pLSInW36896TkhutZbtKTgIJVmyQ==
X-Google-Smtp-Source: AMsMyM6XuJrgYkPWttyciuKZVVyitZ7bgI4UnIPMFD87TSdyjtZk/2CDAGcXbUv37C4RHzsvntj+zA==
X-Received: by 2002:a05:620a:2601:b0:6bc:70bb:c56b with SMTP id z1-20020a05620a260100b006bc70bbc56bmr38918312qko.416.1666961104181;
        Fri, 28 Oct 2022 05:45:04 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id dt36-20020a05620a47a400b006bb8b5b79efsm2872781qkb.129.2022.10.28.05.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 05:45:02 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3321c2a8d4cso46026487b3.5;
        Fri, 28 Oct 2022 05:45:01 -0700 (PDT)
X-Received: by 2002:a81:3d2:0:b0:36b:6772:75a3 with SMTP id
 201-20020a8103d2000000b0036b677275a3mr30116483ywd.383.1666961101680; Fri, 28
 Oct 2022 05:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220920184904.90495-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220920184904.90495-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Oct 2022 14:44:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXaxb05O0vqw8PqRQShOFE-f9JEQqxGb0LaPWTA=yDAYg@mail.gmail.com>
Message-ID: <CAMuHMdXaxb05O0vqw8PqRQShOFE-f9JEQqxGb0LaPWTA=yDAYg@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] dt-bindings: soc: renesas: Move renesas.yaml
 from arm to soc
To:     Prabhakar <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 8:50 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3 -> v4
> * Updated the path in the DT binding
> * Included RB tag from Geert

Will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
