Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19E66E321
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjAQQLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjAQQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:11:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C106718B27;
        Tue, 17 Jan 2023 08:11:02 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HCWUsY023879;
        Tue, 17 Jan 2023 16:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=T38Hza0qCVAayxqFaKMYSOgz+9zdljb8BCeONW2crlE=;
 b=hRon3F2gUAvyH+DWPV7/O6ltpn/d1MnmbVoVXbqABEImfEGm2upjhRLF676rxW5TlnZd
 eGmTst9Wrw/umjLbCCwM+Tz0buc0SO/qEQQIeobXNT5Y/qpkLRG6NOhROt5Kh41c28SB
 x1zTtxOvi8oU98pU/wjwReaRUzP1TXlhKWZPinrfJLv47k9qQej4nv4JuhclVABobkn6
 5Drl+uxXJhQfoaqBSAOr85vNf8BPzYN1aB7xPeQrcrwbc07ZtASZJfSGUG4dGXhF7ftE
 x0DJy+7+4CxNe1K/ICqVLUNbA11MyaDxZEVNRyekpG+sNulxQdMQF1fuSxIaGidkdSax CQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5pbm93qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 16:10:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HGAvIO001163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 16:10:57 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 08:10:56 -0800
Date:   Tue, 17 Jan 2023 08:10:55 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Vote for CX in USB
 controllers
Message-ID: <20230117161055.GF2350793@hu-bjorande-lv.qualcomm.com>
References: <20230112135117.3836655-1-quic_bjorande@quicinc.com>
 <a3594770-1d7e-de02-b78c-8446d239b60b@linaro.org>
 <9CCF91EB-3BB8-4547-AF0F-7CB774A15BDE@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9CCF91EB-3BB8-4547-AF0F-7CB774A15BDE@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8w703Sc_PwElF8aklSBfWFG-djcroLdf
X-Proofpoint-GUID: 8w703Sc_PwElF8aklSBfWFG-djcroLdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_07,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170129
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 07:00:29PM +0200, Dmitry Baryshkov wrote:
> 12 января 2023 г. 16:21:14 GMT+02:00, Konrad Dybcio <konrad.dybcio@linaro.org> пишет:
> >
> >
> >On 12.01.2023 14:51, Bjorn Andersson wrote:
> >> Running GCC_USB30_*_MASTER_CLK at 200MHz requires CX at nominal level,
> >> not doing so results in occasional lockups. This was previously hidden
> >> by the fact that the display stack incorrectly voted for CX (instead of
> >> MMCX).
> >> 
> >> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> >> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> >> ---https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/blob/LV.AU.1.2.3.r1-03600-gen3meta.0/drivers/clk/qcom/gcc-direwolf.c#L2703-2725
> >
> >Maybe in the future there could be some power savings for lower freqs..
> 
> I had the same question. If the vote is not static, but depends on the
> freq, shouldn't this be to implemented as an opp + table?
> 

The upstream Linux driver does not dynamically adjust the rate of the
core clock, so whenever the device isn't suspended it will tick at
200MHz and require nominal voltage.

The downstream driver does adjust the core clock rate based on the link,
and can thereby adjust the voltage level as well. So once this is
supported upstream, replacing this with an opp-table would be
appropriate.

Regards,
Bjorn

> 
> >
> >Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >
> >Konrad
> >>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >> index 2ed17baf50d3..4f4353f84cba 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >> @@ -2265,6 +2265,7 @@ usb_0: usb@a6f8800 {
> >>  					  "ss_phy_irq";
> >>  
> >>  			power-domains = <&gcc USB30_PRIM_GDSC>;
> >> +			required-opps = <&rpmhpd_opp_nom>;
> >>  
> >>  			resets = <&gcc GCC_USB30_PRIM_BCR>;
> >>  
> >> @@ -2319,6 +2320,7 @@ usb_1: usb@a8f8800 {
> >>  					  "ss_phy_irq";
> >>  
> >>  			power-domains = <&gcc USB30_SEC_GDSC>;
> >> +			required-opps = <&rpmhpd_opp_nom>;
> >>  
> >>  			resets = <&gcc GCC_USB30_SEC_BCR>;
> >>  
> 
