Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB493722D5F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjFERJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjFERJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:09:42 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B766AF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:09:40 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bad142be0ebso6037170276.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685984979; x=1688576979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4GWJEMZcMO5R6CDwitNhGNBkGuDXmhHZQItLXpH0uTo=;
        b=pdj/9TlRmRWlyOYd2VLiS64oTqpWOU5PMoiNL5+SGh4vpokaM+qFex8O9+ljopL6Ek
         HBHAvWJQ0M7e3j7sWibBIHzTbZ7f0rfjCT19VhAxApvCJvkBEPAgvtJD/iULeeRRvCsi
         K35kvKwzQOmmk0iNm9NTpfGFzEPZdQgW4GpiloBxi+Vz0V3YRJrdjU9HBlFfsBa4rHBZ
         AMMH3+pYaBrY1aT1mSRJiwNLndUGS6EZpe7XL9uEaZ5GKuZDs2fYRQG8OrwCZzXYkbDw
         +AMx1QTVgl/f3GRDvoqcC+bh1ZarvG2crDi3cMscnTGrZkgloX4ChOL359x5llIys0Fd
         qNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685984979; x=1688576979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GWJEMZcMO5R6CDwitNhGNBkGuDXmhHZQItLXpH0uTo=;
        b=CKY6J0qMoov44U+4asJfIHp1wG5uFCXjpV1eFMQVdujzZC+sQwZgOdfKj1dxaI9TPp
         +LzS34GmR91ZKUUCODZeIqQLGsucZYumvocrAncazdi19NJOPASK/wsc0Nzoplm3+0wU
         Qvj+SsAErUKPJ2g21Vf6IRG75Bx1UvAXlew1LkyCpxiIskLUkRXlmMlbqEMb+CkfIVV7
         ttgfbc6wTwFtrTmd+z3qwk0xhuzUTLf61KfP9ETMinmH9hbf6uw8x3mS4PFoPeemSIIF
         rGCoPiQmymZlT3RVcyb2Iw3xdpoT3to3CvcLtBXQeUxobFHe6dJNVD5nAabwfSG59TkH
         Ndjw==
X-Gm-Message-State: AC+VfDxVAJHHjnvcIC+VEbM48ru9eYClfPGfvwdPYowHCqmRvkiw3Qo5
        9l364wFPI9l0Yd30sioAFP3SLTHvCYv8IBJr+n7bRYJyCoSxPj15
X-Google-Smtp-Source: ACHHUZ4p/Fv7/1YL5aK6ni9BSkRIpB2mD0PTUJxt1VEJdkmZiqICIOae+tEFI3eDyVtAjNHYulgKIeUo+lKq/F6nazA=
X-Received: by 2002:a25:ade5:0:b0:b9e:6d83:7bcf with SMTP id
 d37-20020a25ade5000000b00b9e6d837bcfmr12259782ybe.27.1685984979703; Mon, 05
 Jun 2023 10:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-5-998b4d2f7dd1@linaro.org>
 <e9da7236-5915-b9df-59dc-c2baa960f52b@linaro.org> <ea8d1808-b04c-332f-834a-c3f237e0b931@linaro.org>
In-Reply-To: <ea8d1808-b04c-332f-834a-c3f237e0b931@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 5 Jun 2023 20:09:28 +0300
Message-ID: <CAA8EJprAiB8xrrx23fX95PnVockeH=6omppEwDJAxU6kGS5LwA@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] dt-bindings: display/msm: Add SM6375 MDSS
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 at 20:01, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 4.06.2023 20:04, Krzysztof Kozlowski wrote:
> > On 23/05/2023 09:46, Konrad Dybcio wrote:
> >> Document the SM6375 MDSS.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
> >>  1 file changed, 216 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
> >> new file mode 100644
> >> index 000000000000..3aa4f0470c95
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
> >> @@ -0,0 +1,216 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6375-mdss.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Qualcomm SM6375 Display MDSS
> >> +
> >> +maintainers:
> >> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> >> +
> >> +description:
> >> +  SM6375 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
> >> +  like DPU display controller, DSI and DP interfaces etc.
> >> +
> >> +$ref: /schemas/display/msm/mdss-common.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const: qcom,sm6375-mdss
> >> +
> >
> > Same as 6350 - drop items.
> Ack
>
> >
> > Similar concern about interconnects, although we don't have header file
> > for them, so I assume we will fill it up later.
> Yep, they'll come later and other SoCs may need a bump up for a third icc
> path soon..

4th ;-)

>
> Konrad
> >
> > Best regards,
> > Krzysztof
> >



-- 
With best wishes
Dmitry
