Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710DB62F849
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbiKROxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiKROxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:53:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B123174;
        Fri, 18 Nov 2022 06:53:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y16so9575471wrt.12;
        Fri, 18 Nov 2022 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+Z7oWAPPsDnqJl4jYjtLn8srMZpWZECpL2xbCE05iM=;
        b=ZGk3BZJO/BX+srK7si/NN/z/6Wb0cgxYbmyPK6xdNIRXFisBUdw9QGSyZ0YHFNyxeg
         E6UhaEzD+Jq54LtcCIJAO13d2M3QDscD9pkf5y8SdkOTZiw5im+O+387Ak3pAKRSfmCW
         +lIm2ZKavreqs5dWHhJevhTwbEj8L7gsZIdCsEiB2f+p7ZDet27Wyc14xofsx53HAW2D
         6co4fiHzgbiku8f+L0fI19yg8jcs1JkXiIXclU8jZ4WZqCDYzI+NwWADhcOybQSwKApA
         Wo0/hegz1HHJqnjutHW2RmUKIF8W4O7cm2QUIYhYH0upXFfsxJu5JpBwRaVJ/VBDrUyu
         ueMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O+Z7oWAPPsDnqJl4jYjtLn8srMZpWZECpL2xbCE05iM=;
        b=jWFGHw+IQjlRygHmmMoa3HXLp9e4XzfkAZtE3d94tsPauPRTZzVtO8GKXvy89WJpwn
         Ignx/P2cl9enWK426dy8Fxo3paKxtLSXF5A/9V1axNcjwJE9zsXfvzSCwev+VZsBH2Lu
         8cTiDe5psEqfy9R3hKGwCkiNMstAJ4/VZCKE8EVLVBMQxG6U62t++k7fTrROqnBDD99Z
         0N4oGcdq24b2jl0/XhaCxHm4WDS8gx/Hu9bDPYNd3ZTdpcMXaPbr8oooGHv5wQQURxvV
         b/a5RH09uhifqlhlDHS1lfma5owYPPxuFOKjKmwW/DOSvBhWFmfEGeDSGfEYij0FznSE
         oyJw==
X-Gm-Message-State: ANoB5pkdvagCEMgvC1QIqA92LRWK5NsfZMqPXBqQdaJlk+D+Y4JcuN2n
        JgNZfX6Ru+xbC9C9YCSRSx4=
X-Google-Smtp-Source: AA0mqf41Oa+74ZDv1AvEaL4au10aUyqGoybsAt7f7b4HMj3QTDDbeDzy1OLqEPzPzaCTUXrwvo5ykw==
X-Received: by 2002:a5d:69d0:0:b0:236:6580:da06 with SMTP id s16-20020a5d69d0000000b002366580da06mr4515981wrw.627.1668783186244;
        Fri, 18 Nov 2022 06:53:06 -0800 (PST)
Received: from localhost (188.28.0.239.threembb.co.uk. [188.28.0.239])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003b435c41103sm11263434wmo.0.2022.11.18.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:53:05 -0800 (PST)
References: <20221108045300.2084671-1-lis8215@gmail.com>
 <20221108045300.2084671-2-lis8215@gmail.com>
 <CAPDyKFrMqCL1-faBadVP3xB-5qiCYsyRUuOHbFZuOWfLdCXwig@mail.gmail.com>
 <59EJLR.DQ7KHQEAEUSG2@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Siarhei Volkau <lis8215@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: jz4740: Don't change parent clock rate for
 some SoCs
Date:   Fri, 18 Nov 2022 14:18:07 +0000
In-reply-to: <59EJLR.DQ7KHQEAEUSG2@crapouillou.net>
Message-ID: <t9aKzNwdAtshY49d7AayzhwbD9leN37T@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Cercueil <paul@crapouillou.net> writes:

