Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058E666D44C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjAQCdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjAQCcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:32:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA3B2C67B;
        Mon, 16 Jan 2023 18:32:44 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H2WflZ003294;
        Tue, 17 Jan 2023 02:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=gPI8IrnBLe4xWc0jWZlIULUF+isizpYjaPD72DAALm8=;
 b=L2j5/CuYst6aTPU3rDrxHyQqMiHvvFExCKmLezEB2N4x+oKPAOhE5s4nfRhF1LWfMKl/
 1bMnOHbnY7K33TnGmuic3FZBBTaf7/eZ87sQ45AtBgckNIHQyXK90I0ypXQ4LRguaDrr
 cUVx1BNhRMnE547suskN8u8RS3qQu+86zgowCMhY7SstP+3voartNfN3r1z4epE/htFf
 kzoTw0pGPEMA7CWzGhwFQzAiD+d/xXBoNwKwEFMYV0sODM5/EBTzfrUNFCMm+TQ95KHB
 IXeayDjOc8raoBzCBjxg6Cun9/ZpRHXdJIOnRU0ngc+wJabxqkNJGBv7pcPrlEzyQfFr OQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3j3nmmxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 02:32:41 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H2WeZ8008859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 02:32:40 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 16 Jan 2023 18:32:40 -0800
Date:   Mon, 16 Jan 2023 18:32:38 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/4] soc: qcom: Introduce PMIC GLINK
Message-ID: <20230117023238.GB2350793@hu-bjorande-lv.qualcomm.com>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
 <9e831252-7198-7983-8a52-0e745688452d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9e831252-7198-7983-8a52-0e745688452d@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: osh9xnguttiX6wNl7ddeOFZUg5rRTbsO
X-Proofpoint-ORIG-GUID: osh9xnguttiX6wNl7ddeOFZUg5rRTbsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170016
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 05:10:17PM +0000, Bryan O'Donoghue wrote:
> On 13/01/2023 04:11, Bjorn Andersson wrote:
> > This implements the base PMIC GLINK driver, a power_supply driver and a
> > driver for the USB Type-C altmode protocol. This has been tested and
> > shown to provide battery information, USB Type-C switch and mux requests
> > and DisplayPort notifications on SC8180X, SC8280XP and SM8350.
> > 
> > Bjorn Andersson (4):
> >    dt-bindings: soc: qcom: Introduce PMIC GLINK binding
> >    soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
> >    soc: qcom: pmic_glink: Introduce altmode support
> >    power: supply: Introduce Qualcomm PMIC GLINK power supply
> > 
> >   .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  102 ++
> >   drivers/power/supply/Kconfig                  |    9 +
> >   drivers/power/supply/Makefile                 |    1 +
> >   drivers/power/supply/qcom_battmgr.c           | 1421 +++++++++++++++++
> >   drivers/soc/qcom/Kconfig                      |   15 +
> >   drivers/soc/qcom/Makefile                     |    2 +
> >   drivers/soc/qcom/pmic_glink.c                 |  336 ++++
> >   drivers/soc/qcom/pmic_glink_altmode.c         |  477 ++++++
> >   include/linux/soc/qcom/pmic_glink.h           |   32 +
> >   9 files changed, 2395 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> >   create mode 100644 drivers/power/supply/qcom_battmgr.c
> >   create mode 100644 drivers/soc/qcom/pmic_glink.c
> >   create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
> >   create mode 100644 include/linux/soc/qcom/pmic_glink.h
> > 
> 
> How does the USB PHY and a USB redriver fit into this ?
> 
> Is the host supposed to manage both/neither ? Is the DSP responsible for
> configuring the PHY lanes and the turnaround on orientation switch ?
> 

As indicated above, the firmware deals with battery management and USB
Type-C handling.

The battery/power management is handled by the battmgr implementation,
exposing the various properties through a set of power_supply objects.

The USB Type-C handling comes in two forms. The "altmode" protocol
handles DisplayPort notifications - plug detect, orientation and mode
switches. The other part of the USB implementation exposes UCSI.

The altmode implementation provides two things:
- A drm_bridge, per connector, which can be tied (of_graph) to a
  DisplayPort instance, and will invoke HPD notifications on the
  drm_bridge, based on notification messages thereof.

- Acquire typec_switch and typec_mux handles through the of_graph and
  signal the remotes when notifications of state changes occur. Linking
  this to the FSA4480, is sufficient to get USB/DP combo (2+2 lanes)
  working on e.g. SM8350 HDK.
  Work in progress patches also exists for teaching QMP about
  orientation switching of the SS lines, but it seems this needs to be
  rebased onto the refactored QMP driver.
  I also have patches for QMP to make it switch USB/DP combo -> 4-lane
  DP, which allow 4k support without DSC, unfortunately switch back to
  USB has not been fully reliable, so this requires some more work
  (downstream involves DWC3 here as well, to reprogram the PHY).

I have been experimenting with UCSI in the past, but my goal for this
series was to support external displays on my desktop (laptop...), but
through some experiments I've wired the connectors to dwc3 in order to
get usb_role_switch working. Neil has been looking at this in more
detail lately though.

Regards,
Bjorn
