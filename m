Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C528C61E99F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKGD35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiKGD3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:29:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7419FCC;
        Sun,  6 Nov 2022 19:29:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5Gv31DGYz4x1G;
        Mon,  7 Nov 2022 14:29:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667791792;
        bh=hfcnysi5XE55sQ7n9xn2W1rxdYZnNTSb6DIFzZ2gMmE=;
        h=Date:From:To:Cc:Subject:From;
        b=kaO2POaWN3Rtdq35kgtMMpUbhEToSiR6RpXhGidtvkDbjE25fxDzHUGMynCCfTwpl
         DpoomdyelbGVMgxDqbU9b7dQggGwazRBY6tltoOhQrVRN8NOsSIIfcEo8hIXYgeZVC
         hKK9tJpZZ1O/k2G6yDi+mxzHZum0rEySGiHYgwSjREd5ClpLeoXY4sjYr2EQTAa8Bw
         sAnhYDFzTMRCKZVWHQ1blOOYFtvWQD6yyU7pT1I0XNi9P+GLxDoC+SHajwE/8m+40F
         nWKRI0pTNuGEbSV2rUDxdG+/AoIOMkiP8Dm3lCWi7UKcp8/bc+MhUaojWG/0xU6MqJ
         XWK5Mw0rhMSlg==
Date:   Mon, 7 Nov 2022 14:29:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     John Harrison <John.C.Harrison@Intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20221107142949.516a9112@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uMbCnewP=F7/L37N0U=sqBA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uMbCnewP=F7/L37N0U=sqBA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (KCONFIG_NAME)
produced this warning:

drivers/gpu/drm/i915/i915_perf_types.h:319: warning: Function parameter or =
member 'lock' not described in 'i915_perf_stream'

Introduced by commit

  2db609c01495 ("drm/i915/perf: Replace gt->perf.lock with stream->lock for=
 file ops")

--=20
Cheers,
Stephen Rothwell

--Sig_/uMbCnewP=F7/L37N0U=sqBA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNoe60ACgkQAVBC80lX
0GyLbgf/RZ+b7/pLF2D7REzj9nzdFaW0dnG/URf7FawvAzfOczmNxiIbYkz09LLv
Sy/Q96j96L7Pwtad/tOxUMj2alLRzjwQFrC1wF21SQ2CbExKRtuUzygnr6p/5jAp
oy68vEGwPboXHTzvb4rPPehfPIGwkHGwc0gwvoKKgz4O5wgGU9yI2i3+UWx14/E2
nMGgN3ohShAklRKCLFjhFliiF9Pi1DWSk5wEecMtNKaeU7rjDk78seTJlWh9HtAJ
27y+iMMdR+JQ8J9cJsPdKG8/SEihY66H562KEhUytnejea5Dd+549zsthMosz0ve
8VBkeA4nsN5MENehGenoUPRar5CnMw==
=z9xq
-----END PGP SIGNATURE-----

--Sig_/uMbCnewP=F7/L37N0U=sqBA--
