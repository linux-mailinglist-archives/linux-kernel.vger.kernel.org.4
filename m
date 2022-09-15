Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4EB5B923B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIOBj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOBjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:39:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1861F62E;
        Wed, 14 Sep 2022 18:39:53 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28ENWb5f012278;
        Thu, 15 Sep 2022 01:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D15uozjFHZ8B1sCtYYAsUF+T1E4cvGDPzzwfjWqc2g4=;
 b=jK/EtAlVdcSs1+V3XdDnkti7pRTzlpfMMRjWpbEzrIbEXYrUlT6FTdo6SVa3v+/Uu5gH
 j2GeNsCwEln/VH+0PUE0UedUbnw8TuJGA0XpMx7bsjQWTLNC7CEaHOocEeBLB7Iqea8F
 0Z1QDIM7qmKoWoCzkoT7elxQPFeHFZ6DBEXC56hGg3yQ1kOaKZgkvMDALuuCA4EAbd2q
 a8XQVFYPDC8KwPnTAqAHnhfNWb7+KiPMijvsdH6O/esD1iOak7FkfVUwUl0GMtMmjvmx
 zNEBsnTcbxazvN969ylowOPQpJAPgpmjsu67kISx9BuxRY5n4wGFm35Bi/x8mnHqF2lH BQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkp8arhne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 01:39:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28F1diZA028392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 01:39:44 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 18:39:41 -0700
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: Add dt binding for QTI CPUCP
 mailbox controller
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <agross@kernel.org>
References: <1663135386-26270-1-git-send-email-quic_sibis@quicinc.com>
 <1663135386-26270-2-git-send-email-quic_sibis@quicinc.com>
 <1663153683.714744.1742263.nullmailer@robh.at.kernel.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <51488e14-084e-d5ce-5439-c69bd9f18159@quicinc.com>
Date:   Thu, 15 Sep 2022 07:09:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1663153683.714744.1742263.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 36nAl5G7y6UOrL3pjG5D31IemSPzymZi
X-Proofpoint-ORIG-GUID: 36nAl5G7y6UOrL3pjG5D31IemSPzymZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_11,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=956
 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150007
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/22 4:38 PM, Rob Herring wrote:
> On Wed, 14 Sep 2022 11:33:05 +0530, Sibi Sankar wrote:
>> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
>> controller.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   .../bindings/mailbox/qcom,cpucp-mbox.yaml          | 51 ++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.example.dtb: mailbox@17400000: reg: [[0, 398458880], [0, 16], [0, 408486656], [0, 1792]] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> 
> doc reference errors (make refcheckdocs):

yup noticed that I hadn't included these fixes when I sent the patches
out. Will fix it in the next re-spin.

> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
