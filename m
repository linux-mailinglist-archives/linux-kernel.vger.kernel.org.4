Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE36C6729
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCWLxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjCWLxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:53:52 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1489A34C10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:53:45 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8A91D1C0E52; Thu, 23 Mar 2023 12:53:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679572423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fiiMdIZOFv7MsJRF3rynwKCkciwOFsuLIsr2DLMMX+Y=;
        b=jaWSK/c1sd20l8YItKp23v0CDUBVoTaaR0sQRlQsLelVZyaYzb3UXroiizoFnqlwWVfvuW
        AOLL6wBSgIgXYbQsE+r7JPZCVDQNGh0CIxWE7pi+ij0tOcWw9Tirs3JRu+F9usvY4QixRx
        noKcuW+0tsjrkriVb4fxmyZ0+xG76KE=
Date:   Thu, 23 Mar 2023 12:53:43 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Subject: Re: [PATCH 00/10] sched: EEVDF using latency-nice
Message-ID: <ZBw9x1iJkUwXjBBf@duo.ucw.cz>
References: <20230306132521.968182689@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UoNxk7nC57HeTEdI"
Content-Disposition: inline
In-Reply-To: <20230306132521.968182689@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UoNxk7nC57HeTEdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Ever since looking at the latency-nice patches, I've wondered if EEVDF wo=
uld
> not make more sense, and I did point Vincent at some older patches I had =
for
> that (which is here his augmented rbtree thing comes from).

Link for context: https://lwn.net/Articles/925371/ . "EEVDF" is not
commonly known acronym :-).

BR,								Pavel


--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--UoNxk7nC57HeTEdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBw9xwAKCRAw5/Bqldv6
8vl2AKC9IiQHcjyXtzjITzarV20BXUVgeQCfVRC1MxBg5GhWipTiKw/XUyMSOnM=
=YVmv
-----END PGP SIGNATURE-----

--UoNxk7nC57HeTEdI--
