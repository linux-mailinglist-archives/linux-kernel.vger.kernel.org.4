Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7997721E23
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFEGbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFEGbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:31:18 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C0E9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=lQQH6nOriBLlbTU7J9bMgPN2Mir2
        iDnU+BuOVKAXjy0=; b=qfE5nxbBktFeAPemijTKQLVC/WhI1TyzMVksR92CwnXV
        sTR2tBiYMpNX0fZ7wuzMg1EDHigABIVIF1FDgSUsf0mNf/5dotbZyWhu1c2K7wDx
        VaEtvsG8ePDStqc7Q+61X0GpuMhHI84aw+q7oJ4/6GhBLg5fUC9XltrWU9HPnX8=
Received: (qmail 2911557 invoked from network); 5 Jun 2023 08:31:12 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Jun 2023 08:31:12 +0200
X-UD-Smtp-Session: l3s3148p1@mSVEDFz98tMujnt4
Date:   Mon, 5 Jun 2023 08:31:07 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <ZH2BKzvk/1vS/tZE@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20220329091126.4730-1-wsa+renesas@sang-engineering.com>
 <20220329091126.4730-2-wsa+renesas@sang-engineering.com>
 <YkRuXtTzd11R9IrY@smile.fi.intel.com>
 <Yo5GO5RkBC3PQLTg@shikoro>
 <ZHjAF6xg1fAaJhQV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/4+wwdBOblFw+Mmz"
Content-Disposition: inline
In-Reply-To: <ZHjAF6xg1fAaJhQV@smile.fi.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/4+wwdBOblFw+Mmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Year passed. Any news here?

Well, the issue is that Steven Rostedt told me last years at Kernel
Recipes that disabling the RCU stall detector was bad. He gave me a
pointer where to look for a potentially better solution but I forgot to
note it. When I asked him by mail again for that pointer, he was too
busy to answer and since then I had other things to do. But Steve is at
EOSS end of June as well as me. Asking him again there is big on my
list. Nice you remembered this patch :)


--/4+wwdBOblFw+Mmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmR9gScACgkQFA3kzBSg
KbamSw/9EuKJgRnQIB+TX2ue826riRURYNY5DIp9nNjjI1R0yUcMW+VfojMIPSo+
bhyGyqxUqg8wOwEQWQkDn5q7cAdmiX8v+Cvqt50phQIRVrU5z3kpawio0GLv4x/b
P3Su4iosPtZ2rhBX000Eukha/oc4Z+x+06T1iktnq3DZ/lzPrIPlC5FrU/JNDirW
yKwwS9TYgHBL5v0AdrdGacSBEsz4q34ndqeAXU8MUsBD3U9jWAUikRUP7kF5bbWa
+FbBLLibp1Bk9McMXojPkj9KIsHng/u+o3BsW90+H8e4/EWR92uZLugzESkDxGX0
WbGPleN8laTc1F9aFrArqRuNbKaJVFiy9uIFSTBS6QfxKScaXvvcLBQCi62Zcl8a
SgWIltedUEEDplnvo3/Nbd1RuYLfQ4mZgsm4883cfwwZsNS/eBCjr1ztUS4YtCIK
jF56jMxhgzoTBr4/vlJ+63OtUjggcoVENOuOFr3M7Z8xZoCodi2GguuP/2LGeN7X
vc7j84qkVxwz5wvcqnlS8NVvWU05cdBb8R98M86vLwJtkKIpGACAhm1BMT14Beq7
TVDkOz8XSpW3OLvWgtEy3PLmtCrKWImRZNvD14T03XsreJDusxuscPchawPdVNjS
wKPTCzRaHGSrg5C7oU1mB8N+eTZNSfv5ZQSVEIi9nxD7een9QNE=
=zyfx
-----END PGP SIGNATURE-----

--/4+wwdBOblFw+Mmz--
