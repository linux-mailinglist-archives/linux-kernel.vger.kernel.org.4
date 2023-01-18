Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C05672B37
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjARWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjARWUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:20:48 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA0764682;
        Wed, 18 Jan 2023 14:20:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny0ZZ0ctMz4x1D;
        Thu, 19 Jan 2023 09:20:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674080438;
        bh=H8dlIxPWHf9WYTAj5L1JkHBaFreeBBLNaHVidd7nSMM=;
        h=Date:From:To:Cc:Subject:From;
        b=i9oDwmwbOpmtVi9loYASNDBfGjw+7QxW2BWJebMv2URTjmHj0tN2AxWh53RGKztlp
         dV2fD6XfdrJsIYTReGK5LgoSrdUyKr5XqhAQx/sJRO/rH8M6Da8obq6PaDFDFsVcQ/
         y8vE91PqPYESXFr2IUINTSzxXzRlogEPyzsQEZtGNp9h8ivVoyew5UXp0leXEfgC88
         OOqmDtpV6NW6MoDZT3l45C9fK/HLCzQA0uq/pmW7xtfz5i+5VpNr5vjZmko+exKx+a
         17BHej9wPXrwRqk9jUqgkSm1stdTioOTPkBX1IhePdDisqLXoPllnxlpgv6canYIQF
         yrhzmdViPWE2g==
Date:   Thu, 19 Jan 2023 09:20:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the devicetree-fixes tree
Message-ID: <20230119092037.7fc4f401@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GJL/91woSgvS+TO8SGF.1q/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GJL/91woSgvS+TO8SGF.1q/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the devicetree-fixes tree, today's linux-next build
(powerpc ppc64_defconfig) failed like this:


Caused by commit

  2d681d6a23a1 ("of: Make of framebuffer devices unique")

I have used the devicetree-fixes tree from next-20230118 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/GJL/91woSgvS+TO8SGF.1q/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIcLUACgkQAVBC80lX
0GxF3gf9HvYXWsz2C5MTzcX3lxTPoLGg4cBnF6vBYRJbyBDypkNHzC9hNMIqp/at
Qkr256yFchQUd8y2SRaycXTf6kD5dOQotw4egEO1rJb3ADNEho5IpcOOpPzriqAu
1lQUemwPDhjeOpf/5mD9u35mO8E9XlLtSr2R3VflEUALKb+w+TrfkbOrGz9/7dgy
XCc04iOJwJfJXzKX7t343HtjU2/tvLwtHyo2cUPuwe1gB0Hu86BvxSDrUc6F7mt4
E9/LQhdcFEneal09amov2tjsmBeQXyR9/Vf7d6G445F2UdfFyqD/V3OL6wIxtGOc
fDt5MTtJK5dxZ3U9vjXKpmxjOE64kw==
=dRT9
-----END PGP SIGNATURE-----

--Sig_/GJL/91woSgvS+TO8SGF.1q/--
