Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5A73DF70
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFZMkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFZMk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0A10B;
        Mon, 26 Jun 2023 05:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24B860E88;
        Mon, 26 Jun 2023 12:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FDAC433C8;
        Mon, 26 Jun 2023 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687783226;
        bh=wQ6Z/RpCgi70OuvzNQeJd1tpKawWzkWK8jQrKXYxy2g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aF585ll2jwU6U4JhXNmIBLhtu+HU25IlH7ZKu8FEqDjjEMPowz7borSneEWXW2bnb
         tFLS8MpXqz4ZyhQ5cpIDlDqqmeacUD5SNxExbvglLRvPejcCox1GR5sX4Z8/9/5QzS
         2A9V/ksfnAHU1chizpsw2ljN75OOISfsZMOFBkfiOAuJz30gSJCFOsZsHvwqv12NaW
         oYAMcAc/TWnppC7wnphkrYYClQYp6/OuVe2H10u96hinIBQ9LtU89f7XC7EuyZucYI
         lnAcdOWt+6Ozez/723wKCqBzk958Hlyqr+QDDrgsn/oOPtwlO2+Mi1RdigGK1lXEdl
         ydPCjrLEaaO6Q==
Message-ID: <330d93ee-b4b6-2397-2b7c-eb4d99676f87@kernel.org>
Date:   Mon, 26 Jun 2023 21:40:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
Content-Language: en-US
To:     Runa Guo-oc <RunaGuo-oc@zhaoxin.com>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Cc:     CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, TonyWWang@zhaoxin.com,
        LeoLiu@zhaoxin.com, RunaGuo@zhaoxin.com
References: <1686901766-4928-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <ccabf88b-2e2c-876d-e47a-8d142e27d638@kernel.org>
 <70853f13-f74e-d9bb-89f7-4c804f1fa8a4@zhaoxin.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <70853f13-f74e-d9bb-89f7-4c804f1fa8a4@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 20:29, Runa Guo-oc wrote:
> On 2023/6/16 16:34, Damien Le Moal wrote:
>> On 6/16/23 16:49, Runa Guo-oc wrote:
>>> [PATCH] ata:sata_zhaoxin: Add support for ZhaoXin Serial ATA
>>
>> Broken patch: the email subject is your SoB instead of the above line, which
>> should not be part of the message (it should be the subject). Please reformat
>> and resend.
>>
> 
> Okay.
> 
>>>
>>> Add ZhaoXin Serial ATA support for ZhaoXin CUPs.
>>
>> What is "ZhaoXin" ?
> 
> Zhaoxin is a Chinese company that has mastered the core technology
> of independent general-purpose processors and its system platform chips,
> and is committed to providing users with efficient, compatible and secure
> independent general-purpose processors, chipsets and other products.
> for more information, you can visit here: https://www.zhaoxin.com/.

A company marketing message is not very informative, technically speaking. What
is this chipset and on what board/machine can it be found ? That is the more
relevant information we need in this commit message.

> 
>> And what is "CUPs" ? Please spell this out.
>>
> 
> Yes, this is  a spelling error.
> 
>>>
>>> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
>>> ---
>>>  drivers/ata/Kconfig        |   8 +
>>>  drivers/ata/Makefile       |   1 +
>>>  drivers/ata/sata_zhaoxin.c | 384 +++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 393 insertions(+)
>>>  create mode 100644 drivers/ata/sata_zhaoxin.c
>>>
>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>> index 42b51c9..ae327f3 100644
>>> --- a/drivers/ata/Kconfig
>>> +++ b/drivers/ata/Kconfig
>>> @@ -553,6 +553,14 @@ config SATA_VITESSE
>>>  
>>>  	  If unsure, say N.
>>>  
>>> +config SATA_ZHAOXIN
>>> +	tristate "ZhaoXin SATA support"

Same here. If ZhaoXin is only a company name, we need also a chipset model to be
informative regarding which HW this driver serves.

>>> +	depends on PCI
>>> +	help
>>> +	  This option enables support for ZhaoXin Serial ATA.
>>> +
>>> +	  If unsure, say N.
>>> +
>>>  comment "PATA SFF controllers with BMDMA"
>>>  
>>>  config PATA_ALI
>>> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
>>> index 20e6645..4b84669 100644
>>> --- a/drivers/ata/Makefile
>>> +++ b/drivers/ata/Makefile
>>> @@ -45,6 +45,7 @@ obj-$(CONFIG_SATA_SIL)		+= sata_sil.o
>>>  obj-$(CONFIG_SATA_SIS)		+= sata_sis.o
>>>  obj-$(CONFIG_SATA_SVW)		+= sata_svw.o
>>>  obj-$(CONFIG_SATA_ULI)		+= sata_uli.o
>>> +obj-$(CONFIG_SATA_ZHAOXIN)	+= sata_zhaoxin.o
>>
>> Please sort this alphabetically.
>>
> 
> Like this?
> obj-$(CONFIG_SATA_VITESSE)	        += sata_vsc.o
> obj-$(CONFIG_SATA_ZHAOXIN)	        += sata_zhaoxin.o

Yes.

>>> +
>>> +		ata_link_err(link, "COMRESET success (errno=%d) ap=%d link %d\n",
>>> +					rc, link->ap->port_no, link->pmp);
>>> +	} else {
>>> +		ata_link_err(link, "COMRESET failed (errno=%d) ap=%d link %d\n",
>>> +					rc, link->ap->port_no, link->pmp);
>>
>> Reverse the if condition and exit early for this case. That will make the
>> function code nicer. And you can drop the error message as well since
>> sata_std_hardreset() prints one.
>>
> 
> Yes, I agree with your. I'll adjust the above codes like these?
> 
> if(!rc || rc == -EAGAIN){
>                 struct ata_port *ap = link->ap;
>                 int pmp = link->pmp;
>                 int tmprc;
>                 if(pmp){
>                         ap->ops->sff_dev_select(ap,pmp);
>                         tmprc=ata_sff_wait_ready(&ap->link,deadline);
>                 }else
>                         tmprc=ata_sff_wait_ready(link,deadline);
> 
>                 if(tmprc)
>                         ata_link_err(link,"COMRESET failed for
> wait(errno=%d)\n",rc);
> 
>                 ata_link_err(link,"COMRESET success (errno=%d) ap=%d
> link%d\n",
>                                   rc,link->ap->port_no,link->pmp);
> 

You did not understand my point. Doing:

	rc = sata_std_hardreset(link, class, deadline);
	if (rc && rc != -EAGAIN) {
		ata_link_err(link, "COMRESET failed (errno=%d) ap=%d link %d\n",
			     rc, link->ap->port_no, link->pmp);
		return rc;
	}

	/* rc == 0 || rc == -EAGAIN case */
	...

Makes the code much nicer.


[...]

>>> +MODULE_AUTHOR("Yanchen:YanchenSun@zhaoxin.com");
>>> +MODULE_DESCRIPTION("SCSI low-level driver for ZX SATA controllers");
>>
>> This is not a scsi driver...
>>
> 
> I treat it as a scsi driver for the following reasons,  which may be not
> accurate.
> 1, IO path: vfs->fs->block layer->scsi layer->this driver;
> 2, Extracted from the following link:
> "SCSI Lower level drivers (LLDs) are variously called host bus adapter
> (HBA) drivers and host drivers (HD)."

Again, this is not a scsi driver. Even if in Linux all ATA drives seat under the
scsi layer, this is an ATA subsytem driver for an ATA drive. Not SCSI.

-- 
Damien Le Moal
Western Digital Research

