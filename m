Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827EA609567
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJWSOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:14:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1B1276A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:14:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88E211F74D;
        Sun, 23 Oct 2022 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666548845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1oX52WdM/Uh5b8Yp0Ta8FWs8VaDCQSPMd91Db6p2kvU=;
        b=KQoYANr6CzZ//A1z/rdA5xMtJrJLNLRf27I01E/sYmh6mbWr0519ei8mxFqxttaAuuqLqk
        Mi1lm8mkwfzoTh84k7+WWI4lhIVs9FpjCvp1M1IuKCXA95NGpDYfWVOr823TtJEHWQYyCB
        ex129DY0Nht18fPYynlQwR/NC6TA3b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666548845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1oX52WdM/Uh5b8Yp0Ta8FWs8VaDCQSPMd91Db6p2kvU=;
        b=S/K+smZ/cFyAPHOsMACCH69EYpJM4r+6jAvpE1owZI8/rFGW7zTBthyOGNZBFUHg+HiMyi
        6VZcJeAFa12ya7AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C7D113A3B;
        Sun, 23 Oct 2022 18:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s+RZHm2EVWNafAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 23 Oct 2022 18:14:05 +0000
Date:   Sun, 23 Oct 2022 20:14:00 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for 6.1
Message-ID: <Y1WEaE7S3M/nptM2@zn.tnic>
References: <Y1ULKYsASLRoVb7N@zn.tnic>
 <Y1UPYnju4qOTsusI@zn.tnic>
 <CAHk-=wj0afQB2odHZcfmtymR0q9wJEO8gGQo_Cob+KHgsimG5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wj0afQB2odHZcfmtymR0q9wJEO8gGQo_Cob+KHgsimG5w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 10:06:37AM -0700, Linus Torvalds wrote:
> Nobody will look at the tag name afterwards, so the tag-name being a
> bit odd doesn't really matter. 

I was gonna say, let's have a fixed tag name so that there are no
multiple tags with the same name, per chance, which would confuse. But
it seems that when you pull a tag, it remains a remote tag and doesn't
appear in your tree. Which would be silly because if it did, your tree
would be full of all those tags you're pulling.

It sometimes is kinda annoying in my repo here after I've added a bunch
of repos and fetch from them and all those tags from there appear
locally too and I wonder what those even are.

> But hey, I appreciate the heads-up about the name mix-up

I had a hunch you would. :)

> (although, again, the only time it tends to actually matter is for
> that end-or-release time frame where there can be actual confusion).

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
