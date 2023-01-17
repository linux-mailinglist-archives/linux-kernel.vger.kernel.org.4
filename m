Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6682766D4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjAQDBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjAQDAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:00:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1896A2BEF1;
        Mon, 16 Jan 2023 18:58:24 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H1XF6t015452;
        Tue, 17 Jan 2023 02:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=EEnvsJJM5Osp3CoOWFQQMpnmZGh1V+OjNHzXq5JM+Qc=;
 b=XoLIi6OimKlgfK5FI00qiRPt8WLLxH5eI2Ay6pvsSn4VsTqcNq6/Z0sTPasemPB+pdQU
 YfzXGqz5GMWJTWpjFzpvtK+2Onsn05FndN/QMvWphfI/XsTc7ts890W3XZtx19AwUtTt
 f0jGyBSe98uKeA2Zfw8KdVPWRDi6ZzkUhkcMc/LInEAup9HxOEmbIcqhX3vZ+MPeD3Eh
 RfA5h4Lz5Y07GhAQfj49RquafSiNEbYbbnNwZM1CwJ2MveNz8NCnylsPhjq5dGNj5Wie
 h5MhRx1fxXqpi/ocnVCuMs71kPczhBpbCqW9gQmCWE1+2l9PIyTJ9rmtPa0j+IwybRyC Ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3mg3cjma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 02:58:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H2wJgp028544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 02:58:19 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 16 Jan 2023 18:58:19 -0800
Date:   Mon, 16 Jan 2023 18:58:18 -0800
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
Message-ID: <20230117025818.GC2350793@hu-bjorande-lv.qualcomm.com>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
 <9e831252-7198-7983-8a52-0e745688452d@linaro.org>
 <20230117023238.GB2350793@hu-bjorande-lv.qualcomm.com>
 <c1e3db0d-7593-b0fc-043b-60538faf9ba2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c1e3db0d-7593-b0fc-043b-60538faf9ba2@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MFhhu_0YLnA72HTVJf2Qgv5Pr_YftpSP
X-Proofpoint-GUID: MFhhu_0YLnA72HTVJf2Qgv5Pr_YftpSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301170020
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:37:27AM +0000, Bryan O'Donoghue wrote:
> On 17/01/2023 02:32, Bjorn Andersson wrote:
> > On Fri, Jan 13, 2023 at 05:10:17PM +0000, Bryan O'Donoghue wrote:
> > > On 13/01/2023 04:11, Bjorn Andersson wrote:
> > > > This implements the base PMIC GLINK driver, a power_supply driver and a
> > > > driver for the USB Type-C altmode protocol. This has been tested and
> > > > shown to provide battery information, USB Type-C switch and mux requests
> > > > and DisplayPort notifications on SC8180X, SC8280XP and SM8350.
> > > > 
> > > > Bjorn Andersson (4):
> > > >     dt-bindings: soc: qcom: Introduce PMIC GLINK binding
> > > >     soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
> > > >     soc: qcom: pmic_glink: Introduce altmode support
> > > >     power: supply: Introduce Qualcomm PMIC GLINK power supply
> > > > 
> > > >    .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  102 ++
> > > >    drivers/power/supply/Kconfig                  |    9 +
> > > >    drivers/power/supply/Makefile                 |    1 +
> > > >    drivers/power/supply/qcom_battmgr.c           | 1421 +++++++++++++++++
> > > >    drivers/soc/qcom/Kconfig                      |   15 +
> > > >    drivers/soc/qcom/Makefile                     |    2 +
> > > >    drivers/soc/qcom/pmic_glink.c                 |  336 ++++
> > > >    drivers/soc/qcom/pmic_glink_altmode.c         |  477 ++++++
> > > >    include/linux/soc/qcom/pmic_glink.h           |   32 +
> > > >    9 files changed, 2395 insertions(+)
> > > >    create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> > > >    create mode 100644 drivers/power/supply/qcom_battmgr.c
> > > >    create mode 100644 drivers/soc/qcom/pmic_glink.c
> > > >    create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
> > > >    create mode 100644 include/linux/soc/qcom/pmic_glink.h
> > > > 
> > > 
> > > How does the USB PHY and a USB redriver fit into this ?
> > > 
> > > Is the host supposed to manage both/neither ? Is the DSP responsible for
> > > configuring the PHY lanes and the turnaround on orientation switch ?
> > > 
> > 
> > As indicated above, the firmware deals with battery management and USB
> > Type-C handling.
> > 
> > The battery/power management is handled by the battmgr implementation,
> > exposing the various properties through a set of power_supply objects.
> > 
> > The USB Type-C handling comes in two forms. The "altmode" protocol
> > handles DisplayPort notifications - plug detect, orientation and mode
> > switches. The other part of the USB implementation exposes UCSI.
> > 
> > The altmode implementation provides two things:
> > - A drm_bridge, per connector, which can be tied (of_graph) to a
> >    DisplayPort instance, and will invoke HPD notifications on the
> >    drm_bridge, based on notification messages thereof.
> > 
> > - Acquire typec_switch and typec_mux handles through the of_graph and
> >    signal the remotes when notifications of state changes occur. Linking
> >    this to the FSA4480, is sufficient to get USB/DP combo (2+2 lanes)
> >    working on e.g. SM8350 HDK.
> >    Work in progress patches also exists for teaching QMP about
> >    orientation switching of the SS lines, but it seems this needs to be
> >    rebased onto the refactored QMP driver.
> >    I also have patches for QMP to make it switch USB/DP combo -> 4-lane
> >    DP, which allow 4k support without DSC, unfortunately switch back to
> >    USB has not been fully reliable, so this requires some more work
> >    (downstream involves DWC3 here as well, to reprogram the PHY).
> 
> Oki doki that makes sense and is pretty much in-line with what I thought.
> 
> We still have a bunch of typec-mux and phy work to do even with adsp/glink
> doing the TCPM.
> 

Correct, the registration of QMP as a typec_switch and typec_mux and
handling of respective notification remains open and should (by design)
be independent of the TCPM implementation.

In particular the orientation switching is an itch worth scratching at
this time. But when the DPU becomes capable of producing 4k@60 output it
would obviously be nice to have the whole shebang :)

Regards,
Bjorn

> Thanks for the explanation.
> 
> ---
> bod
> 
