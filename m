Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D87176A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjEaGH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjEaGHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:07:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CF1129;
        Tue, 30 May 2023 23:07:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V5P01p023033;
        Wed, 31 May 2023 06:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FTiZdaopfJdGzY07inwqLy1ZZKpb6Zy7sXOJXUmOmHs=;
 b=l9ntD0s6nbLi7rq0rvQ5xnf3nlw3EPreiMI6VLWg181Kml40k/cEleVpfRQckKuobWUQ
 kilav6+1dYcDccoB0FF3iKeGIDWno7bfy2FEQm60loE2RjVFtJ0JOm1fwFMEVGy1NQxy
 mTEwnoMiI4tS8UV7XoK2Pl5ACbX3K0WcPtNbKsTsjqL5GxzScZO1G+MjgH0+lAqF0djI
 7WS8GB3U1Ot6y0+3gD5a4+gzudVLy+7MsdL4KSJZCzO5z/r3p/fDeq18pSkqBSmVzeNN
 DffEJteoWzKf2bpNSW7qji+rg/pgsWX67+tFFPRUML+7y9a1UAs/cDgH1ghuFrH4h6Bc 2A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw8v4txv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 06:06:58 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V66wBJ022203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 06:06:58 GMT
Received: from [10.252.212.215] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 30 May
 2023 23:06:55 -0700
Message-ID: <38a627a2-040d-23e2-5637-32f199d0fc31@quicinc.com>
Date:   Wed, 31 May 2023 11:36:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] media: venus: firmware: Use of_reserved_mem_lookup()
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zQnBR6ZOqs64iW8B-HLx_LuVdaI35n8H
X-Proofpoint-GUID: zQnBR6ZOqs64iW8B-HLx_LuVdaI35n8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_02,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310053
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On 5/29/2023 11:46 PM, Stephan Gerhold wrote:
> Reserved memory can be either looked up using the generic function
> of_address_to_resource() or using the special of_reserved_mem_lookup().
> The latter has the advantage that it ensures that the referenced memory
> region was really reserved and is not e.g. status = "disabled".
> 
> of_reserved_mem also supports allocating reserved memory dynamically at
> boot time. This works only when using of_reserved_mem_lookup() since
> there won't be a fixed address in the device tree.
IIUC, this would avoid precomputing the hard range for different firmware
regions and also make it more flexible to adjust the sizes, if anyone wants a
bigger size later.
Incase a specific firmware needs a dedicate start address, do we have an option
to specify the same ?

Thanks,
Vikash
> Switch the code to use of_reserved_mem_lookup(). There is no functional
> difference for static reserved memory allocations.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> See e.g. [1] for an example of dynamically allocated reserved memory.
> (This patch does *not* depend on [1] and is useful without as well...)
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index cfb11c551167..2e7ffdaff7b2 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -10,6 +10,7 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
> @@ -82,9 +83,9 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  			 phys_addr_t *mem_phys, size_t *mem_size)
>  {
>  	const struct firmware *mdt;
> +	struct reserved_mem *rmem;
>  	struct device_node *node;
>  	struct device *dev;
> -	struct resource r;
>  	ssize_t fw_size;
>  	void *mem_va;
>  	int ret;
> @@ -99,13 +100,16 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  		return -EINVAL;
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> -	if (ret)
> -		goto err_put_node;
> +	rmem = of_reserved_mem_lookup(node);
> +	of_node_put(node);
> +	if (!rmem) {
> +		dev_err(dev, "failed to lookup reserved memory-region\n");
> +		return -EINVAL;
> +	}
>  
>  	ret = request_firmware(&mdt, fwname, dev);
>  	if (ret < 0)
> -		goto err_put_node;
> +		return ret;
>  
>  	fw_size = qcom_mdt_get_size(mdt);
>  	if (fw_size < 0) {
> @@ -113,17 +117,17 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  		goto err_release_fw;
>  	}
>  
> -	*mem_phys = r.start;
> -	*mem_size = resource_size(&r);
> +	*mem_phys = rmem->base;
> +	*mem_size = rmem->size;
>  
>  	if (*mem_size < fw_size || fw_size > VENUS_FW_MEM_SIZE) {
>  		ret = -EINVAL;
>  		goto err_release_fw;
>  	}
>  
> -	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
> +	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
>  	if (!mem_va) {
> -		dev_err(dev, "unable to map memory region: %pR\n", &r);
> +		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
>  		ret = -ENOMEM;
>  		goto err_release_fw;
>  	}
> @@ -138,8 +142,6 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  	memunmap(mem_va);
>  err_release_fw:
>  	release_firmware(mdt);
> -err_put_node:
> -	of_node_put(node);
>  	return ret;
>  }
>  
> 
> ---
> base-commit: 9f9f8ca6f012d25428f8605cb36369a449db8508
> change-id: 20230529-venus-of-rmem-f649885114fd
> 
> Best regards,
