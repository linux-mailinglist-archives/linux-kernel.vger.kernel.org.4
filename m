Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE4610B99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJ1HvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJ1HvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:51:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0984485AB9;
        Fri, 28 Oct 2022 00:51:13 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S6lQ80023975;
        Fri, 28 Oct 2022 07:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=FUOkIyLd1KkITdni1CtAq8I3dI94667xNj2Ue+unSpU=;
 b=YF9tD7MqFdEcg7iH132qjRTQKVyDiJv0LqXCKSDHBKY2pO0QWSAB1FA1QqRjbe+p31EF
 /Oumxv90sZhYglezFh0VvEzRdoA/FwkHEcpVzsGhoHgsEVionUWMzqISGo+jvfnv3DRH
 CiBf945TpbTlNnGtWM+mDs7Iq2mfP6CR8fSyHt42191uggjt0MBQxDMvaGAQw4n14/uw
 +TJ96Dp3MXhpm7/gtNMSHUiZPjX3QzDRpHHINBi7A8ia18CR2+gwfK5xPuKaW3BCC9Ez
 CDRE5gaif56TJlpFofIU/OYzT2v4WN1o/HC0sARpMtGMGDyEW6qHtbymOITmiUrTUpBA sA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kg59agx8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:51:07 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29S7m1tq009085;
        Fri, 28 Oct 2022 07:51:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3kf9urq5ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:51:07 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29S7nWBk010017;
        Fri, 28 Oct 2022 07:51:06 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 29S7p6BG011702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 07:51:06 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 00:51:03 -0700
Date:   Fri, 28 Oct 2022 13:20:59 +0530
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     <konrad.dybcio@somainline.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        "Brian Masney" <bmasney@redhat.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Message-ID: <20221028075059.GA15101@hu-ppareek-blr.qualcomm.com>
References: <20221020073036.16656-1-quic_ppareek@quicinc.com>
 <20221020073036.16656-3-quic_ppareek@quicinc.com>
 <7a62dd552c02e2b83fabaf9ff55a7c6c@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7a62dd552c02e2b83fabaf9ff55a7c6c@somainline.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BNlJnMlT2jzr7tJQHOKrWUIHFqqr54qT
X-Proofpoint-ORIG-GUID: BNlJnMlT2jzr7tJQHOKrWUIHFqqr54qT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_04,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=757 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:49:23PM +0200, konrad.dybcio@somainline.org wrote:
> On 2022-10-20 09:30, Parikshit Pareek wrote:
> > Introduce the Qualcomm SA8540P ride automotive platform, also known as
> > Qdrive-3 development board.
> > 
> > This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> > regulators, debug UART, PMICs, remoteprocs and USB.
> > 
> > The SA8540P ride contains four PM8450 PMICs.
> > 
> > Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> > ---
> 
> Hi!
> 
> [...[
> 
> > +		vreg_l3c: ldo3 {
> > +			regulator-name = "vreg_l3c";
> > +			regulator-min-microvolt = <1200000>;
> > +			regulator-max-microvolt = <1200000>;
> > +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +			regulator-allow-set-load;
> Not sure if setting load is desired after recent rpmh regulator changes.
May I know the exact patch being refered here?
> 
> [...]
> 
> > +
> > +&spmi_bus {
> > +	pm8450a: pmic@0 {
> > +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> Please add a pm8450[aceg].dtsi instead, as other boards would probably like
> to
> reuse this. Also, move the spmi.h inclusion there.
> 
> [...]
> 
> > +};
> > +
> > +/* PINCTRL */
> Not sure if it's useful if there's nothing there for now.
> 
> Konrad

Regards,
Parikshit Pareek

