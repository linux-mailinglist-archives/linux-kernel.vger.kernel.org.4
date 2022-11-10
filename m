Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC220623D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiKJIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiKJIeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:34:37 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AED209A9;
        Thu, 10 Nov 2022 00:34:34 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AA6pbfA032176;
        Thu, 10 Nov 2022 09:34:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=hX7HLbbo5rodekMp9+mhuon+7a6goJzIM+07WNoX0AQ=;
 b=ZUjySMDmxXOd8lgpHpKQ2nni1ffHstq3crZa+10Xi/oXT8n+HoQ5ixcz+GtQIN431a66
 yvGngTIPvAQZwBzIfleXURdnEJGjxj+z/Pk/GtS3nMWizH0kVorblRA2XPjhktICL0oY
 DoaXdhEs7W8RSJHLSbQwn2f103/sg7dToiRUtpVicU6m9T5+E/9fmXTGPeteS2UEglnc
 3g5oKC1QeXZJGbhGZL6s7Zbwwi7qiE2DgDEVa8hYCo1Li1bCr70sOwWMOb054I1dDLMS
 /ZP//0+J0kBxqKQg82yu1XmHmaHhiEaim3arWe+dyk2KkpovHh+L3+NWaVRvCXo4XuAh sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3krvdb8s7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 09:34:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 651D410003B;
        Thu, 10 Nov 2022 09:34:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5D2262138C9;
        Thu, 10 Nov 2022 09:34:23 +0100 (CET)
Received: from [10.211.0.90] (10.211.0.90) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Thu, 10 Nov
 2022 09:34:23 +0100
Message-ID: <571319ab-bdc2-a884-f462-603e213c13fb@foss.st.com>
Date:   Thu, 10 Nov 2022 09:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH][next] media: i2c: st-vgxy61: Fix spelling mistake
 "substraction" -> "subtraction"
To:     Colin Ian King <colin.i.king@gmail.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221109150544.274795-1-colin.i.king@gmail.com>
Content-Language: en-US
From:   Benjamin MUGNIER <benjamin.mugnier@foss.st.com>
In-Reply-To: <20221109150544.274795-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.211.0.90]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thank you for your patch.

On 11/9/22 16:05, Colin Ian King wrote:
> There are a couple of spelling mistakes in a literal string and in the
> documentation. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

> ---
>  Documentation/userspace-api/media/drivers/st-vgxy61.rst | 2 +-
>  drivers/media/i2c/st-vgxy61.c                           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/drivers/st-vgxy61.rst b/Documentation/userspace-api/media/drivers/st-vgxy61.rst
> index 213b884dcfa6..7fb5b4f60db7 100644
> --- a/Documentation/userspace-api/media/drivers/st-vgxy61.rst
> +++ b/Documentation/userspace-api/media/drivers/st-vgxy61.rst
> @@ -17,7 +17,7 @@ The ST VGXY61 driver implements the following controls:
>  
>      * - HDR linearize
>        - The merger outputs a long exposure capture as long as it is not saturated.
> -    * - HDR substraction
> +    * - HDR subtraction
>        - This involves subtracting the short exposure frame from the long exposure frame.
>      * - "No HDR"
>        - This mode is used for standard dynamic range (SDR) exposures.
> diff --git a/drivers/media/i2c/st-vgxy61.c b/drivers/media/i2c/st-vgxy61.c
> index dfbf25338160..e72fc3a8a54c 100644
> --- a/drivers/media/i2c/st-vgxy61.c
> +++ b/drivers/media/i2c/st-vgxy61.c
> @@ -197,7 +197,7 @@ static const char * const vgxy61_test_pattern_menu[] = {
>  
>  static const char * const vgxy61_hdr_mode_menu[] = {
>  	"HDR linearize",
> -	"HDR substraction",
> +	"HDR subtraction",
>  	"No HDR",
>  };
>  

-- 
Regards,

Benjamin
