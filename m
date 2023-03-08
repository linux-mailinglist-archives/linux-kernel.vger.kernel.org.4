Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5B6B0212
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCHIwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCHIwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:52:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC6A7680;
        Wed,  8 Mar 2023 00:52:03 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u9so62781502edd.2;
        Wed, 08 Mar 2023 00:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpuATYH576ZDI1iTQwP/d6/sFiNmor1rlVdEpEkwzQw=;
        b=Ylq2aKC5yQtP2jkeP6YncjXIl7de9gIVaIZDeerEQjX5apkdaAgXS6imYMtVdM//pi
         38ZCCpGIP6nQY00OhIZMKt7DIcW7KkfH+QW8ia/8ge0J0yXHGdnelGNzdrqLmsYJEOkq
         LKJ/Suwb/pnv2hVfaqActCuvpEc5TFC+G3Sq3irI3IMMRTd3ENAybcdo+vDVEl7RvYFa
         dX4vqpLRf8juxF8oS5UVL1jkz67SjrHHPUXqER62YDS1PUtyRk9BuhdmPP3lKQzZUw+Y
         voa+6AVSbT4ONppbBhWs2GD6eTn9ewR0s0izUJixvndIOYQwYz26hGYrqWCLSC/d9Kiu
         hGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpuATYH576ZDI1iTQwP/d6/sFiNmor1rlVdEpEkwzQw=;
        b=Hqrdnjj0rNWh9WqEP7avVPnUwTlufd6SA+U4DklFNyQrpAo59/aocx06MfVHhiWV6I
         Lqlr7vujgG/CwRtcyUTIRTSJEXwOAjLtlxiGFcVEog9UQyskqNBtCJRCWmyYO3+ho4aJ
         v7ZIQVo2eC0Js4A/fc67aUw01tsJrgYGGTgS7zKvXYTjzjKlth3LHwRrwU9TOnanUL2F
         WzX2JrF/BjSkTc4Hkaoqzv0tEKZTx48bE0vyk57h2zT52E/ZaNFOsP6fnGynAveJWwd0
         65X7xswsl7XVXoFIMaaj5ixjyaO7p9ekO9XkfTLykClSzb8LY0g8/XvxOUF2BINjoRtD
         h10A==
X-Gm-Message-State: AO0yUKV7xSiiu/5lzJ52wqlQ5yP0AhclVi+vK8Gpe4ZnJTceSWYIzZ+S
        O8Cy7I+8Sjp11P34RA4/BFFihoeCrIgnGnquYYCkjKNo
X-Google-Smtp-Source: AK7set9JRa0H6LVEN6vuDg4aOlk7z4nx+H8OsBuyOmysC5wOkuiJVgcutdMuV1YVu5slUZsUGienaGPodHUpgHcutFw=
X-Received: by 2002:a50:baa7:0:b0:4ac:b832:856c with SMTP id
 x36-20020a50baa7000000b004acb832856cmr9599865ede.1.1678265522150; Wed, 08 Mar
 2023 00:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20230308083759.11692-1-clamor95@gmail.com> <202303080844360ced8b82@mail.local>
 <CAPVz0n2XErDOCERV+XO3ek4_15hiwTasy4agLZLijqx2z67UnA@mail.gmail.com> <df35ed19-74d3-5eea-8efb-588417a417f2@linaro.org>
In-Reply-To: <df35ed19-74d3-5eea-8efb-588417a417f2@linaro.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 10:51:51 +0200
Message-ID: <CAPVz0n0N=ChOatodt_W-cAne6Tqwa-1crUjWLuHf1HugpNLXuA@mail.gmail.com>
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Ooof, my bad. I will resend v2 with fix asap.

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 10:49 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 08/03/2023 09:46, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 10:44 A=
lexandre Belloni
> > <alexandre.belloni@bootlin.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> Hello,
> >>
> >> the subject is not correct, please use the subsystem style
> >>
> >> On 08/03/2023 10:37:59+0200, Svyatoslav Ryhel wrote:
> >>> MAX77663 PMIC can have RTC on both 0x63 i2c address (like grouper)
> >>> which is main address but on some devices RTC is located on 0x48
> >>> i2c address (like p880 and p895 from LG). Lets add property to be
> >>> able to use alternative address if needed without breaking existing
> >>> bindings.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>  drivers/rtc/rtc-max77686.c | 8 +++++++-
> >>>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> >>> index b0250d91fb00..218177375531 100644
> >>> --- a/drivers/rtc/rtc-max77686.c
> >>> +++ b/drivers/rtc/rtc-max77686.c
> >>> @@ -691,6 +691,7 @@ static int max77686_init_rtc_regmap(struct max776=
86_rtc_info *info)
> >>>  {
> >>>       struct device *parent =3D info->dev->parent;
> >>>       struct i2c_client *parent_i2c =3D to_i2c_client(parent);
> >>> +     int rtc_i2c_addr;
> >>>       int ret;
> >>>
> >>>       if (info->drv_data->rtc_irq_from_platform) {
> >>> @@ -714,8 +715,13 @@ static int max77686_init_rtc_regmap(struct max77=
686_rtc_info *info)
> >>>               goto add_rtc_irq;
> >>>       }
> >>>
> >>> +     ret =3D device_property_read_u32(parent, "maxim,rtc-i2c-address=
",
> >>> +                                    &rtc_i2c_addr);
> >>
> >> This property needs to be documented
> >>
> >
> > max776xx pmic has no yaml to document
>
> Of course it has, otherwise on what did I work?
>
> git grep max77686
>
>
> Best regards,
> Krzysztof
>
