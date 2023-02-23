Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8FE6A0630
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjBWK1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjBWK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:27:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73244E5D0;
        Thu, 23 Feb 2023 02:27:44 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N34GJR020922;
        Thu, 23 Feb 2023 10:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U0sgrD2VnCWAPk/z6hwGGg1MC9ws6rs2YQCV9DmicYw=;
 b=I6EuLrCmQ8grKQwN3TxlUhvnrD8XiAs5+2pHcqETe+Rk48qQsd7L0ObWCj/0Wki9rltN
 BLU+IvBJBNwgEVZpY2BeMQQ/W0fwloFuYVUGx+ytIyquGpTPbZqo3k77WjzyXe1sBC3U
 QBHmNHbgtYY7kD5YdLLw+VSy8z/H1F1/FwxBD/1UY1JHAnJw8qY7pt5PZxQiGeOFleJ/
 lgIkHTCQoUOefHnY3D9yM7Nz0J7c/Sx9eBtDjEEeAbdSdcZxte2E6JWVLRA+UZ5AMREJ
 vV4ZETX7LZG0yaAl+i1WJZMoAiK7WPZPURN1DBVIdoCKwzz+ax+bAeXMRcPtcB+IlOXH Aw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwybwh020-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:27:28 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NARS7a016451
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:27:28 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 02:27:22 -0800
Message-ID: <7dbb5b31-1113-8b7c-7391-c61e79df0a66@quicinc.com>
Date:   Thu, 23 Feb 2023 18:27:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/7] scsi: ufs: core: Rename symbols
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
        <jiajie.hao@mediatek.com>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
 <20230222030427.957-3-powen.kao@mediatek.com>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <20230222030427.957-3-powen.kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mNyQJHA8dZodSgVit1fh_RCBiB_N3ANg
X-Proofpoint-ORIG-GUID: mNyQJHA8dZodSgVit1fh_RCBiB_N3ANg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_06,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302230088
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/2023 11:04 AM, Po-Wen Kao wrote:
> To avoid confusion, sizeof_utp_transfer_cmd_desc() is renamed to
> ufshcd_get_ucd_size().
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
reviewed-by:  Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 2 +-
>   drivers/ufs/core/ufshcd.c  | 8 ++++----
>   include/ufs/ufshcd.h       | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 3a27fa4b0024..a39746b2a8be 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -265,7 +265,7 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
>   	addr = (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) -
>   		hba->ucdl_dma_addr;
>   
> -	return div_u64(addr, sizeof_utp_transfer_cmd_desc(hba));
> +	return div_u64(addr, ufshcd_get_ucd_size(hba));
>   }
>   
>   static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 3b3cf78d3b10..81c9f07ebfc8 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2823,10 +2823,10 @@ static void ufshcd_map_queues(struct Scsi_Host *shost)
>   static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
>   {
>   	struct utp_transfer_cmd_desc *cmd_descp = (void *)hba->ucdl_base_addr +
> -		i * sizeof_utp_transfer_cmd_desc(hba);
> +		i * ufshcd_get_ucd_size(hba);
>   	struct utp_transfer_req_desc *utrdlp = hba->utrdl_base_addr;
>   	dma_addr_t cmd_desc_element_addr = hba->ucdl_dma_addr +
> -		i * sizeof_utp_transfer_cmd_desc(hba);
> +		i * ufshcd_get_ucd_size(hba);
>   	u16 response_offset = offsetof(struct utp_transfer_cmd_desc,
>   				       response_upiu);
>   	u16 prdt_offset = offsetof(struct utp_transfer_cmd_desc, prd_table);
> @@ -3735,7 +3735,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>   	size_t utmrdl_size, utrdl_size, ucdl_size;
>   
>   	/* Allocate memory for UTP command descriptors */
> -	ucdl_size = sizeof_utp_transfer_cmd_desc(hba) * hba->nutrs;
> +	ucdl_size = ufshcd_get_ucd_size(hba) * hba->nutrs;
>   	hba->ucdl_base_addr = dmam_alloc_coherent(hba->dev,
>   						  ucdl_size,
>   						  &hba->ucdl_dma_addr,
> @@ -3835,7 +3835,7 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
>   	prdt_offset =
>   		offsetof(struct utp_transfer_cmd_desc, prd_table);
>   
> -	cmd_desc_size = sizeof_utp_transfer_cmd_desc(hba);
> +	cmd_desc_size = ufshcd_get_ucd_size(hba);
>   	cmd_desc_dma_addr = hba->ucdl_dma_addr;
>   
>   	for (i = 0; i < hba->nutrs; i++) {
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index ed9e3d5addb3..8f79cca449e1 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1136,7 +1136,7 @@ static inline size_t ufshcd_sg_entry_size(const struct ufs_hba *hba)
>   	({ (void)(hba); BUILD_BUG_ON(sg_entry_size != sizeof(struct ufshcd_sg_entry)); })
>   #endif
>   
> -static inline size_t sizeof_utp_transfer_cmd_desc(const struct ufs_hba *hba)
> +static inline size_t ufshcd_get_ucd_size(const struct ufs_hba *hba)
>   {
>   	return sizeof(struct utp_transfer_cmd_desc) + SG_ALL * ufshcd_sg_entry_size(hba);
>   }
