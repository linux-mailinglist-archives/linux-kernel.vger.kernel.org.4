Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1CB750874
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjGLMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjGLMfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:35:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B97F1718;
        Wed, 12 Jul 2023 05:35:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F3768219A2;
        Wed, 12 Jul 2023 12:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689165347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J13teWvlZsVeWZlR1c10Po+mPEX/DfWkZRPeQXAo6N4=;
        b=lwTSLV6LRelCJbsXcdy+/q4Fa/tftM2aNBLIWn8BiClHOz3ado8qroWStaObaSx2bKYpqR
        uKB1ccACze1N0UA68/xFG7+HPtxCqXa1Ci16DQrLKYPmFTjtTUFI8sQdXiuLAFuO8v7LdS
        sQWbK+CLgZrSxI+3kztkmmCXN8RowwM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFE6B13336;
        Wed, 12 Jul 2023 12:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sVl8MSKermTmUQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 12 Jul 2023 12:35:46 +0000
Date:   Wed, 12 Jul 2023 14:35:45 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the cgroup tree with the mm tree
Message-ID: <bxs72egnup6iuv7yyngpemuqikefd7myxd6dykvgyk4wh23jq5@trnz3oqbwc5e>
References: <20230711110734.7009339b@canb.auug.org.au>
 <xn7nv52qio4aq2ioquuglnfoe6hn2l7newjf53enyxxthy6opd@ztktowlsjub3>
 <20230711100346.0805ead2e7e65be56ce2911c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ewbknfnnhxrwe3i6"
Content-Disposition: inline
In-Reply-To: <20230711100346.0805ead2e7e65be56ce2911c@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ewbknfnnhxrwe3i6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 10:03:46AM -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> I think so.  People tend to put new entries at the end of lists, which
> is the ideal way to cause patch collisions :(

OK, next time when someone adds a new test, let's ask for re-sorting
too.
(I missed it with cd3c6f682df4 ("selftests: cgroup: Add cpuset
migrations testcase").)

Regards,
Michal


--ewbknfnnhxrwe3i6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZK6eHwAKCRAGvrMr/1gc
jlWnAQDIMTbA9Vz2UtLfXwYYZrDnbWi2WKmTHqqg/gYEJqouRgEA6y8xr2n+YxWN
F2GQOqdZLikXJdYHv0NSaze9rTLwXQU=
=/SPO
-----END PGP SIGNATURE-----

--ewbknfnnhxrwe3i6--
