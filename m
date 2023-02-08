Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F268F642
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjBHSA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBHSAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:00:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C42EF96;
        Wed,  8 Feb 2023 10:00:23 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318EjhmN004961;
        Wed, 8 Feb 2023 18:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=YgH90xYls+5ogdomkQXAoILbQ22fA82j/oeKiSbJVIQ=;
 b=SBRSpml5Jc9Y9e7RsXynhjvZfRTMpH2VKWaCd4bG9gReIPruqrvYLZt521vhcPuGchzI
 XHRQ41Xsvy2LDWLs6orgbSSQd6S4Y3+EuQG3NKJwr1iXsgTh1GtYXQZTs+yPvTno/13x
 Wx0elHO26mu9b4NnktDLWpJlLlAauN0/hZSATTiqKdzWOkCUSy5ruidisuBsYWUdpoKt
 IBna+dkjC5SkffdQeDKZgVqXidDSY3DpKNy8L5ZPWniUJ5hJ8E+ufG0B38uq9ecmskYW
 54W/m0HJKLLOwoavpLzyphOiQcNFhl0Y13H8d7UhOg7DAibn4LqNAMo81MofRGG/Qsf5 MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmb8js0n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 18:00:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 318I09d5029565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 18:00:09 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 10:00:09 -0800
Date:   Wed, 8 Feb 2023 10:00:07 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
Message-ID: <20230208180007.GB2397622@hu-bjorande-lv.qualcomm.com>
References: <20230208034620.2048744-1-quic_bjorande@quicinc.com>
 <20230208034620.2048744-3-quic_bjorande@quicinc.com>
 <229edfec-736f-d94d-23ba-2a0649639556@linaro.org>
 <20230208155720.GA2397622@hu-bjorande-lv.qualcomm.com>
 <e9b6cdcc-079d-497a-6e8b-c2d69a393597@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9b6cdcc-079d-497a-6e8b-c2d69a393597@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mp8R0hDq61p70J6e2ER-9h-AvXeRWIDE
X-Proofpoint-GUID: Mp8R0hDq61p70J6e2ER-9h-AvXeRWIDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_08,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=765
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080158
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:40:44PM +0100, Konrad Dybcio wrote:
> On 8.02.2023 16:57, Bjorn Andersson wrote:
> > On Wed, Feb 08, 2023 at 09:14:46AM +0100, Konrad Dybcio wrote:
> >> On 8.02.2023 04:46, Bjorn Andersson wrote:
[..]
> >>>  &usb_0_dwc3 {
> >>> -	/* TODO: Define USB-C connector properly */
> >>>  	dr_mode = "host";
> >>> +
> >>> +	port {
> >>> +		usb_0_role_switch: endpoint {
> >>> +			remote-endpoint = <&pmic_glink_con0_hs>;
> >>> +		};
> >> This should be defined in the SoC DTSI, it's a standard dwc3 binding
> >> with usb HS / SS / SBU ports. Especially since we can feed the endpoint
> >> from any device now, as pmic-glink should work everywhere.
> >>
> > 
> > The sa8295p/sa8540p boards, derived from sc8280xp does not implement
> > pmic_glink, so it seems moving this to the soc.dtsi would be messy.
> > 
> >> Or /omit-if-no-ref/, I suppose.
> >>
> > 
> > Or you're saying I should put the skeleton of the port definition in the
> > soc.dtsi and then fill it out the remote-endpoint here; and mark it
> > omit-if-no-ref to avoid binding warnings?
> I thought omit-if-no-ref actually omits the node before resolving phandles
> that it references, but it seems to not be the case.. Still, we can define
> the ports in the SoC DTSI and assign endpoints per-device (like we do with
> DSI for example).
> 

You mean move the lines:

port {
	usb_0_role_switch: endpoint {
	};
};

to sc8280xp.dtsi and then do:

&usb_0_role_switch {
	remote-endpoint = <&pmic_glink_con0_hs>;
};

here?

Regards,
Bjorn
