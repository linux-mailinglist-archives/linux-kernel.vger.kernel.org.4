Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC369E381
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjBUPdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjBUPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:33:47 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EA66A43;
        Tue, 21 Feb 2023 07:33:40 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1720f9792bbso5449775fac.4;
        Tue, 21 Feb 2023 07:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D29YAjo/vlcZUbv7tADo/2Ki8JawYXw8Kzg/3LElpp4=;
        b=OoiQTkERW8eWUbe7ZCHe6KTK8lrEIdOHfrH4wtXYwRpcGBa0TbQ38tl9y+a8ctDPxF
         0JQDGrzPDIOYXtUHkZmuTP8vYP4fvWG77H0bfow15b08ZXZ2cAQNFvhWFjrpdZZxEMFi
         XyHYDDzgwsdDadFMEMn4xnAsci0V/aQZN+BKXdXb6NdA1GnGOggBJZOisiWwM9C3kj6k
         PvorCGhweKgh+61DyhaNqPJe10KoVwQET/bfIBMYN++OS0gr8V+8LsV+2LFGl8cl5e6q
         ZHAknoomzE0/jAGN28disDeZMZMnwr/6xbFsQ5mrmGq9v4iGK6aMPTE/ssGMgbO8NH6R
         Cw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D29YAjo/vlcZUbv7tADo/2Ki8JawYXw8Kzg/3LElpp4=;
        b=oHP06F69GaaLTaNJzKzOQMIdfDVgzR4wjC4SNgDmR5jIBVUAfS8f3VWyb7jzbbJpGd
         cg2b+fysHEgFBlxtTO2eBMO8SW+CZxtD/csPPwvsckDJ4b7A0C9J8UVAHCIJ433QC/lM
         a0ukZe+gDdrmBoZLUwriEOyf0NwFupOVCynfNEj4VVW/mAJYmbpFMrsDAPr5V9vF2vU4
         98VHaTv+freULgSlFFOkhWypqmiECcQe1eDFrBucvLQmICIdcN6P5sFVukzrAHMses3F
         OnMRycBlUl2qMhdKmLxhhxD3veEQbcPA0PiEwsyEJMdMG/EwqL9wkS5p8YsUZYgV5il1
         4Viw==
X-Gm-Message-State: AO0yUKXt7r7xa+/jAzt9WkKGAH6EU9UmDfgepUFr6vRvAUz4eI4KDc8f
        mzO4KsPrQQTSl4UM3zJQR+PIPL+ZbwvTnzKhtK4=
X-Google-Smtp-Source: AK7set8/8UgTK2difMidimMlDAR2s6fhkhNrMTBsCT6sW5b3cBTC99aQOLdIIIQSls2i06Wb7kS5saE7CzggDeYcG+w=
X-Received: by 2002:a05:6870:b016:b0:171:f3aa:8da5 with SMTP id
 y22-20020a056870b01600b00171f3aa8da5mr464486oae.239.1676993619369; Tue, 21
 Feb 2023 07:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20230221092435.22069-1-arinc.unal@arinc9.com> <20230221092435.22069-2-arinc.unal@arinc9.com>
 <CAMhs-H9qLw6uhjPnFWovQBMFe38y95Q_VvG8Bj9wovSR+1J_2g@mail.gmail.com>
 <85a39e81-51a3-e90f-622e-f2cc7528aa92@arinc9.com> <CAMhs-H_eLwxjA7-EKGSyKOZLQF05N-FNASZWtGgsV2S=txU=yQ@mail.gmail.com>
 <03ae6aab-1492-f8df-2432-cfca52a44131@arinc9.com>
In-Reply-To: <03ae6aab-1492-f8df-2432-cfca52a44131@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Feb 2023 16:33:27 +0100
Message-ID: <CAMhs-H_SqyZUjYzpNQy8E-6jmia5WQyNPR8RDz_f9tiNg_QBjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mips: ralink: make SOC_MT7621 select PINCTRL
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, erkin.bozoglu@xeront.com
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

