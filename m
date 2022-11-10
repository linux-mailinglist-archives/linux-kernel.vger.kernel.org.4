Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA13624079
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKJK4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKJK4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:56:20 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0919968AE3;
        Thu, 10 Nov 2022 02:56:19 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AA6HkCI013421;
        Thu, 10 Nov 2022 04:56:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=LXs6Llt9Vh2y94hkOvFyZNRZkCDLDTeAl26usvz8sik=;
 b=dEqUJkKrLzJcGnwb4ICm6Ne5AYlc5scUFP7nrGGJ2IldUHssWoYBbufGxUhcO8Tphold
 nJPqO7KytDuNE22ys+Em8lTlDXqLRGTXbsbgwZrsg89oBWKGjFH7qQJZy/2rpxYx0Yaj
 9/bxaQSdIhYvE8X8rZI32n7x29vF36KGSuqpNvecJr/8T7jU8RL4vqJx61tGJXt5l2j3
 /Nw8G/2UyiCR8R6hHL/PumN+JTWpoZc8Eh0GtHwmZbL2GAxOrqmMohyIccwdxLYVc6r2
 2PfOGYLBK/HhI/V9L4VQZYwYAuOvCOUCQ04+qP4LaTG6MDvdxx78JICb6BVLpKwLyDkZ 8A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3knn81pse1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 04:56:06 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Thu, 10 Nov
 2022 04:55:57 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Thu, 10 Nov 2022 04:55:57 -0600
Received: from [198.90.251.111] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0A35D476;
        Thu, 10 Nov 2022 10:55:57 +0000 (UTC)
Message-ID: <43a6c801-e76f-7a03-af18-194cad14cbe0@opensource.cirrus.com>
Date:   Thu, 10 Nov 2022 10:55:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 05/12] pinctrl: cirrus: Add support for CS48L31/32/33
 codecs
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <broonie@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-6-rf@opensource.cirrus.com>
 <CACRpkdbY7W2rDZ4knkrRHBSTn7MKYV3LYh_r8Wkn1Hh=j+oL5A@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CACRpkdbY7W2rDZ4knkrRHBSTn7MKYV3LYh_r8Wkn1Hh=j+oL5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tZ_GrKpiLWxf-mqAUCAcqZgSBPBr6Fbv
X-Proofpoint-GUID: tZ_GrKpiLWxf-mqAUCAcqZgSBPBr6Fbv
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 10:02, Linus Walleij wrote:
> On Wed, Nov 9, 2022 at 5:53 PM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> 
>> From: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
>>
>> Codecs in this family have multiple digital I/O functions for audio,
>> DSP subsystem, GPIO and various special functions. All muxable pins
>> are selectable as either a GPIO or an alternate function.
>>
>> Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
>> Signed-off-by: Qi Zhou <qi.zhou@cirrus.com>
>> Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> This looks OK.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Does this patch have compile-time dependencies on the other
> patches or is it something I can just merge separately?
> 

It has compile-time dependencies on the MFD at least.
I should have said that in the cover letter.

> Yours,
> Linus Walleij
