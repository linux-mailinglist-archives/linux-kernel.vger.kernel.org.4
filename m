Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD88D6F651F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjEDGgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEDGgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:36:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213319A8;
        Wed,  3 May 2023 23:36:16 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34468RG2019942;
        Thu, 4 May 2023 06:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ckceYTelOzuvGlPkRZGM3wEiw0L8nAjcFHhd9e4Rrcs=;
 b=AKw/KcvlvOebPtS7/l/ZW9DBbwiRylCHZE5i5j39KKh3LPG2eQNKu0NX9PmBrrBFawwr
 sP7xzGDEKNfHWPDndpDp20kBPvZhGOBV+xdxrEU0dmG22Gg5RkIeoYIUTxUN1WOXslSV
 jxOGx194Xaf9bQvF634+ZuEeLLjtxcxJFVIywkOGkvJqY1uVlg2NEv62aNScMYeKcHrB
 TP3ZGzHAT5XcUiOXH7fw1GsTjBqTSSEr9JG4mXgnb3Uqlii2YwdU5sRpmW7XayhdtJT2
 sH6w04JPsqWJ8mVm0AEjd/1wk9/ixe9U1P/odnD7XEd1mVgB9QRx7R16ObWJMjzJdaKx Bg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc1eurmn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 06:36:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3446a4oN023465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 06:36:04 GMT
Received: from [10.50.29.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 23:36:00 -0700
Message-ID: <f42637c8-400b-e39f-412d-60328e176585@quicinc.com>
Date:   Thu, 4 May 2023 12:05:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V4 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681742910.git.quic_schowdhu@quicinc.com>
 <C1eDJi-H9uWRAtbInRclmCgPb4EcgaeS3sk5FKO9cw8KscgMCH8dxRSvdPGUMwDFKpte7cBVeaqPhlLog-CRrg==@protonmail.internalid>
 <2ef76ce292c059c144e559123a9a54201ae2d0cf.1681742910.git.quic_schowdhu@quicinc.com>
 <575ee047-c6ce-95c3-8781-8c9a78534bb1@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <575ee047-c6ce-95c3-8781-8c9a78534bb1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NoTl_No1p3wIYPJ5tYBWWLiLn5cPNT_c
X-Proofpoint-GUID: NoTl_No1p3wIYPJ5tYBWWLiLn5cPNT_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_03,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305040054
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 4:23 AM, Caleb Connolly wrote:
> 
> 
> On 17/04/2023 16:08, Souradeep Chowdhury wrote:
>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured in a specific format by this driver
>> by mapping a structure to the IMEM memory region and then accessing the
>> members of the structure to show the information within debugfs file.
>> This information is useful in verifying if the existing boot KPIs have
>> regressed or not. The information is shown in milliseconds, a sample
>> log from sm8450(waipio) device is as follows:-
>>
>> /sys/kernel/debug/146aa6b0.boot_stats # cat abl_time
>> 17898 ms
>> /sys/kernel/debug/146aa6b0.boot_stats # cat pre_abl_time
>> 2879 ms
>>
>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>> stage and the timestamp generated by the sleep counter is logged by
>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>> starts execution which is logged here as "pre_abl_time" and the second
>> when it is about to load the kernel logged as "abl_time". Documentation
>> details are also added in Documentation/ABI/testing/debugfs-driver-bootstat
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> 
> Hi,
> 
> [...]
>> +
>> +static int boot_stats_probe(struct platform_device *pdev)
>> +{
>> +	struct device *bootstat_dev = &pdev->dev;
>> +	struct bs_data *drvdata;
>> +
>> +	drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
>> +	platform_set_drvdata(pdev, drvdata);
>> +
>> +	drvdata->dbg_dir = debugfs_create_dir(dev_name(bootstat_dev), NULL);
> 
> This might be better as just "qcom_boot_stats", rather than including
> the address.

We usually use the dev_name to represent the one to one correspondence 
of the debugfs file with the device. Will create the root dir as
"qcom_boot_stats" and push the dev_name dir inside it.

> 
> [...]
>> +
>> +static const struct of_device_id boot_stats_dt_match[] = {
>> +	{ .compatible = "qcom,sm8450-bootstats" },
> 
> This driver doesn't only support sm8450, I've tested this on sdm845 and
> it works just fine. Can we use a generic compatible here instead?

We can add soc specific compatibles here to extend support for other 
socs. This also captures the SoCs for which the driver is supported 
which won't be the case if we use a generic compatible.


>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
>> +
>> +static struct platform_driver boot_stat_driver = {
>> +	.probe  = boot_stats_probe,
>> +	.remove_new = boot_stats_remove,
>> +	.driver = {
>> +		.name = "qcom-boot-stats",
>> +		.of_match_table = boot_stats_dt_match,
>> +	},
>> +};
>> +module_platform_driver(boot_stat_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.7.4
>>
> 
