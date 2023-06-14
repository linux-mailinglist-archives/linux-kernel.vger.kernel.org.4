Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2944723D95
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjFFJdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbjFFJdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:33:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D310D5;
        Tue,  6 Jun 2023 02:32:39 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3569LshB027493;
        Tue, 6 Jun 2023 09:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=WbGyQ5R6yurqK0VL5BRQAmWw7gi95WfOOoc+/brGK+g=;
 b=h6jJ6iUvCYXp/VYHnIndDg1TqeImj8hG+YaYZ3jEczD2Logk93eF/+GF7Un4woIWbVLB
 uKCuLUaBGhUl4JBoxUEDsXb6HSJeZZQUtstnMDmVGvmWli52Jl89x9efDCYgubclNLAJ
 Coif2Guk8lr/Trw/2K3b6gMiI04lKrMam0Bfoo9RDSLUStcOlC/zocpPPTtJa13Re0rm
 vBRyyT8w7r//J5S2EwpvnkjUgpBiqMZuuib5ELv51NJ/ej/RJTft5dCoC45uoD4FaZPB
 zIBI0bib0gi/PfmFJnbvHAfJHnc9MgmUzEA9ACu8EWeLzGQpcqoX5NXGk5/mxJLzUvQc jw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1d4etm6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 09:32:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3569WGPg001882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 09:32:16 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 6 Jun 2023 02:32:10 -0700
Date:   Tue, 6 Jun 2023 15:02:06 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rohit Agarwal <quic_rohiagar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <mani@kernel.org>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: Add the support of cpufreq on
 SDX75
Message-ID: <20230606093206.GA3255667@hu-pkondeti-hyd.qualcomm.com>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-11-git-send-email-quic_rohiagar@quicinc.com>
 <c4f34ad1-bea7-c5cf-dca8-9ededeafa4b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c4f34ad1-bea7-c5cf-dca8-9ededeafa4b4@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -RL8ItFWMdLA1RPKMQn4zlrij96SzO16
X-Proofpoint-GUID: -RL8ItFWMdLA1RPKMQn4zlrij96SzO16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306060080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 08:21:39PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5.06.2023 18:29, Rohit Agarwal wrote:
> > Add the support of cpufreq to enable the cpufreq scaling
> > on SDX75 SoC. Also add CPU specific information to build
> > energy model for EAS.
> > 
> > Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sdx75.dtsi | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> > index 47170ae..e1887a4 100644
> > --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> > @@ -47,10 +47,14 @@
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a55";
> >  			reg = <0x0 0x0>;
> > +			clocks = <&cpufreq_hw 0>;
> >  			enable-method = "psci";
> >  			power-domains = <&CPU_PD0>;
> >  			power-domain-names = "psci";
> >  			next-level-cache = <&L2_0>;
> > +			qcom,freq-domain = <&cpufreq_hw 0>;
> > +			capacity-dmips-mhz = <1024>;
> > +			dynamic-power-coefficient = <100>;
> >  			L2_0: l2-cache {
> >  				compatible = "cache";
> >  				next-level-cache = <&L3_0>;
> > @@ -64,10 +68,14 @@
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a55";
> >  			reg = <0x0 0x100>;
> > +			clocks = <&cpufreq_hw 0>;
> >  			enable-method = "psci";
> >  			power-domains = <&CPU_PD1>;
> >  			power-domain-names = "psci";
> >  			next-level-cache = <&L2_100>;
> > +			qcom,freq-domain = <&cpufreq_hw 0>;
> > +			capacity-dmips-mhz = <1024>;
> > +			dynamic-power-coefficient = <100>;
> >  			L2_100: l2-cache {
> >  				compatible = "cache";
> >  				next-level-cache = <&L3_0>;
> > @@ -78,10 +86,14 @@
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a55";
> >  			reg = <0x0 0x200>;
> > +			clocks = <&cpufreq_hw 0>;
> >  			enable-method = "psci";
> >  			power-domains = <&CPU_PD2>;
> >  			power-domain-names = "psci";
> >  			next-level-cache = <&L2_200>;
> > +			qcom,freq-domain = <&cpufreq_hw 0>;
> > +			capacity-dmips-mhz = <1024>;
> > +			dynamic-power-coefficient = <100>;
> >  			L2_200: l2-cache {
> >  				compatible = "cache";
> >  				next-level-cache = <&L3_0>;
> > @@ -92,10 +104,14 @@
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a55";
> >  			reg = <0x0 0x300>;
> > +			clocks = <&cpufreq_hw 0>;
> >  			enable-method = "psci";
> >  			power-domains = <&CPU_PD3>;
> >  			power-domain-names = "psci";
> >  			next-level-cache = <&L2_300>;
> > +			qcom,freq-domain = <&cpufreq_hw 0>;
> > +			capacity-dmips-mhz = <1024>;
> That sounds a bit bogus.. Thinking about it, it sounds bogus on most
> platforms we have support for! I guess SM8250 big cores aren't *really*
> equally as powerful..
> 

These are relative values on a given CPU. If a b.L SoC has 2 LITTLE CPUs
and 2 big CPUs. The LITTLE CPU capacity is relative to big CPU capacity
i.e 1024. Thats the reason for SM8250 having capacity-dmips-mhz as 448
for LITTLE CPUs (0-3) and 1024 as Big CPUs.

Since SDx75 has all similar capacity CPUs, setting 1024 or for that
matter any value is good enough.

Thanks,
Pavan
