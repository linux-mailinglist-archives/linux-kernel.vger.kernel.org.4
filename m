Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCE6141D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJaXaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJaX3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:29:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE85BA5;
        Mon, 31 Oct 2022 16:29:20 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29VMxBUC018265;
        Mon, 31 Oct 2022 23:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i+BTeQs/uLoY4sXsMIzzuDbt+PCHvSTaZbj7cPW3MiA=;
 b=bgcNNpyUAjmmaqKcjvMWEr6ndM30a9a9Cw/WTs+H/j1cl5ABwrjUCAG5JIKWCcW/eB6g
 SH15mgvRaq41BvoUsOfPckqJ1P/a6ZE/owry5YsWQOiBnejzP4GriRdMgrdUraDY5f8U
 3Sx/aj26IMdhmF5APW6TcvB1ojklaG+cBHUFR+KDMXtVp9urDav3dVhW4r7qryldVAnU
 UbOzPfSJGiR9FQ45kDEh/k71tGl6QhV6vnPJaxJXst1CbohmlmDgafpdiX3VsX+A0Kgw
 FEg8aASLPPELmt+X1bPKsmnKreqkCFKhCz+uI99yqqM4Uu55gURQ0eppL9eCJDdk8rrK iQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kjjqb0mrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 23:29:17 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29VNTG1d028916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 23:29:16 GMT
Received: from [10.110.115.41] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 31 Oct
 2022 16:29:15 -0700
Message-ID: <64d0e5ef-fd36-6f25-2c39-00e8e1346af7@quicinc.com>
Date:   Mon, 31 Oct 2022 16:29:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/3] dt-bindings: interconnect: Remove required reg
 field
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221026190520.4004264-1-quic_molvera@quicinc.com>
 <20221026190520.4004264-2-quic_molvera@quicinc.com>
 <a214f513-fe28-2096-c2b0-2107e97f3ce2@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <a214f513-fe28-2096-c2b0-2107e97f3ce2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JW5bdcnBbfT8RrbgZDWEhlgz1HgcA-WI
X-Proofpoint-GUID: JW5bdcnBbfT8RrbgZDWEhlgz1HgcA-WI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=843 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 8:29 AM, Krzysztof Kozlowski wrote:
> On 26/10/2022 15:05, Melody Olvera wrote:
>> Many of the *-virt compatible devices do not have a reg field
>> so remove it as required from the bindings.
> and some virt have it... This should be probably separate binding or if
> the list is small - allOf:if:then.
I attempted this; however I'm still seeing failures in dtb_check. I've added this
to the binding; does this look correct?
 allOf:
   - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qdu1000-clk-virt
+              - qcom,qdu1000-mc-virt
+
+    then:
+      required:
+        - compatible

>
> Anyway you need to resend everything to Cc all maintainers, not some subset.
Discussed earlier.

Thanks,
Melody
