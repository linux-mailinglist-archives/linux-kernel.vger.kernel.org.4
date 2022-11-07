Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E4961FCD7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiKGSIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiKGSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:08:02 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC52C139;
        Mon,  7 Nov 2022 10:04:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so32222111ejb.13;
        Mon, 07 Nov 2022 10:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg0lwZYTU9JWcjNHK3+96CsLpgsQAQHMbXUOoXcTWAw=;
        b=VgvQeRKGXjpN7rsFy94zWCr9OA0dpnIfL2CawpFJYijveycNO8+9xWYnPS7ZVKjqsJ
         QU94MOffg+97/ZUT1HNpEf0h9rVGh7CXC3zjQbTVmpbY0SQC0tVZYJlGaGr5M3O8trva
         iHeRGHHGEoBD9/8ZjrZtiIUElt7yj7rKO/WgaxbUi2XLbns2vr0dej9wz8FmY2oT2GHe
         IibTpgRZF1ZIPO+acBn94a/vy7DZx0xmBwJ1tyiZr8g3X96PHURRJV7seC/Y7ZTnlYtC
         7+dkOAoUHGL8DGNPkklXkPipQ5gv9b119vAovISr39kdgAIS+T8h7Q4xDbTQny5dRg/K
         gQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg0lwZYTU9JWcjNHK3+96CsLpgsQAQHMbXUOoXcTWAw=;
        b=7xZWUEV3OHeeOIFofkVtXhxjb5DcZuvskWRY9lhNN890CbHSUFQwRG07BjQKki7Gbn
         0WWZ7VPe14qadP1H1EVOSPPSND47cMYVDOdzBEXXJixn+YoN9tz3tTiEej8nSAcVJrl1
         XAL/XWF8SLwOFYHSFQxx+Jyl2HnC68k/4ZdUJh7lVdJhHLQBh6DepmHLUGHpGO5ZmnsQ
         NjR9nVErrnVOfcKPn0Q3nnq9Q4WS0kCjjfjpUm0aCiKTosYVctQuDb6aQZ7YomQMei4I
         G5g/u6QvjBHIVmZvtAvXzmOcpISjLxMwBztDrfyk182q4Kq4q/3GcdF+7LaQ2XrC4Zav
         LLQg==
X-Gm-Message-State: ACrzQf1X8tmyLjcrgevRweouxEGx8bGxlLzY7HVAFtjs1OvHvxKLMARb
        17UcChX04X81Pv6GD/GQRezlxnIyTjG3QxNcOy0=
X-Google-Smtp-Source: AMsMyM7n2WA+ZnLi0QcBe9sJOWeOu60VDFD0EZ1jJifo/fM9/FZPKUKady57RAJ7Z/vjacnBySXxjJd0TDPhpih5svc=
X-Received: by 2002:a17:907:270b:b0:7ad:ae01:e0d9 with SMTP id
 w11-20020a170907270b00b007adae01e0d9mr46374041ejk.196.1667844248212; Mon, 07
 Nov 2022 10:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y17BWPuEcmY7Bba3@spud> <CA+V-a8uKQ8QvYi5qLC9O=QAQN5CxNB7cOTmw4vk+ndB2R8d3nQ@mail.gmail.com>
 <Y17+pHAg/SBJAEXq@spud> <CA+V-a8t-niCHSWo_CSRSkPS4ND12DAkiwxWxOM1vNn=oBKKd_w@mail.gmail.com>
In-Reply-To: <CA+V-a8t-niCHSWo_CSRSkPS4ND12DAkiwxWxOM1vNn=oBKKd_w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 7 Nov 2022 18:03:41 +0000
Message-ID: <CA+V-a8utoDSKcZFdtJ0BKwvPfcvf0WVH2Va-Fv_-pKC1FOOVsQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add support for Renesas RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

On Sun, Oct 30, 2022 at 11:01 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Conor,
>
> On Sun, Oct 30, 2022 at 10:46 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Sun, Oct 30, 2022 at 10:37:01PM +0000, Lad, Prabhakar wrote:
> > > Hi Conor,
> > >
> > > On Sun, Oct 30, 2022 at 6:24 PM Conor Dooley <conor@kernel.org> wrote:
> > > >
> > > > On Fri, Oct 28, 2022 at 05:59:14PM +0100, Prabhakar wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Hi All,
> > > > >
> > > > > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> > > > > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> > > > > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> > > > > entry-class social infrastructure gateway control and industrial gateway
> > > > > control.
> > > > >
> > > > > This patch series adds initial SoC DTSi support for Renesas RZ/Five
> > > > > (R9A07G043) SoC. Below is the list of IP blocks enabled in the initial
> > > > > board DTS which can be used to boot via initramfs on RZ/Five SMARC EVK:
> > > > > - AX45MP CPU
> > > > > - CPG
> > > > > - PINCTRL
> > > >
> > > > Hey,
> > > > Looks like you've got a pair of warnings here from dtbs_check. I tested
> > > > this on top of 20221028's next, with the three branches below merged in,
> > > > hopefully my merges aren't the source of them:
> > > >
> > > > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: 'interrupt-controller' is a required property
> > > >         From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > > > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: '#interrupt-cells' is a required property
> > > >         From schema: linux/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > > >
> > > Thanks for the review and test. The warnings above are coming from [0]
> > > as support for IRQC is missing, once that is added the warnings should
> > > go away.
> >
> > Right. I merged in the stuff in Geert's trees & I don't think I saw any
> > pending patches in the cover that I missed. Is there something else that
> > adds the support that's not going to make v6.2? I got rid of all the
> > dtbs_check warnings for v6.1 and I'd really like to keep things that
> > way!
> >
> Sorry that pacth wasn't posted yet so I hadn't mentioned it in the
> cover letter. I'll make sure I get it posted asap and merged for v6.2.
>
I have got the patches out [0] which will fix the warnings seen above.

BTW on the riscv patchwork I see status as fail "Patch does not apply
to for-next" does that mean I need to resend re-basing on your tree?

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
