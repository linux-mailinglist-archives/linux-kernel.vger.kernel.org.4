Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1249C6484BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiLIPMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLIPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:12:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870A217421
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:12:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c17so3434503edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMRUIEtDFVbh5l53hZeff63KpfZmDW51Pm8OPZ9FBT8=;
        b=byM8H3VPuoJUuOgVb2ndN5rvOI+J/fj4UVR/F9j0gPvlcE+4ieTrdLaiAjmdSJjCWq
         jCwo3zjPh3miq7zWXsdp4brR4rl1V/KtXgIah5R4y40jKGwg+XRjFJKcqBcK+x/pBKQr
         uTKKjCBGQy+H8le08kRza4b6Ee58MgMaDVaIoSxsidW5jUatWVREYN/QSTbvS423lUY5
         FGNhN4vtEKivFnqhDG7tKgEzA7EMYrVyA3hn2nAOXnu/56xiN7jdWU/DfhiD6AozQE8D
         vcmwu+yIWptcvgkdFAeowc+6Z3wXCYUPSsz+C+ZewIZhbo8vTjSpvQyNv1NRjI2VuYSL
         bArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JMRUIEtDFVbh5l53hZeff63KpfZmDW51Pm8OPZ9FBT8=;
        b=DCtfxQLuzXhb6Lju5T8ZFOYu5VVnAmoP+bk51vpmcRYA2IGp9rtNVbmxtqlFAS196+
         NVS1/yoaFKgxrmWmmtAIoS1ikaAFl9GXub1kqkS63bbtMZgXyEToFNjIzp9wASLLMVjN
         2FXKQ/57XipSP0ZI3ivk4Ag/3KEXQZJzdHLOQcUdMxqASkplS47pAmVlvbIuOgvBFGxY
         Ss/vMhYKMTUlHlbRd+SoEBYZVBLV/mR6jojJJg6S14N1/7s8UM/11MKfvsojLK6fCwYk
         S2+H0jutwQ9dNACORyYNbM23yvjvtB44RLeoL8o9YEf+UvTyxJkWsl0Gr9Eygn1MFV8/
         jDow==
X-Gm-Message-State: ANoB5pkDfyAh6ah0EiEguGqiA7Q7Yx+klL73Bm8I+SnxQoyg/MR9YW77
        8qpZPxMyDiXiOW4MqnwO9A8o4w==
X-Google-Smtp-Source: AA0mqf5uLbgwYs3wcM3IJU3+X3Hjrj+LW1wtLk6sCxpNH/7ZZ3jTzODTbIQJJZ0Lwd6I1u2tLlpJiQ==
X-Received: by 2002:a05:6402:2484:b0:45c:835b:8fa3 with SMTP id q4-20020a056402248400b0045c835b8fa3mr6041581eda.14.1670598720098;
        Fri, 09 Dec 2022 07:12:00 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id z4-20020aa7c644000000b0046b471596e6sm732404edr.57.2022.12.09.07.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 07:11:59 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Dec 2022 16:11:59 +0100
Message-Id: <COXDTKRPPU1J.373YHYKBQIN38@otso>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add reg-names property for ICE
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
X-Mailer: aerc 0.13.0
References: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
 <24fa41d2-87d1-be19-af44-337784b0f0a4@linaro.org>
In-Reply-To: <24fa41d2-87d1-be19-af44-337784b0f0a4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 9, 2022 at 4:05 PM CET, Krzysztof Kozlowski wrote:
> On 09/12/2022 15:29, Luca Weiss wrote:
> > The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add thi=
s
> > in the bindings so the existing dts can validate successfully.
> >=20
> > Also sm8450 is using ICE since commit 276ee34a40c1 ("arm64: dts: qcom:
> > sm8450: add Inline Crypto Engine registers and clock") so move the
> > compatible to the correct if.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > (no cover subject)
> >=20
> > The only remaining validation issues I see is the following on sc8280xp=
-crd.dtb
> > and sa8540p-ride.dtb:
> >=20
> >   Unevaluated properties are not allowed ('required-opps', 'dma-coheren=
t' were unexpected)
> >=20
> > Maybe someone who knows something about this can handle this?
> >=20
> > And the patch adding qcom,sm6115-ufshc hasn't been applied yet.
> > ---
> >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Docu=
mentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > index f2d6298d926c..58a2fb2c83c3 100644
> > --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > @@ -102,7 +102,6 @@ allOf:
> >                - qcom,sc8280xp-ufshc
> >                - qcom,sm8250-ufshc
> >                - qcom,sm8350-ufshc
> > -              - qcom,sm8450-ufshc
> >      then:
> >        properties:
> >          clocks:
> > @@ -130,6 +129,7 @@ allOf:
> >                - qcom,sdm845-ufshc
> >                - qcom,sm6350-ufshc
> >                - qcom,sm8150-ufshc
> > +              - qcom,sm8450-ufshc
> >      then:
> >        properties:
> >          clocks:
> > @@ -149,6 +149,12 @@ allOf:
> >          reg:
> >            minItems: 2
> >            maxItems: 2
> > +        reg-names:
>
> There are no reg-names in top-level, so it's surprising to see its
> customized here. It seems no one ever documented that usage...

From what I can tell, from driver side all devices not using ICE don't
need reg-names, only the "ice" reg is referenced by name in the driver.

I didn't add it top-level because with only one reg I think we're not
supposed to use reg-names, right?

Regards
Luca

>
> > +          items:
> > +            - const: std
> > +            - const: ice
> > +      required:
> > +        - reg-names
> > =20
> >    - if:
> >        properties:
> >=20
> > ---
> > base-commit: f925116b24c0c42dc6d5ab5111c55fd7f74e8dc7
> > change-id: 20221209-dt-binding-ufs-2d7f64797ff2
> >=20
> > Best regards,
>
> Best regards,
> Krzysztof

