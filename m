Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0946FDCBA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjEJL1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjEJL1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:27:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D55B8A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:27:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so67998180a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1683718045; x=1686310045;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNpH9churWtVNXY067utTn5iZTHhfSH7PNSyN7PmDpo=;
        b=5F5GRep5g811KAguGtS93rVSUgRHqVtSaY9ywuzMtfzQAQFzM9O2V1CdiwqK5/APC8
         X5erFFpavgIcTEc8AYANnTCtLQCx+RngQ8uRvC1pIOAfb4cxK79NgyN8eT9tiyhRtkQv
         GTDz+CKk86o3oGNNgNAoO7vsVMS45C7TPYG/KMcTKNSDewe5SW6DOLXWDvUSaYFkAmYg
         N4Kp5nVhEfMYz3svQsnxGNAK4k/0PXLqiG1tHhKig7elBHB63DkRzPxP0xY+d8pX5bM3
         QtvvrAZx8VjUTVo5CgJIQUuf+6gqBwFMOVILvfJLUK7ZwwxE/VW9KMTCssntb4HeWeMv
         Ehdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683718045; x=1686310045;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pNpH9churWtVNXY067utTn5iZTHhfSH7PNSyN7PmDpo=;
        b=Xiowzu2cU/jkBWi2xNrmw6NgpV+APVLq4qeGAo55ovbYKNENeXuZN1I4zFnnuRYdwS
         9mTpOysMTcy46XJxszWNfgzknRTtzzXHTQ1bLhLEDobt1biBjwDBKmV3qIfCSbi0Ghq0
         lvwmZmlINdc9DSlpcUj6jyMEGe5yoMgoZLJarsH7ftTuDShGBXK/HpFgG8J/l+4+mxg8
         Qij40zbBXt+Nt3RP/VOrlRsSQ35n1ph+3Nxyyw2YnhlH++L7EJwhstNX+HMltST1uGoK
         7xrtqahbZQZG8wnMZ2VTiWtvrtWzo3eqLaukf5s9Wiq0uREhQ74Nbc7l1cEKZhcurytS
         cqHg==
X-Gm-Message-State: AC+VfDyB3jH2z6+C7iCvAeyfycjPDO5aHiQGEJa4B6QA0fUl9VLK1VBk
        nyVkibvKCshVLxPLT42BNX00+A==
X-Google-Smtp-Source: ACHHUZ7tjOsW38XJxLzNaQXTcPGIml/eKQLTk5/qbm/AqQLokna1fWit8n+3+Gk2VUDLtghCyBe2Sg==
X-Received: by 2002:a05:6402:27d2:b0:506:71bd:3931 with SMTP id c18-20020a05640227d200b0050671bd3931mr16236880ede.2.1683718045201;
        Wed, 10 May 2023 04:27:25 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id bc15-20020a056402204f00b0050b2f588db6sm1742156edb.16.2023.05.10.04.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 04:27:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 10 May 2023 13:27:23 +0200
Message-Id: <CSIK8F6MTIVE.2K2U2Q1LDA70H@otso>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm7250b: make SID configurable
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.1
References: <20230407-pm7250b-sid-v1-0-fc648478cc25@fairphone.com>
 <20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com>
 <f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org>
 <CSIE9TYTQUHL.3E769C2Y4RAAO@otso>
 <c9eea8ec-b289-334c-9c0b-7c992184a265@linaro.org>
 <CAA8EJpoSpytSTm=y7oPD_SC+0-bd735KEczR1JgMc7RuMZ+A+g@mail.gmail.com>
 <CSIGK60CQSD8.1Q4SOANJRMASF@otso>
 <9040e9bb-a16c-0186-edba-da986350340c@linaro.org>
In-Reply-To: <9040e9bb-a16c-0186-edba-da986350340c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 10, 2023 at 12:05 PM CEST, Krzysztof Kozlowski wrote:
> On 10/05/2023 10:34, Luca Weiss wrote:
> > On Wed May 10, 2023 at 10:07 AM CEST, Dmitry Baryshkov wrote:
> >> On Wed, 10 May 2023 at 09:55, Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 10/05/2023 08:47, Luca Weiss wrote:
> >>>> Hi Krzysztof,
> >>>>
> >>>> On Fri Apr 7, 2023 at 10:27 AM CEST, Krzysztof Kozlowski wrote:
> >>>>> On 07/04/2023 09:45, Luca Weiss wrote:
> >>>>>> Like other Qualcomm PMICs the PM7250B can be used on different add=
resses
> >>>>>> on the SPMI bus. Use similar defines like the PMK8350 to make this
> >>>>>> possible.
> >>>>>>
> >>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>>>>> ---
> >>>>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++------=
-
> >>>>>>  1 file changed, 16 insertions(+), 7 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/bo=
ot/dts/qcom/pm7250b.dtsi
> >>>>>> index daa6f1d30efa..eeb476edc79a 100644
> >>>>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> >>>>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> >>>>>> @@ -7,6 +7,15 @@
> >>>>>>  #include <dt-bindings/interrupt-controller/irq.h>
> >>>>>>  #include <dt-bindings/spmi/spmi.h>
> >>>>>>
> >>>>>> +/* This PMIC can be configured to be at different SIDs */
> >>>>>> +#ifndef PM7250B_SID
> >>>>>> +   #define PM7250B_SID 2
> >>>>>
> >>>>> Drop indentation, although anyway I am against this. Please don't b=
ring
> >>>>> new patterns of this at least till we settle previous discussion.
> >>>>>
> >>>>> https://lore.kernel.org/linux-arm-msm/46658cbb-fff5-e98b-fdad-88fa6=
83a9c75@linaro.org/
> >>>>
> >>>> What's the outcome of the discussion? For this PMIC it's totally eno=
ugh
> >>>> to have the SID configurable like in this patch, I don't think this =
PMIC
> >>>> will be included twice in a board - at least I'm not aware of such a
> >>>> configuration.
> >>>
> >>> We did not reach consensus and I still disagree with complex macros o=
r
> >>> macros depending on order of inclusion.
> >>
> >> I still think we should find a way to parametrise PMIC dtsi, however I
> >> agree with Krzysztof that complex CPP is not a way to go.
> >=20
> > What about the macro already used in-tree and proposed with this patch?
> > I wouldn't say this is a "complex macro" since it's just a single numbe=
r
> > being replaced in a few places.
>
> Are you talking about the macro to which I responded: "or macros
> depending on order of inclusion." or something else?

I thought you mean with ..

> >>> We did not reach consensus and I still disagree with complex macros o=
r
> >>> macros depending on order of inclusion.

.. the macros proprosed in the patch you linked (that version that also
adjusts the labels based on the SID).

I was asking if the patch I sent (with #define PM7250B_SID) would be
okay to take in at least until the bigger discussion has come to a
conclusion, since we already have upstream occurances of such a macro so
it's not a new concept.

Otherwise I'll just carry this patch in my local tree until this
situation has cleared up.

Regards
Luca

>
> Best regards,
> Krzysztof

