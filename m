Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285869DDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjBUKWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjBUKWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:22:06 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C81E10428;
        Tue, 21 Feb 2023 02:22:05 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id h6-20020a9d7986000000b0068bd8c1e836so692213otm.3;
        Tue, 21 Feb 2023 02:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30shyJsOAw2zs6Sgq+PUulpeZPcaVAnq8cjIhLP8b54=;
        b=elznRG7Pcy5Yc4r13B85Rv7Bb/wSbDxBrGsxqTtE4BDZkGHucYkpj4EOaS8TrEB40c
         dbKiG2oMsgB4BbiurMCLRitbQ5qXrWR6DbFU3Bvd+CdQNdziLtEmGd5YRGPXoHSso1iu
         0QDrBn1lhOWBp1ZbNiPHZGd+5rRKA018QmBLt+f4s5kY8sKfBEAYqEzv8J2OCGyNcl/g
         Q521vs0aJoAI5Igv6eblmgFIuIMRGB/Ll7uw0OEbDJWIGEKBrQTrLg0hizAPniyazVqp
         C4g//etSa4Mdiax2wpETKvZF3luMrTKZKr280C5koJ1mTRTbdkb5aRQz74QdcL9/YkVO
         IYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30shyJsOAw2zs6Sgq+PUulpeZPcaVAnq8cjIhLP8b54=;
        b=HKSLjW3WoMvktonqxhl2xvDHOxnwvZf9Khhql7Lx42F8jwsk63SH2+Bdn8h5o9Pk+i
         ErGh96uZAkqNU6KansRfyTQN2JAKDlnrNL0vM9i6aJsCTzWBT59r2M/cYoUOeJzZvjFv
         3EGmDjuvd2AewaW19FLvTqUrXUtIIcs9XhL0JZF49K/nHrzJpNnKBYHpHXoWp5isUI6+
         d1I6JtFM3V8oZYVOZx95L8CaVs6svB2pqYWK2MyFCUI9A6tQVfACdBzjkGwV0xR2Whaq
         NJ/BbpBK/L/vx7VTjvzJluknP27SpA9KzdyHccp5GnLTEbQTsPja65jzCEUjZUBH/tlC
         uVNw==
X-Gm-Message-State: AO0yUKU703iE5q496UtJb7rjdvVp3WU6pnG/DU/uOUgD37YMKzjpLxN7
        k9kxPwlSqyJGfTq6opEup8K4rBBHjkdkeyyr9lelzhk7tOA=
X-Google-Smtp-Source: AK7set/LMCWIpWdHwoyBDJak/9l2Ne166sgq+MuWerSv36XxA3hiTz0NvEqvSSMqcauwSt0h4Cf6gjVyxOZc44SjW0g=
X-Received: by 2002:a05:6830:30af:b0:690:f512:20a with SMTP id
 g47-20020a05683030af00b00690f512020amr228730ots.3.1676974924525; Tue, 21 Feb
 2023 02:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20230221092435.22069-1-arinc.unal@arinc9.com> <20230221092435.22069-2-arinc.unal@arinc9.com>
 <CAMhs-H9qLw6uhjPnFWovQBMFe38y95Q_VvG8Bj9wovSR+1J_2g@mail.gmail.com> <85a39e81-51a3-e90f-622e-f2cc7528aa92@arinc9.com>
In-Reply-To: <85a39e81-51a3-e90f-622e-f2cc7528aa92@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Feb 2023 11:21:53 +0100
Message-ID: <CAMhs-H_eLwxjA7-EKGSyKOZLQF05N-FNASZWtGgsV2S=txU=yQ@mail.gmail.com>
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

On Tue, Feb 21, 2023 at 11:09 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arin=
c9.com> wrote:
>
> On 21.02.2023 12:38, Sergio Paracuellos wrote:
> > Hi Ar=C4=B1n=C3=A7,
> >
> > On Tue, Feb 21, 2023 at 10:24 AM <arinc9.unal@gmail.com> wrote:
> >>
> >> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>
> >> Currently, out of every Ralink SoC, only the dt-binding of the MT7621 =
SoC
> >> uses pinctrl. Because of this, PINCTRL is not selected at all. Make
> >> SOC_MT7621 select PINCTRL.
> >>
> >> Remove PINCTRL_MT7621, enabling it for the MT7621 SoC will be handled =
under
> >> the PINCTRL_MT7621 option.
> >>
> >> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >> ---
> >>   arch/mips/ralink/Kconfig | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> >> index 06031796c87b..83e61e147b90 100644
> >> --- a/arch/mips/ralink/Kconfig
> >> +++ b/arch/mips/ralink/Kconfig
> >> @@ -54,7 +54,7 @@ choice
> >>                  select HAVE_PCI
> >>                  select PCI_DRIVERS_GENERIC
> >>                  select SOC_BUS
> >> -               select PINCTRL_MT7621
> >> +               select PINCTRL
> >>
> >>                  help
> >>                    The MT7621 system-on-a-chip includes an 880 MHz MIP=
S1004Kc
> >> --
> >> 2.37.2
> >>
> >
> > Which git tree are you working against? CONFIG_SOC_MT7621 is not
> > selecting PINCTRL_MT7621 at all in v6.2 [0]. I think it should select
>
> mips/linux.git mips-next tree.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/

I see :). Thanks!

>
> > 'PINCTRL_MT7621' and the 'select PINCTRL' stuff added inside the
> > PINCTRL_RALINK option in [1].
>
> I'm working on that, although not exactly the way you describe here, on
> this branch of mine.

So, in which way do you get PINCTRL_MT7621 automatically selected for
this SoC now? I think looking into the Kconfig for ralink pinctrl [0]
all of them at the end need the missing PINCTRL option to be added and
all of them are currently selecting PINCTRL_RALINK . Hence just adding
the PINCTRL option inside PINCTRL_RALINK looks convenient.

>
> https://github.com/arinc9/linux/commits/ralink-pinctrl

Wow! Tons of changes here ;-). Keep going!!

>
> Ar=C4=B1n=C3=A7

Best regards,
    Sergio Paracuellos

[0]: https://elixir.bootlin.com/linux/v6.2/source/drivers/pinctrl/ralink/Kc=
onfig
