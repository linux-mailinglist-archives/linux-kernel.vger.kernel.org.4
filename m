Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF1472D35D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjFLVdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjFLVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9605792;
        Mon, 12 Jun 2023 14:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A94762C6D;
        Mon, 12 Jun 2023 21:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DCAC433D2;
        Mon, 12 Jun 2023 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686605621;
        bh=+NGj3t4VzypRbCTZ4iQmjS2Wvh7LDX62WxdzAqXEl2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5JkrBvOarwkALXD1ohc8mZUcdoQZzN7DpLN0TmW/QPV2mPEOOsbrllkXKW09Jbkc
         NlB1+1ias5qQMHDF7KBaqX927lFXgsAULia9q2EkzVttgQGGnURfolHOMvD64TP6o2
         lnSfiVQGatXdllWyXFiviJiDnjReBZ+BUEeSPUoaTtipaiNLohP7MRpM9KmL3VBxBB
         tkZUTC10ByXcFw6im2WWNj7boDLwPKysA9n/IDv77Qa1asRXu865xLQIEt1SdvIGgZ
         0VHM8w4yo5vUJObpyzcw8IxBqSoNdlDvj1WXiijWuE0LEjili5XzymPxdSzJv5lPD2
         6GKQtQY+JAyUg==
Date:   Mon, 12 Jun 2023 22:33:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v5 2/4] RISC-V: add Zbkb extension detection
Message-ID: <20230612-jumble-worshiper-2fef89b4f3d4@spud>
References: <20230612210442.1805962-1-heiko.stuebner@vrull.eu>
 <20230612210442.1805962-3-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RLdwK+thYKDT3g9A"
Content-Disposition: inline
In-Reply-To: <20230612210442.1805962-3-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RLdwK+thYKDT3g9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--RLdwK+thYKDT3g9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIePMAAKCRB4tDGHoIJi
0s/ZAP9x5oSQ4Z7tadV7lwFQu4Jn14M18EW4rX+tma7eOEHEOQD9EQAXfJzfDILv
phOrPTLfu6crlwn/gZU3AxGnemFUkA8=
=ss8H
-----END PGP SIGNATURE-----

--RLdwK+thYKDT3g9A--
