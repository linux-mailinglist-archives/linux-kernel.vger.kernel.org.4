Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F8678D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjAXBGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAXBGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:06:11 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B413756F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:06:07 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 41855824E0;
        Tue, 24 Jan 2023 01:06:04 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674522367;
        bh=+N1TAk23R+sr7LDX9WLDQgAOiTO+vJ3bImLnwUgTUeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwoZhDhW/49qboqynwnJnYR1KdUkJPAUf4nbLubG1xMHkqJCBEguS64iaXETgWnym
         qEOomS1Zqcc5KuuGVoPGaS6JHkuOsaXk5wNmeqLZwL4Silrnq68M11w0wVcRD0ixLs
         fD25DBd3OdvupB+C2Uc48x+Y5Skme1D7k6yG6cnzTEzjVq+cVcxFElTbXKGj2XfxOw
         SlJ7dosP+q7vrLq8Xd/bbvW1dKOZ7+ANVS/tFPb0Pg9m+lJn1g89+mnJkD8q3eyQxW
         Jl5JDTQDJ/8ssG1z6sPSqoNVSiim1sOAoFmyjdRQi9KRea+cTYjJ1hzRY1Ttx/0FE6
         2zazauHQD8psQ==
Date:   Tue, 24 Jan 2023 08:06:00 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH RFC] tools/nolibc: Add gitignore to avoid git complaints
 about sysroot
Message-ID: <Y88u+KnrxjrC+NBe@biznet-home.integral.gnuweeb.org>
References: <20230124004707.GA318943@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124004707.GA318943@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 04:47:07PM -0800, Paul E. McKenney wrote:
> Testing of nolibc can produce a tools/include/nolibc/sysroot file, which
> is not known to git.  Because it is automatically generated, there is no
> reason for it to be known to git.  Therefore, add a .gitignore to remove
> it from git's field of view.

Yeah, I hit the same "git status" complaint and have a pending patch
for that too:

https://github.com/ammarfaizi2/linux-block/commit/89bfe86a03c173863de12.patch

^ I'll drop this one.

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> 
> diff --git a/tools/include/nolibc/.gitignore b/tools/include/nolibc/.gitignore
> new file mode 100644
> index 0000000000000..dea22eaaed2ba
> --- /dev/null
> +++ b/tools/include/nolibc/.gitignore
> @@ -0,0 +1 @@
> +sysroot

Small nit about the naming, not so much important, but the common
pattern for directory has a trailing slash. So, I would write
"sysroot/".

".gitignore" and "tools/testing/selftests/.gitignore" do that too :-)

Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Thanks!

-- 
Ammar Faizi

