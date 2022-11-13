Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E87626FE9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiKMNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiKMNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:50:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F911148
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:50:16 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id y192so7310191yby.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eceknYWf5pXSjf3uYAdpptzDpxH4rWxr35RcE2M9s1g=;
        b=FkMNT5XysKQDnMO4RcQWSQ6H7JCNFeKZZrJ2RLstMOmDyEPOw5EcHE0WBI5VTbk4Qr
         XR3eYK45+vctcOxbt3m64ODnkQhxCc8VxSO6pDr8uOeYZJCrCtrxFNJSvRp6Cfd/EYN2
         3GUeyTC5bjLbCPZHJEJ219NcIcqu3jKi2nvEAC1pEK3cLsSfm2/cIMJMUodj+yyOgoAH
         vVNL1n2OsEXwwJjcSA5PswuzthJu5PrWiB5y5ldAjsdlb2fAOoszqRkrWC1px0D0fHOm
         k7kxYvddZ1Z/iC1KvOEBUEyfWy2zh/A2ulFOjqMx+043APYWlftEZvQ9Zq9xgU3DrEoQ
         jnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eceknYWf5pXSjf3uYAdpptzDpxH4rWxr35RcE2M9s1g=;
        b=BCRdB/Hu8TPGPANe4rhM251sAJLT8aHOqayoq+ykqNrd0wuhxHkdaSnIFOEX95M76d
         rvlHvNv4P98p9DgRdQ+ITp515dATuVAClzzeqqZ/LmyMqEcehE5sekt+p18lLnf4Yv50
         RLtJvRt6Kh2ws7443Nl3Kisv86hA7AD2ZUqngt5pzuTCE/hmOgpR7THZrwL6L1Sxsvtn
         N7sjs6+r7qO7EXCwoP6egamDfRj8eMcbtNvXjro/w+0EYd4C2XgsGpFHX+LDS7UuKiJi
         5cxHNwuaAqD3/4/g2sI5kEE3wfQEVXAMW4dzdS0i4Jb7GWi9aW9iSUAEgr4agC3c199d
         ksRQ==
X-Gm-Message-State: ANoB5plr9SHiDQmS8EwzzDC8LvyNVLd9nYYjnTQuuFRtrBjYKSsMUeZ1
        QJ0fUf22KoIXH3V22yVckF1usKonVXokByQ53bFxSQ==
X-Google-Smtp-Source: AA0mqf6sABYM0kp61+uu3VEcuDtmXePEQdU78gemQ06iM60ToPaMLunsSHhpQ/NJfefnF7ny12NVXGvpNKORe+MuZos=
X-Received: by 2002:a25:8445:0:b0:6de:4801:a09b with SMTP id
 r5-20020a258445000000b006de4801a09bmr8780968ybm.15.1668347415574; Sun, 13 Nov
 2022 05:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20220830065744.161163-1-krzysztof.kozlowski@linaro.org>
 <20220830065744.161163-2-krzysztof.kozlowski@linaro.org> <fe747000-a650-ed2f-8581-92b044f86f2f@linaro.org>
In-Reply-To: <fe747000-a650-ed2f-8581-92b044f86f2f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 13 Nov 2022 16:50:04 +0300
Message-ID: <CAA8EJpruwhOVacH6_kN2TABmVR5Peu1pjFa1b4sag5p1zouqRA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kumar Gala <galak@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Krzysztof,

On Mon, 26 Sept 2022 at 13:30, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/08/2022 08:57, Krzysztof Kozlowski wrote:
> > The top level qcom,msm-id and qcom,board-id properties are utilized by
> > bootloaders on Qualcomm MSM platforms to determine which device tree
> > should be used and passed to the kernel.
> >
> > The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
> > compatible format") from 2015 was a consensus during discussion about
> > upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
> > problems with that consensus:
> > 1. It was reached 7 years ago but it turned out its implementation did
> >    not reach all possible products.
> >
> > 2. Initially additional tool (dtbTool) was needed for parsing these
> >    fields to create a QCDT image consisting of multiple DTBs, later the
> >    bootloaders were improved and they use these qcom,msm-id and
> >    qcom,board-id properties directly.
> >
> > 3. Extracting relevant information from the board compatible requires
> >    this additional tool (dtbTool), which makes the build process more
> >    complicated and not easily reproducible (DTBs are modified after the
> >    kernel build).
> >
> > 4. Some versions of Qualcomm bootloaders expect these properties even
> >    when booting with a single DTB.  The community is stuck with these
> >    bootloaders thus they require properties in the DTBs.
> >
> > Since several upstreamed Qualcomm SoC-based boards require these
> > properties to properly boot and the properties are reportedly used by
> > bootloaders, document them along with the bindings header with constants
> > used by: bootloader, some DTS and socinfo driver.
> >
> > Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
> > Co-developed-by: Kumar Gala <galak@codeaurora.org>
> > Signed-off-by: Kumar Gala <galak@codeaurora.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > ---
> >
> > Changes since v6:
> > 1. Update header with defines
> > 2. Add Rb tag
>
> Hi Bjorn,
>
> Any further comments on this? Can it be applied?

A gracious ping from my side. I think it would be better to apply this
patch rather than having the undocumented and controversial propreties
in the device trees.

-- 
With best wishes
Dmitry
