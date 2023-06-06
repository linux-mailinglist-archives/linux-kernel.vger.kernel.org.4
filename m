Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E3472383E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjFFG4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjFFG4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:56:12 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BB4C7;
        Mon,  5 Jun 2023 23:56:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2E9DA601AE;
        Tue,  6 Jun 2023 08:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686034569; bh=q+78T66p3liJNTDAQkWym3oKxXPPc8kMYE6Dr6JYeiE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=abZyEyZTWuHG4NhADH+ecUiBgCX/+qUdsxsMx8y8z9plumxWfZw3lYfW0yfqWZYxL
         uw/tRHYHvsg/f/u/s3o4ocD0MZ11CY9lHtCvcPaU072QYm1nooOB3pSV/mLCR3poMy
         nx/0qVATSCLQXHCvvBAwoYN5neE6KeiKCeZXkZ3vJuB2NSr2lnzYv/1KfxmrvxBzYA
         XEy4570SVxNyQCkn27oVL/mtIrAticGH3rkroyFPPfjbcG74uaCd/C9xcqHFwSScBU
         NRVphF6xz9isL3WLjNvBhHmgM5MzhZ6MdKTK5EHbQKcjoBHDfQ53tmdPjgPqLFKr9a
         IIBzzLCKpyeIw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AovoW9PVg2xG; Tue,  6 Jun 2023 08:56:07 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id 5737D601AC;
        Tue,  6 Jun 2023 08:56:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686034567; bh=q+78T66p3liJNTDAQkWym3oKxXPPc8kMYE6Dr6JYeiE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uBgd1RM3JcUVBvUnlrweNkqZXjbbKtMlX7C7De5PwLXPRS8v7oVzYUQ6we9wmP9EB
         VgzEW0eMDvCuZxsbi66GbgoFknwcGezXXC1/VrV1hrS1kIPDaG4IFRNOtS/+mcb2+9
         IF2al//v4IubVtn1MBk+8quK+rjE24EN8+S424yr+FF/U2dbSMvqzSDUAtFCvQ2KRi
         +gpedbBL3iAlBg8lk+uduEt1L7P5agMn91X/z9Wa4U6fffh0KOT/0ECkX8VXIoULAb
         ZDLtqwNP6ri4jm4UZTTjFrx6jb0D9oM/4JKGSfkDyKJI/rsTAAdhhQDTwGfs/WTEIR
         8rmFoeGeJbXLw==
Message-ID: <5a027b45-eeb9-15df-4e5c-5eded17fee6f@alu.unizg.hr>
Date:   Tue, 6 Jun 2023 08:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/1] test_firmware: return ENOMEM instead of ENOSPC on
 failed allocation
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
References: <20230605162746.614423-1-mirsad.todorovac@alu.unizg.hr>
 <8ab7c6f1-7572-49f4-9781-46f4935ea7bf@kadam.mountain>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <8ab7c6f1-7572-49f4-9781-46f4935ea7bf@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 07:37, Dan Carpenter wrote:
> On Mon, Jun 05, 2023 at 06:27:47PM +0200, Mirsad Goran Todorovac wrote:
>> In a couple of situations like:
>>
>> 	name = kstrndup(buf, count, GFP_KERNEL);
>> 	if (!name)
>> 		return -ENOSPC;
>>
>> the error is not actually "No space left on device", but "Out of memory".
>>
>> So, it is semantically correct to return -ENOMEM in all failed kstrndup()
>> and kzalloc() cases in this driver, as it is not a problem with disk
>> space, but with kernel memory allocator.
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
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
> 
> The Cc stable might be a little bit much...  No Fixes tag either.  But
> otherwise it looks fine.

Thank you. I will fix these and resubmit.

Best regards,
Mirsad Todorovac

> regards,
> dan carpenter
