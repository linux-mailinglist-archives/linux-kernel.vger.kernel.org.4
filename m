Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7097D6248D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiKJR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiKJR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:59:08 -0500
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 09:59:05 PST
Received: from welho-filter3.welho.com (welho-filter3b.welho.com [83.102.41.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1145A22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:59:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by welho-filter3.welho.com (Postfix) with ESMTP id 7499113599;
        Thu, 10 Nov 2022 19:50:07 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from welho-smtp1.welho.com ([IPv6:::ffff:83.102.41.84])
        by localhost (welho-filter3.welho.com [::ffff:83.102.41.25]) (amavisd-new, port 10024)
        with ESMTP id taeA9fSntBK7; Thu, 10 Nov 2022 19:50:07 +0200 (EET)
Received: from [192.168.0.20] (82-181-37-202.bb.dnainternet.fi [82.181.37.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by welho-smtp1.welho.com (Postfix) with ESMTPSA id 142A27A;
        Thu, 10 Nov 2022 19:50:05 +0200 (EET)
Message-ID: <a6deb895-342c-ca32-fa3c-39d6c826d70c@helsinkinet.fi>
Date:   Thu, 10 Nov 2022 19:50:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH printk v3 24/40] tty: nfcon: use console_is_registered()
Content-Language: en-US
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-25-john.ogness@linutronix.de>
 <Y20DoLPsrfgm528O@alley> <87cz9u6gfd.fsf@jogness.linutronix.de>
From:   Eero Tamminen <oak@helsinkinet.fi>
To:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
In-Reply-To: <87cz9u6gfd.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10.11.2022 16.19, John Ogness wrote:
> On 2022-11-10, Petr Mladek <pmladek@suse.com> wrote:
...
>>> @@ -106,10 +106,8 @@ static int __init nf_debug_setup(char *arg)
>>>   		return 0;
>>>   
>>>   	stderr_id = nf_get_id("NF_STDERR");
>>> -	if (stderr_id) {
>>> -		nf_console.flags |= CON_ENABLED;
>>> +	if (stderr_id)
>>>   		register_console(&nf_console);
>>
>> My understanding is that this should enable the console
>> when debug=nfcon kernel parameter is used.
>>
>> It is a non-standard way. This is why CON_ENABLED flag
>> has to be explicitly set.
> 
> Understood. I will add a comment explaining why CON_ENABLED is set here.

NatFeats is emulator feature.  If you want to test the resulting kernel, 
you can use either Aranym or Hatari emulator.

Aranym NF docs are here:
https://github.com/aranym/aranym/wiki/natfeats-proposal

Hatari m68k linux docs are here:
https://hatari.tuxfamily.org/doc/m68k-linux.txt


	- Eero
