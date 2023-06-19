Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0773593A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjFSOME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjFSOMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:12:03 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B58BB8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:12:00 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-57059626276so41410437b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1687183919; x=1689775919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSgLesRZe3XK9svI7DO/JvZqoNlNuyMtRCaFHnv2L+E=;
        b=X6+8JyKcaPHB7AK+cJJKPZyZbGRQQ/mO2aQ5hkcnjvovHEW2cunEHrts6QAJ/mwTi2
         43CF3DnN98Jc5fibm5ajT8XmVCkbxqXPDEL7OIx8+cXzGzIRQrvIE8UNN/9OzSogB18J
         snP0NbR34kfJ/dM7JwY2vKLJwTJ3iN1oEvwAJN+J1zrR67fkltCc04uEmiwuhLR/dT0v
         xl+/sc402EkH3cz3kc5Pr6qse8Wxm4636eeDwlLjT9i+9wiVG/YgFRbHqiOuroKlbJxX
         2jn8zJM6JkoEexPhdlrcKIkenTpcyXWs636uzSOaHXi/Ep8NKiPclbvpAnwzh2e0tsfp
         0SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687183919; x=1689775919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSgLesRZe3XK9svI7DO/JvZqoNlNuyMtRCaFHnv2L+E=;
        b=kTRbv81nkewhLRD0fqXpc86lhKerP5GMdTe/+HxzZqo582TVqeyCG2qD+zoNiD2ydU
         bUjv5KxEpwBUg+OSyoPuS6MQNO9P34d0gvGrK3SnoCigNYJ2X220o6fryrzUqXYTnlCx
         ODufpFfkpEPa4soL3sKPgdOTlL02OLb4kberGN9HFtanCJII+1FzfxD2RyyXR600mVZF
         73v32SaYLy3VTZJYw9OEFwAiC3yh5ecM8k+Ha9Fnkf96eQ8cLMYFhGHOSY5ib6sGq3KH
         3tERJCzyzqW9Z1A9c6NGoS7xF62VTogftfgRXlfRVFAlfFyo5dHY6Go3nzEyyknDBxB3
         JOxg==
X-Gm-Message-State: AC+VfDzfNifXdTCH+CHR5RTpKPYuZikTDQYSfL/9hTas8cnk6KPyNaSA
        C+gOru4s3/jvaWFLPO5WS3lj1NZ7NyCHcEYGGaep3w==
X-Google-Smtp-Source: ACHHUZ5ogfYmP/IJ2NvjeqZvZL4TifLjKNSFKzqLEH0w/B4WtWiGqLxT5J3OJF25r7AdRiNd4Yd7AMOhZj4Q2AkiydU=
X-Received: by 2002:a0d:dd46:0:b0:56f:ff55:2b7d with SMTP id
 g67-20020a0ddd46000000b0056fff552b7dmr11174210ywe.17.1687183919401; Mon, 19
 Jun 2023 07:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230617171512.286795-1-krzysztof.kozlowski@linaro.org> <4c71208b-5621-2495-a5de-3622a44d05d4@linaro.org>
In-Reply-To: <4c71208b-5621-2495-a5de-3622a44d05d4@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Mon, 19 Jun 2023 09:11:48 -0500
Message-ID: <CAKXuJqhQJftK9rjG_CRmuc93Sdi1-p0LCNZQ56Uwfxsa-V8WUA@mail.gmail.com>
Subject: Re: [RFT PATCH] arm64: dts: qcom: sdm850-c630: add missing panel supply
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 8:16=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> > Panel bindings (boe,nv133fhm-n61) require supply which here actually ca=
n
> > be turned on/off via GPIO control:
> >
> >   sdm850-lenovo-yoga-c630.dtb: panel: 'power-supply' is a required prop=
erty
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > ---
> >
> > Not tested on hardware
> > ---
> +Steev
>
> Konrad
> >  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arc=
h/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> > index cfbc4fc1eba9..3d871567cf81 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> > @@ -87,6 +87,25 @@ sn65dsi86_refclk: sn65dsi86-refclk {
> >               clock-frequency =3D <19200000>;
> >       };
> >
> > +     vph_pwr: regulator-vph-pwr {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vph_pwr";
> > +             regulator-min-microvolt =3D <3700000>;
> > +             regulator-max-microvolt =3D <3700000>;
> > +     };
> > +
> > +     vlcm_3v3: regulator-vlcm-3v3 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vlcm_3v3";
> > +
> > +             vin-supply =3D <&vph_pwr>;
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +
> > +             gpio =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +
> >       backlight: backlight {
> >               compatible =3D "pwm-backlight";
> >               pwms =3D <&sn65dsi86 1000000>;
> > @@ -419,6 +438,7 @@ aux-bus {
> >                       panel: panel {
> >                               compatible =3D "boe,nv133fhm-n61";
> >                               backlight =3D <&backlight>;
> > +                             power-supply =3D <&vlcm_3v3>;
> >
> >                               port {
> >                                       panel_in_edp: endpoint {

I've tested this on my c630, which does have the nv133fhm-n61,
however... the c630 has 2 different LCD panels available, and I do not
have a c630 which has the other panel (anymore).  I reached out on IRC
to the person who has it, but have not yet heard back.

-- steev
