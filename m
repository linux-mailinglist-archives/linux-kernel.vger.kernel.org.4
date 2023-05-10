Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13D96FD8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjEJIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjEJIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:08:05 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F952122
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:08:04 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-55a829411b5so63677907b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683706084; x=1686298084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jwThnQ8nzpok5U/xS8BVNWwNsnGKUyUosUJ+6RNgc4=;
        b=uC7KdsY69JLNTVZxKpuCTLqjtRxn5UCaDP2RG8mhwtjzr+knBJvmNYveLl5xOxO7TI
         h3+H45gwUIZlifNEGfF3QkpPV3XoexrsaI4d824UAHhTkeSq26XGpT700/teXY7pf3RA
         6sacqBjut0SAMl7m99SnmDrcO3Hqhf6Amv0GkSUtvdGSQXLYp/F5f1Q6mLDLeDEh2Jrj
         u0iGguP2XGO7WUy4qWotxNVzgKYwTNzoupEdrCgJR4gdEYCRB2AH62fzgkSHNMPZ/AHz
         2ws+hKpOaVGFBhYsSz08P7R7e2RnuA9etY2dpvbca6EPIMN9UfVRSkHM27SZCIfleqy8
         rl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683706084; x=1686298084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jwThnQ8nzpok5U/xS8BVNWwNsnGKUyUosUJ+6RNgc4=;
        b=EHzBZCyrXTF3lauC7PcC3HHQ80tM2247Rj3BXy3Kuzua1H93pUUuIuYORAsX7CyCWx
         f0smlBM664eQ2xsF22IZ+e0pqoQDCftWrN3dKR92nZyS1ylDr39pkQ9gsjD3qiDC0u5v
         qYqior5MIjDyGI2quNkGonLrDwPv1H6T3vL/+43ebGvWX5xwO4hc+L2VtBX6Q1w/nTts
         Ab99yl91SAS4mDruog2SMyDhgJj4hN5omaxDWPcSpNAs7WjzrsjKjrQf6XKKBwwZsZP4
         2HI4tzqdtPJQ5dVZG5DGc3+zo/HOnIdXxUEhgWstXlTGoo4Q0VwhfalsG6GF9+BzjJzy
         IShA==
X-Gm-Message-State: AC+VfDwTEcV6KUBCbN/2a4XtPDPk/AJ2HIXDjyiIHZmLocws6OKfeGle
        R2iYVCefkqf/Ufc1RyTgHHp9whIiRlo+veP1JYCFOA==
X-Google-Smtp-Source: ACHHUZ48JTM/PORCfGB1ehZByhVsSyq2yV5nKRFSfcLplxq/yrvBWib1I67KQqpTEU6vTSEDxty8zf0GTpIQuM2zvOE=
X-Received: by 2002:a0d:e242:0:b0:52e:f109:ba7a with SMTP id
 l63-20020a0de242000000b0052ef109ba7amr17722282ywe.51.1683706083905; Wed, 10
 May 2023 01:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230407-pm7250b-sid-v1-0-fc648478cc25@fairphone.com>
 <20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com> <f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org>
 <CSIE9TYTQUHL.3E769C2Y4RAAO@otso> <c9eea8ec-b289-334c-9c0b-7c992184a265@linaro.org>
In-Reply-To: <c9eea8ec-b289-334c-9c0b-7c992184a265@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 10 May 2023 11:07:53 +0300
Message-ID: <CAA8EJpoSpytSTm=y7oPD_SC+0-bd735KEczR1JgMc7RuMZ+A+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm7250b: make SID configurable
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
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

On Wed, 10 May 2023 at 09:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/05/2023 08:47, Luca Weiss wrote:
> > Hi Krzysztof,
> >
> > On Fri Apr 7, 2023 at 10:27 AM CEST, Krzysztof Kozlowski wrote:
> >> On 07/04/2023 09:45, Luca Weiss wrote:
> >>> Like other Qualcomm PMICs the PM7250B can be used on different addresses
> >>> on the SPMI bus. Use similar defines like the PMK8350 to make this
> >>> possible.
> >>>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
> >>>  1 file changed, 16 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> >>> index daa6f1d30efa..eeb476edc79a 100644
> >>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> >>> @@ -7,6 +7,15 @@
> >>>  #include <dt-bindings/interrupt-controller/irq.h>
> >>>  #include <dt-bindings/spmi/spmi.h>
> >>>
> >>> +/* This PMIC can be configured to be at different SIDs */
> >>> +#ifndef PM7250B_SID
> >>> +   #define PM7250B_SID 2
> >>
> >> Drop indentation, although anyway I am against this. Please don't bring
> >> new patterns of this at least till we settle previous discussion.
> >>
> >> https://lore.kernel.org/linux-arm-msm/46658cbb-fff5-e98b-fdad-88fa683a9c75@linaro.org/
> >
> > What's the outcome of the discussion? For this PMIC it's totally enough
> > to have the SID configurable like in this patch, I don't think this PMIC
> > will be included twice in a board - at least I'm not aware of such a
> > configuration.
>
> We did not reach consensus and I still disagree with complex macros or
> macros depending on order of inclusion.

I still think we should find a way to parametrise PMIC dtsi, however I
agree with Krzysztof that complex CPP is not a way to go.

-- 
With best wishes
Dmitry
