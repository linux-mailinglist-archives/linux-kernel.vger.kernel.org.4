Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8A2678E98
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjAXC4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjAXC4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:56:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A039294;
        Mon, 23 Jan 2023 18:55:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1BRv5WK4z4xyd;
        Tue, 24 Jan 2023 13:55:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674528957;
        bh=zX3wtMRaVccd57BJ0+a8W7mlX/qXeO52xggODmbMqC8=;
        h=Date:From:To:Cc:Subject:From;
        b=kfxDBMB5RLOGU8z/17gIPBcj1tEMAgIfdO7bT6DAbNm5/n5v8SkwLhJVX4zu+KbOP
         H/EF3OVjghW0gMYXEENkcuWstlu1JZvtV1vw33y718NLkby8pkBgt25qYR9q+/0syQ
         AywKh8+o0/QVQBhDkiC3Po4jvP635YejA9TPJFd2RrSZjq+BsXxM8/ZoIo0QW3hknS
         oavImppd/RH9JgMSTTYn79CaqrO+ZN6i0lh7YFSRo+r0Fq+EzmOQvOHijHVRXAZgDf
         2uIJPTn/qxKflu3MWrO7O02CifAhZy1Ot4PIdxoEHXWyvyfCarkm7UJcenpg60GilT
         Q0j/hsvSA0D9Q==
Date:   Tue, 24 Jan 2023 13:55:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm tree
Message-ID: <20230124135554.3bedbf77@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZyiKg3sxftyWEF5tI915Z4C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZyiKg3sxftyWEF5tI915Z4C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus the rpmsg tree as a different commit
(but the same patch):

  9bf96454b9dd ("Revert "remoteproc: qcom_q6v5_mss: map/unmap metadata regi=
on before/after use"")

This is also commit

  a899d542b687 ("Revert "remoteproc: qcom_q6v5_mss: map/unmap metadata regi=
on before/after use"")

in the rpmsg tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZyiKg3sxftyWEF5tI915Z4C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPPSLoACgkQAVBC80lX
0GxI0Qf+MvdIFFqknRGKCEx/aINMNxArFQu9MQZQPKa02hPZ1y+lrPwVS8mjeVvv
08PQinmcGWoerjKmIIjnQc8vXx18zTqCjTZ9Fg7op0ni8UYKjopuUIhCs1AzsenR
Jr4Sl+ejL+n3L5eDwHGafcW/0v2FhmBwzlCfpuHce0eMypeoeRDxonIXLmOgax4p
4weo8jFrGw1cvJjg2xGlYo6KeoAzKum19elIgaLG4mfxx7W9fcSQZ+nKciYYnynz
DoE+25nzFXSxJzksgZmsiByTIg+HNzs4wG6nRr4nV6NKdlCgp85NQJbCmxOnmhmf
S4CSn1KfvdtyOqVKyS1ZWSvB3KccIg==
=1Qn6
-----END PGP SIGNATURE-----

--Sig_/ZyiKg3sxftyWEF5tI915Z4C--
