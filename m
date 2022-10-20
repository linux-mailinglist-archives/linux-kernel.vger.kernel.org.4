Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63360627A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJTOJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJTOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:09:02 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3205B170B53
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:09:01 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso11465575otb.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KmrrMOMdYJ6b8buOtE8wTwfyN1foDEi2s8Ex1cEpDfY=;
        b=To+Qk0A3CM/eFhRAolkD4U6Tmg9JsHMThNENPRJNAC/8o31f3nqxxAoWnz8aornjNY
         ZmjX9KtEBg56Di83mek3SSSKstfbmTv32ucyB2YEwNFQOfpZhrpHKLtzIz89q2S0VBB6
         Nwl35WxoMpSkp6lBNMueuK5hUwiiQpuDlfU0nXhZlWgqYM+8f0r6pBkOv45hlWR74/rB
         llB1M+pJJinTTHg1UV3/IA4VeEIdivuIdj7r/QInd0DKXs8veOu1DttyZMiDsaHAGJCs
         g4CRjlw1PAPpqroyID3/q8GTDnu2qA6yuwgUnmzRW33+3ThPWS9uvrJQJyP6Uxkh2KCX
         s5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmrrMOMdYJ6b8buOtE8wTwfyN1foDEi2s8Ex1cEpDfY=;
        b=fWUUk3JwF1XdTIA8JTN6gb2rMOlbW3DTK7/YjUryF/Lmy3d1vQm/MYHv2ljFJnHJG5
         cZv1+RZNiddxTX/djObtg6oYisqtiUn3DE/zs2WzFbxxNlY4u6CQej6E4IILCLKK6YSc
         D7zF7tDNB15fAp7XSwGZwFWLiMf/21bstkA6iNEGwUFtVwg/psyVqH3qikWAq/tTuw59
         yNiHiO1YH0D7w4Vqj7v9OsA7aRT4ceoZsSMGrrwOh+dpZs2h6hyHVEPabPLZy/kXNUlq
         Xd1BcEgTzOO8Y5b7Qi0zuaOiGse3s0E9rO5iR9pGus9q5melDgHb3cEgBMukWO7UVDDo
         daKQ==
X-Gm-Message-State: ACrzQf1lga2pfQAowzJFzzMZU8TJzL8sL5a4ludTMZvg/uBKoOLTri72
        GGnAqcnq12dpaLa4XpvJ2Xzv0z+tJpk4BcHNcFcCWa3E5gc=
X-Google-Smtp-Source: AMsMyM7TnkHvlubvtysHFMD02cLjU/w/mTgkliIpDR7G2WAUuROhb7YuX7lLMg1AN6GBnVxu2mW0NzRsuihLAUrld5s=
X-Received: by 2002:a05:6830:4119:b0:661:e687:1912 with SMTP id
 w25-20020a056830411900b00661e6871912mr7160259ott.352.1666274940321; Thu, 20
 Oct 2022 07:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221018145348.4051809-1-amit.pundir@linaro.org>
 <CAPDyKFoBMB9OMUrcoPCV0of1fj2dimEwPyHGW=ydjJ2M0ubM8Q@mail.gmail.com> <20221020093057.zrrvxlgghn27bpes@bogus>
In-Reply-To: <20221020093057.zrrvxlgghn27bpes@bogus>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 20 Oct 2022 19:38:23 +0530
Message-ID: <CAMi1Hd05PkEJcHqHpQX-X6B2oR4250_pHPjkd2-54JWgKsYx0Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qrb5165-rb5: Disable cpuidle states
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 at 15:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Oct 19, 2022 at 01:57:34PM +0200, Ulf Hansson wrote:
> > On Tue, 18 Oct 2022 at 16:53, Amit Pundir <amit.pundir@linaro.org> wrote:
> > >
> > > Disable cpuidle states for RB5. These cpuidle states
> > > made the device highly unstable and it runs into the
> > > following crash frequently:
> > >
> > > [    T1] vreg_l11c_3p3: failed to enable: -ETIMEDOUT
> > > [    T1] qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
> > > [    T1] qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110
> > >
> > > Fixes: 32bc936d7321 ("arm64: dts: qcom: sm8250: Add cpuidle states")
> > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > index cc003535a3c5..f936c41bfbea 100644
> > > --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > @@ -251,6 +251,14 @@ qca639x: qca639x {
> > >
> > >  };
> > >
> > > +&LITTLE_CPU_SLEEP_0 {
> > > +       status = "disabled";
> > > +};
> > > +
> > > +&BIG_CPU_SLEEP_0 {
> > > +       status = "disabled";
> > > +};
> > > +
> > >  &adsp {
> > >         status = "okay";
> > >         firmware-name = "qcom/sm8250/adsp.mbn";
> > > --
> > > 2.25.1
> >
> > Disabling the CPU idlestates, will revert us back to using only the WFI state.
> >
> > An option that probably works too is to just drop the idlestate for
> > the CPU cluster. Would you mind trying the below and see if that works
> > too?
> >
>
> Indeed this is was I suggested to check initially. But I was surprised to
> see IIUC, Amit just disabled CPU states with above change and got it working.
> So it is not cluster state alone causing the issue, is it somehow presence
> of both cpu and cluster states ? Am I missing something here.
>
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > index c32227ea40f9..c707a49e8001 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > @@ -700,7 +700,6 @@ CPU_PD7: cpu7 {
> >
> >                 CLUSTER_PD: cpu-cluster0 {
> >                         #power-domain-cells = <0>;
> > -                       domain-idle-states = <&CLUSTER_SLEEP_0>;
>
> How about just marking CLUSTER_SLEEP_0 state disabled ? That looks cleaner
> than deleting this domain-idle-states property here. Also not sure if DTS
> warnings will appear if you delete this ?

Hi, I did try disabling CLUSTER_SLEEP_0: cluster-sleep-0 {} in
domain-idle-states {} but that didn't help. That's why I end up
disabling individual cpu states in idle-states {}.

Regards,
Amit Pundir


>
> --
> Regards,
> Sudeep
