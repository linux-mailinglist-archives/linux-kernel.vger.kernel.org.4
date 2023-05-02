Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7116F3EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjEBIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjEBIFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:05:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7875449E;
        Tue,  2 May 2023 01:04:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3427loBA015750;
        Tue, 2 May 2023 08:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=Wwm9DE/KjzOB4GGIfiFTmouYOCBj5Hbw47wN2154+40=;
 b=G8CCF1LisWskr4v88wTEJwfQWnWZn1rMWiXynVCGchMX1mzWjqCyeLFCgK+pZvSL6/yq
 W+pQzrgYMGBu8RJ81Xu5umU7xBubTcKcQUr8EoESUR3E07+6kU2kjHZVPaMAfXk+Xxr7
 O53rcPFpO050hrDuEgISNGN7Li9GTMnNCFYVGEKikUUC8CinMZDeb6P6io3fdUIcLEc1
 MyGvIVgExxV8XcxMZAb27ObBctFo5CA9jWs3cg1fgHBBn5hsxvVky+gn2XWbvZ8U7Zit
 enVZjjM0nqdZNl7Yuyva75vIFVpUsqGPpMkHHlTkVJIdWClirBmd+07gayFuXuMz3jz7 yA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qahhk9g98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 08:04:51 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34284o9f028517
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 May 2023 08:04:50 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 May 2023 01:04:45 -0700
Date:   Tue, 2 May 2023 13:34:41 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq9574: add thermal zone nodes
Message-ID: <20230502080440.GA26126@varda-linux.qualcomm.com>
References: <cover.1682682753.git.quic_varada@quicinc.com>
 <1bda63e18f7257f60cc1082b423aca129abfa3b0.1682682753.git.quic_varada@quicinc.com>
 <CAA8EJpq0RXGf8_oBa_XF0+nOg31ouMUVJ3LhNRh_HtmgJvCJHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpq0RXGf8_oBa_XF0+nOg31ouMUVJ3LhNRh_HtmgJvCJHQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eGiewxL5nQp5kl7PnE8UPH9_xPk1YdxO
X-Proofpoint-GUID: eGiewxL5nQp5kl7PnE8UPH9_xPk1YdxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 10:49:34PM +0300, Dmitry Baryshkov wrote:
> On Fri, 28 Apr 2023 at 17:53, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > This patch adds thermal zone nodes for the various
> > sensors present in IPQ9574
> >
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 208 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 208 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > index 7cd5bdb..a7cb2b4c 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > @@ -947,6 +947,214 @@
> >                 };
> >         };
> >
> > +       thermal_zones: thermal-zones {
> > +               tsens_tz_sensor3 {
>
> Please provide sensible names for all thermal zones. Please follow the
> examples in other DT files.

Ok.

> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 3>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <125000>;
>
> Can it really go up to 125 °C?

The SoC product requirement is 120°C. It is capable of 125°C.
This was tested inside a thermal chamber and ensured that it
hits 125°C and system reboots at that temperature.

> > +                                       hysteresis = <1000>;
> > +                                       type = "critical";
> > +                               };
>
> Please provide also a passive trip point, so that the passive cooling
> can be engaged.

The linux kernel cannot take any steps to initiate cooling for
components other than the 4 CPU cores. The f/w that runs on these
IP blocks have to take steps to initiate cooling. Additionally,
the passive temperature for the non-cpu sensors are not
characterised yet and I don't have the values now.

We have these nodes to be able to read the temperature of the
other blocks via the sysfs entry /sys/devices/virtual/thermal/*/temp
Have given the critical trip point so that the setup is rebooted
if the critical temperature is reached.

Have given passive trip point for the CPU core related thermal
nodes (tsens_tz_sensor10, tsens_tz_sensor11, tsens_tz_sensor12
and tsens_tz_sensor13).

If this is not acceptable, please let me know. Will remove the
non-cpu nodes and post a patch with just the CPU entries.

Thanks
Varada

> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor4 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 4>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <125000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor5 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 5>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <125000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor6 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 6>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <125000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor7 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 7>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <125000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor8 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 8>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <125000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor9 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 9>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <125000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor10 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 10>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <120000>;
> > +                                       hysteresis = <10000>;
> > +                                       type = "critical";
> > +                               };
> > +
> > +                               cpu-passive {
> > +                                       temperature = <110000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "passive";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor11 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 11>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <120000>;
> > +                                       hysteresis = <10000>;
> > +                                       type = "critical";
> > +                               };
> > +
> > +                               cpu-passive {
> > +                                       temperature = <110000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "passive";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor12 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 12>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <120000>;
> > +                                       hysteresis = <10000>;
> > +                                       type = "critical";
> > +                               };
> > +
> > +                               cpu-passive {
> > +                                       temperature = <110000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "passive";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor13 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 13>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <120000>;
> > +                                       hysteresis = <10000>;
> > +                                       type = "critical";
> > +                               };
> > +
> > +                               cpu-passive {
> > +                                       temperature = <110000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "passive";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor14 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 14>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <125000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               tsens_tz_sensor15 {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&tsens 15>;
> > +
> > +                       trips {
> > +                               cpu-critical {
> > +                                       temperature = <125000>;
> > +                                       hysteresis = <1000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +       };
> > +
> >         timer {
> >                 compatible = "arm,armv8-timer";
> >                 interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > --
> > 2.7.4
> >
>
>
> --
> With best wishes
> Dmitry
