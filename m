Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDFA6382A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKYDKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:10:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884CD1E3F6;
        Thu, 24 Nov 2022 19:10:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJKcH3GBsz4x2c;
        Fri, 25 Nov 2022 14:10:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669345823;
        bh=lij2x605a/zTuFIn0XYQZ+zDs1W/t4TpuvMuL09wlnA=;
        h=Date:From:To:Cc:Subject:From;
        b=eBvyWraE8plPrgsbC0+T0U+DxBXU1h4P6uZidtwyZ+NYmKJHad+IxSExodv/rx/zt
         PmdT+LFwnquWFb1+SgCnwJkMmfUWk9yYDZrnzx3WaytsEQeKPP4Fb05JUZNajEhX3w
         oB6tKOCEkUCl7+6613Twv66utXPrSFxLERvCRTtfz5c/yXhGIp8zulZblqjy6ut6mv
         tik4AiAkq4+qx8SWhaTNq0mk4HUP1ogC0VuhZsXiqkjlTXd5Lc/8hO0DjC0CSqWsd6
         vPWDeEOeujDsJU+kL1WqvXiBA5ZajiZOZC6b2P8D4s3fQCd2j8pcM0Naj5CZYfJ+XA
         at5gfA09p8wLg==
Date:   Fri, 25 Nov 2022 14:10:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the ftrace tree
Message-ID: <20221125141022.42d150fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9zLAQO82=4J.+8DsXD1pxCj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9zLAQO82=4J.+8DsXD1pxCj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ftrace tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/trace/osnoise-tracer.rst:112: ERROR: Unknown target name: "no=
".

Introduced by commit

  67543cd6b8ee ("Documentation/osnoise: Add osnoise/options documentation")

--=20
Cheers,
Stephen Rothwell

--Sig_/9zLAQO82=4J.+8DsXD1pxCj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOAMh4ACgkQAVBC80lX
0GxJxAf+NTdmH5iXievOZP0M9XOw9lPwV5jGMJDLHcJlCAmuZwsdJT8zasHJJGB6
XkG6HDYwtRh5HrhwK0tmxLZpPN9Aq6c79LXrFIir+TVOK3d9CooT/PakMU1yjoex
UnWaYFhwbWi4jAyJtZXFbN1dqSUcpCXbOwIaErgQ7lgkp4sJDgqBQxrxHKLMKVaU
d+y2/pwT+MdhiWeNX5S2a5n2JVSLd7tKqjfiFUy2QPMSRAK1a2lMS0m8CCOy8Lxj
27VFcqmGm6/+MHlhwT40I80sAhh7YgyV0FDf+vjLESUJrlEYJsD+7XTvDuoI7MGh
AVvB+AKTMYILHe/Z5Z4Rfc8oCSOEhQ==
=U37O
-----END PGP SIGNATURE-----

--Sig_/9zLAQO82=4J.+8DsXD1pxCj--
