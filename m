Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550D6A06C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjBWKxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBWKxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:53:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BB452DD8;
        Thu, 23 Feb 2023 02:52:47 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NA129N011643;
        Thu, 23 Feb 2023 10:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9RtgpJu54slfX0JMTbbQkMovmg0D++50tTf8IWA0C08=;
 b=LwRRgaN8B3sh7qymZkrsX+ItdZFDNAhy4qrR07c3ANwOYOzwqL7YKo5W0W6x+bUc+Dex
 siYi0XieoVojDtpI/Zv9XD2PNCit61B2bVVT1Ar92Lruf/o2gYrHSrXricPelIssrfg1
 2OUSo8hk4LnrKhp2srWv2RxquudoiEdHIBLbijEErHSCmiCJaYqPuBA1+FcTQXSlWIC4
 pFJX3GvVCYIK/XQoD/I76pBOzUAHxazt3eyG586q8dpiY9UvK47ixrU4BHp7FTC9Jwvz
 fOobsUvwW6GPt/HCxhl+HnWUgXIaWFtRKUd6986BkrQ8yepN056CK3NcnwUZaLI8x8al hQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwy8m11hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:52:18 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NAqIMr017618
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:52:18 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 02:52:12 -0800
Message-ID: <27d2a4c4-2a4c-7fc6-4afb-cf5792e91d85@quicinc.com>
Date:   Thu, 23 Feb 2023 18:52:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 5/7] scsi: ufs: core: Remove redundant check
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <quic_ziqichen@quicinc.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <alice.chao@mediatek.com>,
        <naomi.chu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <cc.chou@mediatek.com>, <eddie.huang@mediatek.com>,
        <mason.zhang@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <quic_cang@quicinc.com>,
        <quic_asutoshd@quicinc.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
 <20230222030427.957-6-powen.kao@mediatek.com>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <20230222030427.957-6-powen.kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kJ6tIHn7zTNWGPlxe8BKBPgyRbxF6M0C
X-Proofpoint-ORIG-GUID: kJ6tIHn7zTNWGPlxe8BKBPgyRbxF6M0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_06,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230092
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/2023 11:04 AM, Po-Wen Kao wrote:
> is_mcq_supported() already check on use_mcq_mode.
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
reviewed-by:  Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index a15a5a78160c..21e3bf5d8f08 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8548,7 +8548,7 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
>   			hba->scsi_host_added = true;
>   		}
>   		/* MCQ may be disabled if ufshcd_alloc_mcq() fails */
> -		if (is_mcq_supported(hba) && use_mcq_mode)
> +		if (is_mcq_supported(hba))
>   			ufshcd_config_mcq(hba);
>   	}
>   
