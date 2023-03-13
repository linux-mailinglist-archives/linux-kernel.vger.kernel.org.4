Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF16B8416
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCMVjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCMVjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:39:35 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5798B302;
        Mon, 13 Mar 2023 14:39:31 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-541a05e4124so80089287b3.1;
        Mon, 13 Mar 2023 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678743570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JXlbj1faTAj8EHCq7W4vAIdTKPi8yA3Zju7BfiDTic=;
        b=RHdGsjoy1dll6IdiStmheyksBtAqRtxsXGBKDpVRGr2GcpN9reO/LAhKAOwJ6kl4sb
         jYbOGWAZgDfJiAg1RKqHN72zz55N4672/SifWa9RTiftbGjxwjq0LG2lW/6CzJxY8zzF
         Jw2k4ZKdgRPwzctl2BPv7ueKVDuLpA4SKfuTn6//klpbCuwvUSI6DybJhdwYAEFeJ4Hh
         fkaMUYHxTuOvQOQqdv2FQsSfpdtAe9SmrDaWc5pqmnVbfORJtl2tWPv/TG6bDWudju1U
         XHBuAQYhgTXfPd+KBjyWhrWVQw/4hLamYe3eQSpEeHrGN26Fmwapq0BAIalRvsFF0XL9
         mMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678743570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JXlbj1faTAj8EHCq7W4vAIdTKPi8yA3Zju7BfiDTic=;
        b=oqekwlLW300Hr5p8bpur2JiFc/VAUfmukr4F2Ffi1ceuFNCC0+UashPwA7lf0yHOOb
         cH13L0BUMrd71Ld/BH9K+oLC0xi5BzqsJo+BdzB1PDddl+pk/qrYOVi8ElqctmaA27B4
         VnA6FhZv/bMEWR4s5jUFMOBrkCrosxdHGvPArj0WHFEffNgUpCPSbapRAuwoV9uBIbh7
         CN7wDRr2iB8O0eEEH/ELz7RpkYAjRNZHdi8Tj5SFkP4f2EXjG97m6FUOvOSwx741SQ/B
         wIEKusa8L1BaAoIWWnb+ohX0NtJOTMj+m8dMGBtACEE/oi8yFXqRm0FOhzyYIUrgtI2I
         nluA==
X-Gm-Message-State: AO0yUKXYxES0OCWJ97WxKcjJO68ShZKUxw39e3krhC40q5ojh6MsmS8z
        Yuyfshj/MK+x9WYzQrCuGMFj8Mv8d8PBLj4IKnc=
X-Google-Smtp-Source: AK7set8gyoVgmVJ0bH1A0Ukh8d5UbesQp5whWIp9pFhSPf6sWaCkuiCgI2nVLCio4rpycn/kTDVe2uX6kCgFCktWM/w=
X-Received: by 2002:a81:a782:0:b0:541:6763:3ce1 with SMTP id
 e124-20020a81a782000000b0054167633ce1mr5823421ywh.2.1678743570108; Mon, 13
 Mar 2023 14:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230310121306.4632-1-noltari@gmail.com> <da5d150e-a2db-573d-e231-b4fd9fdaf63b@gmail.com>
 <CAOiHx=njCvfVju9BAe7gTzMq0vybQF-gy4SRZrhEJFULGLhC7w@mail.gmail.com>
 <5b4d3eef-ff80-29e8-9be0-d487aee5e4e2@broadcom.com> <a88fc41b-69d3-b042-fa91-e403d1263742@gmail.com>
 <CAKR-sGfL5_VU9uxJHGyZ-bj2P_7R6+OOfWs6Yf-ihcCF8bD2MA@mail.gmail.com> <e3cff853-8d5d-acdf-8e6a-3322c4de2023@gmail.com>
In-Reply-To: <e3cff853-8d5d-acdf-8e6a-3322c4de2023@gmail.com>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Mon, 13 Mar 2023 22:39:19 +0100
Message-ID: <CAKR-sGcyMF26NGoeEApKuKDe6=14nCGKwRYx-o68LHAcmUNXhA@mail.gmail.com>
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

I did another test changing from TP1 to TP0 and this is the result:
[ 0.000000] Linux version 5.15.98 (noltari@atlantis)
(mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
[ 0.000000] bmips_cpu_setup: read_c0_brcm_config_0() =3D 0xe30e1006
[ 0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG =3D 0x2a00015
[ 0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)

And there were no exceptions with EHCI/OHCI as opposed to TP1.
So the issue is only happening when booting from TP1.
Maybe it's due to the fact that BCM6358 has a shared TLB?

Maybe the correct way of solving the issue would be by adding the
following code at bcm6358_quirks():
if (read_c0_brcm_cmt_local() & (1 << 31))
    bmips_dma_sync_disabled =3D 1;

BTW, if I understood it correctly, you want me to reverse the logic,
so bmips_dma_sync_disabled instead of bmips_dma_sync_enabled.
Is this correct?

Best regards,
=C3=81lvaro.


El lun, 13 mar 2023 a las 18:37, Florian Fainelli
(<f.fainelli@gmail.com>) escribi=C3=B3:
>
> On 3/12/23 11:50, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > Hi Florian,
> >
> > I tried what you suggested but it stil panics on EHCI:
> >
> > [    0.000000] Linux version 5.15.98 (noltari@atlantis)
> > (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
> > 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
> > [    0.000000] bmips_cpu_setup: read_c0_brcm_config_0() =3D 0xe30e1006
> > [    0.000000] bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG =3D 0x3c1b8041
> > [    0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
> >
> > It looks like bit 29 is set so RAC should be present.
> > And RAC_I seems to be set, but not RAC_D...
> >
> > BTW, this is what I added to bmips_cpu_setup:
> >
> > case CPU_BMIPS4350:
> > cfg =3D read_c0_brcm_config_0();
> > pr_info("bmips_cpu_setup: read_c0_brcm_config_0() =3D 0x%x\n", cfg);
> >
> > cfg =3D __raw_readl(cbr + BMIPS_RAC_CONFIG);
> > pr_info("bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG =3D 0x%x\n", cfg);
> > __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG);
> > __raw_readl(cbr + BMIPS_RAC_CONFIG);
> > break;
>
> Thanks for running those experiments, I cannot explain what you are
> seeing, so there must be some sort of erratum applicable to the
> BMIPS4380 revision used on the 6358 somehow...
>
> If you can make the suggested change to use negative logic in order to
> disable the RAC flushing, that would work for me, also maybe add a
> Fixes: tag so it gets backported to stable trees?
>
> Thanks!
> --
> Florian
>
