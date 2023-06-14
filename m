Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB567301E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjFNO2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjFNO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:28:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C21BEC;
        Wed, 14 Jun 2023 07:28:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ECuAqQ016379;
        Wed, 14 Jun 2023 14:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7egZ/xDr+6s6Ab/jtW/skQRX649b2mJpNoO9csEkpJw=;
 b=ieuJrTa2RNmfEmeirBU0urOTi9fJ+y21IhMGvoBPgoeW/lG6V1pHpLpWrg/NDjD2kpxR
 EvBDYru7bA4QiHbC/KW9ZC8iDOe01X3uSjuqRiLipgKzyA2TjgunWIE9F+KUJyAqd2Ut
 MR6S4DSbWFioXd1K75qfdgDrsJJehizgguW17veGQF0NxR3d0vegcrApV+trJ3BAACKC
 xkK2ZUo0cqbP6U3Hed8/dV46Vjd19gNJXRa0Gq1JCkvTULrFLKPvsFpK6P1F3oj70E6C
 /LIh+Mv6KNR7m+/8+27s7fYJdvWUurJ9yP8GFVsNZ/oWQiV9gbsN8u/nnph8rxd1S5JP Eg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7auy0rn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:27:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EERr4d009262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:27:53 GMT
Received: from [10.216.59.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 07:27:47 -0700
Message-ID: <b39ce1c6-d134-c1b8-4764-fd824c2a2470@quicinc.com>
Date:   Wed, 14 Jun 2023 19:57:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com>
 <1686311249-6857-2-git-send-email-quic_krichai@quicinc.com>
 <168631638078.662811.2470035951687478762.robh@kernel.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <168631638078.662811.2470035951687478762.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C9N1FKMECrTIFhkYK7rT5sWzZRyR2LRp
X-Proofpoint-GUID: C9N1FKMECrTIFhkYK7rT5sWzZRyR2LRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=945
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140125
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/2023 6:43 PM, Rob Herring wrote:
> On Fri, 09 Jun 2023 17:17:26 +0530, Krishna chaitanya chundru wrote:
>> Some platforms may not boot if a device driver doesn't initialize
>> the interconnect path. Mostly it is handled by the bootloader but
>> we have starting to see cases where bootloader simply ignores them.
>>
>> Add the "pcie-mem" interconnect path as a required property to the
>> bindings.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:206:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
>
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dts'
> Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:206:1: found a tab character where an indentation space is expected
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:206:1: found a tab character where an indentation space is expected
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml: ignoring, error parsing file
> make: *** [Makefile:1512: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1686311249-6857-2-git-send-email-quic_krichai@quicinc.com
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
Sorry for sending patch without checking for errors, I fixed the errors 
in the new patch.
