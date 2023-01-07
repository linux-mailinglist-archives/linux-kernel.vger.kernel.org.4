Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A49660EE5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 13:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjAGMth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 07:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjAGMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 07:49:33 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E972D2A;
        Sat,  7 Jan 2023 04:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673095769;
        bh=J9tEidszI5OSDhNzxxshU4pDGQyqa/HcrqWXQLTX1+Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=oU41UjFYG+eCt7E7Qi19rAuNq3fOT/3mL/J0KltS9wIbPzqrWI4rSwgtL5OdagsNd
         mzgzDVwGEHf7gOTadqCKosXxc/DJUCC0SuU3/6KyRI7HsHMLR1EW7vAHCOJ3S8/jn1
         hDE3E4LbuHXLMMXGFJDHMeFIF5fisC+nFgNEMGu0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ECA671286196;
        Sat,  7 Jan 2023 07:49:29 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i4Z1xiuT9A2D; Sat,  7 Jan 2023 07:49:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673095769;
        bh=J9tEidszI5OSDhNzxxshU4pDGQyqa/HcrqWXQLTX1+Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=oU41UjFYG+eCt7E7Qi19rAuNq3fOT/3mL/J0KltS9wIbPzqrWI4rSwgtL5OdagsNd
         mzgzDVwGEHf7gOTadqCKosXxc/DJUCC0SuU3/6KyRI7HsHMLR1EW7vAHCOJ3S8/jn1
         hDE3E4LbuHXLMMXGFJDHMeFIF5fisC+nFgNEMGu0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1AD161286190;
        Sat,  7 Jan 2023 07:49:29 -0500 (EST)
Message-ID: <cefe7e4b604c11dfd3f8b934d53307c364e28d97.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] SCSI fixes for 6.1-rc2
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Date:   Sat, 07 Jan 2023 07:49:27 -0500
In-Reply-To: <yq1h6x2zj3f.fsf@ca-mkp.ca.oracle.com>
References: <f0bc7090c04bc6c0b08471494324a3a577c2d2a1.camel@HansenPartnership.com>
         <20230107182826.1ae7b32c@canb.auug.org.au>
         <yq1h6x2zj3f.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-01-07 at 06:50 -0500, Martin K. Petersen wrote:
> 
> Stephen,
> 
> > I thought that this one was to be removed as the pktcdvd drivers
> > removal is being reverted in the block tree in linux-next (and the
> > revert caused a build failure in linux-next due to this scsi
> > commit).
> 
> Yep, my bad. Got sidetracked debugging a few unrelated issues
> yesterday and didn't get to the point where I finish up and push my
> trees out.
> 
> I have dropped the offending commit and pushed 6.2/scsi-fixes
> separately.

OK, I've got the new tree queued up.  Since the removal caused quite a
bit of patch motion, let's give it at least one -next run, so I won't
resend the pull request until Tuesday.

James

