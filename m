Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD836BD7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCPSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCPSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:04:00 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB47C26C30;
        Thu, 16 Mar 2023 11:03:54 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e194so2955050ybf.1;
        Thu, 16 Mar 2023 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678989834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eekYRYx+AmgPD0Kcnq164hy+fAqpuHvvS5OeiiL07KY=;
        b=AsSiWeSOoLVRsU5g98psOikVpxzh7IRFhvr6bGZeJGpnmvsh7ROblsljw7/2vz71sa
         hwaqodWExdEHOn8FCtf1GOtUJ4lxtoWOIKN+GM0ttsmhZIWhAxN+fOBY4C2D0hajMspd
         ktLXAOnzB1bTfCNmz1Ba9KFkUikkZaCO2l8VnggMiXhzGfBFbqCcLNHM2I97E8kvv4q6
         uVyAthOb4fVw71tL07yBHrJf+H7e1u8x7iV1xHLK8NapsDYik49iHrvuFqeh0kbHc/f3
         U4abMDijh0J7B4/ae9vrsKo15apm1KkG1XBn2pieKm/iU10GPFhWC0mm1+aoWBPQyRvk
         y1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eekYRYx+AmgPD0Kcnq164hy+fAqpuHvvS5OeiiL07KY=;
        b=rfxFdkguywqzdtj+Fm51N+hbxqubf5HVhr1yE+Ou6jAHOvk4jS3dkPYOUTIZJYwzqH
         8w2s4CAb1Mo6EZmH02DpghFEZmNzd4NNRDw/30znQJ2cgN/8lDOEXXbMyrNNwtUtEQpP
         E7+uepsdOdhCwjWqOpyEXYNNDrwfJlchEN9tYc47AAS/SjdY6oHDXj99cov5yqcV62kv
         4jjI0YRyRlIWH6rF13IrS+x33rwQVBwbVZUk6R7h75R7bCJzLjMEAfV76ofBpk2wK0y7
         N8jcVwh/LEZMwbh41kYPx4IsJMRCF57+bpUPnBIrKZVZv8ABRZOFFI1o+K13zG0hL7tq
         DV7w==
X-Gm-Message-State: AO0yUKX0dfL7P/yXpZQx19knXkLPjTUdd+KpaNr7GB+jocgAY+aQNG7s
        UHXkZTlng2NgoEBP+GZ8aLH1Hbgk5oQSyekUU+w=
X-Google-Smtp-Source: AK7set/dLtG1yierM4dyWvBtX2qBuRMqMaKZO4x5Gm4c1vpbs6asaMhH/zmJIUph8WyVvhW62sXxChn8TlYu5Uw2XW4=
X-Received: by 2002:a05:6902:1101:b0:b26:d140:5f74 with SMTP id
 o1-20020a056902110100b00b26d1405f74mr309925ybu.1.1678989833797; Thu, 16 Mar
 2023 11:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230310121306.4632-1-noltari@gmail.com> <da5d150e-a2db-573d-e231-b4fd9fdaf63b@gmail.com>
 <CAOiHx=njCvfVju9BAe7gTzMq0vybQF-gy4SRZrhEJFULGLhC7w@mail.gmail.com>
 <5b4d3eef-ff80-29e8-9be0-d487aee5e4e2@broadcom.com> <a88fc41b-69d3-b042-fa91-e403d1263742@gmail.com>
 <CAKR-sGfL5_VU9uxJHGyZ-bj2P_7R6+OOfWs6Yf-ihcCF8bD2MA@mail.gmail.com>
 <e3cff853-8d5d-acdf-8e6a-3322c4de2023@gmail.com> <CAKR-sGcyMF26NGoeEApKuKDe6=14nCGKwRYx-o68LHAcmUNXhA@mail.gmail.com>
 <7517f1b0-2afb-7edf-a847-e839a410f46f@gmail.com> <CAKR-sGdOeg185sPFi0nwDxd6Fjx_SxyBgvtmFEiO9Y_50Wf2Bw@mail.gmail.com>
 <fd4cb74c-3a8e-c9c0-f9ac-312fb916275c@gmail.com>
