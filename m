Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6FD5E7C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiIWNpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIWNpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:45:34 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15164AB072;
        Fri, 23 Sep 2022 06:45:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 91DAD378;
        Fri, 23 Sep 2022 13:45:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 91DAD378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663940730; bh=hNBiWwThgUqyTe1rjOqsA/BbPGXZ8spv21EYme1ZkQA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QWY+8q7ZMshRXfyj6gmdRp4UaIjrcz99CTyVxr5M8vHdzApl+nYXupZ4urGtavA1Q
         dsfx3yGqmDXPQ6/Lv14oeiROQv3Eu4hFh3D6dOX9RumxGbRVQbt2QgF0pjgGSK1WBz
         qVQ/bvOkekurHmJ6X3yab/wdou9PvCTgnFTvE9Mq9W1tEWXJKFWJGHFlmpNqz2FK/M
         mEIRUaj/okWHH+DqFC79DDjdJCDAmD3U2Jfkwel3xNgIETEmplmmU7qpbz20xN+hUZ
         j/v9FpVTmqf0MWTEa9MEWauHsTUm7L9rIF5QJ02dkcGvRJeKduHyP2H517O2GdNFnG
         ce0+C+mZk2L+w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 0/4] Rewrite the top-level index.rst
In-Reply-To: <7f02143c-461f-268b-0f17-7fe20a7423d6@leemhuis.info>
References: <20220922204138.153146-1-corbet@lwn.net>
 <7f02143c-461f-268b-0f17-7fe20a7423d6@leemhuis.info>
Date:   Fri, 23 Sep 2022 07:45:30 -0600
Message-ID: <875yhep5l1.fsf@meer.lwn.net>
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

Thorsten Leemhuis <linux@leemhuis.info> writes:

> On 22.09.22 22:41, Jonathan Corbet wrote:
>> The top-level index.rst file is the entry point for the kernel's
>> documentation, especially for readers of the HTML output.  It is currently
>> a mess containing everything we thought to throw in there.  Firefox says it
>> would require 26 pages of paper to print it.  That is not a user-friendly
>> introduction.
>
> That's true, but is it maybe good or even important for googleability?
> When you talked about this in your LPC talk this went on in the matrix chat:
>
> ```
> Nur Hussein
> I feel like every existing page needs to be accessible (somehow)
> from that starting page
>
> Zsuzsa Nagy
>
> access to all pages <- findability from a search engine (technical
> author talking here)
>
> step #2 in-site search for those who already landed on your pages
> ```

So every page remains accessible, just like they are now.  They just
aren't linked directly from the front page - as many pages already are
not.  I honestly don't understand what the problem is here.

*No* site links everything directly on its front page.  Even if it had
an effect on search engines, I think it would be wrong to prioritize SEO
over basic usability.

>> This series aims to improve our documentation entry point with a focus on
>> rewriting index.rst.  The result is, IMO, simpler and more approachable.
>> For anybody who wants to see the rendered results without building the
>> docs, have a look at:
>> 
>>   https://static.lwn.net/kerneldoc/
>
> I still think we're doing all this to build something for users and
> hence docs for users should be at the top spot. I'd even think "those
> people are selfish" if I'd look into the docs of a software and find
> texts for developers at the top spot.

Again ... who are the users?  I maintain that the actual users of our
docs are primarily kernel developers.

>> Unless I get screams I plan to slip this into 6.1.  It is definitely not
>> the final form of the front page, but I doubt we'll ever get there; we can
>> change it in whatever ways make sense.
>
> My 2 cent: why the rush? I'd say: let's try to get some feedback from
> Zsuzsa and experts on docs first. I'd be willing to approach them. If
> that doesn't work out over the next few weeks, just merge what you have
> for 6.2.

I want to do it because it's a clear step forward and has already been
pending for a month.  It is surely not perfect, and there will
undoubtedly be changes, perhaps big ones, to come, but I cannot imagine
a scenario where we want to go back to the mess we have now.

Thanks,

jon
