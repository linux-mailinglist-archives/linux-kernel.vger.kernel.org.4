Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA356B89E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCNEtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCNEtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:49:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758F94F4A;
        Mon, 13 Mar 2023 21:49:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3WW6a009513;
        Tue, 14 Mar 2023 04:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GXHNRae79Yv1jTgXEj+ykb0o3orfiIoOE9qjwwFlVHI=;
 b=iJeV1xgkj8LmXKSqi1JA57D7XHT15SMhCBPbTzD4gLiWkbLXaLH+fTePes+LmPl4OO+v
 z2YpIdZpsBnEknnpwK0J2tN6wt8CAdBgsx3Xv9n2L0HAePXI04/Iz7ANxlcroQ5cw6ZP
 G7KLKXWpbdML3ZJqv1CiIGpVKYFjtr6t+biHzndk9eMdwTPW0zVdFaT8emsnXSPrPQm6
 DbNLI82jXBAtauUrbL8f/LYrFg7XGeRyMmWbaWXtU+nGHnHS2EfOBuRPK3OEgBM+s1hy
 l/wKoXQ5M/Tgvxgnh569Iu14+xk4TN/0aYqsCwppMZGhZeshs3ia7hzd+cKzKFXc8snC vg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa203thbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 04:48:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E4mf7d003639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 04:48:41 GMT
Received: from [10.110.22.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 21:48:40 -0700
Message-ID: <1bd61fa7-cd0e-e198-9cee-7485eacbe685@quicinc.com>
Date:   Mon, 13 Mar 2023 21:48:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: add symbols to dtb
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Eric Chanudet <echanude@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230309233945.1199358-1-echanude@redhat.com>
 <43c11038-91d5-cbfd-7349-06fcd61a0661@linaro.org>
From:   Prasad Sodagudi <quic_psodagud@quicinc.com>
In-Reply-To: <43c11038-91d5-cbfd-7349-06fcd61a0661@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j_tz-nZj03YcvYZTdFlNdVkfPFyIYb7S
X-Proofpoint-GUID: j_tz-nZj03YcvYZTdFlNdVkfPFyIYb7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/2023 3:47 PM, Konrad Dybcio wrote:
> 
> 
> On 10.03.2023 00:39, Eric Chanudet wrote:
>> ABL uses the __symbols__ section to process the DTB before passing it
>> forward. Without it, the bootstrap is interrupted.
>>
>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
>> ---
> Fix your ABL.
Hi Konrad,

Apps boot-loader need __symbols__ for dynamic overlay operation. 
Qualcomm firmware passes an overlay file to apps boot-loader to overlay 
some of the nodes based on firmware configuration. Without __symbols__ 
apps boot-loader is not able to overlay.

Qualcomm hypervisor/gunyah would like to overlay arch timer node with 
always-on property, So adding __symbols__ helps boot-loader to overlay.

I think, commit text is misleading here and I will request Eric to fix 
the commit text.

-Thanks, Prasad

> 
> Konrad
>> Depends on initial sa8775p-ride.dts:
>> https://lore.kernel.org/all/20230214092713.211054-3-brgl@bgdev.pl/
>>
>>   arch/arm64/boot/dts/qcom/Makefile | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index b63cd1861e68..72e85ab31d74 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -1,4 +1,8 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +
>> +# Enable support for device-tree overlays required on sa8775p-ride.
>> +DTC_FLAGS_sa8775p-ride := -@
>> +
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> 
> 
