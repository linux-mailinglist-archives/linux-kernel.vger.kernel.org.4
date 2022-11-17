Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F562D848
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiKQKlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiKQKlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:41:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6641FDFDB;
        Thu, 17 Nov 2022 02:41:23 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH9faJ4014964;
        Thu, 17 Nov 2022 10:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NvJ19AgIFMm92fLJWssfg/v+ovpsEf0avC1X30+grjQ=;
 b=SfREdcDjEGLRDytOM0oPT1phGfgwcetjgyf/AyHSzEmTyJCwz39k35Wo0v9tiztn7ARr
 GeeyXz/YM9uJYLzlcooIft4esvdQA1XL6EF+r9BT9exZ/oMmZBGoZ3nePpZIC5TITiA3
 b4oICjBJtVAw90+5hqR/dV3/iTExPPxIj6flaPlxs5m/e32y4h8Yzinf5/jqfq8w46rZ
 Y3ufyAKqelgV54RvfRMZDkq+z01zDCxCtV7FDm1Qxywh3SmjBfcGo1L/LRB0AgnEDPGj
 D18sxUmhO3JVlis3VBZNRhCsBfhOjpOkANjjYpDsBwQtVAl2y7HenXY/tNhHMXLfecVZ qg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kwfx4gs7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 10:40:51 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AHAeoVG001133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 10:40:50 GMT
Received: from [10.216.23.254] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 17 Nov
 2022 02:40:45 -0800
Message-ID: <d7b6b005-91eb-f2aa-62e5-1f94e5253bfd@quicinc.com>
Date:   Thu, 17 Nov 2022 16:10:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] remoteproc: qcom_q6v5_pas: detach power domains on
 remove
Content-Language: en-US
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
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221111115414.153961-2-luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0qold46gCugs6wXMEOtR776Bjm6btrIN
X-Proofpoint-ORIG-GUID: 0qold46gCugs6wXMEOtR776Bjm6btrIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/2022 5:24 PM, Luca Weiss wrote:
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

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
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
