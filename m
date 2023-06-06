Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D480723F22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjFFKRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjFFKRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:17:51 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA17E64
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:17:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id DDE92601D6;
        Tue,  6 Jun 2023 12:17:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686046666; bh=65Q7dqLywf8Wf4YU9FBt+xQ5U+E+fTHuEmhCLrDjpfE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RMJqu9NsLPbhEfo9h5ZK+fWDK8oXqpJBnRCXula/JNqhodiJTEny+eh82Jf7qrbXo
         tN+2NF1YOqsemQojIdgcBxbpaW6QewVnxgbPHymPmT3MOas+4l2LcR4Wb0kt/N3q8L
         ZfT8wlqfujfRt30YbyhBBEWl5EvHzM2gKjIUVO79/I/DwwG6Y3iehjrj7yZQtkNxjT
         SDs6N8QlyZotDjyCpSmu+9QPAthvfpLQVRtI+bzN1ExJud9Ovv0L9312te7aQjBjuV
         +lOKxI/skqK+GN0eleyRWQzUQ2GrHSQOdi9sbNkJTUoxr0jShBjlVDeayQIBt9S77u
         orLt6ocvDmPOQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H0UHvYNJieeU; Tue,  6 Jun 2023 12:17:44 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 6462C601D0;
        Tue,  6 Jun 2023 12:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686046664; bh=65Q7dqLywf8Wf4YU9FBt+xQ5U+E+fTHuEmhCLrDjpfE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TMThnddjbf4eYACeVGxZf2GdXzVwjviV1+usqzx6FvYcUtQqbUoutQRCArxHkaidE
         /hHLQR0uRMEkQ1OyuIxZRstx+G1uGsHzv8bQdy4XeZ2VCZPbZtab8wZdm3KJyRlvkj
         s/fYOdzu8KVUz4f8XLbKwEVZcqojyAF27TL5r+P/oHfL1zYT+wBTc2saUXhKPNls3i
         4YI39ubX9cf5Ux7pu3pHIZrHth9YqdJa8EV9c7agKcKb9HRf5SSw0pCEsY7ebJY0TW
         WyyowQuLfoksCwNDHGQZdHWTsuhnp71meyfZ34ZvV3bsyD2gOIHYWY7EtKtW+eFY3g
         8t9eF+4AKU6+A==
Message-ID: <b77284cc-06e7-69c1-1eaa-b3980ba7db71@alu.unizg.hr>
Date:   Tue, 6 Jun 2023 12:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/1] test_firmware: return ENOMEM instead of ENOSPC on
 failed memory allocation
Content-Language: en-US, hr
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
        Scott Branden <sbranden@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Brian Norris <briannorris@chromium.org>
References: <20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr>
 <ba21003b-1440-464c-b251-0e3c2759d07e@kadam.mountain>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ba21003b-1440-464c-b251-0e3c2759d07e@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 09:14, Dan Carpenter wrote:
> On Tue, Jun 06, 2023 at 09:08:10AM +0200, Mirsad Goran Todorovac wrote:
>> In a couple of situations like
>>
>> 	name = kstrndup(buf, count, GFP_KERNEL);
>> 	if (!name)
>> 		return -ENOSPC;
>>
>> the error is not actually "No space left on device", but "Out of memory".
>>
>> It is semantically correct to return -ENOMEM in all failed kstrndup()
>> and kzalloc() cases in this driver, as it is not a problem with disk
>> space, but with kernel memory allocator failing allocation.
>>
>> The semantically correct should be:
>>
>>          name = kstrndup(buf, count, GFP_KERNEL);
>>          if (!name)
>>                  return -ENOMEM;
>>
>> Cc: Dan Carpenter <error27@gmail.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
>> Cc: Scott Branden <sbranden@broadcom.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
>> Fixes: 0a8adf584759c ("test: add firmware_class loader test")
>> Fixes: 548193cba2a7d ("test_firmware: add support for firmware_request_platform")
>> Fixes: eb910947c82f9 ("test: firmware_class: add asynchronous request trigger")
>> Fixes: 061132d2b9c95 ("test_firmware: add test custom fallback trigger")
>> Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
> 
> Thanks!

Thank you for reviewing the patch at such a short notice.
Though it is merely a code consistency fix.

Best regards,
Mirsad Todorovac

> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> regards,
> dan carpenter

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
