Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546B45EF0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiI2Iut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiI2Iuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:50:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2CEC54B;
        Thu, 29 Sep 2022 01:50:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x1so699751plv.5;
        Thu, 29 Sep 2022 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wyRrlcXzeH4HfHGAImk3NaXe74TrWSFA0ErQXL3Lurc=;
        b=Z6oEko58X6cyAidL5cdLdPtKhJkWxMzfPWazsgsBy2UGktfhzdoqIRABYzT1KRxekx
         bVgp28KwDTcUK/6IHsIfklW1ZhMtkSg36n+zMTH0wfnUORl18OOEcMEz2ddavj8BSEFy
         9RMRyzJ10828D5WFtdqtWUZcPUQ1oQIoqrh9qgAy997yp9S/8gOSAuFgEywGiqWHmVYV
         jqg+AZ8zSyT7LpIZpJxBuMHkTYayRWDaeH4+OIjJn8w4A8v0cKDMeZ2UKJJ/b/2GPLq4
         IkM3jTz5Sux5fwUnw4aJTYUBY9ygMg3mOp/OOBvLkr19needaXPyYlKqtT1UbYCLbNmB
         nYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wyRrlcXzeH4HfHGAImk3NaXe74TrWSFA0ErQXL3Lurc=;
        b=QbJJwU7zA7EUzlK1iN7CqxRGYEUM4tRpfcHu07FTfUtzo+91eH3Z9MXpvhlLKWW18E
         Qpj4mCaYbTiR4YUst7SbFcwxItO6WZPFzUHeU7VCx1ZKqeQeuqX9HV4VBoqZCk7+aP1d
         vEkOguMoWlsHTmSYtN9BHn1blk4FLf/KckpnZg5PMLjnBWcO5ELaq0E6w+VM4XcNzOfY
         lt3PTrxOoonjHxom5R7ETmaQXdl3oPBMw1gg71LQ17veBuRKJmUGIJAdruYZOQlPIYfh
         LRNO6wJBwZTnKlqxeRHRJAnreIIrYbRN8N12akAbkKCYDgx4Wtm4WewqGSSyFoHZlDV9
         QYzw==
X-Gm-Message-State: ACrzQf38q08nS7tyn76gL/rK8dcyvgHYp57Cf1bmKDZHDwqHHEbx9Orv
        mwaEnLCgJBB9Jzyj4CXdfws=
X-Google-Smtp-Source: AMsMyM403XL05GVHUaJT8ocLDAA2Z1Prgmxaf+M7UlldPke0HpTgHrpCYBoEoYdvRv1R3vhpLLZj4Q==
X-Received: by 2002:a17:902:8e84:b0:178:71f2:113c with SMTP id bg4-20020a1709028e8400b0017871f2113cmr2324788plb.79.1664441433296;
        Thu, 29 Sep 2022 01:50:33 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-28.three.co.id. [180.214.232.28])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b0017808db132bsm5365039plg.137.2022.09.29.01.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:50:32 -0700 (PDT)
Message-ID: <71effcc8-7345-28cd-6585-eb729fb4c6db@gmail.com>
Date:   Thu, 29 Sep 2022 15:50:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/4] serial: Convert serial_rs485 to kernel doc
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
 <20220928110509.13544-2-ilpo.jarvinen@linux.intel.com>
 <YzURJa1RnxP+uj5/@debian.me>
 <75f07dbe-d1dd-ac18-5c8e-e6972e7fb28b@linux.intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <75f07dbe-d1dd-ac18-5c8e-e6972e7fb28b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 15:39, Ilpo Järvinen wrote:
> On Thu, 29 Sep 2022, Bagas Sanjaya wrote:
> 
>> On Wed, Sep 28, 2022 at 02:05:06PM +0300, Ilpo Järvinen wrote:
>>> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
>>> index cea06924b295..6e347eb10b1f 100644
>>> --- a/include/uapi/linux/serial.h
>>> +++ b/include/uapi/linux/serial.h
>>> @@ -107,37 +107,57 @@ struct serial_icounter_struct {
>>>  	int reserved[9];
>>>  };
>>>  
>>> -/*
>>> +/**
>>> + * struct serial_rs485 - serial interface for controlling RS485 settings.
>>> + * @flags:			RS485 feature flags.
>>> + * @delay_rts_before_send:	Delay before send (milliseconds).
>>> + * @delay_rts_after_send:	Delay after send (milliseconds).
>>> + * @addr_recv:			Receive filter for RS485 addressing mode
>>> + *				(used only when %SER_RS485_ADDR_RECV is set).
>>> + * @addr_dest:			Destination address for RS485 addressing mode
>>> + *				(used only when %SER_RS485_ADDR_DEST is set).
>>> + * @padding0:			Padding (set to zero).
>>> + * @padding1:			Padding (set to zero).
>>> + * @padding:			Deprecated, use @padding0 and @padding1 instead.
>>> + *				Do not use with @addr_recv and @addr_dest (due to
>>> + *				overlap).
>>> + *
>>
>> I don't see definition of fields after @delay_rts_after_send in the
>> htmldocs output.
> 
> So it seems, this one I had missed. I guess the reason is that those 
> members are inside anonymous unions. But the formatting follows what 
> is documented here AFAICT:
> 
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#nested-structs-unions
> 
> Kerneldoc doesn't seem to live up to what is documented about it. It's a 
> bit ironic that documentation system fails to document even itself to 
> sufficient level, and what's worse, seems to be full of faulty examples.
> 
> Any suggestions how to make it work?
> 

CC'ing Akira.

>>>   * Serial interface for controlling RS485 settings on chips with suitable
>>>   * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by your
>>>   * platform. The set function returns the new state, with any unsupported bits
>>>   * reverted appropriately.
>>> + *
>>> + * serial_rs485::flags bits are:
>>> + *
>>> + * * %SER_RS485_ENABLED		- RS485 enabled.
>>> + * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
>>> + * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after sent.
>>> + * * %SER_RS485_RX_DURING_TX	- Full-duplex RS485 line.
>>> + * * %SER_RS485_TERMINATE_BUS	- Enable bus termination (if supported).
>>> + * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
>>> + * * %SER_RS485_ADDR_RECV	- Receive address filter (enables @addr_recv).
>>> + *				  Requires %SER_RS485_ADDRB.
>>> + * * %SER_RS485_ADDR_DEST	- Destination address (enables @addr_dest).
>>> + *				  Requires %SER_RS485_ADDRB.
>>
>> The last two items are rendered as bold text instead (maybe due to missing
>> fields rendering above?)
> 
> It just goes into some random formatting mode here. Even if I remove those 
> field markers (@) it doesn't do formatting differently so your guesss is 
> wrong.
> 
> I found now a way to make it work though. It works when I put the whole 
> description on a single line but it comes at the cost of removing the 
> alignment of those "-". The other way to make it work would be like this:
> 
> * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv).
>     Requires %SER_RS485_ADDRB.
> 
> ...And that's no good. I guess the single-line approach is an acceptable 
> compromise for this case.
> 

OK, thanks for explaining.

-- 
An old man doll... just what I always wanted! - Clara
