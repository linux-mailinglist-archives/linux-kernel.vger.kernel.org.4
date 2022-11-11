Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784C1625E21
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiKKPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiKKPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:17:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EC825CD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:17:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v17so8022162edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=496UFFIC10qt1M6UVRQKPJnGchRATjnymhhjWaLmr1w=;
        b=RSyI8hdVimJvxqP1L25E2r+IvvfMghhQQhG4xOOGVGNagBkKs6PdvtDlIFJedry2gy
         c4NW9SoTQO+eAxMKq9tmrqF+NJVhiOQvpkx7SAriIF+w8Fa/PfUuCJkpNNmzTkfgxyWe
         mFLzBV3BZO794b6pKcm/Gfvtjgus14npORj6oBVn7ULgjX/RZckFZLa316Wk7nrU3doP
         /4PuEyIa+MCiCVTrIVb1gTKTM4y8FKJa+1AL90s5UDqqVSPNYnC1JP7oAZPUvt08XcKz
         qhPCywtOwwhNgCRuc+ykquvOBHCdJ90Z1WHv+UypB4qihvG51Pxrd9HhHzZlfD3roSPn
         MzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=496UFFIC10qt1M6UVRQKPJnGchRATjnymhhjWaLmr1w=;
        b=7rhLqjreSO9fCzC93/GBj/AJPoBF1TCwoEl7PzL53Iaj/tVYOOPH8NKR9AfWPHOI9o
         e1A7GH0k/Gh3o9qIiMMo/p/7l2NsjIj2v+0VRQvDOl7VpwfS6y6tV0+O65jQ77WE0p7d
         KFwTPVMV94WktLeoao9uPFRGFommPIK5QAm0HHleOB+uM/+eOcQc4Hq52pB+KCS2pIG2
         xY8UNbUXO3IoPqArSSIa6XZ48hBudATtFitgTHrgyzHQ+gZpSS645gS0Yw+KJboQk2Cv
         CRLVLun8zK4yepCUyhsw7Camp5qyCKJFor1mI/0meCxbGljkf2IcZSPNdOWWGvaWV3bY
         AQKg==
X-Gm-Message-State: ANoB5plj1o/qNW9Rj5PPSAb7B3kDPn1nBuR1RUrPdFKGdx78ep+3S+Zb
        daXJSV0MlgCtmtDA+ew6gEsxGgGOr60Y3eIas9ZhZQ==
X-Google-Smtp-Source: AA0mqf7rUnO1t4y0ADfVMEYjKFri9CWgvqhmDL2US1Uq9KFQrYcX4hZNCB5JQzEzP8ka8n7ON29oaQb+5yBamEHWx7E=
X-Received: by 2002:a05:6402:298a:b0:461:4c59:12d6 with SMTP id
 eq10-20020a056402298a00b004614c5912d6mr1877018edb.250.1668179842232; Fri, 11
 Nov 2022 07:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20221028120812.339100-1-robert.foss@linaro.org>
 <20221028120812.339100-9-robert.foss@linaro.org> <eeeefa55-1782-2768-8d47-0f315ed9888b@linaro.org>
In-Reply-To: <eeeefa55-1782-2768-8d47-0f315ed9888b@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 11 Nov 2022 16:17:11 +0100
Message-ID: <CAG3jFyvp1q=VvL6XXLTtkF2BsxUbXCu5+3-psi80A=avkgrAoA@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] arm64: dts: qcom: sm8350-hdk: Enable display & dsi nodes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2022 at 00:03, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/10/2022 08:08, Robert Foss wrote:
> > Enable the display subsystem and the dsi0 output for
> > the sm8350-hdk board.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> > index e6deb08c6da0..6e07feb4b3b2 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> > @@ -213,10 +213,32 @@ &cdsp {
> >       firmware-name = "qcom/sm8350/cdsp.mbn";
> >  };
> >
> > +&dispcc {
> > +     status = "okay";
> > +};
> > +
> > +&dsi0 {
> > +     status = "okay";
>
> Status is the last property.

Ack.

>
>
> Best regards,
> Krzysztof
>
