Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214166EE07F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjDYKkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjDYKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:40:50 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D93FF;
        Tue, 25 Apr 2023 03:40:47 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 4D6A0C009; Tue, 25 Apr 2023 12:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1682419244; bh=ZtUogD1otBOP6kURYBx3pL/G2akgZ11aunENuUap21A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ea4nQ4yP9RS5+PxI0r2yOum4JZ65bRlYfOBtlMGMpcsBeHv3Y92W0tvFbuGrFb5hV
         Bqh4037KSjMUq+sWLVOvKrn1hIEjw3BnJ1yqy+faNDfr2ZzdmBjEVfB5SxDVxvZnn3
         V/RfqUIw3W1t6TLosOT1hc9Hzi0fxlGCgpen+yNzHcDwvGmD4avwf7DGfqS1Ga1l/E
         hTommrx5erHeho+Rq0vLxKR5Dd5ZGEAo5XhYk/+HGGgFVQCFiJ4/s70O+5P8HS56dP
         lfCto8u3Dtie5kKqT5e3UavAWtCTbv8CLddrmUN2EfcHmvx6/jnHh7xulLazrAdsXw
         +T1rlwi1DydQA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 3C7EFC009;
        Tue, 25 Apr 2023 12:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1682419243; bh=ZtUogD1otBOP6kURYBx3pL/G2akgZ11aunENuUap21A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kh2cpVHP26YL9D35y0r40N5bKMrNH1NEQtXE++rE4A9ZlUsu45EjYX0MVCKdLWJDJ
         OH4zfqg006yWltmtQzLulaIhgemHDkacx+39/cjceFJ/DiaCWU3A60VXtlVX5G8JQV
         z+zsexYpCP5Hka+Jv2mYlyQPWkwMNCaZkJQrfEQVGqSauUFxnWA3CfvuWLQjp4Elpo
         LVU2VyPBORNQPC30yypDCiQbYO4DORYDHEEzsC+RUuZtz3CAS9C76vruiybxubZtTQ
         dcMoFpficVtmHVyxgB8kYhxsY7KWRv0/KrzkXNUOTj8rQNOIAIucgb8xv1Fte/JgYL
         v8bTk384VrBdw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id fd4651ec;
        Tue, 25 Apr 2023 10:40:37 +0000 (UTC)
Date:   Tue, 25 Apr 2023 19:40:22 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        v9fs@lists.linux.dev
Subject: Re: [PATCH] fs/9p: Fix a datatype used with V9FS_DIRECT_IO
Message-ID: <ZEeuFlEAaARGqZol@codewreck.org>
References: <80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.1682405206.git.christophe.jaillet@wanadoo.fr>
 <ZEd8d7W6HnHE_66m@codewreck.org>
 <2755033.v0V8SJffbf@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2755033.v0V8SJffbf@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Tue, Apr 25, 2023 at 11:18:37AM +0200:
> > I'm surprised W=1 doesn't catch this... and now I'm checking higher
> > (noisy) W=, or even clang doesn't seem to print anything about e.g.
> > 'v9ses->flags & V9FS_DIRECT_IO is never true' or other warnings I'd have
> > expected to come up -- out of curiosity how did you find this?
> 
> Both gcc and clang only trigger an implicit conversion warning if the value of
> the expression can be evaluated at compile time (i.e. all operands are
> constant), then compiler realizes that the compile-time evaluated constant
> value is too big for the assignment destination and triggers the warning.

Right, `v9ses->flags = V9FS_DIRECT_IO` would have triggered it but not
with `|=` -- but in this case I was also expecting the check
`v9ses->flags & V9fs_DIRECT_IO` to flag something odd...
But nothing seems to care; testing with this snippet:
---
int foo(char x) {
	if (x & 0x200)
		return 1;
	return 0;
}
int foo2(unsigned char x) {
	if (x < 0)
		return 1;
	return 0;
}
---
gcc warns that the x < 0 is always false (clang actually doesn't, even
with scan-build, I must be missing a flag?), but I didn't find anything
complaining about the &.
I'd expect something like coverity to perform a bit better here but it's
a pain to use the "free for open source" version (... I just requested
access to https://scan.coverity.com/projects/128 but I have no idea if
they build next or not)

Oh, well; glad Christophe noticed anyway.

> > Would probably be interesting to run some form of the same in our
> > automation.
> 
> If there is any ATM? I als tried this issue with clang's undefined behaviour
> sanitizer and with the clang static analyzer. Both did not detect it.

There's at least the intel bot building with W=1 and warning if any new
such warning pops up (and I'd like to say I check myself, but I probably
forget about half the time; I looked at making W=1 default for our part
of the tree but it didn't look trivial? I'll try to have another look);
but I'm not aware of anyone testing with scan-build or something else
that'd contact us on new defects.

-- 
Dominique Martinet | Asmadeus
