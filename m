Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7025632BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiKUSCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiKUSCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:02:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E700B1170
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:02:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 910531F8B5;
        Mon, 21 Nov 2022 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669053747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5I8DXGMOj+0tvd0ERf2v2WIQ9f4U4rItqPSaE1++K1M=;
        b=Uz5f5nWkXk1bMBWPI7NjqK3tTjvt4m0GiauGIXJwEBhc1WpxEOgencew8ZkNYX9cXxqLLb
        q05ilqFqDdBpuuNRr3UfKDnhNAGU9PAz+1ngQik396LqExOfxwMu8snCe304fkab5C1maB
        PZefTR+ZgT2P6MMERxl7GGOGdTJvcTg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4206B1376E;
        Mon, 21 Nov 2022 18:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bwUQDzO9e2NPFQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 21 Nov 2022 18:02:27 +0000
Date:   Mon, 21 Nov 2022 19:02:25 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Message-ID: <20221121180225.GA18516@blackbody.suse.cz>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <Y3twWYeAW6U2/D92@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <Y3twWYeAW6U2/D92@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 2022 at 01:34:33PM +0100, Peter Zijlstra <peterz@infradead.=
org> wrote:
> Please test the final version as found here:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit=
/?h=3Dsched/core&id=3D4e3c1b7b489e218dfa576cd6af0680b975b8743e

I went through the patch and I claim it's
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

(not tested though. And thanks Josh for the notice  about the not-double
queueing check.)


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY3u9HAAKCRAkDQmsBEOq
uaRgAQCwuvGbNQwmhzwCQwxSTCcesm3eeE2Cv08Damh+KEonFAD/ee8kVyYxH1Xy
2tfcg62E/Sja0fkaWBWX0I8MtZvR9gQ=
=SRVW
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
