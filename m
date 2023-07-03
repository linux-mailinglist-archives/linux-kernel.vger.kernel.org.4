Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE9E74605E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGCQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjGCQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA29E49;
        Mon,  3 Jul 2023 09:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C2E60FB8;
        Mon,  3 Jul 2023 16:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E58C433C8;
        Mon,  3 Jul 2023 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688400416;
        bh=GR+TZZoxMlJfSWy+5b3SWRjvPIBWPzj4iiEkRB4WS3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPtkHx17+ZMRhE9VSWp1L0Zdfaa+5fYUyAP+rmkglEuLTJeYtjkxKUIpR0NWOEikQ
         FfAq1QZ1S/wVvNEnrIg94792RaN2fAkc3uPjY9gVJwwxMHWP4zIK5ShWFWI5OCv5th
         nJbk2z2KBL8SRwE6vDhATqebTWn0FpG/XCrZaG2tftHa3rVkh8Cexh4fQu8Y3J7Yit
         RFJBh7tzwfcaunRU8cnu/OzGrauQYc6451LWYPNORzO68+sHIV1R7ucwThCH1117hd
         n8ZqZDLzm1WwyzPZOOnfBnl8zWCLIBfaxo5wjbeC42OGi9a6JOhvta9Bvb4q0+AqNy
         DJkiiDTQK15PA==
Date:   Mon, 3 Jul 2023 17:06:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: cpus: Add Cortex-A520 and Cortex-A720
Message-ID: <20230703-aghast-surround-874b25930eef@spud>
References: <20230630184807.2164597-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CBLrZXVkiIGrf87R"
Content-Disposition: inline
In-Reply-To: <20230630184807.2164597-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CBLrZXVkiIGrf87R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 12:48:08PM -0600, Rob Herring wrote:
> Add compatible strings for the Arm Cortex-A520 and Cortex-A720 CPUs.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

It feels a bit needless to Ack your stuff Rob, but w/e...
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--CBLrZXVkiIGrf87R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKLyHAAKCRB4tDGHoIJi
0vbHAQDCS7XS5jOx/TL7WyJQJUTvD92JnSQNu77ITXaZkf9hggD/YVahECwAxXJF
MMtiJzC/zIo1WkCN7OBOr5Cb3Ox9Rwg=
=Z5Mc
-----END PGP SIGNATURE-----

--CBLrZXVkiIGrf87R--
