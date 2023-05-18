Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB97083E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjEROZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjEROZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:25:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B386310A;
        Thu, 18 May 2023 07:25:27 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICUC6Y006621;
        Thu, 18 May 2023 14:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dv/kYzyTjABVbrLr5VsPzbkETBNf77h54Wrhs4vxRzA=;
 b=NEme2u+V4iDKsO0/gWUmHwUgBmqR8F/ichKyRJbyFwBFH3TDYEkVMPmT1/af9Ru500LE
 eXKhiqRaGl0aFRSlTul4pr3Ga5PIR2LX+qtfldw4GM9gsDEKrmZGsB26e1MqHnREZ5f4
 gKAn2fPZ4X8sDhf5Vf2GeCjGQbQRoWBtcqYWOeAw2JZru6NvK9MkUdZQ6peAtebm24TK
 RgmfIzx2peTRqkfcan7bqPj0/uq8A/jZJTXmhxnmqD/BgRPx6bp3SPO5X7/kpQwTaLLK
 szyBMajqJggz3Yajmr2q98GxAfzO319PZkWn7DV3FXJuu7uyOvLJwA3R1bFz+/Z0P0+y fw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnbxqh9nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 14:25:23 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IEPNgr015985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 14:25:23 GMT
Received: from [10.216.40.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 07:25:20 -0700
Message-ID: <f62b5cfd-41e5-aad5-04bf-5959b2fd7a51@quicinc.com>
Date:   Thu, 18 May 2023 19:55:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND,PATCH 1/2] firmware: qcom: scm: Add SDI disable support
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srichara@quicinc.com>
References: <20230518140224.2248782-1-robimarko@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230518140224.2248782-1-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gZ4prnw1DRY7VZDlLSgzOrTRP6srSIlj
X-Proofpoint-GUID: gZ4prnw1DRY7VZDlLSgzOrTRP6srSIlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180116
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2023 7:32 PM, Robert Marko wrote:
> Some SoC-s like IPQ5018 require SDI(Secure Debug Image) to be disabled
> before trying to reboot, otherwise board will just hang after reboot has
> been issued via PSCI.
> 
> So, provide a call to SCM that allows disabling it.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

This scm call support indeed needed for reboot cases, but i am not sure
about target specific check in the later patch.

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   drivers/firmware/qcom_scm.c | 23 +++++++++++++++++++++++
>   drivers/firmware/qcom_scm.h |  1 +
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index fde33acd46b7..bdc9324d4e62 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -407,6 +407,29 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>   }
>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>   
> +static int qcom_scm_disable_sdi(void)
> +{
> +	int ret;
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_BOOT,
> +		.cmd = QCOM_SCM_BOOT_SDI_CONFIG,
> +		.args[0] = 1, /* Disable watchdog debug */
> +		.args[1] = 0, /* Disable SDI */
> +		.arginfo = QCOM_SCM_ARGS(2),
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +	struct qcom_scm_res res;
> +
> +	ret = qcom_scm_clk_enable();
> +	if (ret)
> +		return ret;
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +
> +	qcom_scm_clk_disable();
> +
> +	return ret ? : res.result[0];
> +}
> +
>   static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   {
>   	struct qcom_scm_desc desc = {
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index e6e512bd57d1..7b68fa820495 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -80,6 +80,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>   #define QCOM_SCM_SVC_BOOT		0x01
>   #define QCOM_SCM_BOOT_SET_ADDR		0x01
>   #define QCOM_SCM_BOOT_TERMINATE_PC	0x02
> +#define QCOM_SCM_BOOT_SDI_CONFIG	0x09
>   #define QCOM_SCM_BOOT_SET_DLOAD_MODE	0x10
>   #define QCOM_SCM_BOOT_SET_ADDR_MC	0x11
>   #define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
