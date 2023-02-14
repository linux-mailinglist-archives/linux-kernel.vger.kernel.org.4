Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A4B69638F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjBNMfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjBNMee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:34:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686C0B754;
        Tue, 14 Feb 2023 04:34:33 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E4b9gm017277;
        Tue, 14 Feb 2023 12:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xy5IIT6giUXnOkp3eRt/jKuYY3S9QEps7lthlfLekRU=;
 b=VF8+MKDM7ljQbEg3J7BU0B4DTBzTDKsEY4iYAOr6AKX3OclwZrvtsbw5E0BD70M91yZ0
 fqQx+ff02Cu8R1FhSp322Rg+y8mVFk/0ZtBYnTPqYxXj6q9350pm5vWFAFEB/Prp9Cak
 NT4DNQPufm+Hcx4/VCnAryYHHfno3EekycY/RfHxvHZXYLHrQOrDZqcaXd8Cuj/QE4NR
 mmZaWV59CIc3Lqo2iy+7OrRgbzvVHFCAZ4gRwfRkK2pPOILVB4Gmj+tNLIf58i2yDLNm
 QBh0QjEENQPGOyXos8H0WDjOqOSQbiy/4dKYpVpB/pCHC91diJ0RA2lbAY6KMmTz7IN3 1Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr26u16m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 12:34:30 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ECYTSL006216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 12:34:29 GMT
Received: from [10.216.50.155] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 04:34:26 -0800
Message-ID: <aac2b313-e4af-dc93-f177-0d0be9620e1b@quicinc.com>
Date:   Tue, 14 Feb 2023 18:04:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8450: Add IMEM and PIL info
 region
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Alex Elder <elder@linaro.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1675443891-31709-1-git-send-email-quic_mojha@quicinc.com>
 <1675443891-31709-2-git-send-email-quic_mojha@quicinc.com>
 <cc30f686-dec7-db85-cf0d-c6c685a623ce@linaro.org>
 <d1dc0c9b-eab2-0287-d0a2-ead44ecee5ce@quicinc.com>
 <20230206210455.xgrvtvknkor4nllx@ripper>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230206210455.xgrvtvknkor4nllx@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A6PB5OAt51BMwmeNyryUBrnINZt1Sa7q
X-Proofpoint-ORIG-GUID: A6PB5OAt51BMwmeNyryUBrnINZt1Sa7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_07,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=958 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140109
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+@alex,

Please comment.

-Mukesh

On 2/7/2023 2:34 AM, Bjorn Andersson wrote:
> On Mon, Feb 06, 2023 at 08:06:13PM +0530, Mukesh Ojha wrote:
>>
>>
>> On 2/4/2023 3:07 AM, Konrad Dybcio wrote:
>>>
>>>
>>> On 3.02.2023 18:04, Mukesh Ojha wrote:
>>>> Add a simple-mfd representing IMEM on SM8450 and define the PIL
>>>> relocation info region, so that post mortem tools will be able
>>>> to locate the loaded remoteprocs.
>>>>
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>> ---
>>>   From XBL:
>>>
>>> 0x14680000, 0x0002A000, "IMEM Base"
>>>
>>> Is there anything in that wider address range that would interest
>>> us? I recall Alex once dug into that when diving into IPA, but
>>> I can not recall the conclusion..
>> Spec-wise, yes IPA do own these 0x146A8000 - 0x146AA000 .
>> But, not sure what they use it for.
>>
> 
> The DT should not reflect the organization structure. Let's see if Alex
> have any input on this.
> 
> Thanks,
> Bjorn
> 
>> -Mukesh
>>>
>>> Konrad
>>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> index 5704750..474ea1b 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> @@ -3536,6 +3536,21 @@
>>>>    			};
>>>>    		};
>>>> +		sram@146aa000 {
>>>> +			compatible = "qcom,sm8450-imem", "syscon", "simple-mfd";
>>>> +			reg = <0 0x146aa000 0 0x1000>;
>>>> +
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <1>;
>>>> +
>>>> +			ranges = <0 0 0x146aa000 0x1000>;
>>>> +
>>>> +			pil-reloc@94c {
>>>> +				compatible = "qcom,pil-reloc-info";
>>>> +				reg = <0x94c 0xc8>;
>>>> +			};
>>>> +		};
>>>> +
>>>>    		apps_rsc: rsc@17a00000 {
>>>>    			label = "apps_rsc";
>>>>    			compatible = "qcom,rpmh-rsc";
