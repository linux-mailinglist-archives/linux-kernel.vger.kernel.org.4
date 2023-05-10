Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2296FD75B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjEJGrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjEJGrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:47:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF7B270E
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 23:47:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965ac4dd11bso1354748366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1683701229; x=1686293229;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H//eZGlEJS/35YEhZwhGTWp7oEUZuMDqjOLd1KsW/Dk=;
        b=je9yKiewPEqrhtPLrQqwPtxJPJwBxoylsg0o6HBvbvHaeaOCMwK2O/K63M9TCx581q
         KMMEW5t63lQuVAUf1xo+olgAm9NiF6RqPLHCm5i+3249dA9gRah3aSuUILXkeOSWeZbG
         nfU0EK3FPHsTNEA2Rzwnv+XtlWgxujJ+iefazA07nVnVP+axplHu7lDjdx8lkxhv/I1h
         z9kYI5FDwrnlSuLvF0oE2woDtXjyXIGcPgE9ii0MybB5S5nbkMhDjAd0K6pMvyE+H0pd
         xr+vKV4JEGeOhwrPDqHa3bBrM65Isgzv9dun7qEXa6Y9blruDQQRXwqOIl8ZCJ6oRCUs
         Eu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683701229; x=1686293229;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H//eZGlEJS/35YEhZwhGTWp7oEUZuMDqjOLd1KsW/Dk=;
        b=JHhmI+oyg6tdHdYXYp1sWSS6m1NqWBCA42T/kEdLRq3o4+x2Qua26CbXQF9QOIOVRX
         0Ta1RA7DAJxHWh3zkHK+YD0Eh23xV4Yik2Ro1Aw6jccKiiiJmKBpOrr1rIfS2MRQauiY
         4zNoM5LSUqIw0aWMliL0pBvrlGgjuLp5nr9hkRCF/88EPHJ5w4dlb5/wofkV6nnWmobp
         wE08ursBafcsycLCVH9AXamG1oZBE8Mdc+wvcX7ayBuWdKZoxlysWlBpr8/lVRvUc9+Q
         K8PxzqdlN9HYpXjxlYg4Hj29y6PpxE+ylUed6m/EIdtdz5nWV9F6rqEy2L/WmfA3QCU0
         qRzw==
X-Gm-Message-State: AC+VfDweS0FLhEyS5pQOuDkpZTrtzSzEI1MI7yV1CIRnK5+Khm4QN9Ox
        RwAUCpxLj3m5SY4TF+JE8HjcRo++r8cy4tzVWM3ffA==
X-Google-Smtp-Source: ACHHUZ6oiJs4TBNp02xqpzNHKA1CCtOPDo+5SW3bC6Ts4SsxO/AZwHbz9fCAzOA3jOsEMZHvm8MaFg==
X-Received: by 2002:a17:906:fd8d:b0:94f:3521:394 with SMTP id xa13-20020a170906fd8d00b0094f35210394mr13259517ejb.51.1683701229329;
        Tue, 09 May 2023 23:47:09 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id pk25-20020a170906d7b900b00965d9892bafsm2273306ejb.111.2023.05.09.23.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 23:47:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 10 May 2023 08:47:07 +0200
Message-Id: <CSIE9TYTQUHL.3E769C2Y4RAAO@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm7250b: make SID configurable
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>
X-Mailer: aerc 0.15.1
References: <20230407-pm7250b-sid-v1-0-fc648478cc25@fairphone.com>
 <20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com>
 <f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org>
In-Reply-To: <f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri Apr 7, 2023 at 10:27 AM CEST, Krzysztof Kozlowski wrote:
> On 07/04/2023 09:45, Luca Weiss wrote:
> > Like other Qualcomm PMICs the PM7250B can be used on different addresse=
s
> > on the SPMI bus. Use similar defines like the PMK8350 to make this
> > possible.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dt=
s/qcom/pm7250b.dtsi
> > index daa6f1d30efa..eeb476edc79a 100644
> > --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > @@ -7,6 +7,15 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/spmi/spmi.h>
> > =20
> > +/* This PMIC can be configured to be at different SIDs */
> > +#ifndef PM7250B_SID
> > +	#define PM7250B_SID 2
>
> Drop indentation, although anyway I am against this. Please don't bring
> new patterns of this at least till we settle previous discussion.
>
> https://lore.kernel.org/linux-arm-msm/46658cbb-fff5-e98b-fdad-88fa683a9c7=
5@linaro.org/

What's the outcome of the discussion? For this PMIC it's totally enough
to have the SID configurable like in this patch, I don't think this PMIC
will be included twice in a board - at least I'm not aware of such a
configuration.

Regards
Luca

>
>
> Best regards,
> Krzysztof

