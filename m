Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F32973ADFA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjFWAwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFWAwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:52:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30501FC0;
        Thu, 22 Jun 2023 17:52:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N0R5R1026701;
        Fri, 23 Jun 2023 00:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nb0gkvwePDE1+BINC+VXWChN6537cCXhu4XADvMOeq8=;
 b=QDP/PYquSWe0PH24muDrIpUqnvNcfVepE0M+pEhJqZshxfW+3NkyiAnZ+FHarRRRj3Ds
 DPk6wLPXf/2x8ve5STI0Usd3PZ+mrpAwUBZLwukZ11OanGxSzB6eDUFaK0/274/jqVaN
 blCI55GyZuvMHqcCm+BBPAoqRndf1ts2tAqrqCH+XqfX9DswPiJxAVqido1bGW+hy7rB
 HcV3vcLsCP7+kcF3YjNYiOIDMMWy5uO6V1KTcYZonBg3mIXk5aMnxgWt6hy8A0ue7AIv
 KG1wGPygoamPulWMh9mqQQeaoolDNRLir+3r88Sk3BxNQOH5Q5DC5KIzdxdkA+04XS5g Dg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc359m38k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 00:51:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35N0pql8027064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 00:51:52 GMT
Received: from [10.110.109.161] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 22 Jun
 2023 17:51:52 -0700
Message-ID: <dea0a69e-7c5d-07ad-48da-71d19a7f75e0@quicinc.com>
Date:   Thu, 22 Jun 2023 17:51:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 21/28] ASoC: dt-bindings: Update example for enabling
 USB offload on SM8250
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-22-quic_wcheng@quicinc.com>
 <87f20b22-6305-7590-1dbf-014b5898b15c@linaro.org>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87f20b22-6305-7590-1dbf-014b5898b15c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mL6LnlnUdMfzV_lOLAVeCjfsLcopLIYy
X-Proofpoint-ORIG-GUID: mL6LnlnUdMfzV_lOLAVeCjfsLcopLIYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_18,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=780
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230005
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 3/10/2023 12:56 AM, Krzysztof Kozlowski wrote:
> On 09/03/2023 00:57, Wesley Cheng wrote:
>> Add an example on enabling of USB offload for the Q6DSP.  The routing can
>> be done by the mixer, which can pass the multimedia stream to the USB
>> backend.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> You still miss binding change to APR/GPR. Where is the USB DAI going to sit?
> 

My initial idea is to have it as part of the q6afe APR node (as a 
child).  It would need to issues some transactions over APR to the Q6AFE 
port on the audio DSP, which was the main reason for this.

Something like:

q6afe: apr-service@4 {
	compatible = "qcom,q6afe";
	reg = <APR_SVC_AFE>;
	q6afedai: dais {
		compatible = "qcom,q6afe-dais";
		#address-cells = <1>;
		#size-cells = <0>;
		#sound-dai-cells = <1>;
	};
...
	usbdai: usbd {
		compatible = "qcom,q6usb";
		#sound-dai-cells = <1>;
		iommus = <&apps_smmu 0x180f 0x0>;
		qcom,usb-audio-stream-id = <0xf>;
		qcom,usb-audio-intr-num = <2>;
	};
};

I think the only modification I would probably make is to have an 
example of how to add the q6usb node to enable the audio offloading.

Thanks,
Wesley Cheng

> 
> 
> Best regards,
> Krzysztof
> 
