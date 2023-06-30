Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7231174363A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjF3Hul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjF3Huh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:50:37 -0400
Received: from smtpcmd13146.aruba.it (smtpcmd13146.aruba.it [62.149.156.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E140510A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:50:35 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id F8tlqv6Kd5zjpF8tlqBf7Q; Fri, 30 Jun 2023 09:50:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1688111434; bh=764z+bEI0TCj6mifhhdfUbZvcKT+clWJbZ8kIp0VIpk=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=WufXTHfRymQaFbo4jcHA6TSVjF2XyVyGqvdwtGPjiPC26z98WYDlCUuOOxrmWVpo+
         h526qgYtWaljIXMMOKyUI71vOYLq27uwAtB5TCgfcCzQNuYEMsJZLh+SE/YpRGhIF9
         ejlABkPjNziMSuSDhjYWWVKRekopV08ApffpICcPGOuci9BVEmMBRQAvd3GYdHkLcO
         9d6s5wGgh/aOk1R5tLL8K00Vtuff3S1/ySrwn6vhL19j6MF6ByMgdPmX8mwmdoYZ+G
         F/eL1oDOdR3p8FyYVoUwsHqO/R6r/C3dhlOLzhIlZb7UFfPWFE2h4yTGCtdBwzD45C
         3C3DKXzOtlR5w==
Message-ID: <56e461b4-2cd8-ec89-86b2-68544826cf73@enneenne.com>
Date:   Fri, 30 Jun 2023 09:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] include/uapi pps.h: drop not needed PPS_MAX_SOURCES
 define
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230630071826.105501-1-giometti@enneenne.com>
 <20230630071826.105501-2-giometti@enneenne.com>
 <2023063017-traverse-accustom-97f4@gregkh>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <2023063017-traverse-accustom-97f4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFRM9CD9vSSg6Y/yaMvVQTuL9COMutu6moBCqwQfS9W2BwaVBagmrLgZeb2Z5l0GzfjebWQm05/V9Ihu6H6vhN3lR/pB/NofrBz1WtigPi2pr2J/+JEy
 5b9i0gkUDkDeR6I/Wc53UbkWgwtcrTm/pVsWgQr38ToIcewQIQRF9Glcvu+E3z37IA7UwTudFLss1DsNSymKr7kg/GoHqxsfGEOuqJi6t9+r/wQgora6Gqog
 2RGQd3Fb5HNoDYCQOtcKUA==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/23 09:31, Greg Kroah-Hartman wrote:
> On Fri, Jun 30, 2023 at 09:18:26AM +0200, Rodolfo Giometti wrote:
>> Userspace PPS clients should not known about how many PPS sources can
>> be defined within the system (nor the rfc2783 say so), so we can
>> safely drop this define since is not used anymore in the kernel too.
>>
>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>> ---
>>   drivers/pps/pps.c        | 6 +++---
>>   include/uapi/linux/pps.h | 1 -
>>   2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>> index 5d19baae6a38..1a6131608036 100644
>> --- a/drivers/pps/pps.c
>> +++ b/drivers/pps/pps.c
>> @@ -354,7 +354,7 @@ int pps_register_cdev(struct pps_device *pps)
>>   	 * Get new ID for the new PPS source.  After idr_alloc() calling
>>   	 * the new source will be freely available into the kernel.
>>   	 */
>> -	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
>> +	err = idr_alloc(&pps_idr, pps, 0, MINORMASK, GFP_KERNEL);
>>   	if (err < 0) {
>>   		if (err == -ENOSPC) {
>>   			pr_err("%s: too many PPS sources in the system\n",
>> @@ -449,7 +449,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
>>   static void __exit pps_exit(void)
>>   {
>>   	class_destroy(pps_class);
>> -	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
>> +	unregister_chrdev_region(pps_devt, MINORMASK);
>>   }
>>   
>>   static int __init pps_init(void)
>> @@ -463,7 +463,7 @@ static int __init pps_init(void)
>>   	}
>>   	pps_class->dev_groups = pps_groups;
>>   
>> -	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
>> +	err = alloc_chrdev_region(&pps_devt, 0, MINORMASK, "pps");
>>   	if (err < 0) {
>>   		pr_err("failed to allocate char device region\n");
>>   		goto remove_class;
>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>> index 90f2e86020ba..8a4096f18af1 100644
>> --- a/include/uapi/linux/pps.h
>> +++ b/include/uapi/linux/pps.h
>> @@ -26,7 +26,6 @@
>>   #include <linux/types.h>
>>   
>>   #define PPS_VERSION		"5.3.6"
>> -#define PPS_MAX_SOURCES		MINORMASK
> 
> Why change this in patch 1, and then delete this here?
> 
> That makes no sense.

I did it in two steps to be clear that the first step is about a better 
redefinition of the PPS_MAX_SOURCES define, while the second step is about the 
fact it's now that define is useless.

> And if this is exported to userspace, removing it should break things,
> right?  If not, why was it there in the first place?

In reality such define is not stated within the PPS RFC2783, so userspace 
programs whose relies on such define are broken.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

