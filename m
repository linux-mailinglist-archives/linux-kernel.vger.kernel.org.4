Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D200628649
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiKNQ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbiKNQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:57:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAE1303E4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:56:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C8C22015B;
        Mon, 14 Nov 2022 16:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668444986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cohWP967fM5k66eiwPyUCzOvFE5A3xQATFXcYzJTBgI=;
        b=x8PJN/88Rs3HDZEPW4SS73lszJ990ZTjc7y0jGLs1TsAm2/0hhzlKEz9nyBvf6x6OYDVbt
        /rCmgFK6yaPNV0zwY7qwMT2CmdSdnVlXyIrQ4k2B9qrTNRWspbz7+oIl79Qd6OQFofxHTN
        6voNGvj6fjSfCQ6eDXyFwZlJJByGl50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668444986;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cohWP967fM5k66eiwPyUCzOvFE5A3xQATFXcYzJTBgI=;
        b=RZcYSQu9jIglU+wUpMu9+XuS0nOFfr3z7sgt41Fe2Y52l6JV2t+2HrXL88xqAbNaDLLNm+
        VZPSieo85RWXtfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A74F13A92;
        Mon, 14 Nov 2022 16:56:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eUHsBTpzcmMARgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 14 Nov 2022 16:56:26 +0000
Message-ID: <5dc7529d-9edf-4ea7-35d3-a5f3dc55dd5c@suse.cz>
Date:   Mon, 14 Nov 2022 17:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: include: linux: slab: kmalloc_trace undefined when compiling
 drivers
Content-Language: en-US
To:     Ian Cowan <ian@linux.cowan.aero>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <Y2/Luovqgz8O+Kqa@rhino>
 <f83aca33-3a5f-97ac-625e-aa7c72bf60ba@infradead.org> <Y3AXVRAoZA5YEho+@rhino>
 <1df133ef-d5e9-f323-7c67-fc9ffed04274@infradead.org> <Y3A9waTkehESUyn+@rhino>
 <abdb1b8d-859d-669b-6bbf-604febb643b2@infradead.org> <Y3BGimp2LmRqV9oy@rhino>
 <Y3IDWt9vINpCtXjP@hyeyoo> <Y3I3FnPfHObfdIUb@rhino>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y3I3FnPfHObfdIUb@rhino>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 13:39, Ian Cowan wrote:
> On Mon, Nov 14, 2022 at 05:59:06PM +0900, Hyeonggon Yoo wrote:
>> On Sat, Nov 12, 2022 at 08:21:14PM -0500, Ian Cowan wrote:
>> > On Sat, Nov 12, 2022 at 05:11:27PM -0800, Randy Dunlap wrote:
>> > > 
>> > > 
>> > > On 11/12/22 16:43, Ian Cowan wrote:
>> > > > On Sat, Nov 12, 2022 at 04:34:18PM -0800, Randy Dunlap wrote:
>> > > >>
>> > > >>
>> > > >> On 11/12/22 13:59, Ian Cowan wrote:
>> > > >>> On Sat, Nov 12, 2022 at 09:21:34AM -0800, Randy Dunlap wrote:
>> > > >>>> Hi--
>> > > >>>>
>> > > >>>> On 11/12/22 08:37, Ian Cowan wrote:
>> > > >>>>> When compiling drivers (speficially drivers/pci/hotplug), I am receiving
>> > > >>>>> the following modpost error for both `kmalloc_trace` and
>> > > >>>>> `kmalloc_node_trace` on the staging/staging-next branch:
>> > > >>>>>
>> > > >>
>> > > >> Ian, what do you mean by "on the staging/staging-next branch"?
>> > > >>
>> > > >> What kernel version are you trying to build?
>> > > >>
>> > > >> The .config that you sent is for v6.1.0-rc1.
>> > > > 
>> > > > I am building from the staging repository (gregkh/staging) and my
>> > > > working branch when building is staging-next. So I am trying to build
>> > > > from staging and not a particular version. I have also run `make modules_prepare`
>> > > > and updated the .config per that script. However, when I do build
>> > > > v6.1.0-rc1 from the main repository (torvalds/linux), I run into the same problem.
>> > > 
>> > > Have you built the entire kernel already and then you are trying to build
>> > > only drivers/pci/hotplug?
>> > Yes, I did build the entire kernel already and then I'm just trying to
>> > rebuild that module.
>> > 
>> > In `include/linux/slab.h` if I remove the lines between `#ifdef
>> > CONFIG_TRACING` and `#else` (lines 473-480) and then the corresponding
>> > `#endif` and leave lines 481-499, I'm able to compile that module
>> > without issue.
>> 
>> I don't get what the problem is.
>> In case kmalloc[_node]_trace() is undefined, it's replaced with kmem_cache_alloc[_node]. 
>> 
>> Is the kernel built with same config on tree?
> 
> Yes, the same config on tree with no errors or warnings. I was able to
> trace it back to this commit - building on the commit immediately prior
> builds without error or warning. It looks like this commit does some
> refactoring of the kmem_cache_alloc[_node] and kmalloc[_node]_trace.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=26a40990ba052

As you can see in that diff, mm/slab_common.c does
EXPORT_SYMBOL(kmalloc_trace) and EXPORT_SYMBOL(kmalloc_node_trace) so I
don't see why they should be missing.

Wonder if you have a stale mm/slab_common.o because for some reason it's not
being recompiled (a file timestamp in the future?)
Can you rm it and rebuild? And maybe also mm/built-in.a
Or maybe a full make clean and/or a fresh checkout.


