Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6823B625B83
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiKKNw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiKKNw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:52:27 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA223BCA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:52:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v17so7696758edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JXM+RlfecQsl8R3fGlmC6x2JLEc2q3nlhhTEJRNAqbQ=;
        b=mj7EW2C4wI/AYrFuJnRR3eDzgId1RmzDGW48XzKmelMZyNEnRLGZxFruOa2GzQX7pG
         9MLy4XDPrtTHeNIOp4CQhL6m7V+lisnBvntxIxnA9z80qjgzEBkrylHNLE3q965PTSoZ
         MJNyPhzJFl7IZpvHrOLcQBFZ7DJ5Ief6N9gaVsbRGPRdRSYyjGQ5ECz6/3U+NSzahXF+
         yrlIzAWBGc8dG+U0VZvsUqIyMMDbd6HGh9a5r0akpvZiho/UyndEZJUzqHAyUkB9yAHp
         as5oFzLT/3JZ3J5jT3BzvjD8PhGQPNcmTe9JmUesqI9OrQhQd0e7KiwBN17ZcTMFB7i6
         8PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXM+RlfecQsl8R3fGlmC6x2JLEc2q3nlhhTEJRNAqbQ=;
        b=dDJX5oiqZLRjEV8tblRZvB+7hP3K8z7A+JRbUOMENcAjKwEGfUbM/4FiA/GLGZS2i6
         zCUqeRcPt7jEzeh1K0ItM4AaS2ioQMtMclUeAgzkeyAaFIrunBJcYvgoQoFdW16A9517
         d7TVXSKjXrmWsFmm4Jq7iET8Z5oVAnEHXOHHyQVAm6bMCFqMAsGVfkoHTiwxnjKItx+G
         dTCSv/9HcWqx/mE12XaxMk1ox2vimVydA8tRHlpfn5v5fE4u+A9n7nqOIoUVciJ9/7EM
         7bMS69tyKe9z2OpdxMnvpyNWfGtb/fKmesYpz7i6TmYdCRzSeNLuI6lii07/YVQKXmVR
         aIeA==
X-Gm-Message-State: ANoB5pmw91Q6EWtYaRPhGuCka73csWSCEKXm2uF7H0O8uxWfswpYX33C
        KluMkb8PWuQbhMMcIHveY9rb0jRQiLFEmbbIOJSdBg==
X-Google-Smtp-Source: AA0mqf6c96jhEwp5IIcqNLzVQh7v/brBFkuXH94v9FZGLFHBvHuFSMAHGSUBmt76nOSVZW30mNXKo7pEKrfyx0BQZrA=
X-Received: by 2002:aa7:d716:0:b0:461:cdfb:3072 with SMTP id
 t22-20020aa7d716000000b00461cdfb3072mr1594817edq.56.1668174744060; Fri, 11
 Nov 2022 05:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20221028120812.339100-1-robert.foss@linaro.org>
 <20221028120812.339100-7-robert.foss@linaro.org> <20221028134439.ugja55guopmql4nk@baldur>
In-Reply-To: <20221028134439.ugja55guopmql4nk@baldur>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 11 Nov 2022 14:52:12 +0100
Message-ID: <CAG3jFysvDa7QR5cXZCjHx-28ir40TVngBDUfEy0-Xgo-_jhBmQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] arm64: dts: qcom: sm8350: Use 2 interconnect cells
To:     Bjorn Andersson <andersson@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 at 15:44, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Fri, Oct 28, 2022 at 02:08:09PM +0200, Robert Foss wrote:
> > Use two interconnect cells in order to optionally
> > support a path tag.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8350.dtsi | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > index 606fab087945..b6e44cd3b394 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > @@ -1543,56 +1543,56 @@ apps_smmu: iommu@15000000 {
> >               config_noc: interconnect@1500000 {
> >                       compatible = "qcom,sm8350-config-noc";
> >                       reg = <0 0x01500000 0 0xa580>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
>
> You also need amend all the interconnects references with the additional
> tag cell.

Ack

>
> Regards,
> Bjorn
>
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> >               mc_virt: interconnect@1580000 {
> >                       compatible = "qcom,sm8350-mc-virt";
> >                       reg = <0 0x01580000 0 0x1000>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> >               system_noc: interconnect@1680000 {
> >                       compatible = "qcom,sm8350-system-noc";
> >                       reg = <0 0x01680000 0 0x1c200>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> >               aggre1_noc: interconnect@16e0000 {
> >                       compatible = "qcom,sm8350-aggre1-noc";
> >                       reg = <0 0x016e0000 0 0x1f180>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> >               aggre2_noc: interconnect@1700000 {
> >                       compatible = "qcom,sm8350-aggre2-noc";
> >                       reg = <0 0x01700000 0 0x33000>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> >               mmss_noc: interconnect@1740000 {
> >                       compatible = "qcom,sm8350-mmss-noc";
> >                       reg = <0 0x01740000 0 0x1f080>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> >               lpass_ag_noc: interconnect@3c40000 {
> >                       compatible = "qcom,sm8350-lpass-ag-noc";
> >                       reg = <0 0x03c40000 0 0xf080>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> >               compute_noc: interconnect@a0c0000{
> >                       compatible = "qcom,sm8350-compute-noc";
> >                       reg = <0 0x0a0c0000 0 0xa180>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> > @@ -2420,14 +2420,14 @@ usb_2_ssphy: phy@88ebe00 {
> >               dc_noc: interconnect@90c0000 {
> >                       compatible = "qcom,sm8350-dc-noc";
> >                       reg = <0 0x090c0000 0 0x4200>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> >               gem_noc: interconnect@9100000 {
> >                       compatible = "qcom,sm8350-gem-noc";
> >                       reg = <0 0x09100000 0 0xb4000>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
> >                       qcom,bcm-voters = <&apps_bcm_voter>;
> >               };
> >
> > --
> > 2.34.1
> >