In-Reply-To: <fd4cb74c-3a8e-c9c0-f9ac-312fb916275c@gmail.com>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Thu, 16 Mar 2023 19:03:43 +0100
Message-ID: <CAKR-sGdc3zLyNdzfZ383nu05q=S5We9Q257w4dm7wWLHQ+XtpQ@mail.gmail.com>
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

El jue, 16 mar 2023 a las 18:40, Florian Fainelli
(<f.fainelli@gmail.com>) escribi=C3=B3:
>
> On 3/14/23 11:14, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > Hi Florian,
> >
> > El lun, 13 mar 2023 a las 22:46, Florian Fainelli
> > (<f.fainelli@gmail.com>) escribi=C3=B3:
> >>
> >> (please don't top post)
> >>
> >> On 3/13/23 14:39, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> >>> Hi Florian,
> >>>
> >>> I did another test changing from TP1 to TP0 and this is the result:
> >>> [ 0.000000] Linux version 5.15.98 (noltari@atlantis)
> >>> (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
> >>> 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
> >>> [ 0.000000] bmips_cpu_setup: read_c0_brcm_config_0() =3D 0xe30e1006
> >>> [ 0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x2a00015
> >>> [ 0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
> >>>
> >>> And there were no exceptions with EHCI/OHCI as opposed to TP1.
> >>> So the issue is only happening when booting from TP1.
> >>
> >> Ah, that explains it then, I was just about to ask you which TP was th=
e
> >> kernel booted on.
> >>
> >>> Maybe it's due to the fact that BCM6358 has a shared TLB?
> >>
> >> I think it has to do with the fact that the BMIPS_RAC_CONFIG_1 is like=
ly
> >> not enabling the RAC since that register pertains to TP1, could you du=
mp
> >> its contents, and if they do not set bit 0 and/or 1, please set them a=
nd
> >> try again and see whether it works any better? The RAC provides
> >> substantial performance improvements, it would be a change to keep it
> >> disabled.
> >
> > This is the code that I added to bmips_cpu_setup():
> >      case CPU_BMIPS4350:
> >          cfg =3D read_c0_brcm_cmt_local();
> >          pr_info("bmips_cpu_setup: read_c0_brcm_cmt_local() =3D 0x%x\n"=
, cfg);
> >
> >          cfg =3D read_c0_brcm_config_0();
> >          pr_info("bmips_cpu_setup: read_c0_brcm_config_0() =3D 0x%x\n",=
 cfg);
> >
> >          cfg =3D __raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
> >          pr_info("bmips_cpu_setup: BMIPS_RAC_ADDRESS_RANGE =3D 0x%x\n",=
 cfg);
> >
> >          cfg =3D __raw_readl(cbr + BMIPS_L2_CONFIG);
> >          pr_info("bmips_cpu_setup: BMIPS_L2_CONFIG =3D 0x%x\n", cfg);
> >
> >          cfg =3D __raw_readl(cbr + BMIPS_LMB_CONTROL);
> >          pr_info("bmips_cpu_setup: BMIPS_LMB_CONTROL =3D 0x%x\n", cfg);
> >
> >          cfg =3D __raw_readl(cbr + BMIPS_RAC_CONFIG);
> >          pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x%x\n", cfg);
> >          __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG);
> >          pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x%x\n", cfg);
> >          __raw_readl(cbr + BMIPS_RAC_CONFIG);
> >
> >          cfg =3D __raw_readl(cbr + BMIPS_RAC_CONFIG_1);
> >          pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG_1 =3D 0x%x\n", cfg)=
;
> >          __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG_1);
> >          pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG_1 =3D 0x%x\n", cfg)=
;
> >          __raw_readl(cbr + BMIPS_RAC_CONFIG_1);
> >          break;
> >
> > And this is the result:
> > [    0.000000] bmips_cpu_setup: read_c0_brcm_cmt_local() =3D 0x80000000
>
> OK, so we are executing from TP1, but we knew that already.
>
> > [    0.000000] bmips_cpu_setup: read_c0_brcm_config_0() =3D 0xe30e1006
>
> bit 31: instruction cache enabled
> bit 30: data cache enabled
> bit 29: RAC present
> bit 25: DSU power enabled
> bit 24: data cache power enabled
> bit 19: low-latency memory bus (LMB) present
> bit 18: concurrent multi threading (CMT) present
> bit 17: reserved
> bit 12: split instruction cache
> bit 2: number of Hi/Lo special registers - 1
> bit 1: eDSP present

I'm curious, is there any bit that indicates a split data cache?

>
> This seems to match the recommended and default values
>
> > [    0.000000] bmips_cpu_setup: BMIPS_RAC_ADDRESS_RANGE =3D 0x277bdab0
>
> That does not look intended, the reset value is supposed to be 0. Can
> you apply the same values as the ones programmed in the CPU_BMIPS_3300 ca=
se?

I've just tried this but it still panics...

>
> > [    0.000000] bmips_cpu_setup: BMIPS_L2_CONFIG =3D 0x241a0008
>
>
> > [    0.000000] bmips_cpu_setup: BMIPS_LMB_CONTROL =3D 0x0
>
> LMB not enabled, that's OK.
>
> > [    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x3c1b8041
> > [    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x3c1b8041
> > [    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG_1 =3D 0x3600008
> > [    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG_1 =3D 0x3600008
> >
> > As you can see the bit's aren't set and all the registers appear to
> > have strange values and not the usual ones when initialized by the
> > bootloader...
>
> Yes, so maybe the best way to go about is indeed to go with your change
> such that if we are running on TP1, it is safe to assume that CFE has
> not done any sensible initialization, and we have a non functional RAC.

Yes, I will send v2 checking if we're running on TP1.

>
> >
> >>
> >>>
> >>> Maybe the correct way of solving the issue would be by adding the
> >>> following code at bcm6358_quirks():
> >>> if (read_c0_brcm_cmt_local() & (1 << 31))
> >>>       bmips_dma_sync_disabled =3D 1;
> >>>
> >>> BTW, if I understood it correctly, you want me to reverse the logic,
> >>> so bmips_dma_sync_disabled instead of bmips_dma_sync_enabled.
> >>> Is this correct?
> >>
> >> Yes, I want the logic such that we need to set a variable to 1/true
> >> rather setting one to 0, less change to get it wrong IMHO.
> >>
> >>>
> >>> Best regards,
> >>> =C3=81lvaro.
> >>>
> >>>
> >>> El lun, 13 mar 2023 a las 18:37, Florian Fainelli
> >>> (<f.fainelli@gmail.com>) escribi=C3=B3:
> >>>>
> >>>> On 3/12/23 11:50, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> >>>>> Hi Florian,
> >>>>>
> >>>>> I tried what you suggested but it stil panics on EHCI:
> >>>>>
> >>>>> [    0.000000] Linux version 5.15.98 (noltari@atlantis)
> >>>>> (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f=
5)
> >>>>> 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 20=
23
> >>>>> [    0.000000] bmips_cpu_setup: read_c0_brcm_config_0() =3D 0xe30e1=
006
> >>>>> [    0.000000] bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG =3D 0x3c1b80=
41
> >>>>> [    0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
> >>>>>
> >>>>> It looks like bit 29 is set so RAC should be present.
> >>>>> And RAC_I seems to be set, but not RAC_D...
> >>>>>
> >>>>> BTW, this is what I added to bmips_cpu_setup:
> >>>>>
> >>>>> case CPU_BMIPS4350:
> >>>>> cfg =3D read_c0_brcm_config_0();
> >>>>> pr_info("bmips_cpu_setup: read_c0_brcm_config_0() =3D 0x%x\n", cfg)=
;
> >>>>>
> >>>>> cfg =3D __raw_readl(cbr + BMIPS_RAC_CONFIG);
> >>>>> pr_info("bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG =3D 0x%x\n", cfg);
> >>>>> __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG);
> >>>>> __raw_readl(cbr + BMIPS_RAC_CONFIG);
> >>>>> break;
> >>>>
> >>>> Thanks for running those experiments, I cannot explain what you are
> >>>> seeing, so there must be some sort of erratum applicable to the
> >>>> BMIPS4380 revision used on the 6358 somehow...
> >>>>
> >>>> If you can make the suggested change to use negative logic in order =
to
> >>>> disable the RAC flushing, that would work for me, also maybe add a
> >>>> Fixes: tag so it gets backported to stable trees?
> >>>>
> >>>> Thanks!
> >>>> --
> >>>> Florian
> >>>>
> >>
> >> --
> >> Florian
> >>
> >
> > =C3=81lvaro
>
> --
> Florian
>

=C3=81lvaro
