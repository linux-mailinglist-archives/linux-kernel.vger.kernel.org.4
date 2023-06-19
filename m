Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58DE734C64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjFSHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFSHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:30:04 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DB6121;
        Mon, 19 Jun 2023 00:30:02 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J54gIU016274;
        Mon, 19 Jun 2023 09:29:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=WQGm1bnbcsMFKMHxBrg1wg70iXAEPal+ehfuwX2lwpw=;
 b=Nq2GjWQcY1art4ot8AmwMxDr+4p5P0fpvZtFS3RDbb/GO9bPhhBbHtRRolv09aw++2Yc
 FW9qyW2yngBDFfnKpJywcK7NjEQ3/fZ+qAAbQ1g9dFXLb4lHubXy8/+57cnJGr6bKIUP
 ZmDIVwIL3TrEQHpiyB5m4VXzKfZ3mqmM0F70xwBYb/69au+F48i9vjSVJ8spYu0a72MX
 YvemOYEFphDb6oiKiOG7m8lOR183KsXk5vR/S2jzRCjLszmzXCoF2l684DscwCzL3MT/
 uEFmW+cdAMHDxK7dJmjeNCXnwV94zN0365jx64W5d0/b7uX2tNQgkUXjh4na+gdcX1ao 8Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ragj9rqej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 09:29:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 93F0610002A;
        Mon, 19 Jun 2023 09:29:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F6462138E6;
        Mon, 19 Jun 2023 09:29:19 +0200 (CEST)
Received: from [10.201.21.210] (10.201.21.210) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 19 Jun
 2023 09:29:17 +0200
Message-ID: <78f8bd3d-c4a7-7383-441d-69cd8f5c30fb@foss.st.com>
Date:   Mon, 19 Jun 2023 09:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2
 compatible
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230615092001.1213132-1-yann.gautier@foss.st.com>
 <20230615092001.1213132-2-yann.gautier@foss.st.com>
 <CAPDyKFqJsqmNzeRg8hj55yUEMSycOWsmKVKsMWk4Qu7Y8_dNzg@mail.gmail.com>
 <3b6781cb-8f59-e70a-bcf8-9fb48fa47cbf@foss.st.com>
 <266de9f5-826a-c1bf-be8d-11f5e27c87dc@foss.st.com>
 <CACRpkdZLtCwPQsPw_Lp3Ppw2ed6gOo+-82_y2WPVJ_oZUHbLoQ@mail.gmail.com>
Content-Language: en-US
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CACRpkdZLtCwPQsPw_Lp3Ppw2ed6gOo+-82_y2WPVJ_oZUHbLoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_04,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 20:51, Linus Walleij wrote:
> On Thu, Jun 15, 2023 at 5:19 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
> 
>>>         - description: Entry for STMicroelectronics variant of PL18x.
>>>             This dedicated compatible is used by bootloaders.
> (...)
>>>         - description: Entry for STMicroelectronics variant of PL18x for
>>>             STM32MP25. This dedicated compatible is used by bootloaders.
> (...)
>>> Should I remove (or adapt) both descriptions?
>>>
>>>
>>
>> At the time the patch was done it was really just used by bootloaders.
>> But as it is now used in the driver for delay block, I should remove the
>> second sentence.
> 
> Remove both.
> 
> After "This dedicated compatible is used by bootloaders" there is
> an implicit "in the SDK provided by ST Microelectronics", and that
> is of no concern for DT bindings, which are (well, in theory) used by
> e.g. BSD or other operating systems and who knows what they will
> use and not, we don't put Linux specifics in there, neither Boot
> loader specifics nor ST SDK specifics.
> 
> At least that is the little bureaucratic ambition we have.
> 
> Yours,
> Linus Walleij

Hi,

Thanks for all the reviews.
I'll update this patch in the v2, removing bootloader line and using enum.

Ulf, should I send the new series now, or do you prefer to review the 
whole series before?


Yann
