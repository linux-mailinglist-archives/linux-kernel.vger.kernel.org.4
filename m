Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE708622E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiKIOv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKIOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:51:24 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7591C901;
        Wed,  9 Nov 2022 06:51:23 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9CnK6k025229;
        Wed, 9 Nov 2022 15:50:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5JtF3iJ2oXjNjIAbamTKE27XtiV1yY94Ah+QiBDWb3s=;
 b=etElwXAkt6kcqJIe2SltGS49ceP/WxapGbX4u3Ff81O2QqHa2suZ/WJRKX9FO7dj+2EG
 WwyePRFEabfKVWgx4H+AbcoWAywb6BCYs5ZbBSJQRQVfFyWsKw5Xp1gbdqEkHAWZqO4n
 lok22cczp0S23kA54WfqwmQ2/aPIKgS8L4VTE7qxQkpZ3ns6ejnBLtumHU7ZJDdT2PTa
 R78DNT7Nxovnv+sJyvJizEASGL3CgqIYak5Q2VVvbgAYRBsvRCoOEOnYVvj8AhCBa5KL
 2CgnVL1oassLIUMmIpEKGrqNspCCA5vTzKRmLpglyuE0fWIVG9E0cfugdaW3S0J6InH2 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kpyjqhquy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 15:50:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5240A10002A;
        Wed,  9 Nov 2022 15:50:37 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D9E6D21FEA5;
        Wed,  9 Nov 2022 15:50:37 +0100 (CET)
Received: from [10.252.18.33] (10.252.18.33) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Wed, 9 Nov
 2022 15:50:37 +0100
Message-ID: <f0aee291-ce44-400b-be3a-dfe38c62e450@foss.st.com>
Date:   Wed, 9 Nov 2022 15:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] Documentation: media: Add ST VGXY61 driver documentation
 to userspace API table of contents
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-next@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221109100147.218947-1-bagasdotme@gmail.com>
Content-Language: en-US
From:   Benjamin MUGNIER <benjamin.mugnier@foss.st.com>
In-Reply-To: <20221109100147.218947-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.33]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

I already submitted this here:
https://www.spinics.net/lists/linux-media/msg221143.html

Thanks.

On 11/9/22 11:01, Bagas Sanjaya wrote:
> Sphinx reported missing toctree entry for ST VGXY61 documentation:
> 
> Documentation/userspace-api/media/drivers/st-vgxy61.rst: WARNING: document isn't included in any toctree
> 
> Add the entry to fix the warning.
> 
> Link: https://lore.kernel.org/linux-next/20221109162013.293250a2@canb.auug.org.au/
> Fixes: 2378be892b6ff5 ("media: Documentation: Add ST VGXY61 driver documentation")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/userspace-api/media/drivers/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
> index 32f82aed47d915..0f758c8d45235a 100644
> --- a/Documentation/userspace-api/media/drivers/index.rst
> +++ b/Documentation/userspace-api/media/drivers/index.rst
> @@ -38,4 +38,5 @@ For more details see the file COPYING in the source distribution of Linux.
>  	max2175
>  	meye-uapi
>  	omap3isp-uapi
> +	st-vgxy61
>  	uvcvideo
> 
> base-commit: 1e284ea984d3705e042b6b07469a66f1d43371e3

-- 
Regards,

Benjamin
