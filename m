Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74F73F7CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjF0IwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjF0IwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:52:09 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF110E2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:52:01 -0700 (PDT)
X-ASG-Debug-ID: 1687855917-086e231499081d0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id dxNmhWSMvw4jselI (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 27 Jun 2023 16:51:57 +0800 (CST)
X-Barracuda-Envelope-From: RunaGuo-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 27 Jun
 2023 16:51:57 +0800
Received: from [10.29.8.9] (10.29.8.9) by zxbjmbx1.zhaoxin.com (10.29.252.163)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 27 Jun
 2023 16:51:55 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Subject: Re: [PATCH] Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.9
To:     Damien Le Moal <dlemoal@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH] Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <LeoLiu@zhaoxin.com>,
        <RunaGuo@zhaoxin.com>
References: <1686901766-4928-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <ccabf88b-2e2c-876d-e47a-8d142e27d638@kernel.org>
 <70853f13-f74e-d9bb-89f7-4c804f1fa8a4@zhaoxin.com>
 <330d93ee-b4b6-2397-2b7c-eb4d99676f87@kernel.org>
 <b330e18d-4fd3-2649-aafd-4f941c111803@zhaoxin.com>
 <73aa50fd-2028-c492-59cd-b740a827e90c@kernel.org>
From:   Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
Message-ID: <017f61a6-dd4e-635b-be57-0954296b2db9@zhaoxin.com>
Date:   Tue, 27 Jun 2023 16:51:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <73aa50fd-2028-c492-59cd-b740a827e90c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.9]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1687855917
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4373
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.110596
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/27 16:02, Damien Le Moal wrote:
> On 6/27/23 16:17, Runa Guo-oc wrote:
>> On 2023/6/26 20:40, Damien Le Moal wrote:
>>> On 6/26/23 20:29, Runa Guo-oc wrote:
>>>> On 2023/6/16 16:34, Damien Le Moal wrote:
>>>>> On 6/16/23 16:49, Runa Guo-oc wrote:
>>>>>> [PATCH] ata:sata_zhaoxin: Add support for ZhaoXin Serial ATA
>>>>>
>>>>> Broken patch: the email subject is your SoB instead of the above line, which
>>>>> should not be part of the message (it should be the subject). Please reformat
>>>>> and resend.
>>>>>
>>>>
>>>> Okay.
>>>>
>>>>>>
>>>>>> Add ZhaoXin Serial ATA support for ZhaoXin CUPs.
>>>>>
>>>>> What is "ZhaoXin" ?
>>>>
>>>> Zhaoxin is a Chinese company that has mastered the core technology
>>>> of independent general-purpose processors and its system platform chips,
>>>> and is committed to providing users with efficient, compatible and secure
>>>> independent general-purpose processors, chipsets and other products.
>>>> for more information, you can visit here: https://www.zhaoxin.com/.
>>>
>>> A company marketing message is not very informative, technically speaking. What
>>> is this chipset and on what board/machine can it be found ? That is the more
>>> relevant information we need in this commit message.
>>>
>>
>> The reason why it is called Zhaoxin SATA is actually to express that it
>> applies
>> to all Zhaoxin support of its separate chipset/SOC, for example,
>> ZX-100S/ZX-200
>> chipsets.
> 
> That is fine. I do not need a reason for the name. what I would like to see is
> information about which product/board/soc this driver will be needed for. So
> something like the above is actually fine (may be a little more details if you
> have).
> 
For more details, take ZX-200 as an example to illustrate.
ZX-200 is an TSMC 40nm chip that integrates PCIE EP/RC and internal SB
controllers
(Serial ATA, Universal Serial Bus Controller, Network Interface
Controller, SPI, and so on).

And information about SATA is as follows:
•	Serial ATA
•	Compliant with Serial ATA Specification Revision 3.2
•	Support AHCI compliant with AHCI Specification 1.3.1
•	Internal SATA PHY supports 1.5G, 3G and 6G speed. Up to 4 ports
•	Support 4 SATA ports for one SATA bus master, primary channel and
secondary channel
•	Support Partial/Slumber/Auto Partial to Slumber/HIPM/DIPM, support DEVSLP
•	Support Esata/SATA Express
•	Support M.2
•	Support Listen Mode (both AHCI controller and legacy SATA controller )
•	Support MPS/DevSleep(AHCI controller only)
•	Do not support compatible mode
•	Do not support port multiplier
•	Do not support SGPIO
•	Do not support CPD
•	Support Hot-plug and MSI-X
•	Support FLR

>>
>>>>
>>>>> And what is "CUPs" ? Please spell this out.
>>>>>
>>>>
>>>> Yes, this is  a spelling error.
>>>>
>>>>>>
>>>>>> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
>>>>>> ---
>>>>>>  drivers/ata/Kconfig        |   8 +
>>>>>>  drivers/ata/Makefile       |   1 +
>>>>>>  drivers/ata/sata_zhaoxin.c | 384 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  3 files changed, 393 insertions(+)
>>>>>>  create mode 100644 drivers/ata/sata_zhaoxin.c
>>>>>>
>>>>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>>>>> index 42b51c9..ae327f3 100644
>>>>>> --- a/drivers/ata/Kconfig
>>>>>> +++ b/drivers/ata/Kconfig
>>>>>> @@ -553,6 +553,14 @@ config SATA_VITESSE
>>>>>>  
>>>>>>  	  If unsure, say N.
>>>>>>  
>>>>>> +config SATA_ZHAOXIN
>>>>>> +	tristate "ZhaoXin SATA support"
>>>
>>> Same here. If ZhaoXin is only a company name, we need also a chipset model to be
>>> informative regarding which HW this driver serves.
>>>
>>
>> As mentioned before, the chipset models this driver serves  are ZX-100S
>> and ZX-200
>> currently.
> 
> Fine. Just say so in the Kconfig entry then.
> If in the future your company produces a different chipset model that needs a
> different driver, then the entries can be clearly differentiated even if they
> use the same company name (ZhaoXin). E.g. "ZhaoXin ZX-100S and ZX-200 chipset
> support" vs "ZhaoXin XYZ-newgen chipset support". Adding entries should not
> require modifying existing entries.
> 
> 
> 

I got it. I'll add these information in Kconfig entry briefly next time.
Thank you for your  advice and detailed explanation.
