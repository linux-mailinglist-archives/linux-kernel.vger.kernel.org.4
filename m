Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37A69E835
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBUTZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBUTZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:25:54 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688502FCE6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:25:51 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id d7so97758vsj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1677007550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qIumhXVptDGaCBlNxNpJonBcbHAUubqeifjNAqK+SpU=;
        b=UUimMBx65rs4EgYnP4JSdQZpO27fYhKT8ksV+feyk+W0a+e7v4yo9PUJ5gK05wvGqz
         1xpPPQUc9V9sPuNL/GOm6oL3QSCblAUQqIaGWHGfpL/gmrTc4CoiqwlGquEEIB/Rbac9
         lb9QLJoGPABu8Z5nralY7l99l8xEm+7T3oPw91AyK0iD68t40Rwwf98tRBXP2+MvmMZT
         rlk7irZBawdElh0084INE7qUiNOt8ait/mX4VqyQrfcs7pnl6jNRNEgmtRREAZ1Ks2mp
         qKP1GuVjrjRic9zgDKl7/0lHSnjIPkNDvqlPDraSLlOns276V28YWz9KGpOUpXUOu9tP
         LSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677007550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIumhXVptDGaCBlNxNpJonBcbHAUubqeifjNAqK+SpU=;
        b=TCVtLdTt1xMcOnGo84Os2NLUFm2gEz5xhvu7n5Q1NW7hNaRYZdqKiUsxUU7UqttizG
         o6DARTY88SrPtSJP7l6lZixyM4Qda5ETiCyXlajPgUXIDPX+/Gy+HcC2S9J3p/Fm/Ynj
         BX2g1FC++/eNpipRlc0gc/m2hiB8/gd1IMART2AGuSD4VmlFhKSsQuQlmnPz+VclaCro
         HJsVNeG3riPJL+6IySNR+g4PqrLVpG8ilBNeA0i9NvgXCWNaJWUnj4ULQsmTiP8ULDwZ
         VVrImvnmh0tZVWhwm0rnfQfx3f14t4V50U+lnk6VI3pbBdpI2+ukvXB21bp/a30z2IQm
         p2NA==
X-Gm-Message-State: AO0yUKWSKDTNLOyUhx5rZRgIvDCZm7oAHvrQTv42QDG4J6jEm0ICn9bu
        63LZC4iJWJTlnXI9cxWdC4K+ILtjTBNHF0kCzvnLyQ==
X-Google-Smtp-Source: AK7set+7iHFS/iorUX3sKwtwOxCp5CG/iAxYxwKP+qJHKKmKYSgJ0ayVog03ErDwVkCN6T4iZ+EsshDbaAfP/B7b/w4=
X-Received: by 2002:a67:e1cc:0:b0:3ea:5896:84b9 with SMTP id
 p12-20020a67e1cc000000b003ea589684b9mr897651vsl.75.1677007550472; Tue, 21 Feb
 2023 11:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20230221150543.283487-1-brgl@bgdev.pl> <20230221150543.283487-3-brgl@bgdev.pl>
 <9a3e9c76-ba70-6ccc-3ade-fa08cdff571e@linaro.org>
