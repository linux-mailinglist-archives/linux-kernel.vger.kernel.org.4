Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1497F716203
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjE3NdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjE3NdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:33:18 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77081A7;
        Tue, 30 May 2023 06:33:17 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UC17fS018195;
        Tue, 30 May 2023 15:32:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=/vLDIut8DJG9/eudnX+eCqcgRJdHJKKJcvNGCV6EgSY=;
 b=IF0c4aWTvw6kQpygbI7aSAGl8lG61Uovd2rE+eGYHgBEZ+23cf9L7Evwmp3T+Dt725NO
 GuxtfWC10wi93QsbClbeL/M2w7SaYvHlf4ca9FOTI6VS0zA17pXAaIyJRXG1VmxVgzxr
 2c4ECcQ2qEJ3XeqksAgYT+xjSvu57FRLKnZPJOPi80rFJlJ1/EZ9dRDZfVIHLFyfpFaK
 iQkG4n7rYBcKgO7SoQNdtLmKDxDaCX14s+TbEY7LmqfmOwXnFV28Wn3n8L8/4l/3ALb1
 BVvARjsvG+3irUzOC0k7/4NcQNZWPUZoPrY1P7LFVTzDRIzz8aQslhNglEd3i4WwYr6F kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qwdm5j20a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 15:32:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E713100038;
        Tue, 30 May 2023 15:32:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DAECD228A2D;
        Tue, 30 May 2023 15:32:56 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 30 May
 2023 15:32:55 +0200
Message-ID: <78a7cbcd-2fe5-0533-857c-e50f89aa6dd5@foss.st.com>
Date:   Tue, 30 May 2023 15:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/11] Add STM32MP25 support
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <20230529162034.20481-1-alexandre.torgue@foss.st.com>
 <CACRpkdboHeg-=thHvZrQXcx_HnecwmuBJskJTPjxFOB9z9R0gw@mail.gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <CACRpkdboHeg-=thHvZrQXcx_HnecwmuBJskJTPjxFOB9z9R0gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

On 5/30/23 14:39, Linus Walleij wrote:
> On Mon, May 29, 2023 at 6:20 PM Alexandre Torgue
> <alexandre.torgue@foss.st.com> wrote:
> 
>> Alexandre Torgue (10):
>>    dt-bindings: pinctrl: stm32: support for stm32mp257 and additional
>>      packages
>>    pinctrl: stm32: add stm32mp257 pinctrl support
> 
> Can patch 1 & 2 be applied to the pinctrl tree separately?

Yes please. I'll take others directly in my platform tree.

Thanks
Alex

> Yours,
> Linus Walleij

