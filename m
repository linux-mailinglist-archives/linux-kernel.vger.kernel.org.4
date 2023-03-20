Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393726C2607
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCTXsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjCTXsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:48:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15942DBD0;
        Mon, 20 Mar 2023 16:47:22 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KMBD4S023372;
        Mon, 20 Mar 2023 23:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=27HtUd1mojbfhVpkD4e+wTcjCFDgUp2b3TdzzCWzVdQ=;
 b=gjQhD47oPNq394Si2smK+1hEduPtrfxa9EzqhibfQH4fVfdlpQrBXRgqmzBOIQd+wDMQ
 8IVeegEAAWVB2v/aF0W/ZH9JObQvOS+3wBtylgFTgDCut2UeYx4gG6kg/0mQ9HOJmZ+V
 4uiSYROweKwzR5BGBcZj9RxQiJ6gul2gipBtxO3excKbuC9E/Gn8Y+++/E0/uSuW+nWi
 5Vt9tq18t3oalRns8dfE/+BRA83zc742Hmw2kp66ljR6W1wQmpXTIWa9HEm5pI8zsaa5
 5X1R2wWJw48z+zRWh8sMXKrgGkBhb8N6yP4vH9YdmBQzlE5OUuFyKwJub+Zov4KyAiJz +w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pen6hsw49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:46:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KNk6mJ001408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:46:06 GMT
Received: from [10.110.115.97] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Mar
 2023 16:46:05 -0700
Message-ID: <e5753441-894d-e6f2-c628-eb931a6b2986@quicinc.com>
Date:   Mon, 20 Mar 2023 16:46:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 6/7] remoteproc: qcom_q6v5_pas: Add support to attach a
 DSP
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
 <20230306231202.12223-7-quic_molvera@quicinc.com>
 <20230316022740.umavd6jviftktag7@ripper>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20230316022740.umavd6jviftktag7@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K5qMRy4qy5zq3MB_PpcPonz44UrakDiR
X-Proofpoint-GUID: K5qMRy4qy5zq3MB_PpcPonz44UrakDiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2023 7:27 PM, Bjorn Andersson wrote:
> On Mon, Mar 06, 2023 at 03:12:01PM -0800, Melody Olvera wrote:
>> Some chipsets will have DSPs which will have begun running prior
>> to linux booting, so add support to late attach these DSPs by
>> adding support for:
>> - run-time checking of an offline or running DSP via rmb register
>> - a late attach framework to attach to the running DSP
>> - a handshake mechanism to ensure full and proper booting via rmb
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  drivers/remoteproc/qcom_q6v5_pas.c | 103 ++++++++++++++++++++++++++++-
>>  1 file changed, 102 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 0871108fb4dc..e22be6a029a8 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -242,10 +242,89 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>>  	return ret;
>>  }
>>  
>> +static int adsp_attach(struct rproc *rproc)
>> +{
>> +	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> +	int i, ret;
>> +
>> +	ret = qcom_q6v5_prepare(&adsp->q6v5);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>> +	if (ret < 0)
>> +		goto disable_irqs;
>> +
>> +	ret = clk_prepare_enable(adsp->xo);
>> +	if (ret)
>> +		goto disable_proxy_pds;
>> +
>> +	ret = clk_prepare_enable(adsp->aggre2_clk);
>> +	if (ret)
>> +		goto disable_xo_clk;
>> +
>> +	if (adsp->cx_supply) {
>> +		ret = regulator_enable(adsp->cx_supply);
>> +		if (ret)
>> +			goto disable_aggre2_clk;
>> +	}
>> +
>> +	if (adsp->px_supply) {
>> +		ret = regulator_enable(adsp->px_supply);
>> +		if (ret)
>> +			goto disable_cx_supply;
>> +	}
>> +
>> +	/* if needed, signal Q6 to continute booting */
>> +	if (adsp->q6v5.rmb_base) {
>> +		for (i = 0; i < RMB_POLL_MAX_TIMES; i++) {
>> +			if (readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
>> +				writel_relaxed(1, adsp->q6v5.rmb_base + RMB_BOOT_CONT_REG);
>> +				break;
>> +			}
>> +			msleep(20);
>> +		}
>> +
>> +		if (!readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
>> +			dev_err(adsp->dev, "Didn't get rmb signal from  %s\n", rproc->name);
>> +			goto disable_px_supply;
>> +		}
>> +	}
>> +
>> +	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
>> +	if (ret == -ETIMEDOUT) {
>> +		dev_err(adsp->dev, "start timed out\n");
>> +		qcom_scm_pas_shutdown(adsp->pas_id);
>> +		goto disable_px_supply;
>> +	}
>> +
>> +	return 0;
>> +
>> +disable_px_supply:
>> +	if (adsp->px_supply)
>> +		regulator_disable(adsp->px_supply);
>> +disable_cx_supply:
>> +	if (adsp->cx_supply)
>> +		regulator_disable(adsp->cx_supply);
>> +disable_aggre2_clk:
>> +	clk_disable_unprepare(adsp->aggre2_clk);
>> +disable_xo_clk:
>> +	clk_disable_unprepare(adsp->xo);
>> +disable_proxy_pds:
>> +	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>> +disable_irqs:
>> +	qcom_q6v5_unprepare(&adsp->q6v5);
>> +
>> +	/* Remove pointer to the loaded firmware, only valid in adsp_load() & adsp_start() */
>> +	adsp->firmware = NULL;
>> +
>> +	return ret;
>> +}
>> +
>>  static int adsp_start(struct rproc *rproc)
>>  {
>>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> -	int ret;
>> +	int i, ret;
>>  
>>  	ret = qcom_q6v5_prepare(&adsp->q6v5);
>>  	if (ret)
>> @@ -304,6 +383,22 @@ static int adsp_start(struct rproc *rproc)
>>  		goto release_pas_metadata;
>>  	}
>>  
>> +	/* if needed, signal Q6 to continute booting */
> Why does this come before the wait_for_start()? Is the DSP actually up
> and running when you hit attach, or is it just loaded?

