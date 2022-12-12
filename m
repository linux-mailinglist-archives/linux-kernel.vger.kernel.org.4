Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8564AB46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiLLXQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiLLXQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:16:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD21B1FB;
        Mon, 12 Dec 2022 15:16:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05EAC22DF9;
        Mon, 12 Dec 2022 23:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670886968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35MLcCq6HpH8bsuAViCNeoqoqcBRUFZMfU6wBiwZswI=;
        b=hAfxFt0JgNzYfoLVG0Ty62ZdSPjVSScVW/AZ22LDRF7Z3wtXEpFFuUAamp9IJSKIQ67vgw
        qL9A7WndWqz7f87KQY2zQS5Aral8hEMQZDLClIsrXeCt2bD/SE5ZU2ITyHB0Pi25vTVjuQ
        zBlWkT0SEV5LW2KdoafJ2P+89u7YQsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670886968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35MLcCq6HpH8bsuAViCNeoqoqcBRUFZMfU6wBiwZswI=;
        b=rEWmjZZ/HrMzEX1BSsxGw+GP3yQvQisFieoRQ186DJu8zM096s+Sftg+o9EtcgW7FPgDIq
        l54zm3f+6FMs3xDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEFAE13456;
        Mon, 12 Dec 2022 23:16:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vm26NTe2l2PfOAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 12 Dec 2022 23:16:07 +0000
Message-ID: <e7c6b99a-743f-f40a-0b0f-31730964cb36@suse.cz>
Date:   Tue, 13 Dec 2022 00:16:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] non-MM commits for 6.2-rc1
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
 <Y5eoS/UfBhovR70j@zx2c4.com>
 <20221212142754.5f699c4ff515fd9d42768fb2@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221212142754.5f699c4ff515fd9d42768fb2@linux-foundation.org>
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

On 12/12/22 23:27, Andrew Morton wrote:
> On Mon, 12 Dec 2022 15:16:43 -0700 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> 
>> On Mon, Dec 12, 2022 at 01:44:25PM -0800, Andrew Morton wrote:
>> >       wifi: rt2x00: use explicitly signed or unsigned types
>> 
>> Why is this part of your PULL? This was a netdev/wireless tree fix which
>> was in 6.1-rc5. Kalle wrote that he took it on 21 Oct 2022 in:
>> https://lore.kernel.org/all/166633563389.6242.13987912613257140089.kvalo@kernel.org/
>> 
> 
> Huh.  I guess git quietly accepts the identical commit, so Stephen
> never told me and my test-merge-with-Linus-latest also came up clean. 
> Which leaves it to me to manually handle these things, and that's
> unreliable.
> 
> Is there some way of telling git to complain about identical changes
> when doing a trial merge?
 
Probably not exactly that, but there seems to be a way with "git cherry". Dunno
how reliable in practice, seems to be based on patch-id so probably can fail
easily if the commit or context changes slightly?

$ git checkout mm-nonmm-stable-2022-12-12
$ git cherry -v origin/master
+ eabb7f1ace53e127309407b2b5e74e8199e85270 lib/debugobjects: fix stat count and optimize debug_objects_mem_init
+ 461cc6e54ececa86007d44b0ff2521f75b872745 arc: ptrace: user_regset_copyin_ignore() always returns 0
...
+ d472cf797c4e268613dbce5ec9b95d0bcae19ecb debugfs: fix error when writing negative value to atomic_t debugfs file
- d04bb0852b8bd31c53981a04ff0132698d24523d wifi: rt2x00: use explicitly signed or unsigned types
+ 3965292ad0ca70320f1c632f2ac3b886c88b9e80 checkpatch: add check for array allocator family argument order
...

Seems to have worked in this case and flagged the wifi commit with '-'

HTH,
Vlastimil
