Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6043C667ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjALQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbjALQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:25:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E215823;
        Thu, 12 Jan 2023 08:22:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACB4E4DAD1;
        Thu, 12 Jan 2023 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673540562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pwNcTBY1rS5VS2EgKXmxicqFSha76d0FxJN1NQDRFs=;
        b=BPFON9Z/l2kCkk6bNsfwX8A5n3sMeY8DZpQjUAsqkjJBPoyJuut+UOk5wt+SY3cssbmoOv
        1/tDRYtBpdSiQ25KvQfd/4hJIcpC8/FjBALT6QOgb6N6YfxoUEaRx7q5SRVN5wCu/wZYFs
        jF/STnHYAkwmdFWxAGJUKPDWiXB9hOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673540562;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pwNcTBY1rS5VS2EgKXmxicqFSha76d0FxJN1NQDRFs=;
        b=l2cwg/BJ6F8FTj91DDdoWHuwUU3spoNB0Ur+6qj4qGeKDqS5F2v27oXXTGhuaf6qgx+o32
        s/xqg2ns+6buxnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D09513585;
        Thu, 12 Jan 2023 16:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sENIIdIzwGPuQQAAMHmgww
        (envelope-from <mliska@suse.cz>); Thu, 12 Jan 2023 16:22:42 +0000
Message-ID: <c84fe7eb-27b7-aca7-24a6-09ca67dca43f@suse.cz>
Date:   Thu, 12 Jan 2023 17:22:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] docs: Fix the docs build with Sphinx 6.0
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <87wn629ggg.fsf@meer.lwn.net>
 <cb916eae-fdf6-504f-8f38-7928e0fa8344@gmail.com>
 <20230108150135.060b0c7a@coco.lan>
 <6e81b372-d010-fb75-cdfe-b76c6b197f07@suse.cz>
 <e2d98136-3c4c-8910-d116-93070c48474d@gmail.com>
 <bdd04f2e-64a4-e3ef-eb4c-3681c6f52c2f@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <bdd04f2e-64a4-e3ef-eb4c-3681c6f52c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 00:13, Akira Yokosawa wrote:
> On Tue, 10 Jan 2023 00:17:11 +0900, Akira Yokosawa wrote:
>> On Mon, 9 Jan 2023 15:14:46 +0100, Martin Liška wrote:
>>> Hi.
>>>
>>> I can confirm the regression, I bisected Sphinx revision that caused that
>>> and filled an upstream issues:
>>> https://github.com/sphinx-doc/sphinx/issues/11116
>>
>> Thank you Martin for looking into this!
> 
> Thanks to Martin's inputs on the github issue, Sphinx 6.1.3 has released
> and the issue is resolved for parallel builds.

You're welcome.

> 
> However, for non-parallel builds, the memory hog still remains.
> Again, this is a table comparing 5.3.0, 6.1.2, and 6.1.3.
> 
>  ======  ===================================  ===============================
>                      elapsed time                       maxresident
>          -----------------------------------  -------------------------------
>  Sphinx     -j1     -j2      -j4      -j6       -j1     -j2     -j4     -j6
>  ======  ======== ======== ======== ========  ======= ======= ======= =======
>   6.1.3  15:03.83 11:31.99  9:35.15  8:49.01  2949056 1059516  978232  967400
>   6.1.2  15:11.74 18:06.89 16:39.93      OOM  2961524 5548344 5255372      --
>   5.3.0  14:13.04 10:16.81  8:22.37  8:09.74   711532  937660  846016  800340
>  ======  ===================================  ===============================

I thank you for the nice numbers you provided.

> 
>     Note:
>       - The -j1 run needs an explicit option given to sphinx-build:
>         make SPHINXOPTS="-q -j1" htmldocs
> 
> I naively assumed that the memory hog would be resolved all together,
> but that's not the case.

Yep, I would expect that same.

> 
> Martin, could you report the remaining issue to upstream Sphinx?

Sure: https://github.com/sphinx-doc/sphinx/issues/11124

Btw. do you have an Github account I can CC?

Cheers,
Martin

> 
>         Thanks, Akira
> 
> 

