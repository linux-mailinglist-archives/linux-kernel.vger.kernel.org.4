Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E6663BE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiK2Kh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiK2Khl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:37:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB96BC8;
        Tue, 29 Nov 2022 02:37:38 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AT9pNxj007856;
        Tue, 29 Nov 2022 10:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=49Ttj4zeLRKtXUQ2iiLm1EzCQ/EuPogtM4kufqhs5Uc=;
 b=UBXDWgGoUszM01aQDbG1N66lp30hi4FdoDDlTawTwaAKq6yOZP1QzzSap5pUBRCncdUR
 Nlp7uHJPvPbSaWEvVNtJzHkIO7mP6Qks5s2l4/AP/I6K5W44tr4IY6MxvIMWZ4+vtoWx
 YkHVYE1XuK7X04H6k06cCPRix6JX+kTlCm8C0ZlkRM/xIsxhK9hZsB3iLBlbTAA+C8gH
 KVvv92hrKAAjoC9dwvslCLel29Wh+BauNdGCmUzjbNlhHq3IcueYzC/ZTZmb5akMzPPR
 xSKw+Hy8Q4vKbKeamnF9EX7orNjDaYsCpouEt1vJFHZ9DJQhRs9MKhjwY719UdDHTw30 Fw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m56c69h3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 10:36:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ATAahE9020469
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 10:36:43 GMT
Received: from [10.216.62.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 02:36:38 -0800
Message-ID: <3b00c04c-cb6d-9e9a-ba0c-0ce093b4a3fb@quicinc.com>
Date:   Tue, 29 Nov 2022 16:05:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add system suspend/resume PM
 ops
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
References: <1669621742-28524-1-git-send-email-quic_srivasam@quicinc.com>
 <CAMuHMdUBojHkaAPsjOEadfaikth+L0R_NrKzvqXrmZS9Kc5zHw@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAMuHMdUBojHkaAPsjOEadfaikth+L0R_NrKzvqXrmZS9Kc5zHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y7qbBzVgVThROMFrnCjQzpa-c2HaquO_
X-Proofpoint-GUID: y7qbBzVgVThROMFrnCjQzpa-c2HaquO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_07,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290065
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your time!!!

On 11/29/2022 1:23 PM, Geert Uytterhoeven wrote:
> Hi Srinivasa,
>
> On Mon, Nov 28, 2022 at 8:50 AM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
>> Update lpass sc7180 platform driver with PM ops, such as
>> system supend and resume callbacks.
>> This update is required to disable clocks during supend and
>> avoid XO shutdown issue.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Tested-by: Rahul Ajmeriya <quic_rajmeriy@quicinc.com>
> Thanks for your patch, which is now commit 2d68148f8f85ca5a ("ASoC:
> qcom: lpass-sc7180: Add system suspend/resume PM ops") in next-20221129.
>
>> --- a/sound/soc/qcom/lpass-sc7180.c
>> +++ b/sound/soc/qcom/lpass-sc7180.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>   #include <dt-bindings/sound/sc7180-lpass.h>
>>   #include <sound/pcm.h>
>>   #include <sound/soc.h>
>> @@ -156,10 +157,34 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
>>          struct lpass_data *drvdata = platform_get_drvdata(pdev);
>>
>>          clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
>> +       return 0;
>> +}
>> +
>> +static int sc7180_lpass_dev_resume(struct device *dev)
>> +{
>> +       int ret = 0;
>> +       struct lpass_data *drvdata = dev_get_drvdata(dev);
>>
>> +       ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
>> +       if (ret) {
>> +               dev_err(dev, "sc7180 clk prepare and enable failed\n");
>> +               return ret;
>> +       }
>> +       return ret;
>> +}
>> +
>> +static int sc7180_lpass_dev_suspend(struct device *dev)
>> +{
>> +       struct lpass_data *drvdata = dev_get_drvdata(dev);
>> +
>> +       clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
>>          return 0;
>>   }
> noreply@ellerman.id.au reports for e.g. m68k-allmodconfig:
>
>      sound/soc/qcom/lpass-sc7180.c:179:12: error:
> 'sc7180_lpass_dev_suspend' defined but not used
> [-Werror=unused-function]
>      sound/soc/qcom/lpass-sc7180.c:166:12: error:
> 'sc7180_lpass_dev_resume' defined but not used
> [-Werror=unused-function]
>
>> +static const struct dev_pm_ops sc7180_lpass_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(sc7180_lpass_dev_suspend, sc7180_lpass_dev_resume)
>> +};
> Please use DEFINE_SIMPLE_DEV_PM_OPS()...
Actually, we need to use this patch in in previous kernels 5.4 and 5.15.
I think these changes won't apply on previous kernel.
Hence ignoring for now and will take care next time.
>
>> +
>>   static struct lpass_variant sc7180_data = {
>>          .i2sctrl_reg_base       = 0x1000,
>>          .i2sctrl_reg_stride     = 0x1000,
>> @@ -293,6 +318,7 @@ static struct platform_driver sc7180_lpass_cpu_platform_driver = {
>>          .driver = {
>>                  .name = "sc7180-lpass-cpu",
>>                  .of_match_table = of_match_ptr(sc7180_lpass_cpu_device_id),
>> +               .pm = &sc7180_lpass_pm_ops,
> ... and pm_sleep_ptr().
>
>>          },
>>          .probe = asoc_qcom_lpass_cpu_platform_probe,
>>          .remove = asoc_qcom_lpass_cpu_platform_remove,
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
