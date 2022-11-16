Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1F62B70A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKPJ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKPJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:57:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE9928B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:57:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EBE541F926;
        Wed, 16 Nov 2022 09:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668592661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czxPe4ItB5tqe9afE5IZdwvdY/jMVJmAcwvPJ6Y6Tu0=;
        b=m0Qo8RMB/oMhDn8oGxmg2DVkQygA+2LObXYFpincRsODrlvbiFzDwmVc8PamueJBfXD96x
        O9bhIWXaIm8S+7VV4TGEoqTIYp+8B2gT+iDfzIKxFv0n6+piuTInzjiJ3s4mXj+48LI1pn
        gRzS4ZuO66dpE0yytWxAIJGPdkp/muw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B89AF134CE;
        Wed, 16 Nov 2022 09:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id peNMLBW0dGMdQwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 16 Nov 2022 09:57:41 +0000
Date:   Wed, 16 Nov 2022 10:57:40 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <20221116095740.GA29859@blackbody.suse.cz>
References: <20221026224449.214839-1-joshdon@google.com>
 <20221102165922.GA31833@blackbody.suse.cz>
 <CABk29Nvw8XMrc2_9CAUZb=rO_vddGjsfZ1s3mRQyShANDhtZnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <CABk29Nvw8XMrc2_9CAUZb=rO_vddGjsfZ1s3mRQyShANDhtZnw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 15, 2022 at 07:01:31PM -0800, Josh Don <joshdon@google.com> wrote:
> After more thought, I realized that we can't reuse the throttled_list
> list_head, since that would potentially break the lockless traversal
> of a concurrent list_for_each_entry_rcu() (ie. if we removed the
> element from the throttled list and then added it to the CSD list).

I see, the concurrent RCU traversal is a valid point for the two heads.

What does it mean for SCHED_WARN_ON in __unthrottle_cfs_rq_async()?

IIUC, if the concurrency of cfs_b->throttled_cfs_rq list is
expected (hence I'm not sure about the SCHED_WARN_ON), then it may
happen that __unthrottle_cfs_rq_async is called on cfs_rq that's already
on rq->cfsb_csd_list (there's still rq lock but it's only help inside
cfs_b->throttled_cfs_rq iteration).

Thanks,
Michal

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY3S0AwAKCRAkDQmsBEOq
uXbpAQCLqagcMyDb165HxJhOfjWGUcIvJuvulqJGwtktzGZyBwD/YOkxd/uCb5bF
WQXMRrjyXFnOnEtWRMsY6VbAGWXdkg8=
=kRZ+
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
