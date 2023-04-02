Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F36D3962
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjDBRNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDBRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168944EFF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8050612B2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 17:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F37BC433EF;
        Sun,  2 Apr 2023 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680455613;
        bh=sQegoACIUBNcRL//rJKbKeIXXZJJHSxLLKBYJ/C2xlQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fBX39ciNtkdxb1pPnsHyTOl26UXhiGj+jewXtttpYk/QuRaItdisqvU0PL8lUcJn7
         CeHReRn/J95EEoyUrGHNE2/FbhIhbXjn0GHQIl3jaHuTaYnW9XrMQV8MYqcVtbImvl
         8l2oY4Lqr+Sj9E4PDTJILATYMjO5x/JaxV2WUGZqWufbX+AqmQzzTX/o8xgMjazauH
         EcTkqtOEMmjj72Xpfag1z+clTlj1dDvLHu+QgqOEhGBY6kwOcKLO0bNvj8Cu5E7t5F
         lu51mDIDN/7dvErYmxcC8qTjl+MiOTRFwi4XxueSMrDHfb14vYltinyxg7/XqOlkLc
         VG9jNYO4DfiMg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 99F62154047C; Sun,  2 Apr 2023 10:13:32 -0700 (PDT)
Date:   Sun, 2 Apr 2023 10:13:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, v@vda.io, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools/nolibc: assorted build fixes for nolibc-test
 in rare cases
Message-ID: <369c34e4-3ed0-44fe-817f-e724a02bdb02@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230402081357.12078-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402081357.12078-1-w@1wt.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 10:13:55AM +0200, Willy Tarreau wrote:
> Hello Paul,
> 
> please find in this series two small build fixes. One of them concerns
> two missing include files for building the test against other libc (at
> least glibc) since we added the tests for integer types and ranges. The
> second one removes a single occurrence of a variable definition inside
> the init statement of a for loop that breaks with older compilers which
> do not default to c99. They're still convenient to test the portability
> of the lib itself and I continue to use them for this purpose.
> 
> I consider that there's no rush on this, since these issues only affect
> developers adding test cases, who should normally rebase on top of your
> dev branch. So it's fine if it goes there.

Queued and pushed for the v6.5 merge window (the one after the upcoming
one), thank you!

							Thanx, Paul

> Thank you!
> Willy
> 
> Willy Tarreau (2):
>   tools/nolibc: tests: fix build on non-c99 compliant compilers
>   tools/nolibc: fix build of the test case using glibc
> 
>  tools/testing/selftests/nolibc/nolibc-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.5
> 
