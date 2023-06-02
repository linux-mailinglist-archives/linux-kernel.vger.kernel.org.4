Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5872010E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjFBMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjFBL7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E8E7F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F213964F44
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E5FC433D2;
        Fri,  2 Jun 2023 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685707163;
        bh=zXI9SfXG47m32N4Y7XM5UAcyFzp9aU8iEFUm/vviaSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLAV8rPm+ssL8ppl8D7lf9S8bQxfim5OErgN9phMeoSnfrUs5C/3kafEq+z8fs/fZ
         Bn2pHgdpe9aPNOozxAYH/hMCTdLD1RVZiRGP3Wz/0Z+75JRvPvSizxUmod3NiBIe6k
         ymFNNYWC4z55mZljDFHi+ItDvWjJQDbhaDWy2Eqb4yQlZWEeWEGUwXGZfGUwZ3H1c5
         pOI7tuP3tqyARlYhY8n0TZzI5EZGNAMfSI67+3vuiFF7vxRuqIDTqEWa7ujOLXNhCw
         42NEfEyVR/dLoz/AxASnw7SiwWtiejmigWu6XrZVT6UejvPYczkjzQ5Wz2L+d9F4SD
         G6PAwtFzqMvYw==
Date:   Fri, 2 Jun 2023 12:59:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 10/14] arm64/sysreg: Convert TRBBASER_EL1 register to
 automatic generation
Message-ID: <5bb3834c-bab9-4dc4-b773-17bcd4bda28b@sirena.org.uk>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
 <20230602062552.565992-11-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+x0v4d5lDx/j2ooX"
Content-Disposition: inline
In-Reply-To: <20230602062552.565992-11-anshuman.khandual@arm.com>
X-Cookie: War is an equal opportunity destroyer.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+x0v4d5lDx/j2ooX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 02, 2023 at 11:55:48AM +0530, Anshuman Khandual wrote:

> This converts TRBBASER_EL1 register to automatic generation without
> causing any functional change.

Reviewed-by: Mark Brown <broonie@kernel.org>

as per DDI0601 2023-03.

--+x0v4d5lDx/j2ooX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR52ZQACgkQJNaLcl1U
h9Af4wf+LfzP8AD+HSjsCX9BY0lM0M5X80WKPY4CVRkbH2vX2rx5gz5Lfu5aPZL9
KvUwvIw1UpfwfTC2jsUcNgSNNkCiyQLtnFK7V+lh2USZohIpzIO9wKy/PCUJcYIa
PAhiDfhFkC4w+4vu7XN5SSDZrAGscWfJFfz1JSdW/yBiBTGNChf6LDNtoZ4bl55c
0yWdBHL6A4MtpAQPeuWvyaDzAvdw/XD9C9mHX+CPiw9vwUDqTdY3b9ljtUmfShG8
vNtE/7EhyvBo8lMmw8bJS1h3S3kOCvtokdT5AMEKp2IdxNm7fiIrUVaZSsa7EgpN
aP4XMDcX9TSHUQdutaA9Scn835uB4w==
=UIP6
-----END PGP SIGNATURE-----

--+x0v4d5lDx/j2ooX--
