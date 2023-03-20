Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259C76C2599
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjCTX20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCTX2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:28:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E863587;
        Mon, 20 Mar 2023 16:28:21 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KITHIa022196;
        Mon, 20 Mar 2023 23:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a/IDKoJVzHM1US9p3+YmQx5LUxlZjCPiY9+PMVoxE/M=;
 b=dSg07JhZfBgdp7myyhYtnFQqK1pE/YQsoJSAyvS89gATjFD9EzXGyLpFxLaYpjys7GmA
 2qpPeKSPdVxaiVjGGqlxSGd35QUbyeEGGFUg3XDDZKb7HwjtWPOygdgRW+uvCfmkI0V2
 R5ZLnaOh5Wkz1DKJq2BdmdP25q+8baA6eKeb3leC1ffN1FUNYZDf6zFqAy+GNHpW+qNE
 mzYzFGsXzMvWsUYm5w2jB9VrWyyFiKCX/bpJCeIs7VuH1zyrLeBqW/aiRprKzhNwtRAB
 cu8Ao+4w+FD1FI5avqRk9OJOt2EEkiiR02EmoSFdjbnOidOCZ0u+KqsGXbWX8aZd/oQ3 kg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pernkhayu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:28:17 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KNSGZx000714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:28:16 GMT
Received: from [10.110.115.97] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Mar
 2023 16:28:15 -0700
Message-ID: <80851901-b5d6-3336-2d38-1b84a2185df1@quicinc.com>
Date:   Mon, 20 Mar 2023 16:28:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: qdu1000: Add IPCC, MPSS, AOSS
 nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230306231719.22263-1-quic_molvera@quicinc.com>
 <20230306231719.22263-2-quic_molvera@quicinc.com>
 <af21f499-5895-c564-3e6f-d23ba188544b@linaro.org>
 <3ee969ec-faae-fd9f-d583-6a8e2670b567@quicinc.com>
 <4d7d3d5a-4a3c-44ab-6f32-ddee2cb621fc@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <4d7d3d5a-4a3c-44ab-6f32-ddee2cb621fc@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QC6B2Leo2XY4HwPEPuULlGB4PNbCDY0I
X-Proofpoint-GUID: QC6B2Leo2XY4HwPEPuULlGB4PNbCDY0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=712 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200197
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/2023 3:55 AM, Konrad Dybcio wrote:
>
> On 13.03.2023 22:25, Melody Olvera wrote:
>>
>> On 3/8/2023 2:23 AM, Konrad Dybcio wrote:
>>> On 7.03.2023 00:17, Melody Olvera wrote:
>>>> Add nodes for IPCC, MPSS, and AOSS drivers. Also update
>>>> the scm node to include its interconnect.
>>> Quite a bit of stuff in a single commit, this could be
>>> separated into:
>>>
>>> - scm icc
>>> - aoss+ipcc
>>> - smp2p+mpss
>> Hmm ok. Will split this patch into a few patches.
>>
>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>> ---
> [...]
>
>>>> +			      <0x0 0x4180000 0x0 0x1000>;
>>> No reg-names?
>> No; we don't use reg-names in the driver. Lmk if we should be.
>>
> qcom_q6v5_mss.c / qcom_q6v5_wcss.c get the 'rmb' region with
> [...]_byname and I think it'd scale better if we did the same here,
> as one day there may be a weird SoC that'd have an "XYZ" region,
> different to "base" and "rmb", which we would need to handle.. somehow..

Yeah that's sensible. Will update the driver and this entry.

Thanks,
Melody
>
> Konrad

