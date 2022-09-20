Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB62D5BE77F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiITNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiITNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:47:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB3057217;
        Tue, 20 Sep 2022 06:47:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lh5so6236006ejb.10;
        Tue, 20 Sep 2022 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FIfv7ldS0YkRlbgUcQzoAtfI4poeYBTKR3ilCVR4L44=;
        b=Ib4LtlPrWnMKsLSranL8+d9s8BraCoSk8vC38PSPG45HunaEjF8J+E7X0fZ87WYJ1T
         YexlNUct7PIKUbSlqgCUBv5ecfQOZpLeD7P1/K2BPLk+UTiBRGMsIRLtGti9asAtn/41
         6k5vyMnMTcb/o9pFgCacfYFq7yNJvXdYUYRy8NkOiBwlmYFVSOR6saJaJtjGE7RjSmBg
         U1B1HRDT8He6dxCAimHvMReIJOZoBlHIWYiQeITjAFS2zQs7+MBsSWP+OHJ69pTb28mT
         sG47+kawwNL6JJ6Lx4hgTLKH0ZssKBtnrcAku3GFT8Mizcf+D5Ogz6HE1OZCeSMwQtXA
         +ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FIfv7ldS0YkRlbgUcQzoAtfI4poeYBTKR3ilCVR4L44=;
        b=XSLdOu6J3VOrw1ZGIe54PnCHNZUHpxwPP9lohqw/nCFzDLj0BUZJAxvnU+8BuxNFPA
         qjsIHkz3Gfc6yCJ1kfm5+K57JH0FCjBEdvN+gF0IeG3uk/afSOlk2LT8EwpDY8gu+eBF
         rnlazhNHe5HXrljLZkNL5lkWexhwKA0i8nz6UzCY/v6g80nC36ET2HRwRL5FtmTK6yhO
         oDuAEpIRXFpwPacWRffXQTWILLoJE+2nJ4UiQKRAJOV8hkXiSHU+s90CK/geS9kuU/8a
         bHno1jf2niq+6wTaAa+V+5SnjbAwZ+wmWqpkihcgN7bgZECUn+p0GuyqtdPBBCrbDBCE
         athg==
X-Gm-Message-State: ACrzQf1W4KQBpFGiF2D1y+FTI+X7l4b9E1HC0rFB/LzGBaKSaXUkOFX/
        zjm9sAA5xhzKeZbMopHHe4JCgEezqop1qjfIubM=
X-Google-Smtp-Source: AMsMyM5HgTh+5QojTUeIrgHbwGkUKtpIcdqU9tP/gHB3cveUpRK1tcUB+nxOzNhlHbkx+N7yPSGymD5FZc6WqDCbsRo=
X-Received: by 2002:a17:907:6d90:b0:77c:68a8:a5b with SMTP id
 sb16-20020a1709076d9000b0077c68a80a5bmr17470946ejc.342.1663681639186; Tue, 20
 Sep 2022 06:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <3693a3a1-5a2a-4cc5-fb55-f6ad9a4b3f72@microchip.com> <CA+V-a8u87tqhC69qGD2zq_gT9jc_cSWd+NRn_u0bPTdmmk+j4A@mail.gmail.com>
 <e15f3e2a-2761-84d9-c5c9-118717e0bb83@conchuod.ie> <CAMuHMdUGD9s96JJafsYdfnPqvg6KLvmC9GUS4yjaaXi2hYrJYQ@mail.gmail.com>
 <Yymyh+UlIICacxeV@wendy>
In-Reply-To: <Yymyh+UlIICacxeV@wendy>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 20 Sep 2022 14:46:49 +0100
Message-ID: <CA+V-a8u3LcDhOYqWSOJUUeSMX+o=12pAcFJ0xArYSPy+=uT9NA@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] riscv: boot: dts: r9a07g043: Add placeholder nodes
To:     Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Conor Dooley <mail@conchuod.ie>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, heiko@sntech.de,
        atishp@rivosinc.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
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

Hi Conor and Geert,

On Tue, Sep 20, 2022 at 1:31 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Tue, Sep 20, 2022 at 02:17:50PM +0200, Geert Uytterhoeven wrote:
> > Hi Conor,
> >
> > On Fri, Sep 16, 2022 at 12:40 AM Conor Dooley <mail@conchuod.ie> wrote:
> > > On 15/09/2022 23:26, Lad, Prabhakar wrote:
> > > > On Thu, Sep 15, 2022 at 10:36 PM <Conor.Dooley@microchip.com> wrote:
> > > >> On 15/09/2022 19:15, Prabhakar wrote:
> > > >>> riscv: boot: dts: r9a07g043: Add placeholder nodes
> > > >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >>> Add empty placeholder nodes to RZ/Five (R9A07G043) SoC DTSI.
> > > >> Can you explain why do you need placeholder nodes for this and
> > > >> cannot just directly include the other dtsis?
> > > >>
> > > > Since the RZ/G2UL SoC is ARM64 where it has a GIC and on RZ/Five SoC
> > > > we have PLIC for interrupts. Also the interrupt numbering for RZ/Five
> > > > SoC differs from RZ/G2UL SoC hence we are not directly using the
> > > > RZ/G2UL SoC DTSI [0].
> > > >
> > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi?h=v6.0-rc5
> > > >
> > > > For the RZ/Five SMARC EVK I am re-using the below files [1] (SoM) and
> > > > [2] (Carrier board) as the RZ/Five SMARC EVK is pin compatible.  Since
> > > > I am re-using these when trying to compile the RZ/Five DTB I get
> > > > compilation errors since the nodes dont exist (and there is no way
> > > > currently we can delete the node reference when the actual node itself
> > > > isn't present) hence these place holders.
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi?h=v6.0-rc5
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi?h=v6.0-rc5
> > >
> > > If this method is acceptable to Geert, this explanation 100% needs to
> > > go into the commit message.
> >
> > We've been using these placeholders a lot in Renesas SoC-specific
> > .dtsi files, as they allow us to introduce gradually support for a new SoC
> > that is mounted on an existing PCB, and thus shares a board-specific
> > .dtsi file.  Hence I'm fine with this.
>
> Aye, if you're happy with it then I am too...
> >
> > However, I think more properties can be dropped from the placeholders.
> > There is no need to have e.g. 'reg-names' and 'status = "disabled"'
> > (there is no compatible value, so no matching is done).
>
> ...and this makes a lot of sense. I'd still like a comment in the
> commit message though explaining why placeholder nodes are needed as
> opposed to just leaving it blank etc.
>
I will drop the status and reg-names properties and also update the
commit message while sending the v4

Cheers,
Prabhakar
