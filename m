Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81B970269B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbjEOIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbjEOIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:03:39 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022726A4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:01:15 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-452f317e304so2890113e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684137674; x=1686729674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhB6D2mBgNYWOcxL7gtrfu2QJzPbQO2mileHEDqqD+g=;
        b=tBds+1Rb94ncth5clUQwX1GHR0sEOSgAQjuBcqla8ixZCmaOiT9n/8oHbzwQelIn61
         ALDeW4yYNBcB3VMMXxw2LrjhLsx+M5EYV7dr0VyA1fwoOaFLgG7L+ttOty+a0q/jlPJ3
         cSxytH79/Iqf5lHMWR9E61ymhjdmJr5z271yuRu4JqvF7FCjCyo7/A7wWx7opiJ7/r/I
         RavVvNrwUJxRvfLtPzwFK8udrgYvPDkDTCtfg0wFFimDSF/w7K7TJOY2ifQ5wvWHdkxT
         G73O0fEUyFSh+EbJzpEVQi157Fda7MQ+VxTCGAwngC7qQ3KEBgj1gwRX1Ea95+z10hB+
         cxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684137674; x=1686729674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhB6D2mBgNYWOcxL7gtrfu2QJzPbQO2mileHEDqqD+g=;
        b=LSVvJTMDXtdWytIoeer/fDm2pYHrvc/rit4gJ/GgNmyAqYi2pSCNh72r/obaXhY0Ek
         eEO9bkNOBSAJXTw01JBYVc+xETZNgprZhP8XUy7RdxQjKH2xnJ0WqS11lHoy7ez6pTh9
         XXDopm6C4fTkFF5PfW+sr8UrhsEQ1BJ4SE9ncPVsnUTp4riKYODfc83/BTzy4ZdiyEYr
         LQnhhRDQsW+S9ymiu+Jq56pkwaJVMAT1PpYUf2e79nDKoq6wx7EVwW8IiMCavabv1Aoo
         V6Ij/sqg+aPQfEEwcRC6LWECkf92CXEn3qzz4+NuDFypetGOqqE6S7Ncnn8yEDyfVdzY
         SlWQ==
X-Gm-Message-State: AC+VfDxUSsHdGcSPQnSQAxiIMmk3GlM7sWEEWaIP82HitKZrUdPLVehv
        kAWkOjXa6fSbFT6VZXAlfg9tSXQypswOoSJMqRMdCg==
X-Google-Smtp-Source: ACHHUZ4VM5oZef2/vINe45Q6hG3XQ5373nE1uW4H5hdogJhf2Xuiz0zpleiaXuG74HnehwxG3s+fDUslCXToNltXZ1o=
X-Received: by 2002:a1f:cf44:0:b0:43f:c8ee:62e9 with SMTP id
 f65-20020a1fcf44000000b0043fc8ee62e9mr9667239vkg.15.1684137674258; Mon, 15
 May 2023 01:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230512153232.92450-1-brgl@bgdev.pl> <7738357b-801c-e1a7-8ea9-28d8a3d3d997@linaro.org>
In-Reply-To: <7738357b-801c-e1a7-8ea9-28d8a3d3d997@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 15 May 2023 10:01:02 +0200
Message-ID: <CAMRc=Mfb6xYVrgurL=ZfsNwUT4ghqgOYgg11ij7LjLaVUwJEGg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sa8775p: add the wakeirq map
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 11:26=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:
>
>
>
> On 12.05.2023 17:32, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The SA8775P TLMM driver is missing the GPIO-to-wakeup-pin mapping. This
> > adds it.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> This almost matches
>
> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/d7af4a14603957=
d414e931b5f175f36f3537ae34
>
> minus one diff:
>
> < { 39, 200 },
> ---
> > { 30, 200 },
>

It's my typo, thanks for catching it.

Bartosz

> please consult which one is correct with qc folks
>
> Konrad
> >  drivers/pinctrl/qcom/pinctrl-sa8775p.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/pinctrl/qcom/pinctrl-sa8775p.c b/drivers/pinctrl/q=
com/pinctrl-sa8775p.c
> > index 2ae7cdca65d3..422d72ed1012 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> > @@ -1491,6 +1491,23 @@ static const struct msm_pingroup sa8775p_groups[=
] =3D {
> >       [153] =3D SDC_QDSD_PINGROUP(sdc1_data, 0x199000, 9, 0),
> >  };
> >
> > +static const struct msm_gpio_wakeirq_map sa8775p_pdc_map[] =3D {
> > +     { 0, 169 }, { 1, 174 }, { 2, 170 }, { 3, 175 }, { 4, 171 }, { 5, =
173 },
> > +     { 6, 172 }, { 7, 182 }, { 10, 220 }, { 11, 213 }, { 12, 221 },
> > +     { 16, 230 }, { 19, 231 }, { 20, 232 }, { 23, 233 }, { 24, 234 },
> > +     { 26, 223 }, { 27, 235 }, { 28, 209 }, { 29, 176 }, { 39, 200 },
> > +     { 31, 201 }, { 32, 212 }, { 35, 177 }, { 36, 178 }, { 39, 184 },
> > +     { 40, 185 }, { 41, 227 }, { 42, 186 }, { 43, 228 }, { 45, 187 },
> > +     { 47, 188 }, { 48, 194 }, { 51, 195 }, { 52, 196 }, { 55, 197 },
> > +     { 56, 198 }, { 57, 236 }, { 58, 192 }, { 59, 193 }, { 72, 179 },
> > +     { 73, 180 }, { 74, 181 }, { 75, 202 }, { 76, 183 }, { 77, 189 },
> > +     { 78, 190 }, { 79, 191 }, { 80, 199 }, { 83, 204 }, { 84, 205 },
> > +     { 85, 229 }, { 86, 206 }, { 89, 207 }, { 91, 208 }, { 94, 214 },
> > +     { 95, 215 }, { 96, 237 }, { 97, 216 }, { 98, 238 }, { 99, 217 },
> > +     { 100, 239 }, { 105, 219 }, { 106, 210 }, { 107, 211 }, { 108, 22=
2 },
> > +     { 109, 203 }, { 145, 225 }, { 146, 226 },
> > +};
> > +
> >  static const struct msm_pinctrl_soc_data sa8775p_pinctrl =3D {
> >       .pins =3D sa8775p_pins,
> >       .npins =3D ARRAY_SIZE(sa8775p_pins),
> > @@ -1499,6 +1516,8 @@ static const struct msm_pinctrl_soc_data sa8775p_=
pinctrl =3D {
> >       .groups =3D sa8775p_groups,
> >       .ngroups =3D ARRAY_SIZE(sa8775p_groups),
> >       .ngpios =3D 150,
> > +     .wakeirq_map =3D sa8775p_pdc_map,
> > +     .nwakeirq_map =3D ARRAY_SIZE(sa8775p_pdc_map),
> >  };
> >
> >  static int sa8775p_pinctrl_probe(struct platform_device *pdev)
