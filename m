Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657A86F64A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjEDGGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDGGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:06:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E71D1988;
        Wed,  3 May 2023 23:06:28 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3444x7KD007112;
        Thu, 4 May 2023 06:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GK3/m6ZtfBXZkCTuGy0VMp8ytO9gKhdQZ/jDNeIz4Hk=;
 b=QJmRotiyisYlhXJTkCWVFRMAWpS4w8KS0taYIbwH8GD3fxcMBGUMlyJyZoG9d23pIHR3
 BpMVDhxYZfhQkK8D2EpEm+kmRje53MgREMX3YQI901QfK405hIA/fWSE5oCR1tPWTTCX
 rOm7Wa/XiK7BPF2dWrrLqKafb/RLn+/hiyX7n1SK77RMYXif0d6hYseGjURQNKhhPC8s
 WQHrFhyk1G6wY2DbeDX8QQ272rs+0ZZUeib0kttDiqi9L+NKC1hfOrOqzvJdRImAgA4E
 2+T7m55/REbIoT0pqy/zkgGYOVSReOGccCwqwJps51LPVz37jVCJjYg6JsK3mfbtxKNF 4A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc1eurjxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 06:06:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34466McO016919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 06:06:22 GMT
Received: from [10.242.242.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 23:06:14 -0700
Message-ID: <8a54dd8d-3daf-1e1b-0372-31f98d9998bc@quicinc.com>
Date:   Thu, 4 May 2023 11:36:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 05/11] dt-bindings: clock: qcom: gcc-ipq9574: Add Q6 gcc
 clock control
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-6-git-send-email-quic_mmanikan@quicinc.com>
 <f53b833f-bc1b-0323-c711-a009e9829910@quicinc.com>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <f53b833f-bc1b-0323-c711-a009e9829910@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yCGJdWWCliEWqJpAyLg0aEQVuSYwNCja
