Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AC05ECF09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiI0U7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiI0U7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:59:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14965BF68;
        Tue, 27 Sep 2022 13:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KpOqN5Yf3szXLSSt+oz47DWEKMQrHgd9mzGF3re6HAQ=; b=R8riLb6mTzvJQ4ln1BMBhEqcNP
        puiE/ptVdIKX++axdP70d9MSH0l/xoE2ZzgQfSZSDHMUWUvef66zAyEn7UEFKdtEWOW846nn6/j3s
        2+V2ynXX9hDa2TO1lESdDOxbB+aS4hs8xHzH4IpWR5GjWxpU59rsZP/7CP2DwKPwMpWZqE7TVeThn
        PVKzp7hjedyPjltZp5+5J31dOTHZYI3OoxMGx5HWksJKCQIr9byqUDffJG8/x87+mZYlIyb76UK2q
        BT12ywIPk+kNQkYQD8b7wm5rB66Lav4+0FVDx6ZpgYXUT0WFGAJMcNnrOjcnOWX6yGTfT3PtNSDeu
        SATH61bw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odHfw-00Cd0h-Ve; Tue, 27 Sep 2022 20:59:33 +0000
Message-ID: <877722ad-bf2c-bc9c-e637-4c2e73491bae@infradead.org>
Date:   Tue, 27 Sep 2022 13:59:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 0/7] Rewrite the top-level index.rst
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>
References: <20220927160559.97154-1-corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220927160559.97154-1-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/22 09:05, Jonathan Corbet wrote:
> The top-level index.rst file is the entry point for the kernel's
> documentation, especially for readers of the HTML output.  It is currently
> a mess containing everything we thought to throw in there.  Firefox says it
> would require 26 pages of paper to print it.  That is not a user-friendly
> introduction.
> 
> This series aims to improve our documentation entry point with a focus on
> rewriting index.rst.  The result is, IMO, simpler and more approachable.
> For anybody who wants to see the rendered results without building the
> docs, have a look at:
> 
>   https://static.lwn.net/kerneldoc/

LGTM. Thanks.

for the series:
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> This time around I've rendered the pages using the "Read The Docs" theme,
> since that's what everybody will get by default.  That theme ignores the
> directives regarding the left column, so the results are not as good there.
> I have a series proposing a default-theme change in the works, but that's a
> separate topic.
> 
> This is only a beginning; I think this kind of organizational effort has to
> be pushed down into the lower layers of the docs tree itself.  But one has
> to start somewhere.
> 
> CHANGES from v2: now with less sloppiness.  I've tried to respond to all of
> the review comments.  scripts/checkpatch.pl has been updated to match the
> new location of asm-annotations.rst.  There is also now a link to the man
> pages in the user-oriented documentation section.
> 
> CHANGES from v1: I've tried to address the comments from v1, further
> cleaning up the front page.  I've added the "reporting issues" and "kernel
> testing" documents there, and done a bit of cleanup.  There is plenty more
> yet to be done.


-- 
~Randy
