Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C276C65DF3B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbjADVqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240352AbjADVqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:46:14 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F98F42E1A;
        Wed,  4 Jan 2023 13:45:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnNS72W08z4xMy;
        Thu,  5 Jan 2023 08:45:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672868711;
        bh=Q0NhW7anrrUDZgEP8B0LcI9rjxnS0BhzIw1DzboVlbs=;
        h=Date:From:To:Cc:Subject:From;
        b=TtpePlgezSSjT2SlgTXeoCvY1aKzL0LVxRgtCQR+XXypAAjmSaiG9GrYljglIdt3a
         KFwSPkDJ2au8lVfXcJxsDouWiW5QYHeJTAgltldyGrROHiNyZRRA+NbjOGyFNC0w4r
         U22mQo/wzPZOgz0IA/5fw+wIQ00JGUeZG8q/6bbBZ5X66JJ60KsxPP4mu0imn7kzjG
         NDe5npqXHCe24LE+/0tXZzmd72KYT+IsnD40Yv0D5OyFP0RD5Io7SHC8uFwT5MTtdr
         n/5LjOtBHup8mlYE3uPXuTxR8QReq4Cu5DkEECPEGbZ6c0E/vfIYJJUssBh0NRwsH+
         PE31jFF6g1ABw==
Date:   Thu, 5 Jan 2023 08:45:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the amdgpu tree
Message-ID: <20230105084510.3193434a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dLkUZ0Djhrk_gWgmpJfjEO8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dLkUZ0Djhrk_gWgmpJfjEO8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits already exist in Linus Torvald's tree as different
commits (but the same patches):

  cb8dc232cbd2 ("drm/amdkfd: Fix kfd_process_device_init_vm error handling")
  41d82649ca56 ("drm/amdkfd: Fix double release compute pasid")
  76a95b833ac7 ("drm/amd/pm: avoid large variable on kernel stack")
  7f35c54cc2fa ("drm/amd/pm: bump SMU13.0.0 driver_if header to version 0x3=
4")
  0b93c5434181 ("drm/amd/pm: correct the fan speed retrieving in PWM for so=
me SMU13 asics")
  e3bf7e96d0f6 ("drm/amdgpu: skip mes self test after s0i3 resume for MES I=
P v11.0")
  9c705b96d25c ("drm/amdgpu: enable VCN DPG for GC IP v11.0.4")

--=20
Cheers,
Stephen Rothwell

--Sig_/dLkUZ0Djhrk_gWgmpJfjEO8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO182YACgkQAVBC80lX
0GwGBgf8C6KbLgFnbaD+LwrEcFZBcpW9o9vV4kUazcC898opzM3fZ+qxhIGnoBC5
Q6MAt2UDsbvlMvQPZcgN7Rc4FLsasFvNDpWJsxnltvH6C2COpKB1PmcvCvDBC/Q5
LAb4A5XUttRQqbigRdkZpNrHk/rNkTyBsL7gf/2Qo8f7FJ/aj3V64rUESQ3K9CQ6
6bUCovGoEYKerUOGsf4K/2QdDB0yScmhbAdQZaEoyvMC58X/8jBiNns9F1TKKnhw
90nxJ2dWSZB71Pvt0PnsjagqgjiOB9Oek8Ok/kAXCyNJF26n2gb+O+SVdLlx3iXO
HJy/w9jZpBXhO/3kjqNuoAz7/4p6Qw==
=kJFu
-----END PGP SIGNATURE-----

--Sig_/dLkUZ0Djhrk_gWgmpJfjEO8--