In-Reply-To: <9a3e9c76-ba70-6ccc-3ade-fa08cdff571e@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 21 Feb 2023 20:25:39 +0100
Message-ID: <CAMRc=McMGnzz09SG_QaKWNLSyLbR=QbFvfiYgewYMnAeESRgQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8775p: add cpufreq node
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 6:44 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 21.02.2023 16:05, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a node for the cpufreq engine and specify the frequency domains for
> > all CPUs.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > index ce5976e36aee..5e2bc67b3178 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > @@ -37,6 +37,7 @@ CPU0: cpu@0 {
> >                       compatible = "qcom,kryo";
> >                       reg = <0x0 0x0>;
> >                       enable-method = "psci";
> > +                     qcom,freq-domain = <&cpufreq_hw 0>;
> >                       next-level-cache = <&L2_0>;
> >                       L2_0: l2-cache {
> >                               compatible = "cache";
> > @@ -52,6 +53,7 @@ CPU1: cpu@100 {
> >                       compatible = "qcom,kryo";
> >                       reg = <0x0 0x100>;
> >                       enable-method = "psci";
> > +                     qcom,freq-domain = <&cpufreq_hw 0>;
> >                       next-level-cache = <&L2_1>;
> >                       L2_1: l2-cache {
> >                               compatible = "cache";
> > @@ -64,6 +66,7 @@ CPU2: cpu@200 {
> >                       compatible = "qcom,kryo";
> >                       reg = <0x0 0x200>;
> >                       enable-method = "psci";
> > +                     qcom,freq-domain = <&cpufreq_hw 0>;
> >                       next-level-cache = <&L2_2>;
> >                       L2_2: l2-cache {
> >                               compatible = "cache";
> > @@ -76,6 +79,7 @@ CPU3: cpu@300 {
> >                       compatible = "qcom,kryo";
> >                       reg = <0x0 0x300>;
> >                       enable-method = "psci";
> > +                     qcom,freq-domain = <&cpufreq_hw 0>;
> >                       next-level-cache = <&L2_3>;
> >                       L2_3: l2-cache {
> >                               compatible = "cache";
> > @@ -88,6 +92,7 @@ CPU4: cpu@10000 {
> >                       compatible = "qcom,kryo";
> >                       reg = <0x0 0x10000>;
> >                       enable-method = "psci";
> > +                     qcom,freq-domain = <&cpufreq_hw 1>;
> >                       next-level-cache = <&L2_4>;
> >                       L2_4: l2-cache {
> >                               compatible = "cache";
> > @@ -104,6 +109,7 @@ CPU5: cpu@10100 {
> >                       compatible = "qcom,kryo";
> >                       reg = <0x0 0x10100>;
> >                       enable-method = "psci";
> > +                     qcom,freq-domain = <&cpufreq_hw 1>;
> >                       next-level-cache = <&L2_5>;
> >                       L2_5: l2-cache {
> >                               compatible = "cache";
> > @@ -116,6 +122,7 @@ CPU6: cpu@10200 {
> >                       compatible = "qcom,kryo";
> >                       reg = <0x0 0x10200>;
> >                       enable-method = "psci";
> > +                     qcom,freq-domain = <&cpufreq_hw 1>;
> >                       next-level-cache = <&L2_6>;
> >                       L2_6: l2-cache {
> >                               compatible = "cache";
> > @@ -128,6 +135,7 @@ CPU7: cpu@10300 {
> >                       compatible = "qcom,kryo";
> >                       reg = <0x0 0x10300>;
> >                       enable-method = "psci";
> > +                     qcom,freq-domain = <&cpufreq_hw 1>;
> >                       next-level-cache = <&L2_7>;
> >                       L2_7: l2-cache {
> >                               compatible = "cache";
> > @@ -731,6 +739,19 @@ tcsr_mutex: hwlock@1f40000 {
> >                       #hwlock-cells = <1>;
> >               };
> >
> > +             cpufreq_hw: cpufreq@18591000 {
> > +                     compatible = "qcom,sa8775p-cpufreq-epss",
> > +                                  "qcom,cpufreq-epss";
> That's some very aggressive wrapping! :P
>

For when all you have is vi on a 80-char wide terminal :D

Bartosz

> Nevertheless,
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Konrad
> > +                     reg = <0x0 0x18591000 0x0 0x1000>,
> > +                           <0x0 0x18593000 0x0 0x1000>;
> > +                     reg-names = "freq-domain0", "freq-domain1";
> > +
> > +                     clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
> > +                     clock-names = "xo", "alternate";
> > +
> > +                     #freq-domain-cells = <1>;
> > +             };
> > +
> >               tlmm: pinctrl@f000000 {
> >                       compatible = "qcom,sa8775p-tlmm";
> >                       reg = <0x0 0xf000000 0x0 0x1000000>;
