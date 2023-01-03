Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F4565BD60
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbjACJqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjACJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:45:59 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931FBB0C;
        Tue,  3 Jan 2023 01:45:58 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3039Rttf020920;
        Tue, 3 Jan 2023 10:45:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=mwrG17PW7SqKB89a6ELsvyEm8ye3mmzw4STYyVEeDSU=;
 b=wBAUZhnv0+6UZSKWtf7q+8ZrcsoP9h1Su+GAt2CCsi2qMxxrvHwI96hpveBacWFvLt8z
 M5VGoQN9qR4mR4QpE/r+hZqhPymoFewPAMbgZc0RF/huPUPPH9JARsNTyyIph+sEFYY6
 A7zwU0toRQwlrrGOGCF5hD78vhwrCoZrA/yjOxx8dfmqSLY23Balt56NcAN5EWulNUMa
 LuTH+AYSSPzfmDwJkh+3g9wFOFsyuiLCzXFecKKenpuHUsDkbDEucb/gvZ/wtjLbBaPC
 ZIlq4cY8HTNEADoYrThHWwe13qRF0hL6jfmmuPBFSiU+DNqNH2UwTwXBkwLgRkMslSIo Qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtbcpv7ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 10:45:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4613B10002A;
        Tue,  3 Jan 2023 10:45:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36D0721514F;
        Tue,  3 Jan 2023 10:45:23 +0100 (CET)
Received: from [10.201.21.177] (10.201.21.177) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 3 Jan
 2023 10:45:22 +0100
Message-ID: <98aa92e9-9ac0-0fe4-a140-ac478e261f94@foss.st.com>
Date:   Tue, 3 Jan 2023 10:45:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 0/7] Introduce STM32 system bus
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <Oleksii_Moisieiev@epam.com>, <linus.walleij@linaro.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <devicetree@vger.kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>
References: <20221222100504.68247-1-gatien.chevallier@foss.st.com>
 <Y6SIOpsxNdezKCTc@kroah.com>
Content-Language: en-US
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <Y6SIOpsxNdezKCTc@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.177]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2023-01-03_01,2022-06-22_01
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

I've put the "RFC" tag on the the patch set as it is based on bindings 
that are currently under review. It has been submitted with the idea to 
support the bindings proposed by Oleksii. Apart from this and the 
comments made by Krzysztof, there is indeed no more "work" planned on 
this change.

Should the "RFC" tag be omitted for the next version?

Best regards,
Gatien

On 12/22/22 17:39, Greg KH wrote:
> On Thu, Dec 22, 2022 at 11:04:57AM +0100, Gatien Chevallier wrote:
>> Document STM32 System Bus. This bus is intended to control firewall
>> access for the peripherals connected to it.
> 
> Why is this an "RFC"?  That usually means "I have more work to do on it,
> but I'll send it out now anyway".  What work is left?
> 
> And for most code, I know I don't review "RFC" changes as there are too
> many "real" patches being submitted where people think their code is
> ready to be merged.  Other reviewers might think otherwise, but be aware
> of this...
> 
> thanks,
> 
> greg k-h
