Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079B36F9F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjEHGRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjEHGRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC72E17DFD;
        Sun,  7 May 2023 23:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E84E61F09;
        Mon,  8 May 2023 06:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6796C433EF;
        Mon,  8 May 2023 06:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683526622;
        bh=KxwYxJMc4q2L54lZZg4no2f6ubAF9y02PkE5A4nwysU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pT4cZdOK4XiVUv6jE7p0Pd5sKyBhBWy/ukp72AM5241ZvR4d4ILp2TutFJP3hvs/m
         mk2DmHAA+fS4n6GRwISfwF9vH/CNRwu4IaHQYOksasj4nufkmJBfOJkbRCYvC7nJzs
         4g+N4jG0jGDA3NYm2motEkn1tDBpvNPf12QKEHd9sx06PF2g38u2HOlqVDqYXea3++
         qk89PqUvAiDU1xU9I13ZHuxspdKJiMZFjVQpAlESfgVVVHNgLwNzpkryBmHjbtXEaw
         IpNcN6bMzc5puHeDoiFZSQbWbZkxyLh3QcAvatir0di0v3gpgStxLNQsk5cAely5WM
         apnP+HpSqwwNA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so45687007a12.0;
        Sun, 07 May 2023 23:17:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDxxnUZtycsGrbLPuOqSML+eOGfofzNUzA3naeyunSZN9mUWTH9e
        trVwMj0/OrmsrglrAGCW5nrfGst1GQzfEcn/WhA=
X-Google-Smtp-Source: ACHHUZ4n+NUhxOQEB2cLl1GdPbNVKJ0wiwkd8hT9Ds85PHzuHycN+WrqIpWX2LI39K6y2oNVKhJxTRW5nhjZ4gyxqq8=
X-Received: by 2002:a17:907:6d22:b0:965:d7c7:24db with SMTP id
 sa34-20020a1709076d2200b00965d7c724dbmr8201147ejc.32.1683526620956; Sun, 07
 May 2023 23:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230507182304.2934-1-jszhang@kernel.org>
In-Reply-To: <20230507182304.2934-1-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 8 May 2023 14:16:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTScma2OXQv-2ALkZuuVtJA-tAhhi9B4b0No4DNPkH7Ekw@mail.gmail.com>
Message-ID: <CAJF2gTScma2OXQv-2ALkZuuVtJA-tAhhi9B4b0No4DNPkH7Ekw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add Sipeed Lichee Pi 4A RISC-V board support
To:     Jisheng Zhang <jszhang@kernel.org>, Wei Fu <wefu@redhat.com>,
        Wei Fu <tekkamanninja@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F.Y.I Wei Fu <wefu@redhat.com>


On Mon, May 8, 2023 at 2:34=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's light(a.k.a TH1520) SoC. Add
> minimal device tree files for the core module and the development
> board.
>
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.
>
> Jisheng Zhang (5):
>   irqchip/sifive-plic: Support T-HEAD's C910 PLIC
>   riscv: Add the T-HEAD SoC family Kconfig option
>   riscv: dts: add initial T-HEAD light SoC device tree
>   riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
>   MAINTAINERS: add entry for T-HEAD RISC-V SoC
>
>  .../sifive,plic-1.0.0.yaml                    |   4 +
>  MAINTAINERS                                   |   6 +
>  arch/riscv/Kconfig.socs                       |   6 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/thead/Makefile            |   2 +
>  .../dts/thead/light-lichee-module-4a.dtsi     |  38 ++
>  .../boot/dts/thead/light-lichee-pi-4a.dts     |  32 ++
>  arch/riscv/boot/dts/thead/light.dtsi          | 454 ++++++++++++++++++
>  drivers/irqchip/irq-sifive-plic.c             |   1 +
>  9 files changed, 544 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/thead/Makefile
>  create mode 100644 arch/riscv/boot/dts/thead/light-lichee-module-4a.dtsi
>  create mode 100644 arch/riscv/boot/dts/thead/light-lichee-pi-4a.dts
>  create mode 100644 arch/riscv/boot/dts/thead/light.dtsi
>
> --
> 2.40.0
>


--
Best Regards
 Guo Ren
