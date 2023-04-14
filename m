Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E736E2A60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDNTAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNTAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:00:17 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B42A24D;
        Fri, 14 Apr 2023 12:00:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k13so19048964iov.10;
        Fri, 14 Apr 2023 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681498804; x=1684090804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWR09PnwXA83YCTdrYoULV0/Df8/NB3IaqlxX19sB5E=;
        b=sS9TNcxHWLjDdEZTybGm8OXLbHVx4dLpkhAHGEU00ZQQv4wuc8sm7L9HUctfE3wcIw
         LjkFzJmhjiqwr2tqQpSbDZpDkVK1kGk7LRKUhmU1deWP6w0z1UEN80Ssj0v9B4E2l7n1
         MMz4S0zQoXw+Z4rQan8za66ztL7n/GI8bfDPFominYq9g70Nru3tO7F76iJKef3BYzAl
         K7pVDgr0XyGKQ+dEhv9ZtXYOLOHdQvdW//SQmMOCH3J7Q+gLQM9JkWBzvn5aGsmrC8ze
         jjDPNguPhnKDRDNmfzf2xQPjyp6b5bTg8XWl4ZRxD5QeCKfJ0+lEPfktogDg1Y6y1J3Q
         3bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681498804; x=1684090804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWR09PnwXA83YCTdrYoULV0/Df8/NB3IaqlxX19sB5E=;
        b=TrC+/7nS4lYXluPxi4l/nqQr59MUOXAhuILMqvm/HGPrq+BuJzAeanpj8ETIvLd52x
         +TGAfEJhayz0Jc/grtSXZFxfXeHCzY3php9K8F+IfRApRCWJgIWNjQUruT9zw1owtYr9
         j2UlDPtdDJyY96der9tDkYQcrK3swCE2SbQ2MW+R5eFe6zFU9DXs9L5bgbyc4IahLB2t
         v0L8GdEaEMJot5HxEFIUMUem2rfsFsI+q41NPcQ10rLFsXf7KPZIPcUb7F4i5bzMswLl
         LirYfGgZ0QEaBF/oaRpAx88qNJqjlTAbKNDZjlz8XRw0uMPJm5CzvV1y6nnyp7OMetJX
         vW7w==
X-Gm-Message-State: AAQBX9f48aYMmqPgSjSmtjrtfl8V1XhDc7D5kfVP3/0onDeySA4PYx8s
        AMFbCQK/lvm4EAkPeyb+2ntMlHVkifBuGubSD1k=
X-Google-Smtp-Source: AKy350bBMFShfeoZZt2QjaqsfgTvtxSX9IZEiShxzW3qpTYXC1IhCI0f2JRNozkCVFDD/ZX6hBW/RRG4mX1gkr4y3LM=
X-Received: by 2002:a02:628f:0:b0:3a7:e46e:ab64 with SMTP id
 d137-20020a02628f000000b003a7e46eab64mr2919644jac.1.1681498803871; Fri, 14
 Apr 2023 12:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412110900.69738-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412-cheddar-prune-5ce03ccf5581@spud> <20230413-aorta-unheated-c9bb35411fb2@wendy>
 <CA+V-a8uksWMihUadYc_dCoef7vaC5ncOicX0oGpSP9HRnHgScw@mail.gmail.com>
 <20230413-staunch-superman-e71fd3303176@spud> <CA+V-a8sGsbz5snMzc7JqFVktafzvEJTq3RNH+ndNBV6Fxj5bbQ@mail.gmail.com>
In-Reply-To: <CA+V-a8sGsbz5snMzc7JqFVktafzvEJTq3RNH+ndNBV6Fxj5bbQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 14 Apr 2023 19:59:37 +0100
Message-ID: <CA+V-a8vV0rnOo6bLmegu5gAqA3-jfOn6hknG12jAtYXce0haLQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
To:     Conor Dooley <conor@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:06=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> On Thu, Apr 13, 2023 at 7:46=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > > Is
> > > dma-noncoherent.c also valid for RISCV-32? If not then we can make
> > > pmem.c compile conditionally if DMA non-coherenet is enabled and we
> > > make DMA non-coherent depend on 64bit.
> >
> > Could you drop the {s,l}d in exchange for {s,l}w instead, or am I
> > progressing even further into braino territory?
> Just the direct exchange wont work in addition shifting + oring to
> take care of 64-bit will require. (Correct me if I'm wrong here)
>
> I was wondering now if we need to store/restore the s0 and ra
> registers. I stumbled on an X86 implementation which has call [0] in
> the ALTERNATIVE_X() macro but here we dont store/restore the
> registers. Is the RISC-V implementation of ALT macro different
> compared to x86?
>
I did try a call without stroe/restore of s0 and ra registers and that
didn't work!. So I have re-written the assembly code which makes
32-bit RISC-V compilers happy. Once done with the testing I'll send a
new version of this series. Hopefully the last ;)

Cheers,
Prabhakar
