Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810C06E1653
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDMVGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDMVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:06:34 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B093C0;
        Thu, 13 Apr 2023 14:06:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d16so3620429iow.2;
        Thu, 13 Apr 2023 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681419993; x=1684011993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SRchkl1detoLRdtvEPNw+w/WWg3qTy8HU5Uobm8Vwk=;
        b=VRDisKIvUI6C/VKlm/axDEIrjWxjUxh0UpBHqLJoJVv6Z+MVEEpnwTnQguhH8Tnsus
         8nXKRTYiq9IiT29tFVn+wPHKfrSsolbtq7w7L+ibWP6dYKpMvUPS1nvWASM6rsROveod
         dsF84bz2dukGKVYQhE0Tz20adVD6ujgQI+gEpAD0IEJ/u6C73UzT6WOqqDRZn7cX6tgw
         xbxMvwKIavXy0KbJCYeMw4kSo/drdQWZ0P1uzPpuB6HmlMYtnIiJM5mk4/L7tFcNViXW
         BEP9cgByst4FjjymIy9VIVKUzfeBz9p/obFzcXR03LIrfs81ozW8QC8pw289RWBkykGk
         ipJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681419993; x=1684011993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SRchkl1detoLRdtvEPNw+w/WWg3qTy8HU5Uobm8Vwk=;
        b=dsA+eAkk/Y0JD4s9jp0RF4yn7b4RoKuQxAZimje74n44wYWgKLW1Q6S0peklPQ7JHP
         xiiz0bZb11sqMgdqGraBwrthJ+DONlHl4HkilkEf9fwsUGeOdg0O0xoV34GGPeU9u4c5
         NGCEiLy4mFsTgvru5jzOffeQoy2+rFaBtH9S+ZprulD/l8QpbBYSR/dhqezmtxTH8M3D
         Wruu8HKFJMZZExzoQsL5wcq05xWKq7EmbZ8PpHbiIMmnLzujkgLFSSPsSk1NP8yQ7QeW
         zvtbmIu7y59UxZPsQaH6EraHkB6b7AkbhTlrD9cVKT+rhV8Gbf4E06JJNx0kNhF/+7UO
         VKFA==
X-Gm-Message-State: AAQBX9eQhK959EBzAzZn0edfC08uh7UbDy+JFqqJx/D3KZiTUkIz59HZ
        88rCv0i5OwjWOZ6L7ttrYlZEI/TVrYs9cTyPzRw=
X-Google-Smtp-Source: AKy350aT652d/KwurFfw90Ox4CWRMRjX+PAvoseFaNyYXPjgTJvo2BjSO0kyWOLVZDQox7IFfzPWYCyvL17WareaCZE=
X-Received: by 2002:a6b:680a:0:b0:760:c237:bdd7 with SMTP id
 d10-20020a6b680a000000b00760c237bdd7mr468142ioc.1.1681419993239; Thu, 13 Apr
 2023 14:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412110900.69738-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412-cheddar-prune-5ce03ccf5581@spud> <20230413-aorta-unheated-c9bb35411fb2@wendy>
 <CA+V-a8uksWMihUadYc_dCoef7vaC5ncOicX0oGpSP9HRnHgScw@mail.gmail.com> <20230413-staunch-superman-e71fd3303176@spud>
In-Reply-To: <20230413-staunch-superman-e71fd3303176@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 13 Apr 2023 22:06:06 +0100
Message-ID: <CA+V-a8sGsbz5snMzc7JqFVktafzvEJTq3RNH+ndNBV6Fxj5bbQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 7:46=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> > Is
> > dma-noncoherent.c also valid for RISCV-32? If not then we can make
> > pmem.c compile conditionally if DMA non-coherenet is enabled and we
> > make DMA non-coherent depend on 64bit.
>
> Could you drop the {s,l}d in exchange for {s,l}w instead, or am I
> progressing even further into braino territory?
Just the direct exchange wont work in addition shifting + oring to
take care of 64-bit will require. (Correct me if I'm wrong here)

I was wondering now if we need to store/restore the s0 and ra
registers. I stumbled on an X86 implementation which has call [0] in
the ALTERNATIVE_X() macro but here we dont store/restore the
registers. Is the RISC-V implementation of ALT macro different
compared to x86?

[0] https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/uac=
cess_64.h#L105

Cheers,
Prabhakar
