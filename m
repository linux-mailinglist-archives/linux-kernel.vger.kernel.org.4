Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944F56FC453
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjEIKya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjEIKy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:54:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE13C3A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:54:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-306dbad5182so3610974f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683629644; x=1686221644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=496R25BHVFmCHB4tTwWl5+MSfc4ofDJgsUV109nYDKE=;
        b=nExnE/2dHW0Ch4uqyd8NvrhRt0gem4wS/Fv+gmzf9cpsk1/zgJb2IqRF4UH17DF6D5
         aOMCoIZW4XEBhO44Co+VvNmO4gj0nOm+VtfuWCeiqH0Dgd9WJxFGbdLn0Rozezo1CQlQ
         OBnn2HfIKivXUbXMBrcZzUjj0aO68DQcXvPT1b/4YlHD+rADwzOAyMLE5hALAZ8JDTWq
         HdBlJN8oyexUlQ5pYatj0e3XITDyo4v+QOAAC0/1TZA2hGQwlTPt2Y/qOpy3a90Z4fDy
         wc22GAt809prgpp5SB2Y7ClJoVgB5ZIGnErO4pjFdXOxOF1upUc1oIQ7oEk4+wkFmvfD
         ohmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683629644; x=1686221644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=496R25BHVFmCHB4tTwWl5+MSfc4ofDJgsUV109nYDKE=;
        b=JnKI56HTQiazJu00dFhPzeuQCJ4rAOmnKQI/6+ORvN74mcmYHv0/yku+IyvMdMXINZ
         sJFdkvmx3kuxI2P7grTTRSOKSy7X57O0KJN7yj+NERlym6hKNm6r43W9Yl+EsEipY2Dz
         sSBID9JPs8DN617ddLPbilzPeVsZgmzjeFGbgPeObk0DT0YhFnowDCY1KcLs5Dsa/N8m
         2CmckruOba4x4pmUvt89VjywrQH1n/CgTRKAwn8e1mkwffYXRFVUZWpoUSGgtYC+mtCt
         l1slxBdpPyRzo03gHUrUpHXKALLqiJvOOYJSbvtD54KwQcPTDSFxZefLmWkiBSnFYkoq
         +yBw==
X-Gm-Message-State: AC+VfDzh0OKap3zx6eqjHmjbQxcrC6dBMIOHUipbsGwN1zRkg5zAYyIw
        GFbKdmPE+ErF/PEOPNHmEYsIT9Zq3xx2inmBzwneVw==
X-Google-Smtp-Source: ACHHUZ7Et1agHoOJJ/wu2bg1tg/gf2Uyhrq5Atd1Du4pWTVqynOOkjHaq4BSy8kOZwo7ziK+J+oVC9JGrCuAMyRnlAc=
X-Received: by 2002:a5d:6041:0:b0:306:2c39:5d52 with SMTP id
 j1-20020a5d6041000000b003062c395d52mr9362712wrt.57.1683629644145; Tue, 09 May
 2023 03:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
 <20230505064039.1630025-3-bhupesh.sharma@linaro.org> <fe326d38-ee52-b0a4-21d8-f00f22449417@linaro.org>
 <CAH=2NtyqZVVwqk1FsCGrsGn25wxvzuhV-3z+q=5+JmpOoNm-vQ@mail.gmail.com> <6dc848f9-9955-5785-246e-53371d0a274d@linaro.org>
In-Reply-To: <6dc848f9-9955-5785-246e-53371d0a274d@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 9 May 2023 16:23:52 +0530
Message-ID: <CAH=2NtyByvwxrYgisO-tOrgPu-bQdDC=gntVVicXKkU=k3G6bg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: soc: qcom: eud: Add SM6115 / SM4250 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
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

Hi Krzysztof,

On Fri, 5 May 2023 at 23:27, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/05/2023 18:31, Bhupesh Sharma wrote:
> > HI Krzysztof,
> >
> > On Fri, 5 May 2023 at 21:54, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 05/05/2023 08:40, Bhupesh Sharma wrote:
> >>> Add dt-bindings for EUD found on Qualcomm SM6115 / SM4250 SoC.
> >>>
> >>> On this SoC (and derivatives) the enable bit inside 'tcsr_check_reg'
> >>> needs to be set first to 'enable' the eud module.
> >>>
> >>> So, update the dt-bindings to accommodate the third register
> >>> property (TCSR Base) required by the driver on these SoCs.
> >>>
> >>> Also for these SoCs, introduce a new bool property
> >>> 'qcom,secure-mode-enable', which indicates that the mode manager
> >>> needs to be accessed only via the secure world.
> >>>
> >>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >>> ---
> >>>  .../devicetree/bindings/soc/qcom/qcom,eud.yaml   | 16 ++++++++++++++++
> >>>  1 file changed, 16 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> >>> index f2c5ec7e6437..3b92cdf4e306 100644
> >>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> >>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> >>> @@ -18,17 +18,33 @@ properties:
> >>>      items:
> >>>        - enum:
> >>>            - qcom,sc7280-eud
> >>> +          - qcom,sm6115-eud
> >>>        - const: qcom,eud
> >>>
> >>>    reg:
> >>> +    minItems: 2
> >>>      items:
> >>>        - description: EUD Base Register Region
> >>>        - description: EUD Mode Manager Register
> >>> +      - description: TCSR Base Register Region
> >>> +
> >>> +  reg-names:
> >>> +    minItems: 2
> >>> +    items:
> >>> +      - const: eud-base
> >>> +      - const: eud-mode-mgr
> >>> +      - const: tcsr-base
> >>>
> >>>    interrupts:
> >>>      description: EUD interrupt
> >>>      maxItems: 1
> >>>
> >>> +  qcom,secure-mode-enable:
> >>> +    type: boolean
> >>> +    description:
> >>> +      Indicates that the mode manager needs to be accessed only via the secure
> >>> +      world (through 'scm' calls).
> >>
> >> I understood tcsr-base aplies only to SM6115, so this should be further
> >> constrained in allOf:if:then:.
> >
> > Please refer to my reply to your query in another review.
> > I can see that secure access to mode_mgr register via TCSR will be
> > exposed by other Qualcomm SoCs as well (from the available EUD
> > documentation). So, maybe keeping it generic instead of limiting it to
> > sm6115 only would be more useful, for future changes.
>
> Your reply does not say that qcom,sc7280-eud uses it, so I don't
> understand. This is not valid to qcom,sc7280-eud, so allowing it there
> is not correct.

Ok, I got your concern now. I will send a v5 with the change shortly.

Thanks.
