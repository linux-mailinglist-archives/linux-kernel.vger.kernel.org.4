Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2FB60F1C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiJ0IC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiJ0IB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:01:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8933E072C;
        Thu, 27 Oct 2022 01:01:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d6so1154444lfs.10;
        Thu, 27 Oct 2022 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R+p5nvqTL5SOZ86ilaT/I5U765m1Ya4d2tLi/ODaxYo=;
        b=fjUNCitPMLe0LKP7WU5jXTRdPcLx7DcETPhNKVdPHx/GnNEZTm1ZT+pzPA2tZBMftf
         uCD58161lHfbO5y0NubbJXjD/q76vaTERUY2MCivssREbdZHTPtVUgLfAyBP3Exfftz9
         DlAyprA8yuv1pVJJs1/JP+aRwq/JMMkeVCr7I/qgcw6FHrKlLS0lUNYA3E4eyp2lhtRl
         qIpb3wFM8/ZUtUqPxC0SlSJiUGvVMCqel9XFDNJvhxBce1JYzODe+1atgJ7qJ5kHiOyF
         n4SkLsQ6qVqxdbVTPeOx0It7DXrU3JBN31onsNt7WBGsccM0dZOKW+NeCdl4IE91MlqQ
         PLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+p5nvqTL5SOZ86ilaT/I5U765m1Ya4d2tLi/ODaxYo=;
        b=aB7Ll9mmleFVEI53MVt1SKmy0OJ+MTOseaMCm9rTO0zEa13AfQdxX4dw9JYZxMtUC3
         Sx3PFq8bBRlMnK26qfKf6NrF54wxP2cfO68SiRE+Cng2t/WYFNLqj10EBvA5gajPKnXz
         0cxSlulRl6P7Jr9Na6AnqDHytbg04Co/t6jso5+jDAXoFQe6gBb+ST8fzHVI2OCooj5h
         Ngpns3uWh0rJOQauzFm4eaA9Q75Bq9qu/GaGuCFTbHrCiuQWrq8rZK6an7E5tcEgC66M
         3jHmwG8jwHdaPfKSUJ109l9CKVt8HYXUrctbBCYrjTnTy/b0sCFgFOvpl0QiULgvk+9e
         h/oA==
X-Gm-Message-State: ACrzQf0zdk9rSAx8lRJxOojbK/wMvkFr2wyUHQUbUE8QEUn5WOpl3K2v
        Efjb7d55mMvfYCO15MD0z91c9QsSHTzrDQ==
X-Google-Smtp-Source: AMsMyM6Nv67EAM9h/Td5O72Xt6ReJH2LDW49aEY+sZtqV9LHv/nZzExS3Gr5P36bSJQ+cRS7N508MA==
X-Received: by 2002:a17:906:eec9:b0:783:e662:2513 with SMTP id wu9-20020a170906eec900b00783e6622513mr40204306ejb.656.1666857704566;
        Thu, 27 Oct 2022 01:01:44 -0700 (PDT)
Received: from [109.186.183.118] (109-186-183-118.bb.netvision.net.il. [109.186.183.118])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b007828150a2f1sm392059ejb.36.2022.10.27.01.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 01:01:43 -0700 (PDT)
Message-ID: <818c678f-8a51-a087-f8c0-09553ca1304d@gmail.com>
Date:   Thu, 27 Oct 2022 11:01:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH] char: xillybus: Prevent use-after-free due to race
 condition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, imv4bel@gmail.com
References: <2e5cbdfe-f6cd-d24f-9785-55176af6c975@gmail.com>
 <Y1kjCqUlOFJUgLqZ@kroah.com>
Content-Language: en-US
In-Reply-To: <Y1kjCqUlOFJUgLqZ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

I'm going to follow Alan's advice, and add a mutex instead of juggling 
with the existing one. So I'll prepare a new patch with a completely 
different solution. I've answered your questions below, even though I'm 
not sure any of that is still relevant.

On 26/10/2022 15:07, Greg KH wrote:

>> int xillybus_find_inode(struct inode *inode,
>> +			struct mutex **to_unlock,
> 
> To unlock when?  Who unlocks it?  What is the lifespan here?

xillybus_find_inode() finds the structure that represents a Xillybus 
(PCIe / OF) or XillyUSB (USB) device. The idea was to delay the unlock 
of the mutex until other means have been taken to prevent that structure 
from being freed. Which was virtually immediately after 
xillybus_find_inode() returns, but gave XillyUSB's driver a chance to 
acquire another mutex before releasing this one.

XillyUSB's driver can't prevent the release of this structure before it 
knows which structure it is (that's xillybus_find_inode()'s job to find 
out). But because xillybus_find_inode() unlocks its mutex before 
returning, there is a short period of time where the structure is 
unprotected. So I thought, let's extend the life of the first mutex just 
a little bit to keep the whole thing watertight.

> 
> Why can't it just be part of the structure?

The problem is that this structure is either a struct xilly_endpoint 
(for PCIe / OF) or a struct xillyusb_dev (for USB), and these have 
virtually nothing in common. xillybus_find_inode() is used by two 
completely different drivers that are grouped into a single class.

>>
>> 	*private_data = unit->private_data;
>> 	*index = minor - unit->lowest_minor;
>> +	*to_unlock = &unit_mutex;
> 
> Why are you wanting the caller to unlock this?  It's a global mutex (for
> the whole file), this feels really odd.

As mentioned above, this gives the caller (i.e. XillyUSB's driver) a 
chance to ensure that the structure isn't freed as a result of the 
device's disconnection.
> 
> What is this function supposed to be doing?  You only return an int, and
> you have some odd opaque void pointer being set.  That feels wrong and
> is not a normal design at all.

xillybus_find_inode() finds the device's structure, based upon the 
inode's major and minor.

The opaque void pointer is the structure that represents the device, 
either a PCIe / OF device or a XillyUSB device. Because of the 
difference between a driver for PCIe / OF and a USB driver, these are 
different structs, and hence represented by a void pointer. The int just 
says which of the device files, that are covered by the struct, has been 
opened.

Once again, all this is history, as I'm preparing a new patch, which is 
going to add a separate mutex.

Regards,
    Eli
