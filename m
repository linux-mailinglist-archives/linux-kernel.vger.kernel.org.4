Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31A6719400
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjFAHSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjFAHSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:18:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B70129
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:18:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46B7221993;
        Thu,  1 Jun 2023 07:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685603928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2g1ofEXB91j5w+TmBR/NpzxVxTA77l1U/bYNGicMTA=;
        b=BxglkISk9kFiV+b267g1AAOJkB0qFQsNYCZlPlM4gIj0R+vjYUimICThshulmeaNLbW/66
        v8+1lkVAyyPYjaoiPUWD8Tn0TMcY0aA83/FA5n2CW5JQio9ufA8agrlG3DmQC5mRb0Wd4D
        caoGItmMc0EOphm7Iv94mbidcBRuQu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685603928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2g1ofEXB91j5w+TmBR/NpzxVxTA77l1U/bYNGicMTA=;
        b=zaVg/KIi2m+Ya5ff6DCpwpJeUa88ST6uycVFZwjmjfAtz7pJUXwWCqYWggviOaWzxd0S3Y
        CxqPbFF/+YNc5mBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0763613441;
        Thu,  1 Jun 2023 07:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lBkTAVhGeGQ/XwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 01 Jun 2023 07:18:48 +0000
Message-ID: <38f847ed-69dc-d5da-5822-bd9da753fc30@suse.cz>
Date:   Thu, 1 Jun 2023 09:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Fwd: Started to get "memfd_create() without MFD_EXEC nor
 MFD_NOEXEC_SEAL"
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jeff Xu <jeffxu@google.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stuart Foster <smf-linux@virginmedia.com>
References: <69dad53e-9363-c551-111a-d0051bb0265f@gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <69dad53e-9363-c551-111a-d0051bb0265f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 04:07, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Recent kernels seem to generate this:
>> 
>> "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3976 'Xorg'"
>> 
>> Is this a kernel problem or something to do with Xorg ?
>> 
>> Seen in Kernels 6.3.4 and 6.4.0-rc4.
>> 
>> Thanks
> 
> See Bugzilla for the full thread and attached logs (dmesg, xorg, bisection
> log).
> 
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: 105ff5339f498a https://bugzilla.kernel.org/show_bug.cgi?id=217508
> #regzbot title: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL on Xorg

Hm indeed it seems to have introduced 2 new flags and immediately warn if
any process doesn't use them. Maybe it would make sense for some of the
non-default values of vm.memfd_noexec, but it's too early to warn
unconditionally everywhere, no?

> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217508
> 

