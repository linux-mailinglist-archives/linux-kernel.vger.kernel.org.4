Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B96E122D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDMQX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:23:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0DC869E;
        Thu, 13 Apr 2023 09:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D60A60C92;
        Thu, 13 Apr 2023 16:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C64C433D2;
        Thu, 13 Apr 2023 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681403033;
        bh=63ksHATfE+J5PG5GH23Gfmun9q/zhyYaJcyPhs9226A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jsHIQbINJ2+esLoKal0Ert4zH7CcoIm8NMcGSVLF6YHVqNi8dxIfnYOw+zs7GZeLN
         Bjst3jIqhjTiTJWJZP23X0Pne6Xq6sV5swycdVf/dMZ6nKNnS3ts0tF02iBBiENWP2
         NUTZA/jOrwiUDnOFcR4Nz8ZYhCdngyEUYKGy3UIWTkNItNfWI0m/8pi7Sw3U+h3DnR
         ecGA4rcQ6EGY217jj/aalPFhWfuZ0cGwm+jH4mOf6XAPQq5+y5mFyNgNm1O/QmiqbG
         vLATOJE7wwXJ+p3FnnviwNFJa5lDyp5nPJSy4qa42JEz49JBxr8fgNEBozIDvPlo0Q
         9pR6ZIDTFgcgQ==
Date:   Thu, 13 Apr 2023 17:23:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Gao Xiang <xiang@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the erofs tree with the
 vfs-idmapping tree
Message-ID: <664140af-3d95-416c-8f89-cad7beeaac19@sirena.org.uk>
References: <20230413144651.3519980-1-broonie@kernel.org>
 <4f9fdec2-cc2a-4bc7-9ddc-87809395f493@sirena.org.uk>
 <699f01a7-8c0e-98d9-d2c7-eaf08552f543@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7zx0GPVmMMe9mQfB"
Content-Disposition: inline
In-Reply-To: <699f01a7-8c0e-98d9-d2c7-eaf08552f543@linux.alibaba.com>
X-Cookie: Idleness is the holiday of fools.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7zx0GPVmMMe9mQfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 14, 2023 at 12:16:46AM +0800, Gao Xiang wrote:

> Thanks.  Actually I didn't update the corresponind xattr patches (just
> rebase some older commits, also I'd like to avoid in the future, but
> sometimes it's impossible at least if some RVB is added...)

> I think it could be resolved as before by Stephen:
> https://lore.kernel.org/r/20230412101942.75e3efa9@canb.auug.org.au

> And which looks the same as below:

Probably some context changed which caused me to have to reresolve the
conflict?  Or perhaps just rerere not syncing properly from Stephen's
work.

--7zx0GPVmMMe9mQfB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ4LJMACgkQJNaLcl1U
h9DslwfzBamgEmLUmCZ4y5gdXu1QHH54PrmzE16k2M/L7HDRV5YTPbENhFsdL1sL
DYho+9l1dHi+qm0LDIsf4VvIMy1DSvubfZwYIzT5JFSDYKDQbnEHsrPMurxQWZd2
f13uZmzjrnPUJx9MbGH74ZRHQvFlPNYDj9xI1ygK9+KNcZIcEfm45UYrLjq0jS9L
ucpz59PGPeRIXR8X3Z72J2jizPzGEgLIyB8/Yy0L8o0Enzhx8fUBIPUGQZD0pJde
PunTB2L+Fde3Z1VArmi2IvVjNG4/GS1FI1n5UFbHG0WphtX0KX//+aLGSf+9Y/JX
/GIm1juZpYiPFdsbv3vHn/w7Fbp3
=2jsS
-----END PGP SIGNATURE-----

--7zx0GPVmMMe9mQfB--