On Tue, Feb 21, 2023 at 11:54 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arin=
c9.com> wrote:
>
> On 21.02.2023 13:21, Sergio Paracuellos wrote:
> > On Tue, Feb 21, 2023 at 11:09 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@=
arinc9.com> wrote:
> >>
> >> On 21.02.2023 12:38, Sergio Paracuellos wrote:
> >>> Hi Ar=C4=B1n=C3=A7,
> >>>
> >>> On Tue, Feb 21, 2023 at 10:24 AM <arinc9.unal@gmail.com> wrote:
> >>>>
> >>>> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>>
> >>>> Currently, out of every Ralink SoC, only the dt-binding of the MT762=
1 SoC
> >>>> uses pinctrl. Because of this, PINCTRL is not selected at all. Make
> >>>> SOC_MT7621 select PINCTRL.
> >>>>
> >>>> Remove PINCTRL_MT7621, enabling it for the MT7621 SoC will be handle=
d under
> >>>> the PINCTRL_MT7621 option.
> >>>>
> >>>> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>> ---
> >>>>    arch/mips/ralink/Kconfig | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> >>>> index 06031796c87b..83e61e147b90 100644
> >>>> --- a/arch/mips/ralink/Kconfig
> >>>> +++ b/arch/mips/ralink/Kconfig
> >>>> @@ -54,7 +54,7 @@ choice
> >>>>                   select HAVE_PCI
> >>>>                   select PCI_DRIVERS_GENERIC
> >>>>                   select SOC_BUS
> >>>> -               select PINCTRL_MT7621
> >>>> +               select PINCTRL
> >>>>
> >>>>                   help
> >>>>                     The MT7621 system-on-a-chip includes an 880 MHz =
MIPS1004Kc
> >>>> --
> >>>> 2.37.2
> >>>>
> >>>
> >>> Which git tree are you working against? CONFIG_SOC_MT7621 is not
> >>> selecting PINCTRL_MT7621 at all in v6.2 [0]. I think it should select
> >>
> >> mips/linux.git mips-next tree.
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/
> >
> > I see :). Thanks!
> >
> >>
> >>> 'PINCTRL_MT7621' and the 'select PINCTRL' stuff added inside the
> >>> PINCTRL_RALINK option in [1].
> >>
> >> I'm working on that, although not exactly the way you describe here, o=
n
> >> this branch of mine.
> >
> > So, in which way do you get PINCTRL_MT7621 automatically selected for
> > this SoC now? I think looking into the Kconfig for ralink pinctrl [0]
> > all of them at the end need the missing PINCTRL option to be added and
> > all of them are currently selecting PINCTRL_RALINK . Hence just adding
> > the PINCTRL option inside PINCTRL_RALINK looks convenient.
>
> PINCTRL_RALINK won't appear on the menuconfig unless PINCTRL is enabled.
> So this'd be pointless.

Oh, yes. You are totally right. My bad here, sorry for the noise.

>
>  From what I see on other MIPS and ARM platforms, PINCTRL is supposed to
> be enabled at the platform option, like CONFIG_RALINK. However, the
> Ralink SoCs except MT7621, or rather the DTs for them, do not use the
> pinctrl driver so I only enable it for MT7621, and keep it optional for
> the remaining SoCs.
>
> MediaTek pinctrl kconfig enables the pinctrl driver specific to the SoC
> by default, if the said SoC is enabled. I'm keeping this method when
> moving ralink pinctrl to mediatek with the series below.
>
> So once the pinctrl driver is defined on the DTs for the remaining SoCs,
> we can just put PINCTRL under CONFIG_RALINK and everything will work fine=
.

Sounds good, then. Thanks!

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

>
> >
> >>
> >> https://github.com/arinc9/linux/commits/ralink-pinctrl
> >
> > Wow! Tons of changes here ;-). Keep going!!
>
> Thanks a lot, I've started to refactor everything Ralink. With this
> series, I finalise the work on pinctrl.
>
> Ar=C4=B1n=C3=A7

Best regards,
    Sergio Paracuellos
