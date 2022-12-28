Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1B657BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiL1PYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiL1PYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:24:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B75514021
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:24:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l26so9857645wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nXKCVyOIX4nL784wtZ3ILMzCso/8DNyZaBxq04sqn0=;
        b=HsmTzuhMZWa6Oxk/vOaMQqv2DO5KR6hoG7P4Waf31F+8oxMU2lCAMeICEaWOvObyIM
         mVtuQeDpHICUTJwZRM8Rj+Se1bo5qnuUMJlauo1VtOkHNlhpnesn9L3SYGugl/EkHWMd
         NU/WwKpsTxKFT8eTSsZeYaTJilYE+4iP5IPbGVzx8LMgKBgpJSTXdNbvfJbFr99CLuIc
         Q2MGijvcB1SX37e5Yrc/BZKPCd7zKm/W8ulUFXoPpZwHamrUIFTRm8X/XNGtPjA1ehJB
         hcTmOx1+ZOUoeDDmdAkgAKSnL7PAcBHzgfw0lv1yca0TMzp5UhtEmJQry9d21P/WeZey
         w1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8nXKCVyOIX4nL784wtZ3ILMzCso/8DNyZaBxq04sqn0=;
        b=TUryGaiRD8KGAA90z7eaOqFTLsHKIClN/Pzq3OWak91fKnXkpkKAafPB4U2sc9aIMT
         wZVOxu/rSrofEqUGzjMDEbmcFCbEa+CvfwQ7sH8uzC7f2ayyA4TkcgfH5EQ/IKfQKYCT
         GygDHbhCCf83MrIkUHRJUfIV9uxkcuawDSd2IOccDdJldejySU/SFhwM8b60VBVZ9FI7
         +GRVC2XHEDFIXD+GCrjyjtskbsRUNNBCGIA9qpZecgGSyGfUPM6qZ7+gQaMUSBlDZ80g
         TwXniM79M/D+4af0440b2+19n19L3w+AiVHvpqfclXCjppGjzm4Pbi8DqQJ518uID3r3
         5Cwg==
X-Gm-Message-State: AFqh2kqRBw1IQGdqcNkOgkM8fiyw5Jsb+S4OtLq4lEZEOOmahJx5Pwzg
        iEQxrp/mAwNcKSOxuTAm5fP/QA==
X-Google-Smtp-Source: AMrXdXtCg+Zy0Gj3Bdwd1XS/UTyFga3yDiwuZtjI5i4ejJyCw9JYw95SPFwBVkaqRN9O3lknqx5kEg==
X-Received: by 2002:a05:600c:4191:b0:3d7:9ae7:e4f2 with SMTP id p17-20020a05600c419100b003d79ae7e4f2mr18470609wmh.35.1672241074108;
        Wed, 28 Dec 2022 07:24:34 -0800 (PST)
Received: from localhost (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at. [2a02:8388:6582:fe80::6])
        by smtp.gmail.com with ESMTPSA id h15-20020adfaa8f000000b002421888a011sm15870418wrc.69.2022.12.28.07.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 07:24:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 28 Dec 2022 16:24:32 +0100
Message-Id: <CPDJZJHDL1XJ.2UY1U1E19CTUH@otso>
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
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add reg-names property for ICE
X-Mailer: aerc 0.13.0
References: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
 <c4109766-22f1-7227-47bb-9273a027bb0c@linaro.org>
 <CPDFHXBPSP76.5CWNQK4N1KGI@otso>
 <5391e6e5-3773-a012-c396-b59b1f54ea51@linaro.org>
In-Reply-To: <5391e6e5-3773-a012-c396-b59b1f54ea51@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 28, 2022 at 12:58 PM CET, Krzysztof Kozlowski wrote:
> On 28/12/2022 12:53, Luca Weiss wrote:
> > Hi Krzysztof,
> >=20
> > On Wed Dec 28, 2022 at 12:50 PM CET, Krzysztof Kozlowski wrote:
> >> On 09/12/2022 15:29, Luca Weiss wrote:
> >>> The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add t=
his
> >>> in the bindings so the existing dts can validate successfully.
> >>>
> >>> Also sm8450 is using ICE since commit 276ee34a40c1 ("arm64: dts: qcom=
:
> >>> sm8450: add Inline Crypto Engine registers and clock") so move the
> >>> compatible to the correct if.
> >>>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>> ---
> >>> (no cover subject)
> >>>
> >>> The only remaining validation issues I see is the following on sc8280=
xp-crd.dtb
> >>> and sa8540p-ride.dtb:
> >>>
> >>
> >> Any plans on fixing the patch (after testing it) and resending?
> >=20
> > I wasn't quite sure how to fix the comments, but re-reading them this
> > comment from you is how you expect it to be in v2?
>
> The patch fails testing, so I meant this.
>
> >=20
> >> Just add it to top-level with minItems: 1 and per variant customize:
> >> 1. maxItems: 1
> >> 2. minItems: 2 + required
> >=20

I tried a bit now but couldn't get it to work when using 'items' so that
we have the "std" and "ice" names in there.

Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: allOf:2:then:propertie=
s:reg-names: 'oneOf' conditional failed, one must be fixed:
        [{'const': 'std'}, {'const': 'ice'}] is too long
        [{'const': 'std'}, {'const': 'ice'}] is too short
        False schema does not allow 2
        1 was expected
        hint: "minItems" is only needed if less than the "items" list lengt=
h
        from schema $id: http://devicetree.org/meta-schemas/items.yaml#

Since I have 'minItems: 1' in top-level I seemingly cannot use 'items'
in the 'if' neither alone nor with 'minItems' and/or 'maxItems', getting
different errors when doing that.

Can I just put 'reg-names: true' top-level and then specify either items
for the ones that use ICE or for the others use the 'maxItems: 1'?

Or am I supposed to ignore 'items' completely but driver expects 'ice'
name so I'd rather include it.

Regards
Luca

>
> Yes.
>
> Best regards,
> Krzysztof

