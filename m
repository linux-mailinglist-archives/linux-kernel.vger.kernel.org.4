Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F35C01A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIUPcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIUPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:31:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED94998D06
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FA17B82FD0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F002C433C1;
        Wed, 21 Sep 2022 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663774024;
        bh=baNU578On5vMdGqKW96nH8LWdDtChPsuMJrrVtUkmQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sENXmj9bynvdCHq3fgVkXklZO4KKbk9WrJRjd+vdf2WMMT0TjKua/eUfu1r3zMM2G
         m1bhkUZIeXBq8c3pzsTE9FDG642Cjs2IsW9hXipBi/Uss5O6E8Hju8TrItnV9LmBUC
         2jmaIc5NikdCLjtop7BIUou+qFfrqV9L002CirEZNsByP2CF3oav7x9fcjOZbYw7lm
         olvKIf4bkLxi/XV+bym9dKQ1QlNzRI5qDYJnZUvTDNeFpnIyTe+XAgEkL36Lp/jKjb
         hmqtJuPMI17Bid1xRad1LC3G3K3AhQcuuCtChrbYSyhbXXJnZzXn5M8/gcPBMEf7xa
         EAeaDOid2/Rgw==
Date:   Wed, 21 Sep 2022 16:26:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] arm64: defconfig: Add Coresight as module
Message-ID: <YystQ3pw3uBpi0CT@sirena.org.uk>
References: <20220921140535.152627-1-james.clark@arm.com>
 <20220921140535.152627-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AIuU0qW1akm1CIIV"
Content-Disposition: inline
In-Reply-To: <20220921140535.152627-2-james.clark@arm.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AIuU0qW1akm1CIIV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 21, 2022 at 03:05:35PM +0100, James Clark wrote:

> +CONFIG_CORESIGHT_CTI=m
> +CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y

Do we want this turned on by default?  According to the
description it's a bit dangerous and it's exposed via sysfs
rather than debugfs.

--AIuU0qW1akm1CIIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMrLUAACgkQJNaLcl1U
h9DaPgf+OhI8crAfL7KWOMPYRW17MUXEjp3TTKHFhH8Osk725ykp/A+6DOYMCcNj
ZcO7tSbk9rtGl8IM8/11F6/p1Y3nWdP9tmU/Pabru+qn2wJO9aLoyfbPcLvc8GOW
8QzKIa10nH6aJ3JZGEn09D0SqcuZjAUvCk8K25CPPEw0ivhwyiWoXwDMPQ+X181D
9qlb0dseriyShAOxelxjMBRYafaab8UjVDnCcu/ymiLcyIOCtT9cqGnRggAvy+Lv
iLC2BlILtELLg0HCVU0bA5nRdswpwABHbgxpazL74z8730deFUgtXDhHCN5iRusR
m/ZQNQPHxP5VWktwTh43vobzFO5bNQ==
=56p6
-----END PGP SIGNATURE-----

--AIuU0qW1akm1CIIV--
