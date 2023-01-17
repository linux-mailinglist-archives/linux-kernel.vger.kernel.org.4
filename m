Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417D66D9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjAQJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbjAQJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:20:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565AF39CED;
        Tue, 17 Jan 2023 01:15:06 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H8uiMQ001606;
        Tue, 17 Jan 2023 09:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=kn9odNJkQi3m7iemI181oIY+bwqzN2jC5sd5o9b0cKY=;
 b=i8vx3VCz20ls44KEovWIJsL23Uiow0h4wLGo60Rn/rCt5LuGIwvuSISpwBPPoPIaukBF
 JPLGhWN/iP+Tfegq4F8oTGHgVF8EKI6CinihCX+iJP7nO1feTtdDNZSTyg1wEprbhsKo
 qL4yAFkhMF5XM1lfgy3K0DWencyeQu7Q/gKdOLt79/hebQySf24grlwwDAfECQcBr3sj
 z3hzic6M14A/wAxpPfoYzIRxJHqY2VtXEsmVO2MYcrH//7xWrtOTZIAvLlMoNxuCvcQh
 BrKgvlFxYl2x/SRDBBeqr/6yPHNU8tTmaXKsiZXmNk16Vxd283XvrNZ4JHCeXOmYsKxz 3w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3j3nn8vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:14:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H9EsFh015648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:14:54 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 01:14:50 -0800
Date:   Tue, 17 Jan 2023 14:44:46 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Abel Vesa <abel.vesa@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>
Subject: Re: [PATCH v9 02/10] arm64: dts: qcom: Add base SM8550 dtsi
Message-ID: <20230117091446.GA3704192@hu-pkondeti-hyd.qualcomm.com>
References: <20230106201047.337409-1-abel.vesa@linaro.org>
 <20230106201047.337409-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230106201047.337409-3-abel.vesa@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1D1VN3zjSIA5d2MKyqxJcB_5Kea2Fiib
X-Proofpoint-ORIG-GUID: 1D1VN3zjSIA5d2MKyqxJcB_5Kea2Fiib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=618 phishscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170077
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 10:10:39PM +0200, Abel Vesa wrote:
> +		cpufreq_hw: cpufreq@17d91000 {
> +			compatible = "qcom,sm8550-cpufreq-epss", "qcom,cpufreq-epss";
> +			reg = <0 0x17d91000 0 0x1000>,
> +			      <0 0x17d92000 0 0x1000>,
> +			      <0 0x17d93000 0 0x1000>;
> +			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
> +			clock-names = "xo", "alternate";
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
> +			#freq-domain-cells = <1>;
> +		};

Currently, I am seeing available frequencies as 2x of the original
frequencies. This is observed for all CPUs. The xo source should be bi_tcxo here.
I will send a patch on top of qcom/linux : arm64-for-6.3 branch.

Thanks,
Pavan
