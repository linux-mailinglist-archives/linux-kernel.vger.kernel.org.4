Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA75BE58C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiITMSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiITMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:18:05 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A7774CE8;
        Tue, 20 Sep 2022 05:18:04 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id u28so1441018qku.2;
        Tue, 20 Sep 2022 05:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PCXGt1AyalYiTT3XoklrKq/gCYb3QTPuawn05s9CgfU=;
        b=FCT58oHRMjerlpKgjTHZOQzJjset/VqBFWxaWcEleNFxSABkhWWBrGFHaSTX8bKrlw
         OOVh2DTC4k+yXOwCOZzhhU3laIFfQQQNRvVs5e+KZVWcmbsb00g42S/w6rRk7WS3OTPS
         82/Sx5otCGbeTED2YfizdApa1BgEHBsbB8FYoLGF9UXkdMh6RgPAOr5H1TCdUR+n0ojY
         fnF+8tGcLrEy9nI+jyHIvcRh4otQ+hZnRtqCCbEHuKtoecA1s4saVlNAxSGm/XukJuii
         EmhmosXjpwEc23R4M9Wwgvktowk3FEzrK5t4pJqlSXgSIk8cma1YVws16GvoR+7a779t
         +xzQ==
X-Gm-Message-State: ACrzQf3Xrza/ieyA6nGu+zphHQmoLj+k/2TAaAwRQvx5helnPSOWyl4O
        l9Pl6mTvYLr366IbqA9R5t4Udtfei44IoQ==
X-Google-Smtp-Source: AMsMyM7jnC1xLmd+NO0680Qy3u0Vck4ja8p4d8Zc4GnEQzqT3x543qE4+Zu1CSZ3SLnI0sPQB5ha/Q==
X-Received: by 2002:ae9:df46:0:b0:6bb:7917:5c66 with SMTP id t67-20020ae9df46000000b006bb79175c66mr15738324qkf.342.1663676283357;
        Tue, 20 Sep 2022 05:18:03 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id z22-20020ae9c116000000b006b60d5a7205sm21474qki.51.2022.09.20.05.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 05:18:02 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id a67so3104787ybb.3;
        Tue, 20 Sep 2022 05:18:01 -0700 (PDT)
X-Received: by 2002:a05:6902:45:b0:6ae:ce15:a08d with SMTP id
 m5-20020a056902004500b006aece15a08dmr18526994ybh.380.1663676281670; Tue, 20
 Sep 2022 05:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <3693a3a1-5a2a-4cc5-fb55-f6ad9a4b3f72@microchip.com> <CA+V-a8u87tqhC69qGD2zq_gT9jc_cSWd+NRn_u0bPTdmmk+j4A@mail.gmail.com>
 <e15f3e2a-2761-84d9-c5c9-118717e0bb83@conchuod.ie>
In-Reply-To: <e15f3e2a-2761-84d9-c5c9-118717e0bb83@conchuod.ie>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Sep 2022 14:17:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGD9s96JJafsYdfnPqvg6KLvmC9GUS4yjaaXi2hYrJYQ@mail.gmail.com>
Message-ID: <CAMuHMdUGD9s96JJafsYdfnPqvg6KLvmC9GUS4yjaaXi2hYrJYQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] riscv: boot: dts: r9a07g043: Add placeholder nodes
To:     Conor Dooley <mail@conchuod.ie>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, heiko@sntech.de,
        atishp@rivosinc.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
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

Hi Conor,

On Fri, Sep 16, 2022 at 12:40 AM Conor Dooley <mail@conchuod.ie> wrote:
> On 15/09/2022 23:26, Lad, Prabhakar wrote:
> > On Thu, Sep 15, 2022 at 10:36 PM <Conor.Dooley@microchip.com> wrote:
> >> On 15/09/2022 19:15, Prabhakar wrote:
> >>> riscv: boot: dts: r9a07g043: Add placeholder nodes
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>> Add empty placeholder nodes to RZ/Five (R9A07G043) SoC DTSI.
> >> Can you explain why do you need placeholder nodes for this and
> >> cannot just directly include the other dtsis?
> >>
> > Since the RZ/G2UL SoC is ARM64 where it has a GIC and on RZ/Five SoC
> > we have PLIC for interrupts. Also the interrupt numbering for RZ/Five
> > SoC differs from RZ/G2UL SoC hence we are not directly using the
> > RZ/G2UL SoC DTSI [0].
> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi?h=v6.0-rc5
> >
> > For the RZ/Five SMARC EVK I am re-using the below files [1] (SoM) and
> > [2] (Carrier board) as the RZ/Five SMARC EVK is pin compatible.  Since
> > I am re-using these when trying to compile the RZ/Five DTB I get
> > compilation errors since the nodes dont exist (and there is no way
> > currently we can delete the node reference when the actual node itself
> > isn't present) hence these place holders.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi?h=v6.0-rc5
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi?h=v6.0-rc5
>
> If this method is acceptable to Geert, this explanation 100% needs to
> go into the commit message.

We've been using these placeholders a lot in Renesas SoC-specific
.dtsi files, as they allow us to introduce gradually support for a new SoC
that is mounted on an existing PCB, and thus shares a board-specific
.dtsi file.  Hence I'm fine with this.

However, I think more properties can be dropped from the placeholders.
There is no need to have e.g. 'reg-names' and 'status = "disabled"'
(there is no compatible value, so no matching is done).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
