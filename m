Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0376D628117
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiKNNRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiKNNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:17:07 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417BADE2;
        Mon, 14 Nov 2022 05:17:06 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE9XjP5004653;
        Mon, 14 Nov 2022 14:16:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=12xhdvhfGdlmnPHqB8ap3RlA4mK9WjDTkrMLlKf/Ybo=;
 b=vu4NHQO24koGmLk5G/i80+OITsx6HaHWxcGzEIS8lE8Q+dlkQPo2gk4Axk1Xs721xOhz
 5QvNI72uJVB3iCKlgpOW3i+DxPdLpGFddF8x6s/MMCp2yz1wUkdlttJ3mynPNVSc6GLM
 c7fBQRH8DhvMoXpDKrj35Joe5sObLDJONe2xXEM71RAN1Kfq+R9tmDXrhAwAttzjyLYo
 JD/rIikqa6+GfRLYO9ai+XWbKIuaMKo8fKHjMqPuNHDr6ME0Lb0lL8tULkj3WZdRYsew
 5+y3egJBn1RmBLUG/7md1uCWiivkfVnLEAxVWxDcA9ucWFtyRDRF/CFDazF6DU1tEeVb Mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kudxqk1ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:16:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 223BF10002A;
        Mon, 14 Nov 2022 14:16:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1B90E21B536;
        Mon, 14 Nov 2022 14:16:31 +0100 (CET)
Received: from [10.129.167.233] (10.129.167.233) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Mon, 14 Nov
 2022 14:16:30 +0100
Message-ID: <d651b9bf-dbf5-8737-175f-454335aaef2b@foss.st.com>
Date:   Mon, 14 Nov 2022 14:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Coverity: vgxy61_detect(): Control flow issues
Content-Language: en-US
To:     coverity-bot <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>, <linux-media@vger.kernel.org>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        <linux-next@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <202211100828.FEDCDE7@keescook>
From:   Benjamin MUGNIER <benjamin.mugnier@foss.st.com>
In-Reply-To: <202211100828.FEDCDE7@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.129.167.233]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for your report.

This issue, and all other reported control flow issues, are fixed in the
following patch: 'media: i2c: st-vgxy61: Fix smatch warnings'.
https://lore.kernel.org/linux-media/20221110134102.64990-1-benjamin.mugnier@foss.st.com/

On 11/10/22 17:28, coverity-bot wrote:
> Hello!
> 
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221110 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
> 
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
> 
>   Thu Oct 27 14:37:38 2022 +0300
>     153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")
> 
> Coverity reported the following:
> 
> *** CID 1527257:  Control flow issues  (NO_EFFECT)
> drivers/media/i2c/st-vgxy61.c:1679 in vgxy61_detect()
> 1673     	struct i2c_client *client = sensor->i2c_client;
> 1674     	u16 id = 0;
> 1675     	int ret;
> 1676     	u8 st;
> 1677
> 1678     	id = vgxy61_read_reg(sensor, VGXY61_REG_MODEL_ID);
> vvv     CID 1527257:  Control flow issues  (NO_EFFECT)
> vvv     This less-than-zero comparison of an unsigned value is never true. "id < 0".
> 1679     	if (id < 0)
> 1680     		return id;
> 1681     	if (id != VG5661_MODEL_ID && id != VG5761_MODEL_ID) {
> 1682     		dev_warn(&client->dev, "Unsupported sensor id %x\n", id);
> 1683     		return -ENODEV;
> 1684     	}
> 
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527257 ("Control flow issues")
> Fixes: 153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")
> 
> Thanks for your attention!
> 

-- 
Regards,

Benjamin
