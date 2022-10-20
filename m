Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6794B606308
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJTO2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJTO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:28:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60651CC3D7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:28:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r17so47798757eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QR1IqMPTQfafYMBcRZyO6+upzIaAEmghcFFaL+GXdY=;
        b=vegGHfEDzAlS0VlymlKs1Ypplgljzlzyspn1r1KOwHstsAMU9QtfZ18RgALUIIPhrZ
         yWprS/+oaZXitf5/ng9chHACmDYZusFYBdjlCm+SRcGUd6aBvlX+yCE1Qr0bzstWM9QF
         0hOYwp5OOlmp4LNb8BEsmOWfMzexAfIjoEwuAXtK7vXZIjrj62Cqdm1dOTwrWeovIpnI
         qLQzmLeAjdcbjJ7GMQEGdXmPZIyraOUd26r9u53Mq7uolJggmiH0L+A3Xn86t9Mqn2tR
         XJReD5jrMuqINxnVCjQwZdyqKXhzmUq2kSSq24z6EJgyttB23Fi+INruZJw+dEQbHDRx
         i6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7QR1IqMPTQfafYMBcRZyO6+upzIaAEmghcFFaL+GXdY=;
        b=bq0+pWFoYEWRZINCdr+RIEXsFMUqoPrVVnpqD/cEr7O0ZdO0D1ZoBmLvVNYEtgAJ2H
         TJnoRIKF40Cx8dFw1Ji5soafjr/6G3wku9TWIn/N1zpru7NpKa0i3793vFNLSSnk97E0
         L2mjad1Y9mrMu2OW2876vbErkSq04dzOJOfrRjHo6g7NPr15bBCAUPFOLq1M4d6uGQUn
         po0OY22AAY6dhXb9f2/gcfZKMvpQESkVF5A7ZGHhWO1ypeGtEGW6zNO6noCN7yEqcm2O
         i8yZINwFEusivqO6t7haLLDr5wyrc77eH/RJZRCs6cWA69NRWPeAOseZAzLV480me99r
         THJQ==
X-Gm-Message-State: ACrzQf2OD6eo2RaYFjsedhCRkf8QOCG2GvCMPD0+T0mmJzwrjEGpPPTX
        pj2GU9D2QS1nL+CKtPkFnjylyQ==
X-Google-Smtp-Source: AMsMyM6c3vjC3h2UKyDABM7/Zth6iJYEdeiBBn9C/o6MJ8pVRnDGnQgdHus11l/HJYKNgBqDaxsozQ==
X-Received: by 2002:a17:907:2e01:b0:78d:f24b:7330 with SMTP id ig1-20020a1709072e0100b0078df24b7330mr11097959ejc.604.1666276088208;
        Thu, 20 Oct 2022 07:28:08 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0078116c361d9sm10614246ejd.10.2022.10.20.07.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 07:28:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 20 Oct 2022 16:28:07 +0200
Message-Id: <CNQTKQWNZIH9.61TJWGH1K44F@otso>
Cc:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: pm6350: add temp sensor and thermal
 zone config
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Matthias Kaehlcke" <mka@chromium.org>
X-Mailer: aerc 0.12.0
References: <20220812114421.1195044-1-luca.weiss@fairphone.com>
 <81ae6a31-1f37-a677-f8f8-2340e37d3a63@linaro.org>
 <CM43WTWNP8MM.3145TGVN4208B@otso> <YvaErMmLIQaDolKR@google.com>
In-Reply-To: <YvaErMmLIQaDolKR@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

sorry for the delay in getting back to you.

On Fri Aug 12, 2022 at 6:49 PM CEST, Matthias Kaehlcke wrote:
> On Fri, Aug 12, 2022 at 04:06:47PM +0200, Luca Weiss wrote:
> > Hi Krzysztof,
> >=20
> > +CC Matthias Kaehlcke (author of patch mentioned further below)
> >=20
> > On Fri Aug 12, 2022 at 3:36 PM CEST, Krzysztof Kozlowski wrote:
> > > On 12/08/2022 14:44, Luca Weiss wrote:
> > > > Add temp-alarm device tree node and a default configuration for the
> > > > corresponding thermal zone for this PMIC. Temperatures are based on
> > > > downstream values.
> > > >=20
> > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > ---
> > > > With this config I'm getting this in dmesg, not sure if it's a warn=
ing
> > > > that should be solved or just an informative warning.
> > > >=20
> > > > [    0.268256] spmi-temp-alarm c440000.spmi:pmic@0:temp-alarm@2400:=
 No ADC is configured and critical temperature is above the maximum stage 2=
 threshold of 140 C! Configuring stage 2 shutdown at 140 C.
> > > >=20
> > > > As far as I can tell, based on downstream dts this PMIC doesn't hav=
e an
> > > > ADC.
>
> I don't seem to have access to the datasheet, in any case that the ADC is=
n't
> configured in the downstream dts doesn't necessarily mean the PMIC doesn'=
t
> have one. The PM6150 has one, and it is probably relatively close to the
> PM6350.

Too bad :(

>
> > > You configure 145 and driver believes 140 is the limit, so it seems
> > > warning should be addressed.
> >=20
> > Hm...
> >=20
> > >
> > > From where did you get 145 degrees as limit? Downstream DTS?
> >=20
> > Yes, downstream dts[0].
> >=20
> > From what I can see in the downstream driver, it always disabled this
> > "software override of stage 2 and 3 shutdowns"[1]
> >=20
> > In mainline only since f1599f9e4cd6 ("thermal: qcom-spmi: Use PMIC
> > thermal stage 2 for critical trip points") this check exists, which is
> > not part of downstream (wasn't in 4.19 yet), where this software
> > override tries to get enabled so that thermal core can handle this.
> >=20
> > Any suggestion what I can do here? Maybe looking at msm-5.4 sources (an=
d
> > associated dts) might reveal something..?
>
> I wouldn't necessarily consider QC downstream code as a reliable source o=
f
> truth ...
>
> > Maybe newer SoCs/PMICs have a different config?
>
> Commit aa92b3310c55 ("thermal/drivers/qcom-spmi-temp-alarm: Add support
> for GEN2 rev 1 PMIC peripherals") added support for gen2 PMICs, which
> actually have lower thresholds than gen1. From the log it seems that the
> PM6350 is identified as gen1 device (max stage 2 threshold =3D 140 degC).

PM6350 is detected as QPNP_TM_SUBTYPE_GEN2 so gen2 actually. Just the
log message is hardcoded to 140 degC, the if above actually has
stage2_threshold_max =3D 125000 (125degC) and stage2_threshold_min =3D
110000 (110degC) so lower than 140 (basically like you said).

>
> It seems setting the limit to 140 degC or one of the other stage 2
> thresholds would be a reasonable course of action. stage 2 is the
> threshold at which the PMIC is so hot that the system should shut
> down, and 140 degC is the highest of the stage 2 thresholds. Even
> if it was possible, what would be gained from setting the trip
> point 5 degC higher?

Based on this, do you think it's reasonable to just set the limit to
125 degC and be done with it? Or some other way to resolve this? I'd of
course mention in the commit message that I've decreased the value from
145 (msm-4.19) to 125.

Regards
Luca
