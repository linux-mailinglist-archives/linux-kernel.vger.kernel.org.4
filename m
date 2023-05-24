Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E349670F841
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjEXOG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjEXOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:06:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD69111D;
        Wed, 24 May 2023 07:06:51 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OC3AWM022584;
        Wed, 24 May 2023 14:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nnv6g827kCYfW8QRZDbcfbRQb1m9sQ1h0BY5HuW7+dc=;
 b=pjCMUbIEvi2j7E+mwWPZhEhzLu9Y6N2gkqAj7m78hzsKmBDY5w4zEB3kM6iyfkv3l3w7
 UGElxhzte7r4sufYWxpyWiXy9mlMwdqoRa/Wu5qRuMrOujwG42t9erbD7DquHY3QWtRW
 XzW4DBvkBoC14sAJUpFRycueHvgKy9WfUdZutrE/aSQQOUWW9RNq/5QVVgkgpIWym0Ek
 3vyv1VskCYb8j/ojBkZprrwgsQV+fGe8/61VZEY4WaVzP3CNBO74Ykxn7gqwHo/39Phe
 75FxAQxNjd9AIWUKpUapt0EI8dubgDPP7TL8S7rLALzWV8RYYfZYZlf+Ivwyl3zHRpen xQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsf880q8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:06:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OE6hkJ008495
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:06:43 GMT
Received: from [10.217.216.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 07:06:39 -0700
Message-ID: <772ad12e-2865-4c14-d6b8-80c99a30d802@quicinc.com>
Date:   Wed, 24 May 2023 19:36:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V4 2/3] clk: qcom: videocc-sm8450: Add video clock
 controller driver for SM8450
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_skakitap@quicinc.com>, <quic_imrashai@quicinc.com>,
        <quic_ajipan@quicinc.com>
References: <20230509172148.7627-1-quic_tdas@quicinc.com>
 <20230509172148.7627-3-quic_tdas@quicinc.com>
 <CAA8EJprHgOaiH2CFKmz_E+NvJpA+DRNE-r1wQXbSfYi+5qoBmA@mail.gmail.com>
 <2b013e9d-e4d9-075f-519b-0ce5c4f62894@quicinc.com>
 <CAA8EJprUd-_9D+Xt=4vrXuzYuadhJFu1mA6Fow3K63U=0N2g5A@mail.gmail.com>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJprUd-_9D+Xt=4vrXuzYuadhJFu1mA6Fow3K63U=0N2g5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jL9GJ6AWI6k5EhVxKZofUObgHLhkv7X1
X-Proofpoint-GUID: jL9GJ6AWI6k5EhVxKZofUObgHLhkv7X1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240115
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your review!

