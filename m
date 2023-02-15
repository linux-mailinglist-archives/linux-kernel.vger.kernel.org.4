Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA556981E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBORYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBORYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:24:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE2EEB77;
        Wed, 15 Feb 2023 09:24:12 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FG6CpA016406;
        Wed, 15 Feb 2023 17:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Gg4S9S82OkPVNSqHx0vW9sEfi7mq/UakkdzYpUcytTc=;
 b=BuFtR8q6q5/pxO9IO7fQ6XpZSVCUyr/E9OLqBKXZCqla4hjtWfOHjudg6SnrQeI8mGmK
 Q2HiYApN5fz/wRS35hryrCXHbqRDbscEhuHNRii/rVQYaVNZonYVpW63OBK9/+K3Zo4r
 UfvVyUJi8oTWgIoEYrTGZCuMNtLpIMEWSaQLjeI6Q1wXYoRUXIq0fjp1AcKit7K35oSH
 EAAwSSwzoUVDZOJu4RMtzsE1YkT/qLZG54E12o6cbOp3cDW3MSJKMUBdcs7SFIySLLgb
 lcujwlzJgTqxSbzp45/JCZDzLnmMQDjewtUACdmk9VY90IyQIOWGuJESwgTSM/Q4AKd9 pQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nruta1a19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 17:23:50 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31FHNnjK031153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 17:23:49 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 15 Feb 2023 09:23:48 -0800
Date:   Wed, 15 Feb 2023 09:23:47 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce
 pmic_glink
Message-ID: <20230215172347.GA2417333@hu-bjorande-lv.qualcomm.com>
References: <20230213215619.1362566-1-quic_bjorande@quicinc.com>
 <20230213215619.1362566-3-quic_bjorande@quicinc.com>
 <Y+yqPMdiuJ+ssisR@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+yqPMdiuJ+ssisR@hovoldconsulting.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zuDb66neyffvGrwGI05BsUyq6wN8oEOE
X-Proofpoint-GUID: zuDb66neyffvGrwGI05BsUyq6wN8oEOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_07,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=862 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302150155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:47:40AM +0100, Johan Hovold wrote:
> On Mon, Feb 13, 2023 at 01:56:17PM -0800, Bjorn Andersson wrote:
[..]
> > +&mdss0_dp0_out {
> > +	data-lanes = <0 1>;
> 
> This does not work as the drm driver expects 'data-lanes' to be defined
> in the controller node where you had it in the previous versions:
> 
> 	[    6.669325] [drm] Invalid property "data-lanes", default max DP lanes = 4
> 
> Moving it to the endpoint nodes would require updating both binding and
> driver it seems.
> 

I will go back and double-check, but this should be taken care of in
d25cfeeec064 ("drm/msm/dp: parse data-lanes as property of dp_out
endpoint").

Regards,
Bjorn
