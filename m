Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67C6DF9FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDLP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDLP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:28:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE895FD6;
        Wed, 12 Apr 2023 08:28:37 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CFJUm6011595;
        Wed, 12 Apr 2023 15:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OJIIdCX3KL0XAV8LHGVl0PFik84TwiYTbMK58j6MWFE=;
 b=MFUsseLZg3SHqWs8pxX7a1JOs3TXq/6NwBROBZ/UlyWG71l77aUQob2FRJ6JzPubQcz7
 aEttrXiDtRzFz7IhnvZzrP7QWd84/BQj04n7VfmavXFFogU68WvS6z3N6h0XCmoHEHtT
 JNfSy86CzeaP7NmOb3/1VPlmmq0BvzHMCLJ2QA1KsOs3Q7jhI0A2gPuPESZXp+X0bwTS
 wuA4Y6u0vzOIGIhqLF0pZDEcdusAiMXu18pspvI5QvzfRMxNZ/WmsvS+4agJG78fHTfr
 ltaNns6HBl5LDm+YxMdDXnTb6crDJ+kqhQ1ultDmw+iLClQ8Vg+XyAtSpkTQyjBSJqjU ww== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwy6fr0jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:28:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CFSWqb021671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:28:32 GMT
Received: from [10.216.35.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 08:28:26 -0700
Message-ID: <e69c570d-71e3-2e52-698a-52ea44ec47f7@quicinc.com>
Date:   Wed, 12 Apr 2023 20:58:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7280: Add stream-id of qspi to
 iommus
Content-Language: en-CA
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <broonie@kernel.org>,
        <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <dianders@chromium.org>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
 <1680631400-28865-2-git-send-email-quic_vnivarth@quicinc.com>
 <86449ddc-1eeb-5af0-dfaf-0b80e7d8d992@linaro.org>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <86449ddc-1eeb-5af0-dfaf-0b80e7d8d992@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lrLS8XbgVMWK19sbqPSqIyIirLOx_W_z
X-Proofpoint-GUID: lrLS8XbgVMWK19sbqPSqIyIirLOx_W_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120134
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for the review...


On 4/4/2023 11:49 PM, Krzysztof Kozlowski wrote:
> On 04/04/2023 20:03, Vijaya Krishna Nivarthi wrote:
>> This is done as part of adding DMA support to qspi driver.
>>
>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 5e6f9f4..9e05285 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -3434,6 +3434,7 @@
>>   		qspi: spi@88dc000 {
>>   			compatible = "qcom,sc7280-qspi", "qcom,qspi-v1";
>>   			reg = <0 0x088dc000 0 0x1000>;
>> +			iommus = <&apps_smmu 0x20 0x0>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).


Added changes to yaml file, ran the check and ensured it builds fine.


> Best regards,
> Krzysztof
>