On 5/19/2023 6:19 PM, Dmitry Baryshkov wrote:
> On Fri, 19 May 2023 at 13:53, Taniya Das <quic_tdas@quicinc.com> wrote:
>>
>> Hello Dmitry,
>>
>> Thank you for your review.
>>
>> On 5/10/2023 2:03 AM, Dmitry Baryshkov wrote:
>>> On Tue, 9 May 2023 at 20:22, Taniya Das <quic_tdas@quicinc.com> wrote:
>>>>
>>>> Add support for the video clock controller driver for peripheral clock
>>>> clients to be able to request for video cc clocks.
>>>>
>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>> ---
>>>> Changes since V3:
>>>>    - Use lower case hex.
>>>>    - Check the return value here and bail out early on failure in probe.
>>>>
>>>> Changes since V2:
>>>>    - Update the header file name to match the latest upstream header
>>>>      files.
>>>>
>>>> Changes since V1:
>>>>    - Use DT indices instead of fw_name.
>>>>    - Replace pm_runtime_enable with devm_pm_runtime_enable.
>>>>    - Change license to GPL from GPL V2.
>>>>
>>>>    drivers/clk/qcom/Kconfig          |   9 +
>>>>    drivers/clk/qcom/Makefile         |   1 +
>>>>    drivers/clk/qcom/videocc-sm8450.c | 461 ++++++++++++++++++++++++++++++
>>>>    3 files changed, 471 insertions(+)
>>>>    create mode 100644 drivers/clk/qcom/videocc-sm8450.c
>>>
>>> [skipped]
>>>
>>>
>>>> +static const struct qcom_reset_map video_cc_sm8450_resets[] = {
>>>> +       [CVP_VIDEO_CC_INTERFACE_BCR] = { 0x80e0 },
>>>> +       [CVP_VIDEO_CC_MVS0_BCR] = { 0x8098 },
>>>> +       [CVP_VIDEO_CC_MVS0C_BCR] = { 0x8048 },
>>>> +       [CVP_VIDEO_CC_MVS1_BCR] = { 0x80bc },
>>>> +       [CVP_VIDEO_CC_MVS1C_BCR] = { 0x8070 },
>>>
>>> Can we have a common VIDEO_CC prefix here please?
>>
>> The BCR names are coming from hardware plan and software interface, thus
>> we would like to keep them intact.
> 
> We have had a similar discussion on the sm8350-videocc driver. While
> keeping the hardware names is nice, name uniformity also should not be
> neglected. It is much easier to follow and verify the patches if all
> videocc resets start with VIDEO_CC name.
> 

As mentioned earlier, the BCR names are coming from hardware plan. 
Client drivers also use hardware plan to refer to these names. Hence we 
would like to keep these names aligned as per the hardware plan.

>>
>>
>>>
>>>> +       [VIDEO_CC_MVS0C_CLK_ARES] = { 0x8064, 2 },
>>>> +       [VIDEO_CC_MVS1C_CLK_ARES] = { 0x808c, 2 },
>>>> +};
>>>> +
>>
>> The ARES resets are coming from VideoCC clocks(CBCR), hence the name
>> starts with VIDEO_CC.
>>
>>>> +static const struct regmap_config video_cc_sm8450_regmap_config = {
>>>> +       .reg_bits = 32,
>>>> +       .reg_stride = 4,
>>>> +       .val_bits = 32,
>>>> +       .max_register = 0x9f4c,
>>>> +       .fast_io = true,
>>>> +};
>>>> +
>>>> +static struct qcom_cc_desc video_cc_sm8450_desc = {
>>>> +       .config = &video_cc_sm8450_regmap_config,
>>>> +       .clks = video_cc_sm8450_clocks,
>>>> +       .num_clks = ARRAY_SIZE(video_cc_sm8450_clocks),
>>>> +       .resets = video_cc_sm8450_resets,
>>>> +       .num_resets = ARRAY_SIZE(video_cc_sm8450_resets),
>>>> +       .gdscs = video_cc_sm8450_gdscs,
>>>> +       .num_gdscs = ARRAY_SIZE(video_cc_sm8450_gdscs),
>>>> +};
>>>> +
>>>> +static const struct of_device_id video_cc_sm8450_match_table[] = {
>>>> +       { .compatible = "qcom,sm8450-videocc" },
>>>> +       { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, video_cc_sm8450_match_table);
>>>> +
>>>> +static int video_cc_sm8450_probe(struct platform_device *pdev)
>>>> +{
>>>> +       struct regmap *regmap;
>>>> +       int ret;
>>>> +
>>>> +       ret = devm_pm_runtime_enable(&pdev->dev);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       ret = pm_runtime_resume_and_get(&pdev->dev);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       regmap = qcom_cc_map(pdev, &video_cc_sm8450_desc);
>>>> +       if (IS_ERR(regmap)) {
>>>> +               pm_runtime_put(&pdev->dev);
>>>> +               return PTR_ERR(regmap);
>>>> +       }
>>>> +
>>>> +       clk_lucid_evo_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
>>>> +       clk_lucid_evo_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
>>>> +
>>>> +       /*
>>>> +        * Keep clocks always enabled:
>>>> +        *      video_cc_ahb_clk
>>>> +        *      video_cc_sleep_clk
>>>> +        *      video_cc_xo_clk
>>>> +        */
>>>> +       regmap_update_bits(regmap, 0x80e4, BIT(0), BIT(0));
>>>> +       regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
>>>> +       regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
>>>> +
>>>> +       ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
>>>> +
>>>> +       pm_runtime_put(&pdev->dev);
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static struct platform_driver video_cc_sm8450_driver = {
>>>> +       .probe = video_cc_sm8450_probe,
>>>> +       .driver = {
>>>> +               .name = "video_cc-sm8450",
>>>> +               .of_match_table = video_cc_sm8450_match_table,
>>>> +       },
>>>> +};
>>>> +
>>>> +static int __init video_cc_sm8450_init(void)
>>>> +{
>>>> +       return platform_driver_register(&video_cc_sm8450_driver);
>>>> +}
>>>> +subsys_initcall(video_cc_sm8450_init);
>>>> +
>>>> +static void __exit video_cc_sm8450_exit(void)
>>>> +{
>>>> +       platform_driver_unregister(&video_cc_sm8450_driver);
>>>> +}
>>>> +module_exit(video_cc_sm8450_exit);
>>>
>>> module_platform_driver() ?
>>>
>>
>> We would like to keep the clock drivers all probed at subsys_initcall.
>> We could revisit and update as cleanup if we want to move them to module
>> init.
> 
> Any particular reason?
> 

We need to evaluate and validate if module_initcall works for us in all 
the scenarios. We will revisit and post a cleanup patch once we conclude
module_initcall works for us in all scenarios.

Thanks & Regards,
Jagadeesh
