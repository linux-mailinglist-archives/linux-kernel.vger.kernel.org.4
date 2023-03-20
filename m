Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37936C259F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCTXal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCTXah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:30:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E918145;
        Mon, 20 Mar 2023 16:30:35 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KLWsQL029937;
        Mon, 20 Mar 2023 23:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oS8WmOQq4N8R288gAT5pXvGxE25jWqUFgIue5/beRb8=;
 b=Dj5EMs6asYb/B1Wi/ZE5rsaVB8UrQZNGMokOE1CFEYyvLopWdjsu4LLBDsqHCcoUOoUQ
 e0r2FXSZ2kl7h71lw6HRkbCs6402nbkOKoVfjCDUieaIiSTo40jFiOredjFFnlZHhmlD
 uD/YApv6nyw6tZPwNc3e4s2yxo2UEWU0/w9OO4QjFRj3Hk4qzWaRsQqQLeC+CvGoBO3F
 ujPT2E+9l8tc9Lz8vURrD6lcQpOpCfl67fWCkqFmBCj0CwAqj5CzUgwUnO744ByZyDBY
 1Pa4UhGbLMcNY7w6V6XCuatVxKa65wTPEqci3f/P2/+Ev4UXFjzCr23cxQEj5arguGR1 1A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pes8p189k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:30:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KNUUZB019246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:30:30 GMT
Received: from [10.110.115.97] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Mar
 2023 16:30:29 -0700
Message-ID: <394ed3a3-678e-d2bb-a032-aee135acaee2@quicinc.com>
Date:   Mon, 20 Mar 2023 16:30:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 5/7] remoteproc: qcom: q6v5: Add support for q6 rmb
 registers
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
 <20230306231202.12223-6-quic_molvera@quicinc.com>
 <20230316021736.d53quam5eew5fr6m@ripper>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20230316021736.d53quam5eew5fr6m@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rcdnS3O8jz_GPnWPvXR5YtvdQ2TTR5CQ
X-Proofpoint-ORIG-GUID: rcdnS3O8jz_GPnWPvXR5YtvdQ2TTR5CQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200198
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2023 7:17 PM, Bjorn Andersson wrote:
> On Mon, Mar 06, 2023 at 03:12:00PM -0800, Melody Olvera wrote:
>> When attaching a running Q6, the remoteproc driver needs a way
>> to communicate with the Q6 using rmb registers, so allow the
>> rmb register to be gotten from the device tree if present.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  drivers/remoteproc/qcom_q6v5.c | 9 +++++++++
>>  drivers/remoteproc/qcom_q6v5.h | 8 ++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
>> index 192c7aa0e39e..e8c6be70ebfd 100644
>> --- a/drivers/remoteproc/qcom_q6v5.c
>> +++ b/drivers/remoteproc/qcom_q6v5.c
>> @@ -254,6 +254,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>  		   void (*handover)(struct qcom_q6v5 *q6v5))
>>  {
>>  	int ret;
>> +	struct resource *res;
>>  
>>  	q6v5->rproc = rproc;
>>  	q6v5->dev = &pdev->dev;
>> @@ -263,6 +264,14 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>  	init_completion(&q6v5->start_done);
>>  	init_completion(&q6v5->stop_done);
>>  
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> In addition to the PAS driver, __func__ is being invoked by the non-PAS
> ADSP and MPSS drivers as well, which both uses reg[1] for other
> purposes. So this won't work.
>
> Perhaps I'm missing some possibility of reuse, but it seems reasonable
> for this to move to the pas-driver.

Yeah that's fairly sensible. I'll move this to the pas driver.

Thanks,
Melody
>
> Thanks,
> Bjorn
>
>> +	if (res) {
>> +		q6v5->rmb_base = devm_ioremap_resource(&pdev->dev, res);
>> +		if (IS_ERR(q6v5->rmb_base))
>> +			q6v5->rmb_base = NULL;
>> +	} else
>> +		q6v5->rmb_base = NULL;
>> +
>>  	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
>>  	if (q6v5->wdog_irq < 0)
>>  		return q6v5->wdog_irq;
>> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
>> index 5a859c41896e..95824d5b64ce 100644
>> --- a/drivers/remoteproc/qcom_q6v5.h
>> +++ b/drivers/remoteproc/qcom_q6v5.h
>> @@ -7,6 +7,12 @@
>>  #include <linux/completion.h>
>>  #include <linux/soc/qcom/qcom_aoss.h>
>>  
>> +#define RMB_BOOT_WAIT_REG 0x8
>> +#define RMB_BOOT_CONT_REG 0xC
>> +#define RMB_Q6_BOOT_STATUS_REG 0x10
>> +
>> +#define RMB_POLL_MAX_TIMES 250
>> +
>>  struct icc_path;
>>  struct rproc;
>>  struct qcom_smem_state;
>> @@ -16,6 +22,8 @@ struct qcom_q6v5 {
>>  	struct device *dev;
>>  	struct rproc *rproc;
>>  
>> +	void __iomem *rmb_base;
>> +
>>  	struct qcom_smem_state *state;
>>  	struct qmp *qmp;
>>  
>> -- 
>> 2.25.1
>>

