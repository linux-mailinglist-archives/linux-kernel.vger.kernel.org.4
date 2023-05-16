Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2112B70593A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEPVBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEPVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:01:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D4630E0;
        Tue, 16 May 2023 14:01:49 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GKpQGe012395;
        Tue, 16 May 2023 21:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ttVoZ1MTEot2EPQSmKoMu+nXb5zpPDeIHDthXMvspNo=;
 b=FBcQfqeJBsI+MboplIbzkrfIBX1AejVskGWwzf7r17VRKGdeQYNIudS8mz1Bec/Ff0+r
 0HkSv/hjOp6NZhw0VmiEPxS99y2FCFJp+QS/92z7OWCjga4MRWCiFczRyCDysfySYnM+
 IPJF346rK4fRRn/YcnsK8F+LXkObl7FiqDOrRfxAnZ+YLVhHIU2G6KLu8pMI4uHoTKd3
 dGOc3dSXxx0KNGbreL2Hcs4Xr8JbolaO8/hJMy27tJbd/jKFzxyATg9hGjLv/q0uudFY
 x926siKwiy1i5NIXSYVETKCx3qqzaOtxczOZWOdH9bk3otpwCyufxdDGIpqa5yqmD6I+ HA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmcc60mvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 21:01:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GL1jo5019058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 21:01:45 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 16 May 2023 14:01:44 -0700
Date:   Tue, 16 May 2023 14:01:43 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
Message-ID: <20230516210143.GB606695@hu-bjorande-lv.qualcomm.com>
References: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
 <f6ecd66b-e207-0ed9-0ff3-1febfdf5bce9@linaro.org>
 <20230515023828.jqrrqkit5ygovimp@ripper>
 <1ecd0cba-296e-b036-f59e-f679c771ae9f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1ecd0cba-296e-b036-f59e-f679c771ae9f@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FFoqmScspeWgJR1o5ov0jG0IZPJyt6jr
X-Proofpoint-ORIG-GUID: FFoqmScspeWgJR1o5ov0jG0IZPJyt6jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160178
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 11:34:45AM +0200, Konrad Dybcio wrote:
> 
> 
> On 15.05.2023 04:38, Bjorn Andersson wrote:
> > On Sat, May 13, 2023 at 11:09:07AM +0200, Konrad Dybcio wrote:
> >>
> >>
> >> On 12.05.2023 17:04, Bjorn Andersson wrote:
> >>> The rpmh driver will cache sleep and wake votes until the cluster
> >>> power-domain is about to enter idle, to avoid unnecessary writes. So
> >>> associate the apps_rsc with the cluster pd, so that it can be notified
> >>> about this event.
> >>>
> >>> Without this, only AMC votes are being commited.
> >> Ouch.
> >>
> >> Should we make this required: in bindings and add it to all
> >> platforms?
> >>
> > 
> > I though this was an optimization and in the absence of this callback
> > the driver would just write out wake and sleep sets as well. But per the
> > current implementation (and perhaps some underlying cause?) it is indeed
> > required, if you care about power consumption.
> Hm.. since it's not strictly required for operation, would something
> like this be fitting?:
> 

I don't think it's required for operation, but the current
implementation does require it.

So I think we should either require it in the binding to mimic the
implementation, or the implementation should handle either case (only
with a performance impact)

> oneOf:
>   - required:
>       [...]
>       - power-domains
> 
>   - required:
>       [...]
>     deprecated: true
> 
> (if it even works this way)

I don't think it's worth supporting the combinations.

Regards,
Bjorn

> 
> Konrad
> > 
> >>>
> >>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> >>> ---
> >> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> >>
> > 
> > The Fixes sounds reasonable.
> > 
> > Thanks,
> > Bjorn
> > 
> >> Konrad
> >>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >>> index 8fa9fbfe5d00..5c68f2182c2f 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >>> @@ -3982,6 +3982,7 @@ apps_rsc: rsc@18200000 {
> >>>  			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
> >>>  					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
> >>>  			label = "apps_rsc";
> >>> +			power-domains = <&CLUSTER_PD>;
> >>>  
> >>>  			apps_bcm_voter: bcm-voter {
> >>>  				compatible = "qcom,bcm-voter";
