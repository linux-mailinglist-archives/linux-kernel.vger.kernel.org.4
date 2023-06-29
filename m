Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62D2742D28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjF2TSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjF2TRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:17:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1429E18536;
        Thu, 29 Jun 2023 12:09:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55ae2075990so626591a12.0;
        Thu, 29 Jun 2023 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688065760; x=1690657760;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHxUo6xmiZ7UJTmxLdtD1BHWN7DAFibiiT2PwkiPplg=;
        b=dkblGDhOczYF7XZYo470P1DCjNQH8FV9XL0PGG+hD+i2tKz8Zu4X8SYjDgm27akZnK
         1TemU5ktkZmvu/TQupvUMEPDb3gprAG6dLvr/+qi1G90lQWDNyNtp9ViUkDhSw1463xR
         FSdamd+Bycidk0/lP24wJrPsyskplBkpWJYiPBm9zpG7ABlX54DO2BSXhI5MiJALKgLv
         y77rPBVeRS2ArpE+D8WyEQgZz6hGkBsSLDkbXwKyAsrG4CuOsgwKNZ3UkHECXVH5UmTt
         /yCRZpQIZ+DaHttFVVDv3GrzWLiB9zHQY43TCTg/I15K12z45V2K4ZH8bG0qjjpqzyfp
         Zhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065760; x=1690657760;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHxUo6xmiZ7UJTmxLdtD1BHWN7DAFibiiT2PwkiPplg=;
        b=SuIvpCsk55L7kv8sIrhRXyYiXVoNAm5Jgn5vspoJZ7pRAk8jZHI+CxvZMYRH+wp3A/
         agQDYRnZ0z1P5Y5d6EapnYEKQPrDbkwePOQ+91MyXnKHDNU8sZYR3rkub1Qb5OAVwF+K
         clQGn7Zf/922odb3XYrBeCxQSl2yiOq+uILAONQ7y4e3OlbzH0ScjKSNufPDn0KYj5a+
         Hz2cpRvHzRE6TEdJZvuPLFZ/eZ4BLD3Tq6W5CrZDVdztt98WwRrmLNWqORY9RfpFUNae
         HCHPoAGJ83uTpzU66u1BR85zgKZtIFapjb6NuKybpnV1S9Ei/ZwfsSZbs/oZYHdCkLOA
         JSBg==
X-Gm-Message-State: AC+VfDxNFyBNobr0t4DMQJ4LacebFZfTmEf/h24MhVfDXTchftxiPsJf
        5qmj4nPii0wZbzva2IfrmBuDOoHHN4Q=
X-Google-Smtp-Source: ACHHUZ5ts0HuX+l+OlWWcaPzm44ZWfCrd+jBcwultPqhcIKPqEEJMAbPF34Pn5uh3O4z1VA32Ef9Cw==
X-Received: by 2002:a05:6a20:258b:b0:124:3ad9:7455 with SMTP id k11-20020a056a20258b00b001243ad97455mr810517pzd.2.1688065760351;
        Thu, 29 Jun 2023 12:09:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6-20020a655586000000b0054fe7736ac1sm8157228pgs.76.2023.06.29.12.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 12:09:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1a27469a-4cdb-8cf0-c539-05103f2e0b8f@roeck-us.net>
Date:   Thu, 29 Jun 2023 12:09:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev, Eddie James <eajames@linux.ibm.com>,
        linux-hwmon@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        lakshmiy@us.ibm.com
References: <20230627184027.16343-1-eajames@linux.ibm.com>
 <b12935a2-a8b7-4d70-8c7d-6fd1e92037c2@kadam.mountain>
 <45a29025-4c06-4f88-b82f-a8002c25c376@kadam.mountain>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs
 attribute
In-Reply-To: <45a29025-4c06-4f88-b82f-a8002c25c376@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 11:59, Dan Carpenter wrote:
> On Thu, Jun 29, 2023 at 09:53:16AM +0300, Dan Carpenter wrote:
>> d2c6444389b625 Eddie James 2023-06-27  22  	char out[8];
>> d2c6444389b625 Eddie James 2023-06-27  23  	int rc;
>> d2c6444389b625 Eddie James 2023-06-27  24  	int i;
>> d2c6444389b625 Eddie James 2023-06-27  25
>> d2c6444389b625 Eddie James 2023-06-27  26  	rc = pmbus_lock_interruptible(client);
>> d2c6444389b625 Eddie James 2023-06-27  27  	if (rc)
>> d2c6444389b625 Eddie James 2023-06-27  28  		return rc;
>> d2c6444389b625 Eddie James 2023-06-27  29
>> d2c6444389b625 Eddie James 2023-06-27  30  	rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, data);
>> d2c6444389b625 Eddie James 2023-06-27  31  	pmbus_unlock(client);
>> d2c6444389b625 Eddie James 2023-06-27  32  	if (rc < 0)
>> d2c6444389b625 Eddie James 2023-06-27  33  		return rc;
>> d2c6444389b625 Eddie James 2023-06-27  34
>> d2c6444389b625 Eddie James 2023-06-27  35  	for (i = 0; i < rc && i < 3; ++i)
>> d2c6444389b625 Eddie James 2023-06-27 @36  		snprintf(&out[i * 2], 3, "%02X", data[i]);
>>
>> If data[i] is negative this will print FFFFFFF1 etc.  (This is an x86
>> config...  Did we ever merge that patch to make char signed by default?)
> 
> I meant unsigned not signed.  But actually we debated both ways...
> Signed by default would annoy PowerPC devs since they try to really
> lean into the fact that char is unsigned on that arch.  :P
> 
> https://lwn.net/Articles/911914/
> 

As if anything would be easy nowadays ;-). Anyway, in this case, the array
should be explicitly unsigned, so changing the type to u8 was the right
thing to do. Also, the driver should be usable on non-Intel systems,
which is another reason to make the type sign-specific (even more so in
the context of the above discussion).

Thanks,
Guenter

