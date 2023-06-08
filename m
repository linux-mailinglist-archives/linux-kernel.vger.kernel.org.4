Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E314727BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjFHJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjFHJnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:43:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0DC213C;
        Thu,  8 Jun 2023 02:43:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3588M1Jk018927;
        Thu, 8 Jun 2023 09:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a6YwNpylDSqXhyZmsoAsnK1Xy7ALXw9/OB1/zVN9jAc=;
 b=TuzLMgzZpdEly+HG5vbmGpr2+WE5zUquLZQbQZZ/aQAR4N7cvQJvTjwKwlhaKqm55F8S
 LAfQcBqgkkJnscFoMrM4tWAikgyalIB91n8nA9rmTNUWOGBVY/s51WWh/aN3Xhan21Cp
 Cdr23Jd/MWvN5jKgmCBXck9WIZz+4M1snE/pYJMtfD1GP/18mRsSiuV0e/uFnYjdrjG6
 6C2S7vc6GiDNC6IXdFqfNG1MGdgJIsxhAzehnosB96osFIyJt2aMJK9ggj3l1lrN8kOc
 ALl3Gvwe0gpoA9lPWZcbjHr5FaJiv1BG+5vtgms2XgsvpXEjviBRJHhndjgMS5jtGbju pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r33bvrwwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 09:43:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3589hBkN026305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 09:43:11 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 02:43:07 -0700
Message-ID: <f83d63ec-a29a-1e08-d645-342b8ee941c2@quicinc.com>
Date:   Thu, 8 Jun 2023 15:13:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH v1 1/2] dt-bindings: misc: fastrpc: add fastrpc
 group IDs property
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>,
        <fastrpc.upstream@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <ekangupt@qti.qualcomm.com>, <linux-arm-msm@vger.kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686155407-20054-2-git-send-email-quic_ekangupt@quicinc.com>
 <168615848839.3589502.17296725428809710882.robh@kernel.org>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <168615848839.3589502.17296725428809710882.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rkJrsIvTV_Kj4Hc7u4hGEwPay_gMIq1d
X-Proofpoint-ORIG-GUID: rkJrsIvTV_Kj4Hc7u4hGEwPay_gMIq1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 spamscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080082
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/2023 10:51 PM, Rob Herring wrote:
> 
> On Wed, 07 Jun 2023 22:00:06 +0530, Ekansh Gupta wrote:
>> Add "qcom,fastrpc-gids" property to the list of optional properties.
>> This property contains the list of privileged group IDs which is
>> used to offload process to remote subsystem with increased privileges.
>>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dts:36.17-18 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1512: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1686155407-20054-2-git-send-email-quic_ekangupt@quicinc.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
Thanks for helping with this information. I'll check and re-submit the 
patch.
