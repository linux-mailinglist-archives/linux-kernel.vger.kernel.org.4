Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9E6B9E08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCNSPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjCNSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:14:51 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51301258F;
        Tue, 14 Mar 2023 11:14:49 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5445009c26bso95532857b3.8;
        Tue, 14 Mar 2023 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678817689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44AE1w51mQu+NNfC48lEvJgM6CcI08MxIjGSfmxJVis=;
        b=SYaU+YqMXsSXfqpTKNV3tiob6i278BQaiMqLuIEwX/BezR8Ruiu5GoMXCQ+j7ArxKh
         uYtvoZX9tB2026M++UmvkikFXbNZKfxYBdJW/UQtbBQxsqGJdABD577fXslI0ybsO+0e
         2gHeTggrTWI7xtj2/XsBAEIl3mXhRTkFkP0WHBC6HJd9F4gQOztTbcBklUStoJ2BJr+z
         6FBmjTSBK9LSwmgE4TO8ZFAuBHP9ox/Q0niVoUbcx6j0wXLuM5F0Z8Dv3jjPJF0lcDhU
         TX+B0qI42/EJOlF2CqAEFCTCfanb+sYkr+K7RSwFqdQlhSmUaxK9aCudIYaChh5yuE/9
         75zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678817689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44AE1w51mQu+NNfC48lEvJgM6CcI08MxIjGSfmxJVis=;
        b=APO4olPZxmcdDL9AxaZI50feh8qpDiAObsKsbp9Xk7Vkjnc4/mqYkMLvpY06Yh+bbX
         ogxErgb7b2wysRLtEjO8CboN2BKdRMPo8UEnK4pJ0VMgKc8ulf27X0ZqAl2kRPOSTF6b
         L6CoU3rDStbphJd2LfsnxKFQVxOH5CnrDPVIKhqN3OES7njlxdwlxwI5wlVphtGyreL6
         jOm3FV21tcF4wi+8SP1n+VgqnVRbeamLB4qp8Wk3y3oRz+YQsJ97User8Xd6PF2RjP1A
         BXWebgt9x+O1GhWN62rfyCMdhncDtMZrppb7tC7Xq49HlLjGldmNJExe0zgqvpXbbrsc
         jMgQ==
X-Gm-Message-State: AO0yUKUL96+3mBYBy+IrFUrZAwL/yX4rYHUb+WsFsDO5YgKHfPEEWqy0
        USKgYORbzklSJViAyYZc+w21PqC6tXu3mEP8hw7gOA1sE/3H1Q==
X-Google-Smtp-Source: AK7set9XeXmGKUPH2oTgl2KxjOdNkcRKcVjDLX01NACQBmjVDRwojrFanU2LHe+PnWXZwPIuk+NJj5OwS2UHjwOzfGc=
X-Received: by 2002:a81:ae22:0:b0:541:6fb9:c9c2 with SMTP id
 m34-20020a81ae22000000b005416fb9c9c2mr7662282ywh.2.1678817688851; Tue, 14 Mar
 2023 11:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230310121306.4632-1-noltari@gmail.com> <da5d150e-a2db-573d-e231-b4fd9fdaf63b@gmail.com>
 <CAOiHx=njCvfVju9BAe7gTzMq0vybQF-gy4SRZrhEJFULGLhC7w@mail.gmail.com>
 <5b4d3eef-ff80-29e8-9be0-d487aee5e4e2@broadcom.com> <a88fc41b-69d3-b042-fa91-e403d1263742@gmail.com>
 <CAKR-sGfL5_VU9uxJHGyZ-bj2P_7R6+OOfWs6Yf-ihcCF8bD2MA@mail.gmail.com>
 <e3cff853-8d5d-acdf-8e6a-3322c4de2023@gmail.com> <CAKR-sGcyMF26NGoeEApKuKDe6=14nCGKwRYx-o68LHAcmUNXhA@mail.gmail.com>
 <7517f1b0-2afb-7edf-a847-e839a410f46f@gmail.com>
In-Reply-To: <7517f1b0-2afb-7edf-a847-e839a410f46f@gmail.com>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Tue, 14 Mar 2023 19:14:38 +0100
Message-ID: <CAKR-sGdOeg185sPFi0nwDxd6Fjx_SxyBgvtmFEiO9Y_50Wf2Bw@mail.gmail.com>
Subject: Re: [PATCH] mips: bmips: BCM6358: disable arch_sync_dma_for_cpu_all()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

