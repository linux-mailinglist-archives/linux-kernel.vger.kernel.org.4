Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435686C70E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCWTRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCWTRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:17:07 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7171146BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:17:05 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id fQQnplsmuTpvffQQnp31ME; Thu, 23 Mar 2023 20:17:03 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 23 Mar 2023 20:17:03 +0100
X-ME-IP: 86.243.2.178
Message-ID: <84b81ceb-1c7f-0dac-1988-0a9c0af2757c@wanadoo.fr>
Date:   Thu, 23 Mar 2023 20:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] usb: pci-quirks: Remove a useless initialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <3850d93ff40ed12f4724621a540fb5993c0a0fa9.1679434951.git.christophe.jaillet@wanadoo.fr>
 <a3c703152d89a2c6b34b31f0158f84ba504e24d8.1679434951.git.christophe.jaillet@wanadoo.fr>
 <ZBx/DeY4rwX+4zg8@kroah.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZBx/DeY4rwX+4zg8@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 23/03/2023 à 17:32, Greg Kroah-Hartman a écrit :
> On Tue, Mar 21, 2023 at 10:43:10PM +0100, Christophe JAILLET wrote:
>> 'info' is memset()'ed a few lines below and is not use in the between.
>>
>> There is no need to initialize one of its field to false here.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/usb/host/pci-quirks.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
>> index 6b741327d2c4..46f2412dcb40 100644
>> --- a/drivers/usb/host/pci-quirks.c
>> +++ b/drivers/usb/host/pci-quirks.c
>> @@ -208,7 +208,6 @@ static void usb_amd_find_chipset_info(void)
>>   {
>>   	unsigned long flags;
>>   	struct amd_chipset_info info;
>> -	info.need_pll_quirk = false;
> Why not just change the line above it to:
> 	struct amd_chipset_info info = { };
> and drop the call to memset entirely?

I find an explicit memset() more readable, but it's mostly a matter of 
taste.

I'll send a v2.

CJ


> thanks,
>
> greg k-h
