Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D765101D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiLSQQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiLSQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:16:29 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD6F13CDB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:16:07 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id i127so7029721oif.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t1fQ3HMUMjTYp4HukGDzZcKzvdvCdzA+hW6xmFvbLbk=;
        b=mawyphQIqE/IdbX4iuJqDAYHDp5dpI18h3M1s3GRCCdPuxswNYEyIw5fHZQFOnfCY6
         FpWMaNjIDZm3APc6kJC+1BW7xR4j+GQjkB8yxswZCpxJYY9aMDZ8fTW/T1TCpcB9691x
         9iH+FqFzci8DHbP8Y0LJFA5xRdCCEs3Jnt8zRjEpzhHV66DyJdoFEjhIbrPVQoK+bdLk
         xP3lRf0tc3U1nCc2OHxbNEuzy87zfwvbcHUjE0bXNpmVPmb4b2ELg37PtmFIpmVqFt3B
         mpCA9xzo6u+DN+X60gwbKU77Uu8NYE/Lj9yBO1y7pJU/p/8pcIzmGy8G0XmYhUbbvAII
         plFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1fQ3HMUMjTYp4HukGDzZcKzvdvCdzA+hW6xmFvbLbk=;
        b=jF+I3suzZG6e/m9hn4N7qZwEnrWEiTIPKx3dbkFAPHyS7HHyVx88YX/UsdAXMeTkJF
         U88k2La7n+d43tQZuFPvRmhYfQN91jUO8FyAFMOYnqmJlhPOy8aI9LXXpTjz6CSYGhL7
         mEHZAMGKrhP7vZm7GhbMH8D6UrYCmAgGtBhxhGfWXo4UmLAJoCiSYkysCb04ERiy7kBy
         2I3cH5bs7b5lx2mXJDpTcDa+Obrr+2+X5fjKQz8HdjKrvldQtqnIQgPv2tWn8FXBAYA9
         kY48WoX7YVP7m11qWfW8e4Mk5rReE+CbN9BNbUgKm2whYarZaBUK9vs1dmNM/tD4M5Sh
         sVnw==
X-Gm-Message-State: ANoB5pmmwzXvKLi8aZuBt+qpJQR3Arta++Ujfd2siBT81vDcGOvy/A34
        1RCGA6+//VbEw9vGysh8EqePT4ttRf2X7am5k2sVwQ==
X-Google-Smtp-Source: AA0mqf4S6tnPPRCOQWCsOq5kuksb7+u/7cQmv2C9BJe4b2BQ//W8JNd2zSsEQvuXeFLOKtkDMW4ei0zslW/NQI2W9RI=
X-Received: by 2002:aca:1c07:0:b0:359:ef86:2f4f with SMTP id
 c7-20020aca1c07000000b00359ef862f4fmr1016768oic.14.1671466566962; Mon, 19 Dec
 2022 08:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20221205163754.221139-1-robert.foss@linaro.org>
 <20221205163754.221139-9-robert.foss@linaro.org> <60884c0e-7533-788b-2f93-c128cf7d27fd@kernel.org>
In-Reply-To: <60884c0e-7533-788b-2f93-c128cf7d27fd@kernel.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 19 Dec 2022 17:15:56 +0100
Message-ID: <CAG3jFyuoXekXN48jAgXxLMy8yGAzK9oJH_1HHYAuRLBCzyordQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] arm64: dts: qcom: sm8350: Use 2 interconnect cells
To:     Georgi Djakov <djakov@kernel.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
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

On Mon, 5 Dec 2022 at 20:19, Georgi Djakov <djakov@kernel.org> wrote:
>
> Hi Robert,
>
> On 5.12.22 18:37, Robert Foss wrote:
> > Use two interconnect cells in order to optionally
> > support a path tag.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sm8350.dtsi | 28 ++++++++++++++--------------
> >   1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > index 805d53d91952..434f8e8b12c1 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > @@ -1543,56 +1543,56 @@ apps_smmu: iommu@15000000 {
> >               config_noc: interconnect@1500000 {
> >                       compatible = "qcom,sm8350-config-noc";
> >                       reg = <0 0x01500000 0 0xa580>;
> > -                     #interconnect-cells = <1>;
> > +                     #interconnect-cells = <2>;
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
> [..]
> > @@ -1620,8 +1620,8 @@ ipa: ipa@1e40000 {
> >                       clocks = <&rpmhcc RPMH_IPA_CLK>;
> >                       clock-names = "core";
> >
> > -                     interconnects = <&aggre2_noc MASTER_IPA &mc_virt SLAVE_EBI1>,
> > -                                     <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_IPA_CFG>;
> > +                     interconnects = <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI1 0>,
> > +                                     <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
> >                       interconnect-names = "memory",
> >                                            "config";
> >
> > @@ -1661,7 +1661,7 @@ mpss: remoteproc@4080000 {
> >                                       <&rpmhpd SM8350_MSS>;
> >                       power-domain-names = "cx", "mss";
> >
> > -                     interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>;
> > +                     interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1 0>;
>
> The second cell for the first endpoint is missing, so this should be:
>         interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;

Nice catch, thanks!

>
> Thanks,
> Georgi
>
> >
> >                       memory-region = <&pil_modem_mem>;
> >
> > @@ -2239,7 +2239,7 @@ cdsp: remoteproc@98900000 {
> >                                       <&rpmhpd SM8350_MXC>;
> >                       power-domain-names = "cx", "mxc";
> >
> > -                     interconnects = <&compute_noc MASTER_CDSP_PROC &mc_virt SLAVE_EBI1>;
> > +                     interconnects = <&compute_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
> >
> >                       memory-region = <&pil_cdsp_mem>;
> >
> > @@ -2421,14 +2421,14 @@ usb_2_ssphy: phy@88ebe00 {
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
>
