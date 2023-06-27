Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188A873F52B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjF0HRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0HRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:17:20 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6F01BEC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:17:16 -0700 (PDT)
X-ASG-Debug-ID: 1687850226-086e23149807fd0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id rycdsnRLOkURt9qa (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 27 Jun 2023 15:17:07 +0800 (CST)
X-Barracuda-Envelope-From: RunaGuo-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 27 Jun
 2023 15:17:06 +0800
Received: from [10.29.8.9] (10.29.8.9) by zxbjmbx1.zhaoxin.com (10.29.252.163)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 27 Jun
 2023 15:17:05 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
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
From:   Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
Message-ID: <b330e18d-4fd3-2649-aafd-4f941c111803@zhaoxin.com>
Date:   Tue, 27 Jun 2023 15:17:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <330d93ee-b4b6-2397-2b7c-eb4d99676f87@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.9]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1687850226
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6143
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.110594
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

On 2023/6/26 20:40, Damien Le Moal wrote:
> On 6/26/23 20:29, Runa Guo-oc wrote:
>> On 2023/6/16 16:34, Damien Le Moal wrote:
>>> On 6/16/23 16:49, Runa Guo-oc wrote:
>>>> [PATCH] ata:sata_zhaoxin: Add support for ZhaoXin Serial ATA
>>>
>>> Broken patch: the email subject is your SoB instead of the above line, which
>>> should not be part of the message (it should be the subject). Please reformat
>>> and resend.
>>>
>>
>> Okay.
>>
>>>>
>>>> Add ZhaoXin Serial ATA support for ZhaoXin CUPs.
>>>
>>> What is "ZhaoXin" ?
>>
>> Zhaoxin is a Chinese company that has mastered the core technology
>> of independent general-purpose processors and its system platform chips,
>> and is committed to providing users with efficient, compatible and secure
>> independent general-purpose processors, chipsets and other products.
>> for more information, you can visit here: https://www.zhaoxin.com/.
> 
> A company marketing message is not very informative, technically speaking. What
> is this chipset and on what board/machine can it be found ? That is the more
> relevant information we need in this commit message.
> 

The reason why it is called Zhaoxin SATA is actually to express that it
applies
to all Zhaoxin support of its separate chipset/SOC, for example,
ZX-100S/ZX-200
chipsets.

>>
>>> And what is "CUPs" ? Please spell this out.
>>>
>>
>> Yes, this is  a spelling error.
>>
>>>>
>>>> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
>>>> ---
>>>>  drivers/ata/Kconfig        |   8 +
>>>>  drivers/ata/Makefile       |   1 +
>>>>  drivers/ata/sata_zhaoxin.c | 384 +++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 393 insertions(+)
>>>>  create mode 100644 drivers/ata/sata_zhaoxin.c
>>>>
>>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>>> index 42b51c9..ae327f3 100644
>>>> --- a/drivers/ata/Kconfig
>>>> +++ b/drivers/ata/Kconfig
>>>> @@ -553,6 +553,14 @@ config SATA_VITESSE
>>>>  
>>>>  	  If unsure, say N.
>>>>  
>>>> +config SATA_ZHAOXIN
>>>> +	tristate "ZhaoXin SATA support"
> 
> Same here. If ZhaoXin is only a company name, we need also a chipset model to be
> informative regarding which HW this driver serves.
> 

As mentioned before, the chipset models this driver serves  are ZX-100S
and ZX-200
currently.

