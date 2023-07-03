Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411A7745F03
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGCOsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjGCOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:47:53 -0400
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0533310C2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:47:29 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id GKpoqwMkk4iOUGKpoqLUnY; Mon, 03 Jul 2023 16:47:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1688395645; bh=NOx9nUtR8OOcpYMcehzkrBt/SXaGbSqWZgl3UHzFKfY=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=PyKSuSXtzqIsMOFPTPX8a55dT5yOyhs/VB8DaGNLfKO1DYdE8VGzHpLe8yq6ToHnK
         x95CCbAHhJLxeo/rufhwhcNwK5dUvrelYhT+kvvY+/jaamsgqvNa/vWwPKdRSbfPyR
         MZwCSDTrCP1aK1ylOqkzJGnG235vWOudhepXcTZNAKSNkmAdNlceLIfoNWjNOmjlJZ
         AjA/RIMKGcAto68jEjBoQ6XIhbtOKQ9js8yQwcXOicyEpHHwNbiwPseWpWptxZ1zEA
         +Gh/l5mRK2D/eJj2TRW91hzzP3RL44yH1uONS778M8IjJqjpO3efnHGf7CJAK7GVa+
         9EQ15G2T3w2fQ==
Message-ID: <a743ab0a-fd45-2cd1-2546-44cf4547266f@enneenne.com>
Date:   Mon, 3 Jul 2023 16:47:24 +0200
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
 <56e461b4-2cd8-ec89-86b2-68544826cf73@enneenne.com>
 <2023063015-immerse-broadside-3dab@gregkh>
 <ca137a28-28a3-f563-52e9-4ee0ef1daa9f@enneenne.com>
 <2023070327-gangway-comic-6e15@gregkh>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <2023070327-gangway-comic-6e15@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfC+J2hdxjVRu1RYgGGYVsFbnyC3t0b7DaN7IgRtdAKVtFEj3940QBPbm6IGve8AS/53AMzcR873kspeVPImgi1c454bupC6TCP5Fr434Pfw/k7Gmvdu9
 15IkIKYWz+G6q/gK5f7O1EGvwc/L/QHV5qcjlGfeBbju8NnCuD/452VYjK5fwyDVv1fjLbSyD5GCOhLxRrQ+gNIablWtpCDW2/kr9xe3ZKvJ9UZqC7Nyhuv4
 JqWiBaVuu11gzGW60JIt7g==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/23 15:38, Greg Kroah-Hartman wrote:
> On Fri, Jun 30, 2023 at 03:29:50PM +0200, Rodolfo Giometti wrote:
>> On 30/06/23 14:53, Greg Kroah-Hartman wrote:
>>> On Fri, Jun 30, 2023 at 09:50:33AM +0200, Rodolfo Giometti wrote:
>>>> On 30/06/23 09:31, Greg Kroah-Hartman wrote:
>>>>> On Fri, Jun 30, 2023 at 09:18:26AM +0200, Rodolfo Giometti wrote:
>>>>>> Userspace PPS clients should not known about how many PPS sources can
>>>>>> be defined within the system (nor the rfc2783 say so), so we can
>>>>>> safely drop this define since is not used anymore in the kernel too.
>>>>>>
>>>>>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>>>>>> ---
>>>>>>     drivers/pps/pps.c        | 6 +++---
>>>>>>     include/uapi/linux/pps.h | 1 -
>>>>>>     2 files changed, 3 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>>>>>> index 5d19baae6a38..1a6131608036 100644
>>>>>> --- a/drivers/pps/pps.c
>>>>>> +++ b/drivers/pps/pps.c
>>>>>> @@ -354,7 +354,7 @@ int pps_register_cdev(struct pps_device *pps)
>>>>>>     	 * Get new ID for the new PPS source.  After idr_alloc() calling
>>>>>>     	 * the new source will be freely available into the kernel.
>>>>>>     	 */
>>>>>> -	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
>>>>>> +	err = idr_alloc(&pps_idr, pps, 0, MINORMASK, GFP_KERNEL);
>>>>>>     	if (err < 0) {
>>>>>>     		if (err == -ENOSPC) {
>>>>>>     			pr_err("%s: too many PPS sources in the system\n",
>>>>>> @@ -449,7 +449,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
>>>>>>     static void __exit pps_exit(void)
>>>>>>     {
>>>>>>     	class_destroy(pps_class);
>>>>>> -	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
>>>>>> +	unregister_chrdev_region(pps_devt, MINORMASK);
>>>>>>     }
>>>>>>     static int __init pps_init(void)
>>>>>> @@ -463,7 +463,7 @@ static int __init pps_init(void)
>>>>>>     	}
>>>>>>     	pps_class->dev_groups = pps_groups;
>>>>>> -	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
>>>>>> +	err = alloc_chrdev_region(&pps_devt, 0, MINORMASK, "pps");
>>>>>>     	if (err < 0) {
>>>>>>     		pr_err("failed to allocate char device region\n");
>>>>>>     		goto remove_class;
>>>>>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>>>>>> index 90f2e86020ba..8a4096f18af1 100644
>>>>>> --- a/include/uapi/linux/pps.h
>>>>>> +++ b/include/uapi/linux/pps.h
>>>>>> @@ -26,7 +26,6 @@
>>>>>>     #include <linux/types.h>
>>>>>>     #define PPS_VERSION		"5.3.6"
>>>>>> -#define PPS_MAX_SOURCES		MINORMASK
>>>>>
>>>>> Why change this in patch 1, and then delete this here?
>>>>>
>>>>> That makes no sense.
>>>>
>>>> I did it in two steps to be clear that the first step is about a better
>>>> redefinition of the PPS_MAX_SOURCES define, while the second step is about
>>>> the fact it's now that define is useless.
>>>
>>> Better to just convert everything in patch one, and then in patch 2
>>> delete the .h #define.  That way, when userspace breaks, you can revert
>>> just the last patch :)
>>
>> I'm puzzled since I did as you say... patch 1/2 increases PPS_MAX_SOURCES
>> value while patch 2/2 drops PPS_MAX_SOURCES define.
> 
> Ah, I thought patch 1/2 renamed it.

No, patch 1/2 just safely increases PPS_MAX_SOURCES value as other drivers does.

> But why increase it if you are removing it?

As I said I splitted the modification in two steps just to highlight that the 
first step is a better redefinition of PPS_MAX_SOURCES, while the second step 
drops it since it's useless for userspace. As you noticed this last step is not 
trivial since it may breaks some userspace programs, but it's also true that 
RFC2783 doesn't define it, so well written userspace programs should not use 
that define and then they should not break at all. :)

>>>>> And if this is exported to userspace, removing it should break things,
>>>>> right?  If not, why was it there in the first place?
>>>>
>>>> In reality such define is not stated within the PPS RFC2783, so userspace
>>>> programs whose relies on such define are broken.
>>>
>>> RFC's do not document Linux kernel apis.
>>
>> It's true, but well written PPS clients should relay only on PPS API which
>> in turn doesn't states that define. :P
> 
> Are you sure?  Have you audited the clients?  if so, please document
> that in the changelog text.

OK, I'm going to re-write the changelog text adding this information.

>>> So if any userspace code breaks, you have to put this back, sorry.
>>
>> If you think that patch 2 is not good, no problem, just drop it, but please
>> just consider applying patch 1, since increasing PPS_MAX_SOURCES value is
>> good.
> 
> You can't change a uapi value either without breaking things :(

I see, but in this case what do you suggest to do? Keeping 1/2 and dropping 2/2?

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

