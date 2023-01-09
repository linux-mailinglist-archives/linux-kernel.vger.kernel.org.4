Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2FA662833
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjAIOOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjAIOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:14:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02E513D32;
        Mon,  9 Jan 2023 06:14:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F10453ED59;
        Mon,  9 Jan 2023 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673273686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9S9Hp7M6l4jEHkugrulqVkvSK/6qpyC9jzrf+F4o2AA=;
        b=bjOTbDDPTc6RKKH8PgbHeazQVkyID7wRFs/fD33NPgUJ+YKxdAgJgltCjpzO6wXa0qZn8Q
        Iycle1MOic4+MupitdTTYXDzu8AOEgnnSI1G5hzjpRSaY+T8D46x3Bhz+Xgq/OIvqu8AkU
        yY4Q9z7YqTNBbL7hjWLbXwalfq4VF4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673273686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9S9Hp7M6l4jEHkugrulqVkvSK/6qpyC9jzrf+F4o2AA=;
        b=7tK+kmR7F6GyUiFWfzO9O8zODHiZAjh360hh0nMRVEMYSMtGHAJKefaDHdOXVJBUzVENZL
        V0j+Y1P+ppWBVZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C25E813583;
        Mon,  9 Jan 2023 14:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JorTLVYhvGMPJgAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 09 Jan 2023 14:14:46 +0000
Message-ID: <6e81b372-d010-fb75-cdfe-b76c6b197f07@suse.cz>
Date:   Mon, 9 Jan 2023 15:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] docs: Fix the docs build with Sphinx 6.0
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87wn629ggg.fsf@meer.lwn.net>
 <cb916eae-fdf6-504f-8f38-7928e0fa8344@gmail.com>
 <20230108150135.060b0c7a@coco.lan>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <20230108150135.060b0c7a@coco.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/23 15:01, Mauro Carvalho Chehab wrote:
> Em Sat, 7 Jan 2023 14:17:24 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Wed, 04 Jan 2023 13:45:35 -0700, Jonathan Corbet wrote:
>>> Sphinx 6.0 removed the execfile_() function, which we use as part of the
>>> configuration process.  They *did* warn us...  Just open-code the
>>> functionality as is done in Sphinx itself.
>>>
>>> Tested (using SPHINX_CONF, since this code is only executed with an
>>> alternative config file) on various Sphinx versions from 2.5 through 6.0.
>>>
>>> Reported-by: Martin Liška <mliska@suse.cz>
>>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>>
>> I have tested full builds of documentation with this change
>> with Sphinx versions 1.7.9, 2.4.5, 3.4.3, 4.5.0, 5.3.0, and 6.0.0.
>>
>> Tested-by: Akira Yokosawa <akiyks@gmail.com>
>>
>> That said, Sphinx 6.0.0 needs much more time and memory than earlier
>> versions.
>>
>> FYI, I needed to limit parallel slot to 2 (make -j2) on a 16GB machine.
>> If you are lucky, -j3 and -j4 might succeed. -j5 or more ended up in
>> OOM situations for me:
>>
>> Comparison of elapsed time and maxresident with -j2:
>>
>>    ============== ============ ===========
>>    Sphinx version elapsed time maxresident
>>    ============== ============ ===========
>>    5.3.0          10:16.81      937660
>>    6.0.0          17:29.07     5292392
>>    ============== ============ ===========

Hi.

I can confirm the regression, I bisected Sphinx revision that caused that
and filled an upstream issues:
https://github.com/sphinx-doc/sphinx/issues/11116

Cheers,
Martin

> 
>  From the changelogs:
> 	https://www.sphinx-doc.org/en/master/changes.html
> 
> It seems that 6.1 came with some performance optimizations, in particular:
> 
>      Cache doctrees in the build environment during the writing phase.
> 
>      Make all writing phase tasks support parallel execution.
> 
>      Cache doctrees between the reading and writing phases.
> 
> It would be nice if you could also test and check elapsed time
> there too, as I suspect that 6.0 will have a very short usage, as
> 6.1 was released just a few days after it.
> 
> Regards,
> Mauro.
> 
> 
> 
>>
>>          Thanks, Akira
>>
>>> ---
>>>   Documentation/sphinx/load_config.py | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/sphinx/load_config.py b/Documentation/sphinx/load_config.py
>>> index eeb394b39e2c..8b416bfd75ac 100644
>>> --- a/Documentation/sphinx/load_config.py
>>> +++ b/Documentation/sphinx/load_config.py
>>> @@ -3,7 +3,7 @@
>>>   
>>>   import os
>>>   import sys
>>> -from sphinx.util.pycompat import execfile_
>>> +from sphinx.util.osutil import fs_encoding
>>>   
>>>   # ------------------------------------------------------------------------------
>>>   def loadConfig(namespace):
>>> @@ -48,7 +48,9 @@ def loadConfig(namespace):
>>>               sys.stdout.write("load additional sphinx-config: %s\n" % config_file)
>>>               config = namespace.copy()
>>>               config['__file__'] = config_file
>>> -            execfile_(config_file, config)
>>> +            with open(config_file, 'rb') as f:
>>> +                code = compile(f.read(), fs_encoding, 'exec')
>>> +                exec(code, config)
>>>               del config['__file__']
>>>               namespace.update(config)
>>>           else:
>>> -- 
>>> 2.38.1
> 
> 
> 
> Thanks,
> Mauro

