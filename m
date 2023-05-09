Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D715A6FCAFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjEIQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjEIQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:16:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DDD4201;
        Tue,  9 May 2023 09:16:29 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349CuDeq030500;
        Tue, 9 May 2023 16:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=5QjsPrySGpUbdD0FnigO/E6A7H438BUPnM4ByTuH7AQ=;
 b=BYxkeJ2IL+q5zZGsfUY0iL0/2+vs4GjWZ0jaDn5Pjqw0pxCrBkWfgNHxl8R145ux8YAN
 qFMYC/XPjqX6L6xOvuYYAu/692+pLq/lGcR1QVt1v20+uYPpXiIvA51y455WjnUFoBPZ
 8ho4GzRwHNFtw9JrNRfgozG/L59iNQHW9DaJKfcnlf8C4CE3nhzYwDN3BOCZGtPyLr/G
 OtT23califun/KwPvgusU9ZHyMTZ+t+piwnKyWF4NEzEBnKv6adzMWe+2BVufdZdllr7
 hqqfUE/CXfrYpcWJMYK6Esz0Rcp8crllWRMzKmITLRgms4+5tzMlNYDkDOFzte67dZNZ mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf785a9vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 16:16:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349GGOrO030226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 16:16:24 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 09:16:24 -0700
Date:   Tue, 9 May 2023 09:16:23 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp: Add SDC2 and enable on
 CRD
Message-ID: <20230509161623.GA1765076@hu-bjorande-lv.qualcomm.com>
References: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
 <20230509030136.1524860-2-quic_bjorande@quicinc.com>
 <20230509063205.GB4823@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230509063205.GB4823@thinkpad>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qvhDOJOxOWEnRBzREsu_HozggY17A0yV
X-Proofpoint-GUID: qvhDOJOxOWEnRBzREsu_HozggY17A0yV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxlogscore=959
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 12:02:05PM +0530, Manivannan Sadhasivam wrote:
> On Mon, May 08, 2023 at 08:01:36PM -0700, Bjorn Andersson wrote:
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
[..]
> > +	sdc2_default_state: sdc2-default-state {
[..]
> > +		card-detect-pins {
> > +			pins = "gpio131";
> > +			function = "gpio";
> > +			drive-strength = <2>;
> > +			bias-disable;
> 
> Since the card detect is active low, shouldn't the pin be pulled high to avoid
> floating? Or is there an external pull up available on the board?
> 

There's an external pull up resistor to vreg_s10b, so there shouldn't be
any reason to pull it internally as well.

Regards,
Bjorn
