Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEFB6ED2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjDXQsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjDXQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:48:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1246580;
        Mon, 24 Apr 2023 09:48:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3886A21979;
        Mon, 24 Apr 2023 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682354907;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q0EGwejdLAGL43XPRy5+57KZH/Iv8Vay1sAesVB+mM0=;
        b=URgZQq3EAqsDrbivzuqTKSpvkS1NlycKh2txTI5/yrV/pVzNWM6TOhddcFfUFtGEHm/EP8
        9J9gK6Nojzz261PRIApv7FjSnSuvCWknu6den0k2YRHM/ur+KxJPW94XktAr/TKyMqLGHT
        4sHEliuMIoFw4/nLKJ3EONjBAqHsXDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682354907;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q0EGwejdLAGL43XPRy5+57KZH/Iv8Vay1sAesVB+mM0=;
        b=rxtrMnL7QtigII4uWp4ABpOCyRY7/s1rLKQsnehqJp1LDlKVH92VYnQNfTcMpj2pXxRwYv
        aJs7fV/bJn2MNmDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD3301390E;
        Mon, 24 Apr 2023 16:48:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WSxSK9qyRmQsFgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 24 Apr 2023 16:48:26 +0000
Date:   Mon, 24 Apr 2023 18:48:35 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] uapi/netfilter: Prefer ISO-friendly __typeof__
Message-ID: <20230424164835.GA2814761@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230416210705.2300706-1-pvorel@suse.cz>
 <f8bd4212-9cca-03ca-884a-c9dec63bb256@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8bd4212-9cca-03ca-884a-c9dec63bb256@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 16/04/2023 23:07, Petr Vorel wrote:
> > typeof() is a GNU extension, UAPI requires ISO C, therefore __typeof__()
> > should be used.  Similarly to b4bd35a19df5 ("uapi/linux/const.h: Prefer
> > ISO-friendly __typeof__") use __typeof__() also in x_tables.h.

> Thanks for finishing up the work!

> Minor thing, the hash for my commit in -next seems to be 31088f6f7906 at
> the moment. As to the Fixes: tag, it looks like it should be (assuming
> that commit already exported the macro):

> Fixes: 72b2b1dd77e8 ("netfilter: xtables: replace XT_ENTRY_ITERATE macro")

> Aside from that, looks good to me, so:

Thank you!

Andrew, I'll just wait for others to comment and then I'll send v2
(so that you don't need to update the work yourself).

Kind regards,
Petr

> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> Kevin

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Based on [1] merged into linux-next as b4bd35a19df5.
> > There should be the same Fixes: which we agree in discussion in [1]
> > (likely a79ff731a1b2, or d6fc9fcbaa65).

> > Kind regards,
> > Petr

> > [1] https://lore.kernel.org/lkml/20230411092747.3759032-1-kevin.brodsky@arm.com/


> >  include/uapi/linux/netfilter/x_tables.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)

> > diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linux/netfilter/x_tables.h
> > index 796af83a963a..d4eced07f2a2 100644
> > --- a/include/uapi/linux/netfilter/x_tables.h
> > +++ b/include/uapi/linux/netfilter/x_tables.h
> > @@ -172,11 +172,11 @@ struct xt_counters_info {

> >  /* pos is normally a struct ipt_entry/ip6t_entry/etc. */
> >  #define xt_entry_foreach(pos, ehead, esize) \
> > -	for ((pos) = (typeof(pos))(ehead); \
> > -	     (pos) < (typeof(pos))((char *)(ehead) + (esize)); \
> > -	     (pos) = (typeof(pos))((char *)(pos) + (pos)->next_offset))
> > +	for ((pos) = (__typeof__(pos))(ehead); \
> > +	     (pos) < (__typeof__(pos))((char *)(ehead) + (esize)); \
> > +	     (pos) = (__typeof__(pos))((char *)(pos) + (pos)->next_offset))

> > -/* can only be xt_entry_match, so no use of typeof here */
> > +/* can only be xt_entry_match, so no use of __typeof__ here */
> >  #define xt_ematch_foreach(pos, entry) \
> >  	for ((pos) = (struct xt_entry_match *)entry->elems; \
> >  	     (pos) < (struct xt_entry_match *)((char *)(entry) + \

