Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B696B351E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCJEEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJEEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:04:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F3EE501E;
        Thu,  9 Mar 2023 20:04:33 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32A16TZ4002304;
        Fri, 10 Mar 2023 04:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Qy1PUzn19VptN8IfOjaioaDlFAVD7aWdoVwO37RW/Ko=;
 b=GUtsNN75D+5nCv7YyGv4381CVWdZniukmtlgVzuxvR6l2QsH3JG6EEg7Z1Cti5lSKdr4
 0Xv6ELqm9ai6/gXk9C4qP471zFMIbbWzOCH01/C57dj0xwPkYLEaRLOIbR/zejlar9kK
 Gzvw8myX0Ay5ZVDluFBugtkAq+mx2Mn3yxeKuhWdDrFVdoH7G+vVQKoNMo3wp4AQRosr
 c/GEIURZUeL94Tjbt46O3YuAsR7iuJSLOmfYJ3ak7Ph73s/39QxET8AUdMpJvG8c+hcz
 Q8iR9xpgB4tkSoTRACXAP0wz26KiPg2IWDvxLupRO8atYf629Fy7eYR/vxVRj3DQ6jg4 rQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p758cuufh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 04:04:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32A44P7l002890
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 04:04:25 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 20:04:14 -0800
Message-ID: <affcec97-6cc2-aa0a-103d-efa8ad3b68bf@quicinc.com>
Date:   Fri, 10 Mar 2023 09:34:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/1] remoteproc: qcom: pas: Coredump elf class to elf64
Content-Language: en-US
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <20230309001035.24024-1-quic_gokukris@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20230309001035.24024-1-quic_gokukris@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8useoCWDgeErQAEsQYb-NErQBF6ghjH6
X-Proofpoint-GUID: 8useoCWDgeErQAEsQYb-NErQBF6ghjH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Gokul,

Thanks for the patch.

On 3/9/23 05:40, Gokul krishna Krishnakumar wrote:
> This change adds a new initialization param which modifies the elf
> class accordingly. Some of the subsystem dump analysis tools need
> the elf class to be elf64.
> 

https://lore.kernel.org/lkml/8dea333d-544d-7c07-d560-a1a9c3a38ddc@quicinc.com/

This patch was already sent upstream a while back ^^. IIRC the firmware
certainly aren't 64 bit elfs and dump analysis tools don't really care 
as long the coredump contains section headers.

- Sibi

> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 0871108fb4dc..17ce3177be7b 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -39,6 +39,7 @@ struct adsp_data {
>   	int pas_id;
>   	int dtb_pas_id;
>   	unsigned int minidump_id;
> +	bool uses_elf64;
>   	bool auto_boot;
>   	bool decrypt_shutdown;
>   
> @@ -681,7 +682,10 @@ static int adsp_probe(struct platform_device *pdev)
>   	}
>   
>   	rproc->auto_boot = desc->auto_boot;
> -	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
> +	if (desc->uses_elf64)
> +		rproc_coredump_set_elf_info(rproc, ELFCLASS64, EM_NONE);
> +	else
> +		rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>   
>   	adsp = (struct qcom_adsp *)rproc->priv;
>   	adsp->dev = &pdev->dev;
> @@ -1126,6 +1130,7 @@ static const struct adsp_data sm8550_adsp_resource = {
>   	.pas_id = 1,
>   	.dtb_pas_id = 0x24,
>   	.minidump_id = 5,
> +	.uses_elf64 = true,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
>   		"lcx",
> @@ -1145,6 +1150,7 @@ static const struct adsp_data sm8550_cdsp_resource = {
>   	.pas_id = 18,
>   	.dtb_pas_id = 0x25,
>   	.minidump_id = 7,
> +	.uses_elf64 = true,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
>   		"cx",
> @@ -1165,6 +1171,7 @@ static const struct adsp_data sm8550_mpss_resource = {
>   	.pas_id = 4,
>   	.dtb_pas_id = 0x26,
>   	.minidump_id = 3,
> +	.uses_elf64 = true,
>   	.auto_boot = false,
>   	.decrypt_shutdown = true,
>   	.proxy_pd_names = (char*[]){
