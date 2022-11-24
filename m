Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B587637E81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKXRlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKXRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:41:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7606713C707
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:41:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F193B82898
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C2FC433D6;
        Thu, 24 Nov 2022 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669311696;
        bh=3OMz0gCP/7fXvXnmHIFizM8ZPLUCFrA2IU8lKaplgic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaAn1vt2QCMwD8cm7usiggtitIP8Ztq3pRcxypt9e+TKicn5XXlj0gIptkZxxiBof
         6udu0IN+AhXqBPrkPyXMmeRHRrb1M8IvShjjNeeZ4vmsm1CpeTyG1g0mlott3ED1Ml
         qE3hpM6XPDChSIRHFQv4d/xYpKYExeDtD+6p+yrsnkNQdaqYqUBjuAjaSI3EqSYdUo
         7KsdPptFqA2Ml/DyQLb1CTcBjoomuyGYn+Ewz3HHI8YeOwqDiN7Z7V2kVMwvh8UDY3
         dV0WJ/e6mLzl0IKU3TE+1eilW9SWjNGTQtcJzJXNBJWew2XCu1VN3beLSwErxO05ZF
         aAL7UEn0y9dcg==
Date:   Thu, 24 Nov 2022 17:41:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] regulator: da9211: Use irq handler when ready
Message-ID: <Y3+sy9hJ4U3CwWzb@sirena.org.uk>
References: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
 <20221124-da9211-v1-1-a54549aa6d3b@chromium.org>
 <Y3+hpgjQVK+8Ut9s@sirena.org.uk>
 <CANiDSCuMA3N-spbKQUZJywKMhxZyd-YB0bYSEeC9reQJOSi7mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QuL2NNpEK3HW6ICo"
Content-Disposition: inline
In-Reply-To: <CANiDSCuMA3N-spbKQUZJywKMhxZyd-YB0bYSEeC9reQJOSi7mw@mail.gmail.com>
X-Cookie: Apply only to affected area.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QuL2NNpEK3HW6ICo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 24, 2022 at 06:35:42PM +0100, Ricardo Ribalda wrote:

> On Thu, 24 Nov 2022 at 17:54, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Nov 24, 2022 at 05:45:31PM +0100, Ricardo Ribalda wrote:

> > Please think hard before including complete backtraces in upstream
> > reports, they are very large and contain almost no useful information
> > relative to their size so often obscure the relevant content in your
> > message. If part of the backtrace is usefully illustrative (it often is
> > for search engines if nothing else) then it's usually better to pull out
> > the relevant sections.

> Do you want that I post a v2 of the patch?

It's fine, just please think about this for future submissions.

--QuL2NNpEK3HW6ICo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN/rMoACgkQJNaLcl1U
h9DlyAgAg3ewpHAYegS8/EEEO0Bxk/5U+mcsSjEaB4EIXMVEPkZY4qGNhFpZWvy+
DHUY7Dy/fK+Cv1CZVuqFJy/mp3HMAsWE5wuuzrn1UFEjfY3ffgFuBnwM0aWjb+ia
KEINynpo4Y11kPWqGiiSvfMGM39bAzK6rELECjgtgF3mj0XdDVmHBIqsRi8O3etS
NWAphpWhLgVLHJxWqqLDXS/pNgPauOedczO13jZ2u9PrhwGUu4GX8bQOQe0ecvZK
EUHEkAb4pZH80fdt5RlzLKpFhQFLplXu586idwZxm+8Q5C0ZgERuHd6Ln9jjyaXL
hs10xxcdZdHiVk32dWzILbaW7uvKiA==
=zwpw
-----END PGP SIGNATURE-----

--QuL2NNpEK3HW6ICo--
