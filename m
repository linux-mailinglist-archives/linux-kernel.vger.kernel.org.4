Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79DB70EE63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbjEXGqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbjEXGpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:45:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A371730;
        Tue, 23 May 2023 23:44:30 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5kDXg016227;
        Wed, 24 May 2023 06:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=fhmeCxwy3IFIJvSPhqeyEtb835qgpGjZ9gCVIyptO5o=;
 b=D4sCPtXjX20nMxHDUh5rfpSOZeSmqtxXE75pEFaUYQP/pX9TFIvzTdIaNtJNnG76+Gd0
 8LGJY0jPt9ks3+KNi17/8pg4zTxy2QJMU46uFEhElY3AaeiSVrZtFIbrMckMM4/LXFon
 5FbuLHfCCd1OLsA0s0d9b7qmCJDMPzA38Ly/SQwWoRvywbTdXx6bwnvHgxN65n40Jwit
 hQXPuueg5ijLrMHVFey+/OGwaCQa1hBTOpoi0ztFbIGmdIS78tH9OkoRCZhYBQwLvLVt
 I63eOYLBHTY2w+ii/V+I85hTY8BGbRDWRjZWqOWrwefdi8jkybedUa1qZ6rH3fRbKlr0 Tw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qscaur5fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 06:43:18 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O6hHVC003137
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 06:43:17 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 23 May 2023 23:43:12 -0700
Date:   Wed, 24 May 2023 12:13:08 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
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
Message-ID: <20230524064307.GA5052@varda-linux.qualcomm.com>
References: <20230516120426.GA1679@varda-linux.qualcomm.com>
 <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
 <20230517055726.GA3165@varda-linux.qualcomm.com>
 <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
 <20230518054054.GA998@varda-linux.qualcomm.com>
 <fe1d81d2-52e6-7d2d-8d6c-ffdcbb8ccc89@linaro.org>
 <20230518090503.GA9173@varda-linux.qualcomm.com>
 <24b60ca3-b6b9-662f-03c8-df1536b52bc9@linaro.org>
 <20230523101903.GA31656@varda-linux.qualcomm.com>
 <20230523-clergyman-reputably-21f69cd98797@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230523-clergyman-reputably-21f69cd98797@spud>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -eOri0q7mhdamoslfl8BjtjCUJofnH-w
X-Proofpoint-GUID: -eOri0q7mhdamoslfl8BjtjCUJofnH-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 05:44:02PM +0100, Conor Dooley wrote:
> On Tue, May 23, 2023 at 03:49:04PM +0530, Varadarajan Narayanan wrote:
> > On Thu, May 18, 2023 at 01:06:49PM +0200, Krzysztof Kozlowski wrote:
> > > On 18/05/2023 11:05, Varadarajan Narayanan wrote:
> > > > On Thu, May 18, 2023 at 09:09:12AM +0200, Krzysztof Kozlowski wrote:
> > > >> On 18/05/2023 07:40, Varadarajan Narayanan wrote:
> > > >>> On Wed, May 17, 2023 at 09:00:49AM +0200, Krzysztof Kozlowski wrote:
> > > >>>> On 17/05/2023 07:57, Varadarajan Narayanan wrote:
> 
> > > It's not true. The error you see is result because you removed something
> > > you should not. I did not ask you to remove anything. So repeating -
> > > "add new item". Adding is not "removal and adding". Adding is just "adding".
> > 
> > See below for the changes that were tried and the corresponding errors.
> > 
> > (1) No lines removed
> > 
> > 	@@ -66,6 +66,7 @@
> > 	       - description: v2 of TSENS with combined interrupt
> > 		 enum:
> > 		   - qcom,ipq8074-tsens
> > 	+          - qcom,ipq9574-tsens
> > 
> > 	   reg:
> > 	     items:
> > 
> > 	dt_binding_check: No errors
> > 
> > 	dtbs_check	:
> > 		arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: thermal-sensor@4a9000: compatible: 'oneOf' conditional failed, one must be fixed:
> > 	        ['qcom,ipq9574-tsens', 'qcom,ipq8074-tsens'] is too long
> 
> Which I figure you understand makes sense.
> 
> > (2) No lines removed
> > 
> > 	@@ -66,6 +66,8 @@
> > 	       - description: v2 of TSENS with combined interrupt
> > 		 enum:
> > 		   - qcom,ipq8074-tsens
> > 	+          - qcom,ipq9574-tsens
> > 	+        - const: qcom,ipq8074-tsens
> > 
> > 	   reg:
> > 	     items:
> > 
> > 	dt_binding_check: No errors
> > 
> > 	dtbs_check	: Gives errors for all the DTS files that have tsens-v0_1, tsens-v2, tsens-v1. Copy pasted a sample for each one of them
> > 		arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb: /soc@0/thermal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8916-tsens', 'qcom,tsens-v0_1']
> > 		arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb: /soc@0/thermal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8953-tsens', 'qcom,tsens-v2']
> > 		arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb: /soc@0/thermal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8956-tsens', 'qcom,tsens-v1']
> 
> I think you've missed an earlier error that points out the entire
> binding is invalid.
> 
> > (3) No lines removed
> > 	@@ -19,6 +19,7 @@
> > 	 properties:
> > 	   compatible:
> > 	     oneOf:
> > 	+      - const: qcom,ipq8074-tsens
> > 	       - description: msm8960 TSENS based
> > 		 items:
> > 		   - enum:
> > 	@@ -66,6 +67,8 @@
> > 	       - description: v2 of TSENS with combined interrupt
> > 		 enum:
> > 		   - qcom,ipq8074-tsens
> > 	+          - qcom,ipq9574-tsens
> > 	+        - const: qcom,ipq8074-tsens
> > 
> > 	   reg:
> > 	     items:
> > 
> > 	dt_binding_check: Same as above
> > 
> > 	dtbs_check	: Same as above
> 
> Ditto here.
> 
> > (4) Change 8074 from enum to const
> > 	@@ -19,6 +19,7 @@
> > 	 properties:
> > 	   compatible:
> > 	     oneOf:
> > 	+      - const: qcom,ipq8074-tsens
> > 	       - description: msm8960 TSENS based
> > 		 items:
> > 		   - enum:
> > 	@@ -64,8 +65,10 @@
> > 		   - const: qcom,tsens-v2
> > 
> > 	       - description: v2 of TSENS with combined interrupt
> > 	-        enum:
> > 	-          - qcom,ipq8074-tsens
> > 	+        items:
> > 	+          - enum:
> > 	+              - qcom,ipq9574-tsens
> > 	+          - const: qcom,ipq8074-tsens
> > 
> > 	   reg:
> > 	     items:
> > 
> > 	dt_binding_check: No errors
> > 
> > 	dtbs_check	: No errors
> > 
> > But (4) doesn't seem acceptable. Any other alternative to resolve this?
> 
> It now has a "random" entry up at the top w/ no description, not
> matching the existing style. Can you just fix that up & send a v(N+1)
> so that the discussion can restart in a less confusing way? I am trying
> to fill in for Krzysztof but I am struggling to follow the thread.

Sure. Will post the next version.

Thanks
Varada
