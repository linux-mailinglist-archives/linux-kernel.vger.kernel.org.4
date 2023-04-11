Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0A6DD255
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDKGBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDKGBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:01:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A8C12B;
        Mon, 10 Apr 2023 23:01:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwZwZ0NN0z4x91;
        Tue, 11 Apr 2023 16:01:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681192894;
        bh=fDaRNAXX3MceCbtR8+zQSYBG3ckpk+sV0RZO2DLtF9U=;
        h=Date:From:To:Cc:Subject:From;
        b=m0LU6aN//0lWVh+QtqhonJVZiqmoAu9in9B6NOtoY1luetF8GXvGo+2ThI0uAYrDA
         hh8rL5j93VAS8Ks96mzDHEMFgR7B4hZhzk4sG0mhJLPrV5n0GUUuXNDtqZ20psNfjd
         YBNevWTzok66MyY08oBUnN8rEAeVMDPKWPcXAShWDHT+oH5xj8P5PctRmPkZyPdHTC
         Op8jddV/NPyTfiJ2mihqjGa9+Fc7K7Qoi30r89ikDTf+AunFvlAQfGicpOcIBylkzP
         ye7QTBnc69DwKhdqUJvN+GhP8bpUm/qyI+YwJ1w8MlyWT5XWT+TKBsmBvoB/lmDgc/
         Vpe2vQJllRr5g==
Date:   Tue, 11 Apr 2023 16:01:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20230411160132.07ff8eaf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e_Sj8bDijfZn0ZQeY=GNlR.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e_Sj8bDijfZn0ZQeY=GNlR.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (htmldocs) produced
this warning:

drivers/gpu/drm/i915/i915_perf.c:5307: warning: Function parameter or membe=
r 'i915' not described in 'i915_perf_ioctl_version'

Introduced by commit

  94d82e95219a ("drm/i915/perf: Pass i915 object to perf revision helper")

--=20
Cheers,
Stephen Rothwell

--Sig_/e_Sj8bDijfZn0ZQeY=GNlR.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ097wACgkQAVBC80lX
0GzlxAf9GPN3/Na9xZT596Kvql08eS7J+K9BJ2pHJlCFg+Cm+2VhZOVjbfHxfsjI
aazCfnV7q/ngOpDahWXoXbX7pzEtMxenfjyKEex1HTuCZkrO8S0Ig+wCVvPpYe5L
BBNicptz0yZiM2Jm5iIuQ9JFFLIR0SNC3taj0oXFAskaVjaHUe3j1dn3+ThfpQDG
lrbtxFTqzHpBgAdjBPbhBRyRdvc4hRbXbSGnHDSYdPe8F6D3zaQCGWvOE7I3T3Jy
DBaDDweb0t9/3G6CeybOjKxuyuXR4H6orGuk+lISvBfnCGIrvhpmGrBfZMilpB9Z
OzwHgGj6xT/WVgeDmlsVp7cmxbc9vg==
=44wx
-----END PGP SIGNATURE-----

--Sig_/e_Sj8bDijfZn0ZQeY=GNlR.--
