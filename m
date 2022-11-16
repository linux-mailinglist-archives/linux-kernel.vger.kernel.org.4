Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383E062B6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiKPJeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbiKPJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:34:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14B24956;
        Wed, 16 Nov 2022 01:34:04 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG8s3ik009658;
        Wed, 16 Nov 2022 09:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=l+DQqc+1IE6NDIxZi6HxFmkfpES6h9yCkbLrtcues4M=;
 b=T5INpm8GcuDQ32JEcq9Wu1FMXdXpbquAmrwuF637ahL39JmjnCXPmmK/p8Ov4PeZ71pv
 5ghhuXmWhkrzVLjkO8uU1f8FKk1yaUbCitUppRHqIt+ncJvy0lzMPtTOJzF6wKlc2UiD
 LIEvAZTm0kOX1Fe5BNv0FSTSPB80uWdxltjbwFs3YtjCqCfhO9m+1Wjoh4obl0maLgzo
 /AJ4Vk9q/y1jY6Ec+cExr40z54MemF9aXwPrZaFcrDdlhUsHLh+OznGAW371VSSS6zzL
 PsOF3bbLtvGRIYDyiiZM0m2RR1QaXqzkCqnDaDMCQ73G9TPQ3c7TyFtIK9dlEtPMKCXd yg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kvtbrrjwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 09:33:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AG9XT0r022317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 09:33:29 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 16 Nov
 2022 01:33:26 -0800
Message-ID: <054a0023-13c3-047a-20a8-28a0b1a05fe9@quicinc.com>
Date:   Wed, 16 Nov 2022 15:03:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] remoteproc: qcom_q6v5_pas: detach power domains on
 remove
To:     Luca Weiss <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221111115414.153961-1-luca.weiss@fairphone.com>
 <20221111115414.153961-2-luca.weiss@fairphone.com>
Content-Language: en-US
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221111115414.153961-2-luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gqYC8oMmSNTuFrw7ENFiGQl8Wr_NbBIz
X-Proofpoint-GUID: gqYC8oMmSNTuFrw7ENFiGQl8Wr_NbBIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Luca,

Thanks for the fix.


On 11/11/22 17:24, Luca Weiss wrote:
> We need to detach from the power domains also on remove, not just on
> probe fail so a subsequent probe works as expected.
> 
> Otherwise the following error appears on re-probe:
> 
> [   29.452005] sysfs: cannot create duplicate filename '/devices/genpd:0:3000000.remoteproc'
> [   29.477121] CPU: 1 PID: 483 Comm: sh Tainted: G        W          6.1.0-rc4-00075-g71a113770bda #78
> [   29.510319] Hardware name: Fairphone 4 (DT)
> [   29.538335] Call trace:
> [   29.564470]  dump_backtrace.part.0+0xe0/0xf0
> [   29.592602]  show_stack+0x18/0x30
> [   29.619616]  dump_stack_lvl+0x64/0x80
> [   29.646834]  dump_stack+0x18/0x34
> [   29.673541]  sysfs_warn_dup+0x60/0x7c
> [   29.700592]  sysfs_create_dir_ns+0xec/0x110
> [   29.728057]  kobject_add_internal+0xb8/0x374
> [   29.755530]  kobject_add+0x9c/0x104
> [   29.782072]  device_add+0xbc/0x8a0
> [   29.808445]  device_register+0x20/0x30
> [   29.835175]  genpd_dev_pm_attach_by_id+0xa4/0x190
> [   29.862851]  genpd_dev_pm_attach_by_name+0x3c/0xb0
> [   29.890472]  dev_pm_domain_attach_by_name+0x20/0x30
> [   29.918212]  adsp_probe+0x278/0x580
> [   29.944384]  platform_probe+0x68/0xc0
> [   29.970603]  really_probe+0xbc/0x2dc
> [   29.996662]  __driver_probe_device+0x78/0xe0
> [   30.023491]  device_driver_attach+0x48/0xac
> [   30.050215]  bind_store+0xb8/0x114
> [   30.075957]  drv_attr_store+0x24/0x3c
> [   30.101874]  sysfs_kf_write+0x44/0x54
> [   30.127751]  kernfs_fop_write_iter+0x120/0x1f0
> [   30.154448]  vfs_write+0x1ac/0x380
> [   30.179937]  ksys_write+0x70/0x104
> [   30.205274]  __arm64_sys_write+0x1c/0x2c
> [   30.231060]  invoke_syscall+0x48/0x114
> [   30.256594]  el0_svc_common.constprop.0+0x44/0xec
> [   30.283183]  do_el0_svc+0x2c/0xd0
> [   30.308320]  el0_svc+0x2c/0x84
> [   30.333059]  el0t_64_sync_handler+0xf4/0x120
> [   30.359001]  el0t_64_sync+0x18c/0x190
> [   30.384385] kobject_add_internal failed for genpd:0:3000000.remoteproc with -EEXIST, don't try to register things with the same name in the same directory.
> [   30.406029] remoteproc remoteproc0: releasing 3000000.remoteproc
> [   30.416064] qcom_q6v5_pas: probe of 3000000.remoteproc failed with error -17
> 
> Fixes: 17ee2fb4e856 ("remoteproc: qcom: pas: Vote for active/proxy power domains")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index d830bf13c32c..747155c85085 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -573,6 +573,7 @@ static int adsp_remove(struct platform_device *pdev)
>   	qcom_remove_sysmon_subdev(adsp->sysmon);
>   	qcom_remove_smd_subdev(adsp->rproc, &adsp->smd_subdev);
>   	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
> +	adsp_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>   	rproc_free(adsp->rproc);
>   	device_init_wakeup(adsp->dev, false);
>   
