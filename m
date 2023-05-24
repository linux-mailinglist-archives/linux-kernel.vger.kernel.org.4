Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D705670FDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbjEXSQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjEXSQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:16:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14898;
        Wed, 24 May 2023 11:16:53 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OGs0oS027823;
        Wed, 24 May 2023 18:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VVcf3WP76UEbHeuge7bWC4FsIaQYADQLxZE6F4Bp/xk=;
 b=jJuy1tNSCieGU4p+mK4V9Q0xdJ1dQIiOSyKNB44ZjUPwc/sNeWpF43z5IbUCSGksO/ap
 yVTNnNlEbiaM4WLcNnLWYVgm2dVl5iNZnc4zNNsORxK2E0gjU6rF+sMQDjNRhL4aUyMb
 tpTI8cr4GfdcKBiIlHeQapIPTh36xohFX5Al+SJbmS9E8RuFiqsCKuYgSk+6Qi8oIS9l
 GTgpubtSVBTxoNDUs0m1bOrzXxZ5Bmq4VuvLsQCUQ+DtEyWgkq/IYHlVPke9zGgUzk39
 Oup45Tpi/TxT12NTgDTs/NfT2BJDQ73m0IiTWHtqVLC6MaRUH71G9Q8xzbkXjDr11XwU BQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsdhh1j8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 18:16:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OIGnN9025539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 18:16:49 GMT
Received: from [10.216.58.102] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 11:16:44 -0700
Message-ID: <61d352f4-d486-acf0-73a1-b9ed4e9bf669@quicinc.com>
Date:   Wed, 24 May 2023 23:46:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] clk: qcom: gpucc-sm8550: Add support for graphics
 clock controller
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        <quic_imrashai@quicinc.com>, <quic_ajipan@quicinc.com>
References: <20230519213656.26089-1-quic_jkona@quicinc.com>
 <20230519213656.26089-3-quic_jkona@quicinc.com>
 <31b311d7-7150-fe4c-1851-a9372878603c@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <31b311d7-7150-fe4c-1851-a9372878603c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JhtOqa4c3wRY6pXGE36d2vWI2daG-5r5
X-Proofpoint-ORIG-GUID: JhtOqa4c3wRY6pXGE36d2vWI2daG-5r5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_13,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 mlxlogscore=948 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240151
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for your review and sharing your changes!

On 5/20/2023 4:31 AM, Konrad Dybcio wrote:
> 
> 
> On 19.05.2023 23:36, Jagadeesh Kona wrote:
>> Add support for gpucc driver on SM8550, which provides clocks for the
>> graphics subsystem.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
> Looks like we did some duplicate work..
> 
> Please diff it against my take on the driver and check any discrepancies.
> 

> https://github.com/SoMainline/linux/commit/74320ee22f200fb21a8dbfc65aa55cf454825158
> 
The main difference I see is your driver also have clocks under gx 
domain (gpu_cc_gx_*_clk) modelled, but they are really not required 
since there are no clients in linux voting directly on these clocks.

> 
> I also reused 8450 GPUCC (which I sent recently and is likely to get in)
> bindings, you may wish to do something similar.
> 
> https://github.com/SoMainline/linux/commit/aabc4357c975f288add8b9dfa7601c5aa36f2798
> 
Yes, will take care of this in the next series.

> Konrad
>>   drivers/clk/qcom/Kconfig        |   8 +
>>   drivers/clk/qcom/Makefile       |   1 +
>>   drivers/clk/qcom/gpucc-sm8550.c | 609 ++++++++++++++++++++++++++++++++
>>   3 files changed, 618 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gpucc-sm8550.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 6bb9b4aff047..b730dd9ed6b1 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -900,6 +900,14 @@ config SM_GPUCC_8350
>>   	  Say Y if you want to support graphics controller devices and
>>   	  functionality such as 3D graphics.
>>   
[skipped]

Thanks & Regards,
Jagadeesh