> Hi,
>
> (Ingenic SoCs maintainer here)
>
> Le ven. 18 nov. 2022 =C3=A0 09:45:48 +0100, Ulf Hansson <ulf.hansson@lina=
ro.org> a
> =C3=A9crit :
>> On Tue, 8 Nov 2022 at 05:53, Siarhei Volkau <lis8215@gmail.com> wrote:
>>>  Some SoCs have one clock divider for all MMC units, thus changing one
>>>  affects others as well. This leads to random hangs and memory
>>>  corruptions, observed on the JZ4755 based device with two MMC slots
>>>  used at the same time.
>> Urgh, that sounds like broken HW to me.
>> The MMC blocks could share a parent clock (that would need a fixed
>> rate for it to be applied), assuming there is a separate gate/divider
>> available per block. But there isn't'?
>
> They do share a parent clock and have separate gates, and each MMC IP blo=
ck has
> an internal divider for the bus frequency derived from that shared clock.
>
>>>  List of SoCs affected includes: JZ4725b, JZ4755, JZ4760 and JZ4760b.
>>>  However, the MMC driver doesn't distinguish JZ4760 and JZ4770
>>>  which shall remain its behavior. For the JZ4755 is sufficient to
>>>  use JZ4725b's binding. JZ4750 is outside of the patch.
>>>  The MMC core has its own clock divisor, rather coarse but suitable wel=
l,
>>>  and it shall keep the role of tuning clock for the MMC host in that
>>>  case.
>> The mmc core doesn't have a clock divisor, but it does control the bus
>> clock frequency through the ->set_ios() host ops. It needs to do that,
>> to be able to conform to the (e)MMC, SD and SDIO specifications.
>> Can you please try to elaborate on the above, so I can better
>> understand your point?
>
> Yes, I don't really understand the patch, TBH.
>
> The "clk_set_rate" call will only set the shared clock to the *maximum* c=
lock
> frequency (host->mmc->f_max) which should be the exact same across all MM=
C IPs.
>
> So it doesn't matter if it's set 3 times by 3 different instances of the =
IP, as
> long as they all request the same value.

Isn't the fact that 3 separate driver instances call clk_set_rate()
on a shared clock kind of... problematic? Nor is it documented that
all controllers need to use the same max-frequency.

Given it's a shared clock which can't realistically be controlled by
any of the consumers, I don't think it's unreasonable to assign the
clock frequency from the DT, but it needs to be backward-compatible
with old DTs.

On another note, shouldn't the MMC mux parent be assigned from the DT?
JZ4760 (and most other Ingenic SoCs) have multiple choices and I don't
see the parent being assigned anywhere.

Regards,
Aidan

>
> Besides, I know for a fact that the mainline driver works fine on the JZ4=
760(B)
> and JZ4725B.
>
> Finally... even if it was correct, this change would break compatibility =
with
> old Device Tree files.
>
> Cheers,
> -Paul
>
>>>  Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
>> Kind regards
>> Uffe
>>
>>>  ---
>>>   drivers/mmc/host/jz4740_mmc.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>  diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_m=
mc.c
>>>  index dc2db9c18..d390ff31d 100644
>>>  --- a/drivers/mmc/host/jz4740_mmc.c
>>>  +++ b/drivers/mmc/host/jz4740_mmc.c
>>>  @@ -114,6 +114,7 @@ enum jz4740_mmc_version {
>>>          JZ_MMC_JZ4740,
>>>          JZ_MMC_JZ4725B,
>>>          JZ_MMC_JZ4760,
>>>  +       JZ_MMC_JZ4770,
>>>          JZ_MMC_JZ4780,
>>>          JZ_MMC_X1000,
>>>   };
>>>  @@ -887,7 +888,13 @@ static int jz4740_mmc_set_clock_rate(struct
>>> jz4740_mmc_host *host, int rate)
>>>          int real_rate;
>>>          jz4740_mmc_clock_disable(host);
>>>  -       clk_set_rate(host->clk, host->mmc->f_max);
>>>  +
>>>  +       /*
>>>  +        * Changing rate on these SoCs affects other MMC units too.
>>>  +        * Make sure the rate is configured properly by the CGU driver.
>>>  +        */
>>>  +       if (host->version !=3D JZ_MMC_JZ4725B && host->version !=3D
>>> JZ_MMC_JZ4760)
>>>  +               clk_set_rate(host->clk, host->mmc->f_max);
>>>          real_rate =3D clk_get_rate(host->clk);
>>>  @@ -992,6 +999,7 @@ static const struct of_device_id jz4740_mmc_of_mat=
ch[]
>>> =3D {
>>>          { .compatible =3D "ingenic,jz4740-mmc", .data =3D (void *)
>>> JZ_MMC_JZ4740 },
>>>          { .compatible =3D "ingenic,jz4725b-mmc", .data =3D (void
>>> *)JZ_MMC_JZ4725B },
>>>          { .compatible =3D "ingenic,jz4760-mmc", .data =3D (void *)
>>> JZ_MMC_JZ4760 },
>>>  +       { .compatible =3D "ingenic,jz4770-mmc", .data =3D (void *)
>>> JZ_MMC_JZ4770 },
>>>          { .compatible =3D "ingenic,jz4775-mmc", .data =3D (void *)
>>> JZ_MMC_JZ4780 },
>>>          { .compatible =3D "ingenic,jz4780-mmc", .data =3D (void *)
>>> JZ_MMC_JZ4780 },
>>>          { .compatible =3D "ingenic,x1000-mmc", .data =3D (void *) JZ_M=
MC_X1000
>>> },
>>>  --
>>>  2.36.1
>>>