Yeah so DSP is loaded and partially booted, but it's waiting for a signal from our driver
to complete the boot process through to err_ready.

>
>> +	if (adsp->q6v5.rmb_base) {
> Afaict this is copy-paste from attach, please move it to a helper
> function.

Sure.

>
>> +		for (i = 0; i < RMB_POLL_MAX_TIMES; i++) {
>> +			if (readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
>> +				writel_relaxed(1, adsp->q6v5.rmb_base + RMB_BOOT_CONT_REG);
>> +				break;
>> +			}
>> +			msleep(20);
>> +		}
>> +
>> +		if (!readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
> If you hit the break above, there should be no reason to read this
> register again.
>
> Seems cleaner to write this as:
>
> 	ret = readl_poll_timeout();
> 	if (ret < 0)
> 		goto release;
>
> 	writel(1, ...);

That is much cleaner; I didn't know about the poll timeout function. Will rewrite using it.

Thanks,
Melody
>
> Regards,
> Bjorn
>
>> +			dev_err(adsp->dev, "Didn't get rmb signal from  %s\n", rproc->name);
>> +			goto release_pas_metadata;
>> +		}
>> +	}
>> +
>>  	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
>>  	if (ret == -ETIMEDOUT) {
>>  		dev_err(adsp->dev, "start timed out\n");
>> @@ -413,6 +508,7 @@ static unsigned long adsp_panic(struct rproc *rproc)
>>  static const struct rproc_ops adsp_ops = {
>>  	.unprepare = adsp_unprepare,
>>  	.start = adsp_start,
>> +	.attach = adsp_attach,
>>  	.stop = adsp_stop,
>>  	.da_to_va = adsp_da_to_va,
>>  	.parse_fw = qcom_register_dump_segments,
>> @@ -423,6 +519,7 @@ static const struct rproc_ops adsp_ops = {
>>  static const struct rproc_ops adsp_minidump_ops = {
>>  	.unprepare = adsp_unprepare,
>>  	.start = adsp_start,
>> +	.attach = adsp_attach,
>>  	.stop = adsp_stop,
>>  	.da_to_va = adsp_da_to_va,
>>  	.load = adsp_load,
>> @@ -728,6 +825,10 @@ static int adsp_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto detach_proxy_pds;
>>  
>> +	if (adsp->q6v5.rmb_base &&
>> +			readl_relaxed(adsp->q6v5.rmb_base + RMB_Q6_BOOT_STATUS_REG))
>> +		rproc->state = RPROC_DETACHED;
>> +
>>  	qcom_add_glink_subdev(rproc, &adsp->glink_subdev, desc->ssr_name);
>>  	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
>>  	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
>> -- 
>> 2.25.1
>>

