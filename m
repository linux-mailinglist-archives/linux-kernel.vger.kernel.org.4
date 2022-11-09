Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9A3622E65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiKIOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiKIOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:51:29 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF11C429;
        Wed,  9 Nov 2022 06:51:27 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9DAnuW006374;
        Wed, 9 Nov 2022 15:50:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=79OH1DwyAqr1kS6NrKlpXjyyYczdpVQlD8FQaAu+5bY=;
 b=kIsqgzsb/ZUpi2bwaS5X1nOfXp/DOweJsOFlOfnOED7vJLIrRAECVb4Zyoq8ZS/G+xTO
 Id/wNBoNtoMebTmKLYVT64lg7YjxaOv2tUAiNbrsaeZWq0OiQRYZ2im0fU7kOl/b9Rt0
 e+mSpdiCk0v+Wg3oH9LpkTjyV8Ppc4OWfwYkNEbmY/AivrC3N6i9o24KBa3xchawtQug
 bhGrCvEvMPERTr2SG/Q+P+hZhvYYjnFeS0tHyp24V15jKvW8yjJbFvOB9l8Dw6EJxXLX
 FQjk0505TjIXhphswga7RugT04VJV1yYBe+KEVtpYF1es2gvpHat2C8IkDqSx7PnXFYE zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kq0fu8g72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 15:50:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 46D6B10002A;
        Wed,  9 Nov 2022 15:50:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42D3121FEA5;
        Wed,  9 Nov 2022 15:50:45 +0100 (CET)
Received: from [10.252.18.33] (10.252.18.33) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Wed, 9 Nov
 2022 15:50:44 +0100
Message-ID: <cf3de975-afe6-6e02-0bbe-ccc50f3828a8@foss.st.com>
Date:   Wed, 9 Nov 2022 15:50:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: build warning after merge of the v4l-dvb-next tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221109162013.293250a2@canb.auug.org.au>
From:   Benjamin MUGNIER <benjamin.mugnier@foss.st.com>
In-Reply-To: <20221109162013.293250a2@canb.auug.org.au>
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

Hi Stephen,

Yes, I apologize for this.
This is fixed by this patch:
https://www.spinics.net/lists/linux-media/msg221143.

On 11/9/22 06:20, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the v4l-dvb-next tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/userspace-api/media/drivers/st-vgxy61.rst: WARNING: document isn't included in any toctree
> 
> Introduced by commit
> 
>   2378be892b6f ("media: Documentation: Add ST VGXY61 driver documentation")
> 

-- 
Regards,

Benjamin
