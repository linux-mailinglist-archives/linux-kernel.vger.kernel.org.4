Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB768862D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBBSPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjBBSOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:14:52 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB371CAF5;
        Thu,  2 Feb 2023 10:14:52 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DCA467F9;
        Thu,  2 Feb 2023 18:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DCA467F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675361692; bh=URykxkm+B/bxSKxIteGcBEDebNhTkwcRj+Ep2GbWutc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hMkB7+phsvoliGTNRAUXnOVBoYG4oOuCE15coZT8YaYoC+RnyOexi+x4zku0Z19WR
         cTslskjsB4DD919V8r2RfJkWe/quQYjY7Qv12fiGl1nu8gq4NM6saxDUl7Ys+2I6b7
         1PILPoEz2EvZ/y8hgymNjF+TBOUyJ/65lj4JFnbl4lqFOPjn4APlAXL4byhqnCzjWf
         Lm3ERlmmM6aOJ+lj1OcmVSABx+JZJ8JYy4WzXIrbFM1uka51/02QYGAjEpUtbKe39X
         oaMDWjJged1lc+eHZQqhzZ7Sx4EGXdep/JBtR8kdpeTQSyyXK/6wK5rxfPx+yKymZJ
         xXzE2NlvAbDFw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tracing/histogram: Wrap remaining shell snippets in
 code blocks
In-Reply-To: <20230129031402.47420-1-bagasdotme@gmail.com>
References: <202301290253.LU5yIxcJ-lkp@intel.com>
 <20230129031402.47420-1-bagasdotme@gmail.com>
Date:   Thu, 02 Feb 2023 11:14:51 -0700
Message-ID: <871qn8vsro.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Most shell command snippets (echo/cat) and their output are already in
> literal code blocks. However a few still isn't wrapped, in which the
> htmldocs output is ugly.
>
> Wrap the remaining unwrapped snippets, while also fix recent kernel test
> robot warnings.
>
> Link: https://lore.kernel.org/linux-doc/202301290253.LU5yIxcJ-lkp@intel.com/
> Fixes: 88238513bb2671 ("tracing/histogram: Document variable stacktrace")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/trace/histogram.rst | 93 ++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 46 deletions(-)

So this is a good cleanup and I'd like to apply it, but it doesn't come
close to applying to docs-next.  Which tree did you do this against?

Thanks,

jon
