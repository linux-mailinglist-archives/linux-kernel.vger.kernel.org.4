Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0E66342F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbjAIWnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjAIWnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:43:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B0C633B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:43:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 14A455CDE8;
        Mon,  9 Jan 2023 22:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673304210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZRxQ/OEFLF0ZRAZvAP4JUULIQr4b47/DWJewsV7EvkA=;
        b=gEyfvrEbxDIojjwsD7bFN8ark6Q0Uc0+cfP1GvQynjWbVexuYzk47hX9t9+ze8mxZgRhbY
        o3HTbTD1TNKDM1g/QqTp7KlMsL5wDIiQ5qfjBx9tMjitFacr3HTWMRzSpw6K+qtD5Hcfu9
        TYbo5y4v0p56e/eLbJmE5Rrs9aTgN2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673304210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZRxQ/OEFLF0ZRAZvAP4JUULIQr4b47/DWJewsV7EvkA=;
        b=23eoKFiydH8SfRTgiPg3A5UPTMW+IDbN62QPdF4SBlvW/+RZKIDYrHagHN1XvcszLE/Ks6
        j/CIxX4qVis7XgCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3B5E13587;
        Mon,  9 Jan 2023 22:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yqh5NpGYvGN5IQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 Jan 2023 22:43:29 +0000
Message-ID: <f39c266c-9802-71a5-8f1c-2d0a1340f59f@suse.cz>
Date:   Mon, 9 Jan 2023 23:43:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Linux 6.2-rc3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <kees@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
 <20230109174742.GA1191249@roeck-us.net>
 <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
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

On 1/9/23 23:18, Linus Torvalds wrote:
> On Mon, Jan 9, 2023 at 11:47 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
>> include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
> 
> Ok, I guess we'll have to disable this gcc warning for this version
> again. I don't think anybody figured out why it happens. We had
> several people look at it (Kees, Vlastimil, Jaegeuk) and I think
> everybody ended up going "tis looks like a compiler thing".
> 
> Does anybody remember - what was the compiler version again and what
> do we need to disable?

Guenter reported that "The problem is seen with gcc 11.3.0, but not with gcc
12.2.0 nor with gcc 10.3.0."

https://lore.kernel.org/all/20221227002941.GA2691687@roeck-us.net/

Kees said it's -Warray-bounds, already disabled on gcc 12 for other reasons:

https://lore.kernel.org/all/D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org/

