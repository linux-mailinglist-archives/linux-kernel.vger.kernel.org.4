Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D26FDA21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbjEJIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbjEJIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:55:53 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ECDE54
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:55:48 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-559de1d36a9so100666337b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683708948; x=1686300948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hoZ8kkN1eS0yykkcRILWwhA511HYhnHiIl1p28gNBmc=;
        b=sE0SnGa6LPEDuvJL8kk7+DMF5cC3tWhw0haIWIWmyXXxyTFKhNOsSyOAllIZBFOW8h
         1VoALPXuv4QRHUoSVmdbbICLEmRh/6WZzl0Z1fmcAIf8P8xQ3M8hid6ndSt36nE7xbE4
         RFaeK452hgYr4Ugbg/8s2+AljLJ/uGdS5qn08eInvWf8PfeLOQCopqUoUkWGDJ2R+wfJ
         xXkxW806dxeq5UU5+dx/wSIcsqDtkgDNDUmMjfygj/UpsdTWZRKMDG9w9UqAknIZYmNx
         sYxb/vQ5ZX/HssoUg3z6Mu4gAD4OXZPyQFUXZF9+NqNm0hHryTsvaZlQphHUhhvuX4ZG
         NtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708948; x=1686300948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoZ8kkN1eS0yykkcRILWwhA511HYhnHiIl1p28gNBmc=;
        b=JKq03B9IkrQuw969vlj50EMLA91LLcrD1wWxmqefGeaha1ZJAqqS9noglOSqDFSp6a
         PGFXqz+qmMZU8zKu3xt6XXVHfbJgnPWQI4KGupxTVxeI2jnLdldbe9JgxgaS2lVh5uox
         b3s3n6v/SkX4J3FuBLCREqRUMcIeiUOa/kgjec2ANMhSYfwHPlwPzLRDOeHAOptQysSQ
         4sm3B+hujGhn7phBdQHiHn2fQEVklytneH8WigmhwsusPJcwroS2X0+PgoRofNrfaQgE
         sAUs+9/0/IdQcUBZt+8twqgmd/N9EAwV+TXBd43bLdd1cVmhOqooW1RGjh1aO3RysJ0W
         9HOA==
X-Gm-Message-State: AC+VfDyUiLo2qL0bwbagi4eNFH6FZCXIE7jyOvH57pfgJzfJBxyb5jC2
        5NIie8mtFA1wNZ7wRTd1s1ZsK/6hnSK11hCGUxaunQ==
X-Google-Smtp-Source: ACHHUZ6h/7XbWO9srKHcAZigjp0WAm69hMHMRIsT5c7ivJxUTKLk8WJh1quj3rCkCQMUSSdLD/MBOP4/378bbGqa5zM=
X-Received: by 2002:a81:8443:0:b0:54f:179:cef2 with SMTP id
 u64-20020a818443000000b0054f0179cef2mr19353393ywf.19.1683708948031; Wed, 10
 May 2023 01:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230407-pm7250b-sid-v1-0-fc648478cc25@fairphone.com>
 <20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com> <f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org>
 <CSIE9TYTQUHL.3E769C2Y4RAAO@otso> <c9eea8ec-b289-334c-9c0b-7c992184a265@linaro.org>
 <CAA8EJpoSpytSTm=y7oPD_SC+0-bd735KEczR1JgMc7RuMZ+A+g@mail.gmail.com> <CSIGK60CQSD8.1Q4SOANJRMASF@otso>
In-Reply-To: <CSIGK60CQSD8.1Q4SOANJRMASF@otso>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 10 May 2023 11:55:37 +0300
Message-ID: <CAA8EJpouRet-h0uRx7seLOMk8hy7m3c+XdfN9SnG2yy04y2R=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm7250b: make SID configurable
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 at 11:34, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> On Wed May 10, 2023 at 10:07 AM CEST, Dmitry Baryshkov wrote:
> > On Wed, 10 May 2023 at 09:55, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 10/05/2023 08:47, Luca Weiss wrote:
> > > > Hi Krzysztof,
> > > >
> > > > On Fri Apr 7, 2023 at 10:27 AM CEST, Krzysztof Kozlowski wrote:
> > > >> On 07/04/2023 09:45, Luca Weiss wrote:
> > > >>> Like other Qualcomm PMICs the PM7250B can be used on different addresses
> > > >>> on the SPMI bus. Use similar defines like the PMK8350 to make this
> > > >>> possible.
> > > >>>
> > > >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > >>> ---
> > > >>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
> > > >>>  1 file changed, 16 insertions(+), 7 deletions(-)
> > > >>>
> > > >>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > > >>> index daa6f1d30efa..eeb476edc79a 100644
> > > >>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > > >>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > > >>> @@ -7,6 +7,15 @@
> > > >>>  #include <dt-bindings/interrupt-controller/irq.h>
> > > >>>  #include <dt-bindings/spmi/spmi.h>
> > > >>>
> > > >>> +/* This PMIC can be configured to be at different SIDs */
> > > >>> +#ifndef PM7250B_SID
> > > >>> +   #define PM7250B_SID 2
> > > >>
> > > >> Drop indentation, although anyway I am against this. Please don't bring
> > > >> new patterns of this at least till we settle previous discussion.
> > > >>
> > > >> https://lore.kernel.org/linux-arm-msm/46658cbb-fff5-e98b-fdad-88fa683a9c75@linaro.org/
> > > >
> > > > What's the outcome of the discussion? For this PMIC it's totally enough
> > > > to have the SID configurable like in this patch, I don't think this PMIC
> > > > will be included twice in a board - at least I'm not aware of such a
> > > > configuration.
> > >
> > > We did not reach consensus and I still disagree with complex macros or
> > > macros depending on order of inclusion.
> >
> > I still think we should find a way to parametrise PMIC dtsi, however I
> > agree with Krzysztof that complex CPP is not a way to go.
>
> What about the macro already used in-tree and proposed with this patch?
> I wouldn't say this is a "complex macro" since it's just a single number
> being replaced in a few places.

My 2c: in my opinion it is fine (and it follows parameterization that
we already have for some PMICs).

> Could we get this in now, and if we find a new & better way in the
> future we can adjust all the dtsi upstream?

And this depends on the decision of RobH and Krzysztof.

-- 
With best wishes
Dmitry
