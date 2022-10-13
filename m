Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336615FD62E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJMI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJMI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:27:58 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68045B97A1;
        Thu, 13 Oct 2022 01:27:55 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29D3rG6q019788;
        Thu, 13 Oct 2022 10:27:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=jbP99aAj4yZmJy7mMcp948NSkY8bJOqMeU8NBPr4IN4=;
 b=oXSKlnGJHZnXz/6wu1BrYqqQp0GrUyoZv6CcyBeVPgvUB+vqfP8gGlheE1qeLpS3ennh
 UoyEpyxdtg8ZLoISa8ynhz3T2bAnkbwA6Y1DZAcJZitTZEdm0xn0ZE4ci3YY/4d1lFuL
 lym1UiQfX+ASSazGt92AfbPR3cK4yvKZlzTcMt6zRF+/09Ko9O1PdLOZopHS+EKLviNG
 8ERCvYZn0/dZ42HD61N3tjyAWEHBp3IzcuB2JTPM7MgJO3RUrmv4cskqrfJX1wJxtgmI
 xVXcThjjgluHBBi+UZhHvySMW9jk/qhqxKu1UdxNhStKbP9yghE5ajH3C1HDCj7dqAXo Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k5v4my3fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 10:27:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5016710002A;
        Thu, 13 Oct 2022 10:27:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4A8D7215152;
        Thu, 13 Oct 2022 10:27:40 +0200 (CEST)
Received: from [10.201.22.54] (10.75.127.48) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 10:27:39 +0200
Message-ID: <154222f3-39e4-a545-d820-fc3d6a8b2ab6@foss.st.com>
Date:   Thu, 13 Oct 2022 10:27:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] remoteproc: core: Auto select rproc-virtio device id
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shengjiu.wang@gmail.com>
References: <1665628087-20829-1-git-send-email-shengjiu.wang@nxp.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1665628087-20829-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_06,2022-10-12_01,2022-06-22_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengju,

On 10/13/22 04:28, Shengjiu Wang wrote:
> With multiple remoteproc device, there will below error:
> 
> sysfs: cannot create duplicate filename '/bus/platform/devices/rproc-virtio.0'

Good catch! 
Previously the device created was 
/sys/class/remoteproc/remoteproc0/remoteproc0#vdev0buffer/

So with your fix it become something like 
/bus/platform/devices/rproc-virtio.2.auto


This works fine on my platform, also when creating two virtio devices for one
remoteproc device.
 
Just a remark, could be nice to indicate in the commit message the result of
your patch, means the name of the files created.

With that:
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Thanks,
Arnaud


> 
> The rvdev_data.index is duplicate, that cause issue, so
> need to use the PLATFORM_DEVID_AUTO instead.
> 
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 8768cb64f560..03a26498e879 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -509,7 +509,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  	rvdev_data.rsc_offset = offset;
>  	rvdev_data.rsc = rsc;
>  
> -	pdev = platform_device_register_data(dev, "rproc-virtio", rvdev_data.index, &rvdev_data,
> +	pdev = platform_device_register_data(dev, "rproc-virtio", PLATFORM_DEVID_AUTO, &rvdev_data,
>  					     sizeof(rvdev_data));
>  	if (IS_ERR(pdev)) {
>  		dev_err(dev, "failed to create rproc-virtio device\n");
