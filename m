Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B90069CE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjBTN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjBTN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:56:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF951E9E7;
        Mon, 20 Feb 2023 05:55:55 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K5l5lm027414;
        Mon, 20 Feb 2023 13:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=B/rlVhJvUxZCNcI3JwfDGsrkVkQ6lvojO9Mkp8yABVM=;
 b=iqS9JmgVnKzbkJBcTkNmi87ZI2l6l9XKg0hnsGIJJy9xityKR0UIUCu3bPXSFKgCfND5
 VdGY/4vAwKuvImrGj33yFQ/HyLxRfBebvosnWiJunGwpfpsSUdy4w7p8mBquAF9KKlqi
 oFONiO+kf/drRO942jC7DxEEgmDhJl2eBGvppGbHnvrgO1Ewl2+BPYiYvqgvah+Ie3u9
 4n28K5s52FCS+DrLGT0gjC5XWiNioSQgrneC+OzcMPWM1+ekLCYTIhwU5/FtgWyg9Ap9
 JLuHGhF1KGgFb1sHJ2s8jWOfpe09osgxZMOQ+C7yExVzVb84jxb32JK8CrdC78v36H5P bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntp98d9ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:55:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31KDtUhh022362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:55:30 GMT
Received: from [10.216.11.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Feb
 2023 05:55:22 -0800
Message-ID: <1d1cdd40-8bc8-c6e2-bc80-961e6aa2328d@quicinc.com>
Date:   Mon, 20 Feb 2023 19:25:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 2/5] clk: qcom: apss-ipq-pll: Enable APSS clock driver
 in IPQ9574
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
References: <20230217134107.13946-1-quic_devipriy@quicinc.com>
 <20230217134107.13946-3-quic_devipriy@quicinc.com>
 <3bc2f33d-163c-1f26-1d05-e3056f852bcd@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <3bc2f33d-163c-1f26-1d05-e3056f852bcd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KcHRkWijTEaaPkxVEN3h_y81VGaMb_r3
X-Proofpoint-ORIG-GUID: KcHRkWijTEaaPkxVEN3h_y81VGaMb_r3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_11,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200126
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/2023 7:43 PM, Konrad Dybcio wrote:
> 
> 
> On 17.02.2023 14:41, Devi Priya wrote:
> The subject is.. weird.. something like:
> 
> clk: qcom: apss-ipq-pll: add support for IPQ9574
> 
> would have made more sense, as you're not enabling the clock
> driver, and certainly not *in* the SoC.
Yes agreed. Will update this in V3
> 
>> Add the compatible and configuration values
> Generally the lines in commit messages should be broken at 70-75
> chars, not 40.
> 
Okay
>> for A73 Huayra PLL found on IPQ9574
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Is Praveenkumar's last name "I"?
yes, it is
> 
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
> Otherwise the code looks good, I think.
Sure, thanks
> 
> Konrad
>>   Changes in V2:
>> 	- Rebased the changes on the below series which refactors the
>> 	  driver to accommodate Huayra & Stromer Plus PLLs
>> 	  https://lore.kernel.org/linux-arm-msm/20230217083308.12017-2-quic_kathirav@quicinc.com/
>> 	- Changed the hex value in ipq9574_pll_config to lowercase
>> 	- Dropped the mailbox driver changes as ipq9574 mailbox is
>> 	  compatible with ipq6018
>>
>>   drivers/clk/qcom/apss-ipq-pll.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
>> index cf4f0d340cbf..ce28d882ee78 100644
>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>> @@ -111,6 +111,18 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>>   	.test_ctl_hi_val = 0x4000,
>>   };
>>   
>> +static const struct alpha_pll_config ipq9574_pll_config = {
>> +	.l = 0x3b,
>> +	.config_ctl_val = 0x200d4828,
>> +	.config_ctl_hi_val = 0x6,
>> +	.early_output_mask = BIT(3),
>> +	.aux2_output_mask = BIT(2),
>> +	.aux_output_mask = BIT(1),
>> +	.main_output_mask = BIT(0),
>> +	.test_ctl_val = 0x0,
>> +	.test_ctl_hi_val = 0x4000,
>> +};
>> +
>>   struct apss_pll_data {
>>   	int pll_type;
>>   	struct clk_alpha_pll *pll;
>> @@ -135,6 +147,12 @@ static struct apss_pll_data ipq6018_pll_data = {
>>   	.pll_config = &ipq6018_pll_config,
>>   };
>>   
>> +static struct apss_pll_data ipq9574_pll_data = {
>> +	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
>> +	.pll = &ipq_pll_huayra,
>> +	.pll_config = &ipq9574_pll_config,
>> +};
>> +
>>   static const struct regmap_config ipq_pll_regmap_config = {
>>   	.reg_bits		= 32,
>>   	.reg_stride		= 4,
>> @@ -180,6 +198,7 @@ static const struct of_device_id apss_ipq_pll_match_table[] = {
>>   	{ .compatible = "qcom,ipq5332-a53pll", .data = &ipq5332_pll_data },
>>   	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
>>   	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
>> +	{ .compatible = "qcom,ipq9574-a73pll", .data = &ipq9574_pll_data },
>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
Best Regards,
Devi Priya
