Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5AF67D896
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjAZWhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjAZWgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC8B3C39;
        Thu, 26 Jan 2023 14:36:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2wYP4mB6z4xwq;
        Fri, 27 Jan 2023 09:36:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674772601;
        bh=w6NFETs287m+waQNjv1iPPSx9DhormQPktztfTYHRjA=;
        h=Date:From:To:Cc:Subject:From;
        b=W5OWfb6btDxkTJCkODuHeJALPzA2YxAJ4/628HTMlrm1LGW7xAoRgCiyAYVy2yb5X
         j+W+lHA6cDESjx/R0nAeKIg7LT/fu+yVivjRfZBLP2ykyYIEKZEPRhl0JzJv8zv354
         S9NYYDSZJaIelfe8i02v9T4NgzBvhWhZd/JCvkiY8BmAy1075+NmE8svzRR/5Mhwg8
         hqUPUEOeCxjKqzJmJd5F3T41qfz7wqg216HMXmrEaUAmiFybvpbtpUADzMVtW5ag1H
         rmMsmESs0QHqs7SLcrVC+qi+FKYtuVwNgBRuE3C5C0BqHgm9PlE4EE5R11eat2SS1g
         XMmT3PZKthrmg==
Date:   Fri, 27 Jan 2023 09:36:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the pci tree
Message-ID: <20230127093639.27eb526b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7h9W=Mqc7OfBfveWzalAujA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7h9W=Mqc7OfBfveWzalAujA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different
commit (but the same patch):

  b692c96b424f ("PCI: dwc: Adjust to recent removal of PCI_MSI_IRQ_DOMAIN")

This is commit

  760d560f71c8 ("PCI: dwc: Adjust to recent removal of PCI_MSI_IRQ_DOMAIN")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/7h9W=Mqc7OfBfveWzalAujA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTAHgACgkQAVBC80lX
0Gy1zQf+KM+1qP/1o85sKL+kBNr1JI/KZSr4+V6V3A0D4v6nGQM6ZjdD71ahGw3P
NHWgzoB605Yk9Ce6mSqaWRi7jKNFN2uIX83tP9Bh9N71/SG95Qc+irsBOnxBZHDP
qkBlNIJ5l22RMhRM1ctv/3pemlF5cI2rzdq9iHZKRVS2lq0f+RXL4CB6fnsFBvSe
ZsmuxYDFgpbBIYlc2ulU+tp8vuzQBOrbNHLZLUqKcy9NNVE4jj4o0xhZoWndeJ7f
7guKHp/rdDGrpVF1DPkC8twgROtU9s8DccpT3JFBJsAsblhdM0dELSq3PdjjP8FV
KQ2pROVbOSGfyZlh1ViR9iVUGj49Mw==
=jOFK
-----END PGP SIGNATURE-----

--Sig_/7h9W=Mqc7OfBfveWzalAujA--
