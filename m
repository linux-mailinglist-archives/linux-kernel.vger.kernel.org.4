Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B7C7079BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 07:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjERFlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 01:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjERFlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 01:41:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6099A2D4C;
        Wed, 17 May 2023 22:41:11 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I3w2Qi021276;
        Thu, 18 May 2023 05:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ESj7ja+wnB0eb850UfwKQW6ufww4tlrQ4xDywmAuR8M=;
 b=OOtIWou4h+P3hiGewq1adQ9xG3q/aZgC5PoftJWYARrQ32Ea2ZCnxWf9GuTb0JrFBm0D
 zU434dJJjkX6wNZ5z1F5e4fA/E91D8OUm79GUy7e6BJoBNAEMsNzLNpApONEfvSGqdiv
 ChqzBF6kzcN0Q407qJ+KYxcCbyXkuwgVVt5WYkc9EaaMqiNHWyAqV5C6atzp8A+NPY3/
 ZCJCjPRc3UyI5iFA9p8dj/KNS9W8kSyfDSb0iRoqqUWsZ/Vx8QKbNQ/m5ShPFy56MQle
 X3u9T4CfLZlGAIlk3atp806f3I+cryHGHCjAJ5cvCNNcBGceRa5SycvARYpibEKRma4R xA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnc30r6fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 05:41:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I5f5X2024891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 05:41:05 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 22:41:00 -0700
Date:   Thu, 18 May 2023 11:10:55 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Message-ID: <20230518054054.GA998@varda-linux.qualcomm.com>
References: <cover.1684140883.git.quic_varada@quicinc.com>
 <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
 <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
 <20230516120426.GA1679@varda-linux.qualcomm.com>
 <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
 <20230517055726.GA3165@varda-linux.qualcomm.com>
 <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DLro9qGo7FQu15ozKjF18TO5HbrMWr6t
X-Proofpoint-ORIG-GUID: DLro9qGo7FQu15ozKjF18TO5HbrMWr6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=794 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180041
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 09:00:49AM +0200, Krzysztof Kozlowski wrote:
> On 17/05/2023 07:57, Varadarajan Narayanan wrote:
> > Part-1 is adding the 'const' entries at the beginning i.e.
> >
> > 	+      - const: qcom,tsens-v0_1
> > 	+      - const: qcom,tsens-v1
> > 	+      - const: qcom,tsens-v2
> > 	+      - const: qcom,ipq8074-tsens
> >
> > Part-2 is changing from one valid syntax to another i.e.
> >
> > 	+        items:
> > 	+          - enum:
> > 	+              - qcom,ipq9574-tsens
> > 	+          - const: qcom,ipq8074-tsens
> >
> > Without both of the above changes, either or both of dtbs_check
> > & dt_binding_check fails. So, it is not possible to just add the
> > "valid hunk" (part-2) alone.
>
> Of course it is. All schema files work like that...
> >
> > If having both part-1 and part-2 in the same patch is not
> > acceptable, shall I split them into two patches? Please let me know.
>
> No, hunk one is not justified.

For the other compatibles, the enum entries and const/fallback
entries are different. For the 9574 & 8074 case, we want to have
qcom,ipq8074-tsens as both enum and const/fallback entry. Hence,
if we don't have the first hunk, dtbs_check fails for 8074
related dtbs

	ipq8074-hk01.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
		['qcom,ipq8074-tsens'] is too short

	ipq8074-hk10-c2.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
		['qcom,ipq8074-tsens'] is too short

	ipq8074-hk10-c1.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
		['qcom,ipq8074-tsens'] is too short

I'm not sure of the correct solution. Having the first hunk
solves the above dtbs_check errors, so went with it. I'm able to
avoid dtbs_check errors with just one entry in the first hunk.

 	+      - const: qcom,ipq8074-tsens

Please let me know if there is a better way to resolve this or we
can have just the 8074 entry in the first hunk.

Thanks
Varada
