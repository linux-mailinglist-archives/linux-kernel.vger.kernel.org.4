Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38455EFC07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiI2Rby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiI2Rbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:31:51 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE2D1F11D1;
        Thu, 29 Sep 2022 10:31:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D48782C5;
        Thu, 29 Sep 2022 17:31:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D48782C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664472710; bh=LA89bzVbd6Dxqi9oYpscXv0N7S8TvcbIPChAe2BE2OE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dLQlVPoMW1n0EKvEQpDFeismuI57/QckJr8AJoEZzPz2HZC6D8cQwJznGmKZUpX0J
         UzQLk0AIPGN8qYQXGgTKG29TgM9RjX6NWc87w4NZGyQYtcPtnTk6FBwKCAtGjcbbjz
         yLK7f5dLDDhDn5U+ukxQy3tVHJwcvdjw6L7qh1cJ45wo6NUV5zHV8LXV9ENEawUDYi
         BIAqSrMJt94HKiVK0ubAf+5kB2KEX+Fof6uRodUo+v2FRPENr79S0g+RIA5JmkA0Iu
         2nXqGMrAIx8VJ/GvtHaeW3EyEr+G/HTg/gm5klTZT0dWLcnGYIpiTbCNMPtm/KlYpo
         r1HSrDamo5WjQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v3 0/7] Rewrite the top-level index.rst
In-Reply-To: <202209290858.4A3FC9082@keescook>
References: <20220927160559.97154-1-corbet@lwn.net>
 <87mtaii491.fsf@meer.lwn.net> <202209290858.4A3FC9082@keescook>
Date:   Thu, 29 Sep 2022 11:31:49 -0600
Message-ID: <87ill6hyt6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Sep 29, 2022 at 09:34:18AM -0600, Jonathan Corbet wrote:
>> Jonathan Corbet <corbet@lwn.net> writes:
>> 
>> > The top-level index.rst file is the entry point for the kernel's
>> > documentation, especially for readers of the HTML output.  It is currently
>> > a mess containing everything we thought to throw in there.  Firefox says it
>> > would require 26 pages of paper to print it.  That is not a user-friendly
>> > introduction.
>> >
>> > This series aims to improve our documentation entry point with a focus on
>> > rewriting index.rst.  The result is, IMO, simpler and more approachable.
>> > For anybody who wants to see the rendered results without building the
>> > docs, have a look at:
>> >
>> >   https://static.lwn.net/kerneldoc/
>> 
>> So I think I'll go ahead and drop this into docs-next shortly.  Thanks
>> to everybody who has commented.
>> 
>> This, of course, has the potential to create conflicts with other 6.1
>> work that touches Documentation/index.rst.  Amazingly, as far as I can
>> tell, there is only one linux-next commit touching that file - the
>> addition of the Rust docs.  We'll want to be sure that doesn't get lost
>> during the merge window.  I'll be sure to include a suitable heads-up in
>> my pull request.
>
> I can add a note in my PR of Rust too -- how should I suggest it be
> resolved?

The Rust documentation change to Documentation/index.rst is simple
enough:

> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 4737c18c97ff..00722aa20cd7 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -82,6 +82,7 @@ merged much easier.
>     maintainer/index
>     fault-injection/index
>     livepatch/index
> +   rust/index

The resolution should take the docs-next version of the file, but add
that line after "livepatch/index" in its new location.

Thanks,

jon
