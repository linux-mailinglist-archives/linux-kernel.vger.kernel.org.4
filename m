Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F2E693DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 06:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBMFI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 00:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBMFI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 00:08:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE11D523;
        Sun, 12 Feb 2023 21:08:25 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D4d3Ks012411;
        Mon, 13 Feb 2023 05:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=407iwzSIVRBMFYKAUPm/LirkhOodDidvXEKKRkZ/mlU=;
 b=ZCgpxLXq8hBWjWOssO6KXjowH/QXIfz0QvGhXPlJ/eX9Pak7SfK6UfpanpqLNWVMuwvY
 9uW/M7rHmlOlv82vlgB5qee7GeAJAKQHNGVC1fe7QOiGW/O6qcTXaQqFqK/w7J9DdTuZ
 fNVO4l/++13r+KW25bURC4u19NPvtWmYiOgSb+Jv2HhIml71HxSy03JKCFtfeaFu3/Sx
 S8MhGUw5uFqWZmQkB7VqpGkptELmrDPqJa35E0+dwbC6JtoZfrjg2DvNFtqUHUR3Fdet
 gUW1kXEWocifFDz5zPFkvSGiXUcgDqZ3yoFIh6uoYaBq2B2x/Vlaa+5NuPIsrNdydxK4 DA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np46vk03t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 05:08:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31D57x81012661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 05:07:59 GMT
Received: from [10.216.16.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 12 Feb
 2023 21:07:47 -0800
Message-ID: <d9adef45-82c3-52fa-1261-c2df88c95639@quicinc.com>
Date:   Mon, 13 Feb 2023 10:37:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V3] arm64: defconfig: Enable scm download mode config for
 IPQ Targets
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230208053332.16537-1-quic_poovendh@quicinc.com>
 <20230208053332.16537-5-quic_poovendh@quicinc.com>
 <20230208214254.nabavfpj5ymdgr3a@ripper>
Content-Language: en-US
From:   POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
In-Reply-To: <20230208214254.nabavfpj5ymdgr3a@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NR7k7PI41S6RtALDeX2gOH3jWXpFGad5
X-Proofpoint-GUID: NR7k7PI41S6RtALDeX2gOH3jWXpFGad5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130046
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/2023 3:12 AM, Bjorn Andersson wrote:
> On Wed, Feb 08, 2023 at 11:03:31AM +0530, Poovendhan Selvaraj wrote:
>> Enabling the download mode config by default as the IPQ Targets use
>> crashdump feature extensively to debug crashes.
>>
> No thanks.
>
> You can pass qcom_scm.download_mode=1 on the kernel command line to turn
> this on dynamically when you want it. There's no reason to attempt
> enabling download mode on every Qualcomm board running the upstream
> kernel.
>
> Regards,
> Bjorn

Okay sure...i will remove this patch in next series.

Regards,
Poovendhan S

>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> ---
>>   Changes in V3:
>> 	- Updated the commit message
>>
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 37a60df14e1d..42c9ccdbf0dc 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -258,6 +258,7 @@ CONFIG_ARM_SCPI_PROTOCOL=y
>>   CONFIG_RASPBERRYPI_FIRMWARE=y
>>   CONFIG_INTEL_STRATIX10_SERVICE=y
>>   CONFIG_INTEL_STRATIX10_RSU=m
>> +CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
>>   CONFIG_EFI_CAPSULE_LOADER=y
>>   CONFIG_IMX_SCU=y
>>   CONFIG_IMX_SCU_PD=y
>> -- 
>> 2.17.1
>>
