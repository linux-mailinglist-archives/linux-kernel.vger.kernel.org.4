Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223361E9C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiKGDjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiKGDjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:39:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B105D63;
        Sun,  6 Nov 2022 19:39:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5H5d1C6fz4xG8;
        Mon,  7 Nov 2022 14:39:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667792341;
        bh=sAF/VAs4bVZneFveAgK5h87NaaJF7EqwoY/5dS35PcA=;
        h=Date:From:To:Cc:Subject:From;
        b=s298iSYcIEn/fT7AJaNyQZGjRCEW2dSi0LXZUHmD1oL3fBckih0QIztPHktMhIeRC
         UrhJL/Hvg6qZ0tYLLMx2rsFLjkjeZd27eYdTjAtrnH5MSX6RtrmlFiY3hhKhLFKqhM
         DGWOHl0y8IQ2AQ49V4S55vF07wNHuLrAPVGd1uhd6eaDBA629Fl/bh1W80loyI3dgw
         0yDRZ35EQGmpGJ6r60g8csCMeepRqzTg/cXF3NRND2zu/YC7kykfS9HLQEv0sunB4o
         U+o7sU78Wx0ASk/yEDqX3S8gGSiRtPWCi4v0SqTTcvZuUuaS1n3p2xZqfz0NmCEOQO
         XmPs5rITd9cEQ==
Date:   Mon, 7 Nov 2022 14:38:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20221107143858.0253a8ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/blIYOki0/Vg8Y5atyMWpuJf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/blIYOki0/Vg8Y5atyMWpuJf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced this warning:

include/drm/drm_fb_helper.h:204: warning: Function parameter or member 'hin=
t_leak_smem_start' not described in 'drm_fb_helper'

Introduced by commit

  e7c5c29a9eb1 ("drm/fb-helper: Set flag in struct drm_fb_helper for leakin=
g physical addresses")

--=20
Cheers,
Stephen Rothwell

--Sig_/blIYOki0/Vg8Y5atyMWpuJf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNofdMACgkQAVBC80lX
0Gz5Agf+OXwpimukDV8k+J5jCHIAYcEP70XSS168xmn5MdrD+WDccqXrkf6u0hzZ
VSG7dpf6U0SyRWZzRxkvTXtjz6wer/8y1kQPFcm/7xB6jIY9RTeJH4l9rQVJHALM
LDa+HhzSCx6wJ7XdW9FyzdldrKGe+moFTLNJeQTRnJ+M5BH/wfGEa7x8tANm6DHS
cNUsY/llFncC34kfcgK/7d+8y6jtTmVY20Du30i6nwtZxf52fGBUUSRkhuw9Rjvn
5CaprVqsV928zgCqZ3lByLBHVNVrrhTdktlA1rfXnAWA1BRsv4p4WaB5H51iGAa1
GlUmjqS6RDbp78h9cZ7fAaekdYL00A==
=tSVU
-----END PGP SIGNATURE-----

--Sig_/blIYOki0/Vg8Y5atyMWpuJf--
