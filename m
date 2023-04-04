Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E166D619C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjDDMvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjDDMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:51:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2041BC7;
        Tue,  4 Apr 2023 05:51:47 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334C4sME008549;
        Tue, 4 Apr 2023 12:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=S56gB3YQkJOt44DZlf+zjHqDJe5ozPp+Loy1PCk6f9Q=;
 b=AVwtTz4nDRVh58sfp30UTInPgn4QThvPODmw3V1GsV36TOiV0vAnCKcfqd8rwyfbi3Bv
 3aJfRNZTc6mtWwJDQVh+0y+ApvlfDeIDyOojIi0kWtKvYsNSi9qvhqtGxKMeh00LgJ6x
 F8pOf7jdIRAOzJ1lSk3U2OmThlW3Pe0wv6ihlIT4mX1DspapLKRqjbMVGlwToNtOUQns
 ow5w+ozQVK/PqTPGr43l0zngi8zQz78iGWOsND5NiIGg/Rtq4grQsGHgksjJRtsTlHdw
 js6VeIWF5WK7JYYBDX20xhQ6rlYpn97ibecYQ75XcPDmhs0gWGEeI/d1VquR2XcwFMwh 4w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqwdrugdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 12:51:27 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 334CpQas018881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 12:51:26 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 4 Apr 2023
 05:51:23 -0700
Message-ID: <676dfbfb-f1ee-b02f-0383-9a84a91634af@quicinc.com>
Date:   Tue, 4 Apr 2023 18:21:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] remoteproc: pru: remove always true check positive
 unsigned value
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Dan Carpenter <error27@gmail.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20230404-pru-always-true-v1-1-b1b55eeff188@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230404-pru-always-true-v1-1-b1b55eeff188@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d1U18E7dXEJCaMRXgYCwRKKITKsc2Csj
X-Proofpoint-ORIG-GUID: d1U18E7dXEJCaMRXgYCwRKKITKsc2Csj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_04,2023-04-04_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=936 suspectscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040119
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2023 6:14 PM, Simon Horman wrote:
> In both cases they type of da is u32. And PRU_PDRAM_DA is 0.
> So the check da >= PRU_PDRAM_DA is always true and can be removed.
> 
> Flagged by Smatch:
> 
>   drivers/remoteproc/pru_rproc.c:660 pru_d_da_to_va() warn: always true condition '(da >= 0) => (0-u32max >= 0)'
>   drivers/remoteproc/pru_rproc.c:709 pru_i_da_to_va() warn: always true condition '(da >= 0) => (0-u32max >= 0)'
> 
> No functional changes intended.
> Compile tested only.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://www.spinics.net/lists/kernel/msg4025983.html
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/remoteproc/pru_rproc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index b76db7fa693d..095f66130f48 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -657,7 +657,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>   		swap(dram0, dram1);
>   	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
>   
> -	if (da >= PRU_PDRAM_DA && da + len <= PRU_PDRAM_DA + dram0.size) {
> +	if (da + len <= PRU_PDRAM_DA + dram0.size) {
>   		offset = da - PRU_PDRAM_DA;
>   		va = (__force void *)(dram0.va + offset);
>   	} else if (da >= PRU_SDRAM_DA &&
> @@ -706,8 +706,7 @@ static void *pru_i_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>   	 */
>   	da &= 0xfffff;
>   
> -	if (da >= PRU_IRAM_DA &&
> -	    da + len <= PRU_IRAM_DA + pru->mem_regions[PRU_IOMEM_IRAM].size) {
> +	if (da + len <= PRU_IRAM_DA + pru->mem_regions[PRU_IOMEM_IRAM].size) {
>   		offset = da - PRU_IRAM_DA;
>   		va = (__force void *)(pru->mem_regions[PRU_IOMEM_IRAM].va +

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>


--Mukesh
>   				      offset);
> 
