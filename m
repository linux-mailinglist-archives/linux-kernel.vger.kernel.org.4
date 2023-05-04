Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108A56F70A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjEDRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjEDRPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:15:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741E35A0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:15:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so7986705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683220519; x=1685812519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mPxz+XWlXQuQsb3fDFfD8YJvL7javRdaPks0ljDpTFI=;
        b=WMc5XOjIqzCkMxkbelUG6Azyo4ovAmJa42k7u5K/7aE8Jiq4UM/D+KcQ1DsJe0g1bC
         KYOvHpsOYgPBdZ0LUD2qWE4IWTaC+hT/9jRqtVw2UWPoGwK50I8k26bS7cgAGWyUjquY
         WzbZV1B4j3d5qoDLD4DtXuyvDBYfX9JEUzRnCe9XCPyUPnmofVkRuFTfTW6hmWi4cJYj
         zLqXqh03Keffm5TXqSVCRDCe9VKWAdZcWa03BRrEsrtWKWvj4XjPB3R8lc8NE6unTq6B
         35Swcg4+nLD0+CIWEK/+ldi8CF3WzMt1AvWI8KmafB/AJaQ4dSZcrVPHZFhln+wie3ky
         uTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220519; x=1685812519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPxz+XWlXQuQsb3fDFfD8YJvL7javRdaPks0ljDpTFI=;
        b=N1A+FByBNBdixkp6KcbJEF1umQlKiXAyCGsBFsOPDWJYiPevV5aPw5ygYMXL1y5IxC
         4ciITRDpXNVBiDW2U/vvlAh7aRv3qCgQLRBZaEdBWqCNczBO0+vze5Yb6l4060r996kK
         cnrg/q0WgsqRgCQHY60Um9wGfWvkJ9hWwM4VQtKNZxqfHjf6B5YF5uin+M+u+TyOEHJc
         9cXOih0ZvdHJfZGeNIWHG6GS+cukw4eINNH0q/UmRarcbnKfL6UZte4aCLRiUlqbWYub
         SIXBZqwZinfZKKVEOFaf0N/9WIBmt4zWEl0V2HAJCbxOrO8mXJ/yZmtPnITSm8jquC65
         cMLQ==
X-Gm-Message-State: AC+VfDwoBuN6y2RHJMCY3FlI9vJOfXNOziafXIkkHhuqOqwk7U/tssCO
        2b8A4WVt2QgbrXraGOANAabtMyM3ZxW1ba3PS77k3veot75xJN68
X-Google-Smtp-Source: ACHHUZ7OBUvbjJ8DH6bij+IQ1ETjKEi6vzhPPQ7PS0McYH+SJEvnAvTYVizHZBdeou6PKE2blxE+YQprpGkcPiIC4LE=
X-Received: by 2002:adf:e60b:0:b0:2e9:bb2f:ce03 with SMTP id
 p11-20020adfe60b000000b002e9bb2fce03mr3254064wrm.0.1683220519370; Thu, 04 May
 2023 10:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
 <20230501105832.1185477-4-bhupesh.sharma@linaro.org> <1aaff58a-f07b-1e2a-e27b-df41eacd19e7@linaro.org>
In-Reply-To: <1aaff58a-f07b-1e2a-e27b-df41eacd19e7@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 4 May 2023 22:45:08 +0530
Message-ID: <CAH=2NtziEnOquGBukh221Lv6++QJdrEEkU1v469QqvR+AZRYyg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qrb4210-rb2: Enable aDSP and
 cDSP remoteproc nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
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

On Tue, 2 May 2023 at 17:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 1.05.2023 12:58, Bhupesh Sharma wrote:
> > Enable the aDSP and cDSP remoteproc nodes on Qualcomm QRB4210 RB2 board.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > index bff6ba1d689f..3ab46499d3fa 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > @@ -34,6 +34,16 @@ &qupv3_id_0 {
> >       status = "okay";
> >  };
> >
> > +&remoteproc_adsp {
> > +     status = "okay";
> > +     firmware-name = "qcom/sm6115/adsp.mdt";
> status last
> also, don't we want to use .mbn (squashed binary)?

Ok, let me fix this in the next version.

Thanks,
Bhupesh
