Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2B37040D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245663AbjEOWRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244443AbjEOWRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:17:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D55FC4;
        Mon, 15 May 2023 15:17:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKtz00K22z4x3l;
        Tue, 16 May 2023 08:17:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684189052;
        bh=+yERE2+fCqGTHED1pWlZ5cC7CvZHJBwQ/OgBm8DlQVI=;
        h=Date:From:To:Cc:Subject:From;
        b=IyUgc6GYkxVxQVe3l7EtZ47P//HAd/hVuXECgo6S2MnWj52LjKj4QGJTQy6GHrwOu
         IKVqy0RdfquR9lxFL57CbA+r12EPWs4bo9LGKolOAia6UHY8sYyiLgjyn+4kc6xbL+
         6pvu208sBbostfMnZToQsgDX+P1FmSERbvsDufoCgF4S/TFXF+4bYkZIH/gh/JDu3N
         j9MWjYFmBeiYXHGZxU6+m70cLCsQ8zCa4ivTA+wkSw4ISZbaZLiqfQuyST9FSHunK5
         e9k5GsC1NKRHBrw35O48CmHYEZRlENkikB7qIy9FttWbAIh/9tgETGXuFO4GwcSmwS
         AmZT2yE0OnUZQ==
Date:   Tue, 16 May 2023 08:17:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rpmsg tree
Message-ID: <20230516081730.77425ad8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pEhdyJAcchxI8XCgDG7Xyqe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pEhdyJAcchxI8XCgDG7Xyqe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  de598695a2ad ("remoteproc: stm32: Allow hold boot management by the SCMI =
reset controller")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/pEhdyJAcchxI8XCgDG7Xyqe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRir3sACgkQAVBC80lX
0GwbBQf/XAMtP8LTKv80oabShOmD7+anOi/J5B6loatcalzGtclS2Nb2rdaCNi6i
tlYqqfYDoZfkqHx0NU/QT/E++yiKzg+BuQ0TRGqCHXa+WEmUpzZJj9UH/lwYEZMx
8sL5/MZKVDi4aTr+pgyGY2zeM3UQs2NaENwBarLtmHo7n51V4c0QirhGXuPrYGqy
e6GlR1Z9MteuPaG0n5a/+2ObRF631OCysTOgA6KoxV4mkt8VJ9aJOtLhCUfOrpQt
qdH5sEpcvXlhAFUpva/bmWArVStnsMYng1lBVEr9K7faTTi7k8ABwk4d0luCxsA9
GJhg/dGdwwzsicc9KDTFFv5nVFSsFQ==
=dHNH
-----END PGP SIGNATURE-----

--Sig_/pEhdyJAcchxI8XCgDG7Xyqe--
