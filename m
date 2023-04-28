Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BA6F1ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbjD1Ttt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjD1Ttr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:49:47 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7FF1BCB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:49:46 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54f8e823e47so3589017b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682711386; x=1685303386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/ndJlRpl2jIqqzoCVeqrKVlFCiLWS3lHrlVMMffJAU=;
        b=y4ls9Mo3jpN/beT51E7z1jkXP4P+qfI3oczrkApcuzXMQTFL0evI6GAbBqSxmVbttK
         laipb0M9fNYjxjpA0wDNe1MZHjOdOc+Ll8ovOyM8xrJZ+fZZNBNif7fWW0FvlYgIFGOq
         CgV+KvGUvf2MErXutLc/EQdEBRzkRjRzE0EUUBID0CF+hoYPB3b/iqtvUXTkBCE6U91d
         ChzHxWf7UNxW1AxyaLO5XNSr7dFnq+9D3RluN2QlrB84Jr3pf2bvJLudUHvPuReNGHB+
         kRpavEImX3L+YuH1SlQfsnm4lP1rUNuwbZU3hCYasvV2loM8I8/k7kwfb97FCWB42ylS
         txBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682711386; x=1685303386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/ndJlRpl2jIqqzoCVeqrKVlFCiLWS3lHrlVMMffJAU=;
        b=kIOc85glZIKUM7gJ2Uus1Klg416Q9Dtl8tAVXhwrR720SMQD7oF8ga6g4stelojSLT
         /Bk1hTl2n54XThtd1HBr43z/V4OFuGBoefH10bgCgFzXSnnTasYUJ7NaxJT3zDLZzPs7
         puqM5BcyE0nW87MwWgmJ0Equv97fSrmoS7UohNRvdl3ONvT6QFdfaoGDc00r+oDtdxwr
         VG8BwZEA5N8Aatc3Mrma+wwLTyUhv2+599u07LTrsMTX0osCEDDUBbORb9E/ufxE3ppm
         /MLAlbAkKBYp+MxUqHeeHhKApoAyAVbHbhRlcfpHdk+0YNfTrOHN92kP2O+fliOqVKUA
         kmfw==
X-Gm-Message-State: AC+VfDxw5Sxhm/zuWRnSgqlEyni2K0jK1MiGUHmwtsPpoJJOSey9Ghdj
        j5gFz/XVnGHJVw99baciQOswDA8U9sjOoEnA2U9S4A==
X-Google-Smtp-Source: ACHHUZ5+zZDhZmQBpQaKcJ+OXWrStnmqq1Ba0mGKcp6Kr+4tTfPfuN7/HvBD5YRWrAfhl6GiSIvreP36ZUwSVFKRksc=
X-Received: by 2002:a81:4e47:0:b0:559:cbff:4aa2 with SMTP id
 c68-20020a814e47000000b00559cbff4aa2mr670782ywb.45.1682711385615; Fri, 28 Apr
 2023 12:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682682753.git.quic_varada@quicinc.com> <1bda63e18f7257f60cc1082b423aca129abfa3b0.1682682753.git.quic_varada@quicinc.com>
In-Reply-To: <1bda63e18f7257f60cc1082b423aca129abfa3b0.1682682753.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 28 Apr 2023 22:49:34 +0300
Message-ID: <CAA8EJpq0RXGf8_oBa_XF0+nOg31ouMUVJ3LhNRh_HtmgJvCJHQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq9574: add thermal zone nodes
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 at 17:53, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> This patch adds thermal zone nodes for the various
> sensors present in IPQ9574
>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 208 ++++++++++++++++++++++++++++=
++++++
>  1 file changed, 208 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/=
qcom/ipq9574.dtsi
> index 7cd5bdb..a7cb2b4c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -947,6 +947,214 @@
>                 };
>         };
>
> +       thermal_zones: thermal-zones {
> +               tsens_tz_sensor3 {

Please provide sensible names for all thermal zones. Please follow the
examples in other DT files.

> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 3>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <125000>;

Can it really go up to 125 =C2=B0C?

> +                                       hysteresis =3D <1000>;
> +                                       type =3D "critical";
> +                               };

Please provide also a passive trip point, so that the passive cooling
can be engaged.

> +                       };
> +               };
> +
> +               tsens_tz_sensor4 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 4>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <125000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor5 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 5>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <125000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor6 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 6>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <125000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor7 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 7>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <125000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor8 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 8>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <125000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor9 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 9>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <125000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor10 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 10>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <120000>;
> +                                       hysteresis =3D <10000>;
> +                                       type =3D "critical";
> +                               };
> +
> +                               cpu-passive {
> +                                       temperature =3D <110000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "passive";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor11 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 11>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <120000>;
> +                                       hysteresis =3D <10000>;
> +                                       type =3D "critical";
> +                               };
> +
> +                               cpu-passive {
> +                                       temperature =3D <110000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "passive";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor12 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 12>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <120000>;
> +                                       hysteresis =3D <10000>;
> +                                       type =3D "critical";
> +                               };
> +
> +                               cpu-passive {
> +                                       temperature =3D <110000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "passive";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor13 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 13>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <120000>;
> +                                       hysteresis =3D <10000>;
> +                                       type =3D "critical";
> +                               };
> +
> +                               cpu-passive {
> +                                       temperature =3D <110000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "passive";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor14 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 14>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <125000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               tsens_tz_sensor15 {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsens 15>;
> +
> +                       trips {
> +                               cpu-critical {
> +                                       temperature =3D <125000>;
> +                                       hysteresis =3D <1000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +       };
> +
>         timer {
>                 compatible =3D "arm,armv8-timer";
>                 interrupts =3D <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_T=
YPE_LEVEL_LOW)>,
> --
> 2.7.4
>


--=20
With best wishes
Dmitry
