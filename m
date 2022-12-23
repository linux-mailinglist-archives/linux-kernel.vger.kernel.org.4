Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9B6549B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiLWARk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiLWART (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:17:19 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903B32B9E;
        Thu, 22 Dec 2022 16:16:08 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9DDBAC009; Fri, 23 Dec 2022 01:16:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671754579; bh=3g+YqbVOxOYOai/as9CquuT+BvETpQ9bhFQwYeRZGeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKL7A12xoVb6t40Iy4YGv1tw+PzU/OIlomzJZ9mzz/e+Cs/gPHi/aa73HohLvAmQX
         /e8dodS9/x+xDgOYvZjooysQrNqJPMunBqtvzYgb+rN8mbYn3HqTP6QM58Srshn1mN
         OpPAmmbrx4KEgrpHjPnMy6v4kG3K9v+0KEUNo/eYiEjJwVGST9RHIDGeOgFzA81jaI
         K7xw+b3jcjyQ0E6YPwxEKJAMi88k9lWd0mTPHG3XxGK7UfB+utBxNApUmskhYicEBW
         1DkU0fDZs3p036Y7RMSDUtfN/mxx3RdZB7oFwQxv4NaCnVEIh6El6rkNOmrok0llCE
         aMZvVI+pb8Nqg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 24BEFC009;
        Fri, 23 Dec 2022 01:16:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671754579; bh=3g+YqbVOxOYOai/as9CquuT+BvETpQ9bhFQwYeRZGeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKL7A12xoVb6t40Iy4YGv1tw+PzU/OIlomzJZ9mzz/e+Cs/gPHi/aa73HohLvAmQX
         /e8dodS9/x+xDgOYvZjooysQrNqJPMunBqtvzYgb+rN8mbYn3HqTP6QM58Srshn1mN
         OpPAmmbrx4KEgrpHjPnMy6v4kG3K9v+0KEUNo/eYiEjJwVGST9RHIDGeOgFzA81jaI
         K7xw+b3jcjyQ0E6YPwxEKJAMi88k9lWd0mTPHG3XxGK7UfB+utBxNApUmskhYicEBW
         1DkU0fDZs3p036Y7RMSDUtfN/mxx3RdZB7oFwQxv4NaCnVEIh6El6rkNOmrok0llCE
         aMZvVI+pb8Nqg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 80ec58c6;
        Fri, 23 Dec 2022 00:16:01 +0000 (UTC)
Date:   Fri, 23 Dec 2022 09:15:45 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Solar Designer <solar@openwall.com>
Cc:     oss-security@lists.openwall.com,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <Y6TzMR1Wh7jKmatU@codewreck.org>
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <20221222232112.GA29438@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221222232112.GA29438@openwall.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solar Designer wrote on Fri, Dec 23, 2022 at 12:21:12AM +0100:
> On Fri, Dec 23, 2022 at 07:03:17AM +0900, Dominique Martinet wrote:
> > Alexey Dobriyan wrote on Thu, Dec 22, 2022 at 07:42:53PM +0300:
> > > --- a/man5/proc.5
> > > +++ b/man5/proc.5
> > > @@ -2092,6 +2092,11 @@ Strings longer than
> > >  .B TASK_COMM_LEN
> > >  (16) characters (including the terminating null byte) are silently truncated.
> > >  This is visible whether or not the executable is swapped out.
> > > +
> > > +Note that \fIcomm\fP can contain space and closing parenthesis characters. 
> > > +Parsing /proc/${pid}/stat with split() or equivalent, or scanf(3) isn't
> > > +reliable. The correct way is to locate closing parenthesis with strrchr(')')
> > > +from the end of the buffer and parse integers from there.
> > 
> > That's still not enough unless new lines are escaped, which they aren't:
> > 
> > $ echo -n 'test) 0 0 0
> > ' > /proc/$$/comm
> > $ cat /proc/$$/stat
> > 71076 (test) 0 0 0
> > ) S 71075 71076 71076 34840 71192 4194304 6623 6824 0 0 10 3 2 7 20 0 1 0 36396573 15208448 2888 18446744073709551615 94173281726464 94173282650929 140734972513568 0 0 0 65536 3686404 1266761467 1 0 0 17 1 0 0 0 0 0 94173282892592 94173282940880 94173287231488 140734972522071 140734972522076 140734972522076 140734972526574 0
> > 
> > The silver lining here is that comm length is rather small (16) so we
> > cannot emulate full lines and a very careful process could notice that
> > there are not enough fields after the last parenthesis... So just look
> > for the last closing parenthesis in the next line and try again?
> 
> No, just don't treat this file's content as a line (nor as several
> lines) - treat it as a string that might contain new line characters.

Ah, this came just after the /proc/net/unix discussion in another
thread[1] pointing to [2] with one line per entry, and I was still in
that mode.

For /proc/pid/stat with a single entry I agree treating it as a buffer
and looking for the last closing parenthesis should be correct as per
the man page suggestion -- sorry for the noise.

[1] https://www.openwall.com/lists/oss-security/2022/12/21/8
[2] https://lore.kernel.org/all/8a87957e-4d33-9351-ae74-243441cb03cd@opteya.com/

-- 
Dominique Martinet | Asmadeus
