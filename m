Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5C729563
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbjFIJfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbjFIJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:35:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336F74C07;
        Fri,  9 Jun 2023 02:30:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3598YZJT010667;
        Fri, 9 Jun 2023 09:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=hdCdBzVVwM/1xNMeSkgsNCfYfjLjbhdJKTfVZF0ScwE=;
 b=IGVmdPYGroC+9DUFq/zNMeTOOIqxSIe0FubBcnjztNSFcU9iMIj6nDaXYvxnOp2rGxZ3
 DhqZlGto8sFGR5R+44KzI9MlTcxfRr7AC06cuG7p+jqYy+tpvXacrPjS9HNzssCTcoWx
 EscsyNj1NpTppJJvg+VLyHAk9GflVKbnTaLKVjLYpZwjVf92QrzZwdfNA9+qRI2FU5Sj
 aq3b0lCjcGdNeqwb44F3i3u6VJ0KUdyQ6k4tRf6BjZSva+EkhPgT/V7SzkAFL0h914zK
 7hios4OrW+jjlQvfvKMHvGKZocxarF/mARt8wDr32cAXkFgSW3xfWurpEuaNyaCH5ng6 6A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3wykgcyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 09:29:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3599TJ3l026361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 09:29:19 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 02:29:14 -0700
Date:   Fri, 9 Jun 2023 14:59:10 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <mani@kernel.org>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75
 compatible
Message-ID: <20230609092910.GA558673@hu-pkondeti-hyd.qualcomm.com>
References: <1686138469-1464-1-git-send-email-quic_rohiagar@quicinc.com>
 <1686138469-1464-5-git-send-email-quic_rohiagar@quicinc.com>
 <20230609050052.GA472607@hu-pkondeti-hyd.qualcomm.com>
 <f44293c7-fce9-e7a3-2a02-7ad5f7980e81@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f44293c7-fce9-e7a3-2a02-7ad5f7980e81@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k6WSzfNCW1BVZXXpYe3YFe1eXrxFhw3M
X-Proofpoint-GUID: k6WSzfNCW1BVZXXpYe3YFe1eXrxFhw3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 11:17:08AM +0200, Konrad Dybcio wrote:
> 
> 
> On 9.06.2023 07:00, Pavan Kondeti wrote:
> > On Wed, Jun 07, 2023 at 05:17:48PM +0530, Rohit Agarwal wrote:
> >> Add compatible for EPSS CPUFREQ-HW on SDX75.
> >>
> >> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> >> index a6b3bb8..866ed2d 100644
> >> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> >> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> >> @@ -36,6 +36,7 @@ properties:
> >>                - qcom,sa8775p-cpufreq-epss
> >>                - qcom,sc7280-cpufreq-epss
> >>                - qcom,sc8280xp-cpufreq-epss
> >> +              - qcom,sdx75-cpufreq-epss
> >>                - qcom,sm6375-cpufreq-epss
> >>                - qcom,sm8250-cpufreq-epss
> >>                - qcom,sm8350-cpufreq-epss
> > 
> > This is a very basic question, not completely related to this patch.
> > Apologies in advance.
> > 
> > What is the rationale for adding a new soc string under compatible and
> > using it in the new soc device tree? Is it meant for documentation purpose?
> > i.e one know what all SoCs / boards supported by this device node.
> It's two-fold:
> 
> 1. The device tree describes the hardware, and for lack of better terms (e.g.
>    an SoC-specific version number of the block that is identical to all other
>    implementations of that revision on all SoCs that use it), we tend to
>    associate it with the SoC it's been (first) found on.
> 
> 2. In case we ever needed to introduce a SoC-specific quirk, we can just add
>    an of_is_compatible-sorta check to the driver and not have to update the
>    device trees. This is very important for keeping backwards compatibility,
>    as it's assumed that not everybody may be running the latest one. This
>    means we have to avoid ABI breaks (unless we have *very* good reasons, like
>    "this would have never worked anyway" or "it was not described properly
>    and worked on this occasion by pure luck")
> 

Thanks Konrad for the explanation. The #2 is a clear winner here. It
makes complete sense. In devices like USB, we have PID/VID through which
quirks can be implemented later. So I guess the same analogy applies here.
Like you said in (1), the devices are identified with SoC compatible
string.

Thanks,
Pavan
