Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025F974EF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGKMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGKMlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:41:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41098B0;
        Tue, 11 Jul 2023 05:41:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB7BC225C3;
        Tue, 11 Jul 2023 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689079279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTTkzVVPTdBTTX1F+dGFkKgrQMAgN0MI9e62axP2ESk=;
        b=TtsgEo0ggMHrj25ng3aYrEMQybqPBakEUTcdctxqd21tyemkFpLLiFszDVNNwYswiP0Z3W
        WTE3DBlSulUwv5f1yRZQRQssAqNmJM41hmoUO6ss68XCuXMjbY4QqR92QFgBXmdwU6/ahH
        QIZQqNJCjg3zP8EzEyrGjl+Vv4zmGvY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C98341391C;
        Tue, 11 Jul 2023 12:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id baRbMO9NrWT3QAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 11 Jul 2023 12:41:19 +0000
Date:   Tue, 11 Jul 2023 14:41:18 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the cgroup tree with the mm tree
Message-ID: <xn7nv52qio4aq2ioquuglnfoe6hn2l7newjf53enyxxthy6opd@ztktowlsjub3>
References: <20230711110734.7009339b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="624tujepdzi6sdtb"
Content-Disposition: inline
In-Reply-To: <20230711110734.7009339b@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--624tujepdzi6sdtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Jul 11, 2023 at 11:07:34AM +1000, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

Would alphabetical sorting of entries be helpful? (Lower conflict
probability than the single end for appending.)

Thanks,
Michal

--624tujepdzi6sdtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZK1N7AAKCRAGvrMr/1gc
jlFLAP47B14jQYzwELF9vZsjK1/SuujT3qR3i4tFcnp++ipnfwEA3YlUsUVOpDCE
XGJK/eTUn8ReFUylhASijiS7lmmohAU=
=HX7y
-----END PGP SIGNATURE-----

--624tujepdzi6sdtb--