El lun, 13 mar 2023 a las 22:46, Florian Fainelli
(<f.fainelli@gmail.com>) escribi=C3=B3:
>
> (please don't top post)
>
> On 3/13/23 14:39, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > Hi Florian,
> >
> > I did another test changing from TP1 to TP0 and this is the result:
> > [ 0.000000] Linux version 5.15.98 (noltari@atlantis)
> > (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
> > 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
> > [ 0.000000] bmips_cpu_setup: read_c0_brcm_config_0() =3D 0xe30e1006
> > [ 0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x2a00015
> > [ 0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
> >
> > And there were no exceptions with EHCI/OHCI as opposed to TP1.
> > So the issue is only happening when booting from TP1.
>
> Ah, that explains it then, I was just about to ask you which TP was the
> kernel booted on.
>
> > Maybe it's due to the fact that BCM6358 has a shared TLB?
>
> I think it has to do with the fact that the BMIPS_RAC_CONFIG_1 is likely
> not enabling the RAC since that register pertains to TP1, could you dump
> its contents, and if they do not set bit 0 and/or 1, please set them and
> try again and see whether it works any better? The RAC provides
> substantial performance improvements, it would be a change to keep it
> disabled.

This is the code that I added to bmips_cpu_setup():
    case CPU_BMIPS4350:
        cfg =3D read_c0_brcm_cmt_local();
        pr_info("bmips_cpu_setup: read_c0_brcm_cmt_local() =3D 0x%x\n", cfg=
);

        cfg =3D read_c0_brcm_config_0();
        pr_info("bmips_cpu_setup: read_c0_brcm_config_0() =3D 0x%x\n", cfg)=
;

        cfg =3D __raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
        pr_info("bmips_cpu_setup: BMIPS_RAC_ADDRESS_RANGE =3D 0x%x\n", cfg)=
;

        cfg =3D __raw_readl(cbr + BMIPS_L2_CONFIG);
        pr_info("bmips_cpu_setup: BMIPS_L2_CONFIG =3D 0x%x\n", cfg);

        cfg =3D __raw_readl(cbr + BMIPS_LMB_CONTROL);
        pr_info("bmips_cpu_setup: BMIPS_LMB_CONTROL =3D 0x%x\n", cfg);

        cfg =3D __raw_readl(cbr + BMIPS_RAC_CONFIG);
        pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x%x\n", cfg);
        __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG);
        pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x%x\n", cfg);
        __raw_readl(cbr + BMIPS_RAC_CONFIG);

        cfg =3D __raw_readl(cbr + BMIPS_RAC_CONFIG_1);
        pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG_1 =3D 0x%x\n", cfg);
        __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG_1);
        pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG_1 =3D 0x%x\n", cfg);
        __raw_readl(cbr + BMIPS_RAC_CONFIG_1);
        break;

And this is the result:
[    0.000000] bmips_cpu_setup: read_c0_brcm_cmt_local() =3D 0x80000000
[    0.000000] bmips_cpu_setup: read_c0_brcm_config_0() =3D 0xe30e1006
[    0.000000] bmips_cpu_setup: BMIPS_RAC_ADDRESS_RANGE =3D 0x277bdab0
[    0.000000] bmips_cpu_setup: BMIPS_L2_CONFIG =3D 0x241a0008
[    0.000000] bmips_cpu_setup: BMIPS_LMB_CONTROL =3D 0x0
[    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x3c1b8041
[    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x3c1b8041
[    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG_1 =3D 0x3600008
[    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG_1 =3D 0x3600008

As you can see the bit's aren't set and all the registers appear to
have strange values and not the usual ones when initialized by the
bootloader...

>
> >
> > Maybe the correct way of solving the issue would be by adding the
> > following code at bcm6358_quirks():
> > if (read_c0_brcm_cmt_local() & (1 << 31))
> >      bmips_dma_sync_disabled =3D 1;
> >
> > BTW, if I understood it correctly, you want me to reverse the logic,
> > so bmips_dma_sync_disabled instead of bmips_dma_sync_enabled.
> > Is this correct?
>
> Yes, I want the logic such that we need to set a variable to 1/true
> rather setting one to 0, less change to get it wrong IMHO.
>
> >
> > Best regards,
> > =C3=81lvaro.
> >
> >
> > El lun, 13 mar 2023 a las 18:37, Florian Fainelli
> > (<f.fainelli@gmail.com>) escribi=C3=B3:
> >>
> >> On 3/12/23 11:50, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> >>> Hi Florian,
> >>>
> >>> I tried what you suggested but it stil panics on EHCI:
> >>>
> >>> [    0.000000] Linux version 5.15.98 (noltari@atlantis)
> >>> (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
> >>> 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
> >>> [    0.000000] bmips_cpu_setup: read_c0_brcm_config_0() =3D 0xe30e100=
6
> >>> [    0.000000] bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG =3D 0x3c1b8041
> >>> [    0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
> >>>
> >>> It looks like bit 29 is set so RAC should be present.
> >>> And RAC_I seems to be set, but not RAC_D...
> >>>
> >>> BTW, this is what I added to bmips_cpu_setup:
> >>>
> >>> case CPU_BMIPS4350:
> >>> cfg =3D read_c0_brcm_config_0();
> >>> pr_info("bmips_cpu_setup: read_c0_brcm_config_0() =3D 0x%x\n", cfg);
> >>>
> >>> cfg =3D __raw_readl(cbr + BMIPS_RAC_CONFIG);
> >>> pr_info("bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG =3D 0x%x\n", cfg);
> >>> __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG);
> >>> __raw_readl(cbr + BMIPS_RAC_CONFIG);
> >>> break;
> >>
> >> Thanks for running those experiments, I cannot explain what you are
> >> seeing, so there must be some sort of erratum applicable to the
> >> BMIPS4380 revision used on the 6358 somehow...
> >>
> >> If you can make the suggested change to use negative logic in order to
> >> disable the RAC flushing, that would work for me, also maybe add a
> >> Fixes: tag so it gets backported to stable trees?
> >>
> >> Thanks!
> >> --
> >> Florian
> >>
>
> --
> Florian
>

=C3=81lvaro
