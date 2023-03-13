Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703946B7D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCMQ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjCMQ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:26:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284D077E2E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:26:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDFF31FE0E;
        Mon, 13 Mar 2023 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678724779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSRdEVYjIp3MPfK6d1mb8MjcriEK9DC473gzAVaXYC4=;
        b=NXt0ygQ5dQYT2n0avtfdCcn1HyyFiIaVgfT4u/L6yNULFuYxnVZc/P/+QoR4pI0XQ7EOkJ
        BqlpCMlbDZtUIDLGqVym7G0Tu7oFuz4zdJ06rDtuitNO8lyIGwA5tqaYWNvOHrpAbxg1a4
        sL+TleXLvIyU5YtBAJbUhA5bMRB0e80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678724779;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSRdEVYjIp3MPfK6d1mb8MjcriEK9DC473gzAVaXYC4=;
        b=/ViIEdP1QPQw63BYLqTLgjilMHEV49DDb7/K8iE2xQL6A7TxdzbTmTD8zFU4k7LDiX85W/
        gA1mT8ajCadaIADA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B136F13517;
        Mon, 13 Mar 2023 16:26:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xEq+KatOD2QIDwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Mar 2023 16:26:19 +0000
Message-ID: <b0ceb6a5-5949-2e0b-0634-e9d991c43188@suse.cz>
Date:   Mon, 13 Mar 2023 17:26:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/slub: fix help comment of SLUB_DEBUG[_ON]
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vernon Yang <vernon2gm@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230222232058.66971-1-vernon2gm@gmail.com>
 <Y/a7db7v9zJJnX30@localhost>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y/a7db7v9zJJnX30@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 02:03, Hyeonggon Yoo wrote:
> On Thu, Feb 23, 2023 at 07:20:58AM +0800, Vernon Yang wrote:
>> Since commit 081248de0a02 ("kset: move /sys/slab to /sys/kernel/slab"),
>> the SYSFS path of slab was modified, so fix up the help comment of
>> SLUB_DEBUG to use the correct one.
>> 
>> And now the "slub_debug" parameter on boot that is support for more
>> fine grained debug control, so fix up help comment of SLUB_DEBUG_ON
>> for "no support" to "support".
>> 
>> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
>> ---
>>  mm/Kconfig.debug | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
>> index fca699ad1fb0..732043bf56c6 100644
>> --- a/mm/Kconfig.debug
>> +++ b/mm/Kconfig.debug
>> @@ -61,8 +61,8 @@ config SLUB_DEBUG
>>  	help
>>  	  SLUB has extensive debug support features. Disabling these can
>>  	  result in significant savings in code size. This also disables
>> -	  SLUB sysfs support. /sys/slab will not exist and there will be
>> -	  no support for cache validation etc.
>> +	  SLUB sysfs support. /sys/kernel/slab will not exist and there
>> +	  will be no support for cache validation etc.
> 
> After commit ab4d5ed5eeda ("slub: Enable sysfs support for !CONFIG_SLUB_DEBUG"),
> "Disabling SLUB_DEBUG also disables SLUB sysfs support" is not true anymore.

Yeah we could say that /sys/kernel/slab will exist but will not provide e.g.
cache validation.

>>  config SLUB_DEBUG_ON
>>  	bool "SLUB debugging on by default"
>> @@ -73,10 +73,10 @@ config SLUB_DEBUG_ON
>>  	  Boot with debugging on by default. SLUB boots by default with
>>  	  the runtime debug capabilities switched off. Enabling this is
>>  	  equivalent to specifying the "slub_debug" parameter on boot.
>> -	  There is no support for more fine grained debug control like
>> -	  possible with slub_debug=xxx. SLUB debugging may be switched
>> -	  off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
>> -	  "slub_debug=-".
>> +	  There is support for more fine grained debug control like
>> +	  possible with slub_debug=xxx, details in Documentation/mm/slub.rst.
>> +	  SLUB debugging may be switched off in a kernel built with
>> +	  CONFIG_SLUB_DEBUG_ON by specifying "slub_debug=-".
> 
> I think this is a misunderstanding. SLUB_DEBUG_ON is equivalent to
> passing boot parameter slub_debug=FUPZ, and what the help text says is that
> 
> "You can enable slub debugging by default using this config option but
>  there is no support for fine-grained control like what slub_debug
>  boot parameter provides."
> 
>  IOW SLUB_DEBUG_ON cannot be used to have same effect as passing
>  something like slub_debug=F.

Agree with both comments. Vernon, will you send an updated patch?

>>  
>>  config PAGE_OWNER
>>  	bool "Track page owner"
>> -- 
>> 2.34.1
>> 
>> 