>>>> +	depends on PCI
>>>> +	help
>>>> +	  This option enables support for ZhaoXin Serial ATA.
>>>> +
>>>> +	  If unsure, say N.
>>>> +
>>>>  comment "PATA SFF controllers with BMDMA"
>>>>  
>>>>  config PATA_ALI
>>>> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
>>>> index 20e6645..4b84669 100644
>>>> --- a/drivers/ata/Makefile
>>>> +++ b/drivers/ata/Makefile
>>>> @@ -45,6 +45,7 @@ obj-$(CONFIG_SATA_SIL)		+= sata_sil.o
>>>>  obj-$(CONFIG_SATA_SIS)		+= sata_sis.o
>>>>  obj-$(CONFIG_SATA_SVW)		+= sata_svw.o
>>>>  obj-$(CONFIG_SATA_ULI)		+= sata_uli.o
>>>> +obj-$(CONFIG_SATA_ZHAOXIN)	+= sata_zhaoxin.o
>>>
>>> Please sort this alphabetically.
>>>
>>
>> Like this?
>> obj-$(CONFIG_SATA_VITESSE)	        += sata_vsc.o
>> obj-$(CONFIG_SATA_ZHAOXIN)	        += sata_zhaoxin.o
> 
> Yes.
> 
>>>> +
>>>> +		ata_link_err(link, "COMRESET success (errno=%d) ap=%d link %d\n",
>>>> +					rc, link->ap->port_no, link->pmp);
>>>> +	} else {
>>>> +		ata_link_err(link, "COMRESET failed (errno=%d) ap=%d link %d\n",
>>>> +					rc, link->ap->port_no, link->pmp);
>>>
>>> Reverse the if condition and exit early for this case. That will make the
>>> function code nicer. And you can drop the error message as well since
>>> sata_std_hardreset() prints one.
>>>
>>
>> Yes, I agree with your. I'll adjust the above codes like these?
>>
>> if(!rc || rc == -EAGAIN){
>>                 struct ata_port *ap = link->ap;
>>                 int pmp = link->pmp;
>>                 int tmprc;
>>                 if(pmp){
>>                         ap->ops->sff_dev_select(ap,pmp);
>>                         tmprc=ata_sff_wait_ready(&ap->link,deadline);
>>                 }else
>>                         tmprc=ata_sff_wait_ready(link,deadline);
>>
>>                 if(tmprc)
>>                         ata_link_err(link,"COMRESET failed for
>> wait(errno=%d)\n",rc);
>>
>>                 ata_link_err(link,"COMRESET success (errno=%d) ap=%d
>> link%d\n",
>>                                   rc,link->ap->port_no,link->pmp);
>>
> 
> You did not understand my point. Doing:
> 
> 	rc = sata_std_hardreset(link, class, deadline);
> 	if (rc && rc != -EAGAIN) {
> 		ata_link_err(link, "COMRESET failed (errno=%d) ap=%d link %d\n",
> 			     rc, link->ap->port_no, link->pmp);
> 		return rc;
> 	}
> 
> 	/* rc == 0 || rc == -EAGAIN case */
> 	...
> 
> Makes the code much nicer.
> 
> 
> [...]
> 

Okay, I'll adjust  it like this?
  ...
  struct ata_port *ap = link->ap;
  int pmp = link->pmp;
  int tmprc;

 rc = sata_std_hardreset(link, class, deadline);
 if (rc && rc != -EAGAIN) {
        ata_link_err(link, "COMRESET failed (errno=%d) ap=%d link %d\n",
                       rc, link->ap->port_no, link->pmp);
         return rc;
 }

  if(pmp){
     ap->ops->sff_dev_select(ap,pmp);
     tmprc=ata_sff_wait_ready(&ap->link,deadline);
 }else
    tmprc=ata_sff_wait_ready(link,deadline);

  if(tmprc)
      ata_link_err(link,"COMRESET failed for wait(errno=%d)\n",rc);

 return rc;


>>>> +MODULE_AUTHOR("Yanchen:YanchenSun@zhaoxin.com");
>>>> +MODULE_DESCRIPTION("SCSI low-level driver for ZX SATA controllers");
>>>
>>> This is not a scsi driver...
>>>
>>
>> I treat it as a scsi driver for the following reasons,  which may be not
>> accurate.
>> 1, IO path: vfs->fs->block layer->scsi layer->this driver;
>> 2, Extracted from the following link:
>> "SCSI Lower level drivers (LLDs) are variously called host bus adapter
>> (HBA) drivers and host drivers (HD)."
> 
> Again, this is not a scsi driver. Even if in Linux all ATA drives seat under the
> scsi layer, this is an ATA subsytem driver for an ATA drive. Not SCSI.
> 

Okay, I'll remove this inaccurate description next time.
Thank you.
