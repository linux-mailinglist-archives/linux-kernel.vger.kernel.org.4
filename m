Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C3C617AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiKCKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:11:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2F4B75
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 03:11:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B0C21F890;
        Thu,  3 Nov 2022 10:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667470286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gIbn6Jdny57DgvpWIdnJozO9qB7X5TWdsi4aX7H7iv8=;
        b=ehzIkwZa+O9DsxbLL9MRsGmkXcdHWo4t7jYzAOBmeX6PnIux5PBgf85ILX4bg1qy3IKtrT
        e2ErdGPVKQN8waLS7HBrpRPKd4YXf1uSVnEwfMR7FupMI2m3WAiWijIF/mdeEvTKEJLiz5
        r+GUPSmbetSkE+c0gwYMy0zakiWjcOA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60B0913AAF;
        Thu,  3 Nov 2022 10:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cxyjFs6TY2MDcAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 03 Nov 2022 10:11:26 +0000
Date:   Thu, 3 Nov 2022 11:11:24 +0100
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
Message-ID: <20221103101124.GD10591@blackbody.suse.cz>
References: <20221026224449.214839-1-joshdon@google.com>
 <20221102165922.GA31833@blackbody.suse.cz>
 <CABk29Nsjbex9VYw01HQN4Bgvrf66w2YDfpRLuns2nDt5UxCjUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <CABk29Nsjbex9VYw01HQN4Bgvrf66w2YDfpRLuns2nDt5UxCjUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 02, 2022 at 05:10:08PM -0700, Josh Don <joshdon@google.com> wrote:
> Without my patch, distribute_cfs_runtime() will unthrottle the
> cfs_rq's, and as you point out, it doesn't actually give them any real
> quota, it lets assign_cfs_rq_runtime() take care of that. But this
> happens asynchronously on those cpus. If they are idle, they wait for
> an IPI from the resched_curr() in unthrottled_cfs_rq(), otherwise they
> simply wait until potentially the next rescheduling point. So we are
> currently far from ever being guaranteed that the order the cpus pull
> actual quota via assign_cfs_rq_runtime() matches the order they were
> unthrottled from the list.

Thanks for breaking it down, I agree your change won't affect the
fairness substantially and my other points are clarified too.

Michal


--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY2OTugAKCRAkDQmsBEOq
uR3pAQDo5+2d5zDKYrRDoKurRMR240+Jnvbif9Y21KaDfIpEKAEA5mv0PJFfF0z9
JH+NhJC7BFmoXqzJyiZ5KYTCl/YWAgg=
=AKaU
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
