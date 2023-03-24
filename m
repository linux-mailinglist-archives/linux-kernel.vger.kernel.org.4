Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB36C7D84
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCXLzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCXLzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052723847
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7121762A6F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5883BC433EF;
        Fri, 24 Mar 2023 11:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679658931;
        bh=OVEuUE0WW9mm8Nmy+r/QmBOi2aXg8YDEqN9guHehgkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZkcyenz9ThHHjj9Mbrlk+f10KS4z8/JNsvb5YPQTFpwGOtbV6Sc0979xzFSb4D00
         ytRzIcrOGLtYK3fpMzC0uLiMjn4xYaNMStp197oNJWD/wn09qFfoL5HzRlbFawOX2g
         Dgf2SNdrkY2+njb7bskRnbk6a0SRsSH2AOkhzXBqRF4pn421oYcGOLZnj1WpyLA2hT
         0EbsdSL/Ej3y/l1ZniJNMAEnvdL06SN5lCxxIhxHoeBmgjKfQDNPi059u43++SdQVW
         R5nH4XdZabiXq0AAU/C7fqMJ1K7h18VRDpdmYLe9qowy7uZHm9OgkvVK0+nWRu6bOi
         ewru/hUVkDhUA==
Date:   Fri, 24 Mar 2023 11:55:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Disable EL2 traps for BRBE instructions executed
 in EL1
Message-ID: <ZB2PsJ+1U+TJJ70o@sirena.org.uk>
References: <20230324055127.2228330-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CWVMHk8IWIq6m5Gy"
Content-Disposition: inline
In-Reply-To: <20230324055127.2228330-1-anshuman.khandual@arm.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CWVMHk8IWIq6m5Gy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2023 at 11:21:27AM +0530, Anshuman Khandual wrote:

> This disables EL2 traps for BRBE instructions executed in EL1. This would
> enable BRBE to be configured and used successfully in the guest kernel.

We should probably update booting.rst too.

--CWVMHk8IWIq6m5Gy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQdj68ACgkQJNaLcl1U
h9Br8wf/cSZsPb7klipcF4vE/oMZiaZvULmY9arXsV8UbTBf5NuCLGIHfNmKq/4B
FUKvl+TkuI2AMTvHRQFiGTtIB6Dau1MNf0ka7Nwk2cgg7Ip4LaX7MbztV/FzpBz1
4D+Br/wvYBpQM6lWQ1VFewHAVCgWH1LA3BXnC2BXOeLQ/POp1Taua2yqRsLIHmoe
CwEIhwK8Nyo0oH4ukk0b6R2nRxwNO6E+V7/I0hNlWhZyIunpofcKFGB5hgHr09Z4
1UlCTdfDFab+c5wpy2xGQTIv5PdTFmwZRJ3IHtv8ltTDyI2tRPfpbymWbf23Oan0
3ycTekp57SyJLAENvJ4jHut7Hms5Gw==
=8dZt
-----END PGP SIGNATURE-----

--CWVMHk8IWIq6m5Gy--
