Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391E56C9C33
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjC0Hfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjC0Hfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:35:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB391734
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC0DB80E24
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC9DC433D2;
        Mon, 27 Mar 2023 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679902494;
        bh=K2oIW15RhBxCS54oVebcTobUQkdXp4z3qc7Uqyf7U+0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bH59hrj6R6kDbeNKRxiqgrwYolN+ukVrwBeYu4tjm6uECawAo6frpOXKyWaoPfMot
         8Cy16aYb1BLOKqYji4dB4fU9zLd5Hc4GzNlgDZF1z+IK34V9nUlRzcNQG/CmRlFC8V
         Bi+SnyCUAAuxqraRN16CW4UEy+Ruh/5sdGpU064AnZ2KPrYQ6RALZHwwGIpQYVw/iv
         fxoM8P6/ryZNiBWTH0hz8aUhh96/xRHQQ1aB0J35hEafHfGuaKUbYBhxNYRBFb2T96
         fIaJj0dnsrGS0pZ26sA+F23T5Zc4Li3StnrV8ccW+87Z93yhC3qVZGIKWEgTD5hPe5
         q1yoN6inyBpfg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Change in kernel debian packages between -rc2 and -rc3
References: <20230325143122.GA409315@mit.edu>
        <CAK7LNARndpbtzRAW1kEiqyNBmAxdqJKiTquvY9bW08LYTTMiOg@mail.gmail.com>
        <20230326121118.GB323408@mit.edu>
Date:   Mon, 27 Mar 2023 10:34:47 +0300
In-Reply-To: <20230326121118.GB323408@mit.edu> (Theodore Ts'o's message of
        "Sun, 26 Mar 2023 08:11:18 -0400")
Message-ID: <87pm8utzoo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Sun, Mar 26, 2023 at 12:39:44PM +0900, Masahiro Yamada wrote:
>> 
>> I am afraid you are completely misunderstanding the two versions,
>> the ABI version and the package version.
>> 
>> They do not need to match. Actually, they do not match.
>> 
>> See real Debian (or Ubuntu) systems.
>> 
>> `uname -r` returns '5.10.0-21-amd64'.
>> This is what they call the ABI version, and
>> this is contained as a part of the package name,
>> 'linux-image-5.10.0-21-amd64'
>
> That may be a convention that Debian uses, but I'll point out that
> trying to use this as an ABI version when people are using different
> .config's is not going to end well.  That's because many different
> Kernel configurations will end up making incompatible changes to the
> ABI.  and only works if you are ***super*** careful about not making
> any kind of changes (e.g., the number of CPU's, adding or changing
> various cgroup controllers, all of which will make incompatible kernel
> ABI changes.)
>
> This is "Stable ABI nonsense" is well, nonsense.
>
>> It was _not_ reflected in the package version.
>> This is also correct since the package version
>> is not meant to reflect such user configuration
>> as CONFIG_LOCALVERSION.
>
> Citation, please?  Does the Debian system work in that particular way?
>
> In any case, it's an incompatible regression made during rc2 and rc3,
> which I think is at the very least, unfortunate.

v6.3-rc3 also broke my deb install scripts, so definitely not cool
breaking it like this. Please keep the deb names stable.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
