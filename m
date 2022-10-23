Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B866095BD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJWTGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJWTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:06:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4024E51A11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:06:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 703A91F74D;
        Sun, 23 Oct 2022 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666551998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZn10VbThi2Z5iW5LVXcbz4mxl1wk+O7BoR/CjPDmpc=;
        b=OVLWX+WtmB76Rfx+/FwaAkDNVpfMSMrzPKigXWO5AG/WzZ+3bE3ImyJ+HuSXqxDeyX3U8/
        6+fBp1iaHoAK9wboeshjNra7/2F9YjH2NQcPOa/6HYoYGnch+CGeawEAAj3DK0Vf51O52D
        GTHWr4oN/yHJntWB+nE0spTYlmbThv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666551998;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZn10VbThi2Z5iW5LVXcbz4mxl1wk+O7BoR/CjPDmpc=;
        b=OVP7TVmpG0QnfuVvb7hsO3NTchLy4giUZAjeEmQZA1H6zPsqaqTrBZ9mGFERahh9jSkFFo
        cQTiljV6ZVEUZGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6327F139F0;
        Sun, 23 Oct 2022 19:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1fQnGL6QVWPaEQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 23 Oct 2022 19:06:38 +0000
Date:   Sun, 23 Oct 2022 21:06:34 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for 6.1
Message-ID: <Y1WQunTanl4gWpng@zn.tnic>
References: <Y1ULKYsASLRoVb7N@zn.tnic>
 <Y1UPYnju4qOTsusI@zn.tnic>
 <CAHk-=wj0afQB2odHZcfmtymR0q9wJEO8gGQo_Cob+KHgsimG5w@mail.gmail.com>
 <Y1WEaE7S3M/nptM2@zn.tnic>
 <CAHk-=whi1xkXFRu79fOvwu17qaw7J9HkzW1DUV7jTawJZtc6VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whi1xkXFRu79fOvwu17qaw7J9HkzW1DUV7jTawJZtc6VQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 11:42:25AM -0700, Linus Torvalds wrote:
> Several trees do that already, and jst call the tags "for-linus" or similar.

Yap, exactly. And I have had a bunch of times a git warning in my tree
complaining about "master" being an ambiguous reference which was fun to
chase down the first time.

In tip we opted for either calling the tag "<branch-name>-<date>" -
which I still think is suboptimal because then you have to go and
match the date to the release which was current at the time.

Or use my vastly superior idea of <branch-name>_for_<kernel-version>
which tells you everything you wanna know. :-)

> I obviously don't want to distribute these temporary tags as tags, no.
> That's a git default behavior thing, because it would be very annoying
> to get hundreds of irrelevant tags that get distributed with the
> kernel.

Yap, exactly.

> And that's the part I mean when I said "Nobody will look at the tag
> name afterwards". Yes, there are signs of that incorrect tag name in
> there, but it's not like I suspect anybody would have ever even
> noticed hadn't you brought it up.

Yes, makes perfect sense to me. I had a hunch that it would be something
along the lines of: the tag doesn't really need to be a 1st class object
in the pulling repo and it is good enough if it is part of the pull
request text only.

So thanks for explaining.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