X-Proofpoint-GUID: yCGJdWWCliEWqJpAyLg0aEQVuSYwNCja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_02,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305040049
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 12:12 PM, Sricharan Ramabadhran wrote:
> 
> 
> On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
>> Add support for the QDSP6 gcc clock control used on IPQ9574
>> based devices. This would allow mpd remoteproc driver to control
>> the required gcc clocks to bring the subsystem out of reset.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h | 159 ++++++++++---------
>>   1 file changed, 83 insertions(+), 76 deletions(-)
>>
>> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h 
>> b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> index c89e96d568c6..8bd6350ecd56 100644
>> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> @@ -138,80 +138,87 @@
>>   #define WCSS_AHB_CLK_SRC                129
>>   #define GCC_Q6_AHB_CLK                    130
>>   #define GCC_Q6_AHB_S_CLK                131
>> -#define GCC_WCSS_ECAHB_CLK                132
>> -#define GCC_WCSS_ACMT_CLK                133
>> -#define GCC_SYS_NOC_WCSS_AHB_CLK            134
>> -#define WCSS_AXI_M_CLK_SRC                135
>> -#define GCC_ANOC_WCSS_AXI_M_CLK                136
>> -#define QDSS_AT_CLK_SRC                    137
>> -#define GCC_Q6SS_ATBM_CLK                138
>> -#define GCC_WCSS_DBG_IFC_ATB_CLK            139
>> -#define GCC_NSSNOC_ATB_CLK                140
>> -#define GCC_QDSS_AT_CLK                    141
>> -#define GCC_SYS_NOC_AT_CLK                142
>> -#define GCC_PCNOC_AT_CLK                143
>> -#define GCC_USB0_EUD_AT_CLK                144
>> -#define GCC_QDSS_EUD_AT_CLK                145
>> -#define QDSS_STM_CLK_SRC                146
>> -#define GCC_QDSS_STM_CLK                147
>> -#define GCC_SYS_NOC_QDSS_STM_AXI_CLK            148
>> -#define QDSS_TRACECLKIN_CLK_SRC                149
>> -#define GCC_QDSS_TRACECLKIN_CLK                150
>> -#define QDSS_TSCTR_CLK_SRC                151
>> -#define GCC_Q6_TSCTR_1TO2_CLK                152
>> -#define GCC_WCSS_DBG_IFC_NTS_CLK            153
>> -#define GCC_QDSS_TSCTR_DIV2_CLK                154
>> -#define GCC_QDSS_TS_CLK                    155
>> -#define GCC_QDSS_TSCTR_DIV4_CLK                156
>> -#define GCC_NSS_TS_CLK                    157
>> -#define GCC_QDSS_TSCTR_DIV8_CLK                158
>> -#define GCC_QDSS_TSCTR_DIV16_CLK            159
>> -#define GCC_Q6SS_PCLKDBG_CLK                160
>> -#define GCC_Q6SS_TRIG_CLK                161
>> -#define GCC_WCSS_DBG_IFC_APB_CLK            162
>> -#define GCC_WCSS_DBG_IFC_DAPBUS_CLK            163
>> -#define GCC_QDSS_DAP_CLK                164
>> -#define GCC_QDSS_APB2JTAG_CLK                165
>> -#define GCC_QDSS_TSCTR_DIV3_CLK                166
>> -#define QPIC_IO_MACRO_CLK_SRC                167
>> -#define GCC_QPIC_IO_MACRO_CLK                           168
>> -#define Q6_AXI_CLK_SRC                    169
>> -#define GCC_Q6_AXIM_CLK                    170
>> -#define GCC_WCSS_Q6_TBU_CLK                171
>> -#define GCC_MEM_NOC_Q6_AXI_CLK                172
>> -#define Q6_AXIM2_CLK_SRC                173
>> -#define NSSNOC_MEMNOC_BFDCD_CLK_SRC            174
>> -#define GCC_NSSNOC_MEMNOC_CLK                175
>> -#define GCC_NSSNOC_MEM_NOC_1_CLK            176
>> -#define GCC_NSS_TBU_CLK                    177
>> -#define GCC_MEM_NOC_NSSNOC_CLK                178
>> -#define LPASS_AXIM_CLK_SRC                179
>> -#define LPASS_SWAY_CLK_SRC                180
>> -#define ADSS_PWM_CLK_SRC                181
>> -#define GCC_ADSS_PWM_CLK                182
>> -#define GP1_CLK_SRC                    183
>> -#define GP2_CLK_SRC                    184
>> -#define GP3_CLK_SRC                    185
>> -#define DDRSS_SMS_SLOW_CLK_SRC                186
>> -#define GCC_XO_CLK_SRC                    187
>> -#define GCC_XO_CLK                    188
>> -#define GCC_NSSNOC_QOSGEN_REF_CLK            189
>> -#define GCC_NSSNOC_TIMEOUT_REF_CLK            190
>> -#define GCC_XO_DIV4_CLK                    191
>> -#define GCC_UNIPHY0_SYS_CLK                192
>> -#define GCC_UNIPHY1_SYS_CLK                193
>> -#define GCC_UNIPHY2_SYS_CLK                194
>> -#define GCC_CMN_12GPLL_SYS_CLK                195
>> -#define GCC_NSSNOC_XO_DCD_CLK                196
>> -#define GCC_Q6SS_BOOT_CLK                197
>> -#define UNIPHY_SYS_CLK_SRC                198
>> -#define NSS_TS_CLK_SRC                    199
>> -#define GCC_ANOC_PCIE0_1LANE_M_CLK            200
>> -#define GCC_ANOC_PCIE1_1LANE_M_CLK            201
>> -#define GCC_ANOC_PCIE2_2LANE_M_CLK            202
>> -#define GCC_ANOC_PCIE3_2LANE_M_CLK            203
>> -#define GCC_SNOC_PCIE0_1LANE_S_CLK            204
>> -#define GCC_SNOC_PCIE1_1LANE_S_CLK            205
>> -#define GCC_SNOC_PCIE2_2LANE_S_CLK            206
>> -#define GCC_SNOC_PCIE3_2LANE_S_CLK            207
>> +#define GCC_WCSS_AHB_S_CLK                132
>> +#define GCC_WCSS_ECAHB_CLK                133
>> +#define GCC_WCSS_ACMT_CLK                134
>> +#define GCC_SYS_NOC_WCSS_AHB_CLK            135
>> +#define WCSS_AXI_M_CLK_SRC                136
>> +#define GCC_WCSS_AXI_M_CLK                137
>> +#define GCC_ANOC_WCSS_AXI_M_CLK                138
>> +#define QDSS_AT_CLK_SRC                    139
>> +#define GCC_Q6SS_ATBM_CLK                140
>> +#define GCC_WCSS_DBG_IFC_ATB_CLK            141
>> +#define GCC_WCSS_DBG_IFC_ATB_BDG_CLK            142
>> +#define GCC_NSSNOC_ATB_CLK                143
>> +#define GCC_QDSS_AT_CLK                    144
>> +#define GCC_SYS_NOC_AT_CLK                145
>> +#define GCC_PCNOC_AT_CLK                146
>> +#define GCC_USB0_EUD_AT_CLK                147
>> +#define GCC_QDSS_EUD_AT_CLK                148
>> +#define QDSS_STM_CLK_SRC                149
>> +#define GCC_QDSS_STM_CLK                150
>> +#define GCC_SYS_NOC_QDSS_STM_AXI_CLK            151
>> +#define QDSS_TRACECLKIN_CLK_SRC                152
>> +#define GCC_QDSS_TRACECLKIN_CLK                153
>> +#define QDSS_TSCTR_CLK_SRC                154
>> +#define GCC_Q6_TSCTR_1TO2_CLK                155
>> +#define GCC_WCSS_DBG_IFC_NTS_CLK            156
>> +#define GCC_WCSS_DBG_IFC_NTS_BDG_CLK            157
>> +#define GCC_QDSS_TSCTR_DIV2_CLK                158
>> +#define GCC_QDSS_TS_CLK                    159
>> +#define GCC_QDSS_TSCTR_DIV4_CLK                160
>> +#define GCC_NSS_TS_CLK                    161
>> +#define GCC_QDSS_TSCTR_DIV8_CLK                162
>> +#define GCC_QDSS_TSCTR_DIV16_CLK            163
>> +#define GCC_Q6SS_PCLKDBG_CLK                164
>> +#define GCC_Q6SS_TRIG_CLK                165
>> +#define GCC_WCSS_DBG_IFC_APB_CLK            166
>> +#define GCC_WCSS_DBG_IFC_APB_BDG_CLK            167
>> +#define GCC_WCSS_DBG_IFC_DAPBUS_CLK            168
>> +#define GCC_WCSS_DBG_IFC_DAPBUS_BDG_CLK            169
>> +#define GCC_QDSS_DAP_CLK                170
>> +#define GCC_QDSS_APB2JTAG_CLK                171
>> +#define GCC_QDSS_TSCTR_DIV3_CLK                172
>> +#define QPIC_IO_MACRO_CLK_SRC                173
>> +#define GCC_QPIC_IO_MACRO_CLK                           174
>> +#define Q6_AXI_CLK_SRC                    175
>> +#define GCC_Q6_AXIM_CLK                    176
>> +#define GCC_Q6_AXIM2_CLK                177
>> +#define GCC_WCSS_Q6_TBU_CLK                178
>> +#define GCC_MEM_NOC_Q6_AXI_CLK                179
>> +#define Q6_AXIM2_CLK_SRC                180
>> +#define NSSNOC_MEMNOC_BFDCD_CLK_SRC            181
>> +#define GCC_NSSNOC_MEMNOC_CLK                182
>> +#define GCC_NSSNOC_MEM_NOC_1_CLK            183
>> +#define GCC_NSS_TBU_CLK                    184
>> +#define GCC_MEM_NOC_NSSNOC_CLK                185
>> +#define LPASS_AXIM_CLK_SRC                186
>> +#define LPASS_SWAY_CLK_SRC                187
>> +#define ADSS_PWM_CLK_SRC                188
>> +#define GCC_ADSS_PWM_CLK                189
>> +#define GP1_CLK_SRC                    190
>> +#define GP2_CLK_SRC                    191
>> +#define GP3_CLK_SRC                    192
>> +#define DDRSS_SMS_SLOW_CLK_SRC                193
>> +#define GCC_XO_CLK_SRC                    194
>> +#define GCC_XO_CLK                    195
>> +#define GCC_NSSNOC_QOSGEN_REF_CLK            196
>> +#define GCC_NSSNOC_TIMEOUT_REF_CLK            197
>> +#define GCC_XO_DIV4_CLK                    198
>> +#define GCC_UNIPHY0_SYS_CLK                199
>> +#define GCC_UNIPHY1_SYS_CLK                200
>> +#define GCC_UNIPHY2_SYS_CLK                201
>> +#define GCC_CMN_12GPLL_SYS_CLK                202
>> +#define GCC_NSSNOC_XO_DCD_CLK                203
>> +#define GCC_Q6SS_BOOT_CLK                204
>> +#define UNIPHY_SYS_CLK_SRC                205
>> +#define NSS_TS_CLK_SRC                    206
>> +#define GCC_ANOC_PCIE0_1LANE_M_CLK            207
>> +#define GCC_ANOC_PCIE1_1LANE_M_CLK            208
>> +#define GCC_ANOC_PCIE2_2LANE_M_CLK            209
>> +#define GCC_ANOC_PCIE3_2LANE_M_CLK            210
>> +#define GCC_SNOC_PCIE0_1LANE_S_CLK            211
>> +#define GCC_SNOC_PCIE1_1LANE_S_CLK            212
>> +#define GCC_SNOC_PCIE2_2LANE_S_CLK            213
>> +#define GCC_SNOC_PCIE3_2LANE_S_CLK            214
> 
> These should be added in the end as new entries.
> 
> Regards,
>   Sricharan

Sure. I will add at the end.

Thanks & Regards,
Manikanta.
