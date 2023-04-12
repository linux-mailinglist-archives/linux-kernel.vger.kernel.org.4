Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19856DFFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDLUXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjDLUXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E693D59F2;
        Wed, 12 Apr 2023 13:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CBB66253E;
        Wed, 12 Apr 2023 20:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9A2C4339B;
        Wed, 12 Apr 2023 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681330993;
        bh=Pbpdff07CGQ9RlJoIcjFDulY8ORNkgKzg/SbW9DnDYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDhU2wda1ZP5zafYJe6ojzlEt7pOkZlOr4T2uv3bu+EybAk/f9NwUopMbByuVmEyK
         979rQWKYp6y8T50yHdmtGW9VIqQiMTz/nb+M0V0pM+WEtZW9OFFKGfaPJ8jI1Id8aY
         0lihW6PRZbP+V/NLdyU7pwSTRmsmRrJzjKMldJGQD4jovkcMzs51fUDDLVc56BpBhO
         y1Qt7Cgk5HK5vq+hVqGvLZnthh4MUHpzoWd+LF/zR83cSWGzdfzfHRXmuNJg4aXFpq
         ZZ8f/h2HMcmNMAT4dOE3eRSr3Kz1ZurOg1iurlPbb3ZPGkEvEdMTTr18lb0iKs+UZ6
         t/hbpRzc1qpag==
Date:   Wed, 12 Apr 2023 21:23:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rohit Ner <rohitner@google.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, joychakr@google.com
Subject: Re: [PATCH v2 0/1] SPI loopback testing framework updates
Message-ID: <d43b3412-2fa5-41a8-9f7c-d6859b3ba22d@sirena.org.uk>
References: <20230412202009.3750955-1-rohitner@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XutlTNAnxAAtlnj1"
Content-Disposition: inline
In-Reply-To: <20230412202009.3750955-1-rohitner@google.com>
X-Cookie: Happy feast of the pig!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XutlTNAnxAAtlnj1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 01:20:08PM -0700, Rohit Ner wrote:
> ---
> V1 Changes : Add module param for iteration length
> ---
> V1->V2 Changes : Fix patch format
> ---

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--XutlTNAnxAAtlnj1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ3EywACgkQJNaLcl1U
h9Ci8gf8Dk4Ja6/ClDmBkOBes49NVGVlE/OnIk6eGtZCIOFdD/SnEWZxlJm4HMwT
L/uqr8wd1X7Gx/Mv+vcFErE96lVOKayiwARi+gyKLybhqv+oWE7EmLNezTq58t+h
f72Hy3DT9sJlNiVJ+leBd0kp6XkB+ryvWgsk7SvCpHuiMktweOQVmCR5/1pBr+nG
QbAHNZTpiJf+5Gf9uqCraEYT/D4GsrBZ8UE53811m18M0hmFDjTUIlM5od4AS24/
ju9j41D+wyAaJTLQnFiImyjC6Yvo+YutmOU0kywBNvfjcFlyx5AxtbTi4UOcIL9e
9PsS3WLlBZBh3V/UP7q+2F9Aeb/Dzw==
=jQ2i
-----END PGP SIGNATURE-----

--XutlTNAnxAAtlnj1--
