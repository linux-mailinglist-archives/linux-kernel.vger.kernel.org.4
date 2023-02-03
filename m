Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E5688D61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjBCCxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBCCxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:53:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AE22A0E;
        Thu,  2 Feb 2023 18:53:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P7Kw04n6gz4xZj;
        Fri,  3 Feb 2023 13:53:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675392784;
        bh=YVCnkJKekD9jf5cUhxiuiMU4drjtSui1/krseXp+DSc=;
        h=Date:From:To:Cc:Subject:From;
        b=dZgvAMh1qgHF8WH/CFSlL6SBA4B55pUJ/feaXaq6CGabzG/kqmU07XP4MOCDu1D24
         NAuXFhN292m9u5G/VNlZknw8roKsS1QSOJQtL8V6vCBHvdiA/XXnq+eRjIhg2A0Nsq
         Kk2sq6mz0yAjibhNwjdlRdaS+usi7ewW01Q1/9Rwn0OYDHzmGEeRjWARZc92dNHpW0
         M+GXMInqjXjN+N/84nZIYB6ZZv0viiW7xQWSRYz87yI53hWsmMTEcSQdTps+AQEjzH
         PHVT2raDBkTr8P8ydkXwCh9K2rv58Eq2XBAjd8UWtpcr2UngagYrrRvx4PE9PO1xed
         VrteuaoRBbS3Q==
Date:   Fri, 3 Feb 2023 13:53:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drivers-x86 tree
Message-ID: <20230203135303.32da1fc6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q6zMJiKUPGUxHfzpyW4b_fV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q6zMJiKUPGUxHfzpyW4b_fV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drivers-x86 tree, today's linux-next build (htmldocs)
produced this warning:

include/media/v4l2-subdev.h:1088: warning: Function parameter or member 'pr=
ivacy_led' not described in 'v4l2_subdev'

Introduced by commit

  10d96e289fbd ("media: v4l2-core: Make the v4l2-core code enable/disable t=
he privacy LED if present")

--=20
Cheers,
Stephen Rothwell

--Sig_/Q6zMJiKUPGUxHfzpyW4b_fV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPcdw8ACgkQAVBC80lX
0Gxk8wf/RYVrcn1ylnl3Tqb1eIQ7jFoFA2DoxS+pucLNTXg9CICoHzD8pg97Wm90
5UWi/CkrfVFh44tfIUiQwOzsX/XOct/SQjEL6u90+QmvLcoE6fp/kjJ2tjUnaAfF
v7TyI5yH7sbgz5M/aF0tqFdbGY4exT6rD2Tctfk4pqz1TTpcZt0XHBONCHYRWTCu
4NO0JzGitJSm2k5kUzbBn21hzwrH4RYqv2eGzBVVQvYSS2DhMi+T6ul0jcKCZ8Sc
7ofImc6vT7vl7HZF9QnzUqncuB4z/b1/m+1SNuOKgdEs7CgsM/47lx5dyL73BgZ6
2yPQRV5XUPB5UNZGzvQ7LzJXzjK1Zw==
=1DXa
-----END PGP SIGNATURE-----

--Sig_/Q6zMJiKUPGUxHfzpyW4b_fV--
