Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE55268B1F3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 22:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBEVcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 16:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBEVcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 16:32:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331714498;
        Sun,  5 Feb 2023 13:32:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P92fR5tDMz4xFv;
        Mon,  6 Feb 2023 08:32:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675632735;
        bh=KYTm1/5j7llHa2lFmeU2YJGSgVg3cFfrtVh8VGzonOE=;
        h=Date:From:To:Cc:Subject:From;
        b=o0j2wsLIQKh13mY+qQL8yLuFLXj49Os9SF7osUkdbNoxd6ijTZ8CBhL5qUWnMCzyD
         t4GwLSws9vZD0V1CSpU9ZqejXC2AbcHm26fOvb3yo2SeC8RuNj/DXGmz3q6vyFtAvv
         LIrH6IIhXhg/sI4wJIq5b5BabVfn/XeoQgN2lOvC/atO0sl9eGkPM1VHetvtpFuqD6
         YWafHTERrwzKksbUTXU+x76Jo0B72Ft8YBjvLrGQe/LwhVewjGfkJep/SSclSodG5k
         ZzaqkyLU5Ai9axpkR4muCP5jkj8+XRXGWMY3c1TF7jiwu0ZgLpMyDWHpQIKFUiNdph
         ZnLcWDzopUUqA==
Date:   Mon, 6 Feb 2023 08:32:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nvmem tree
Message-ID: <20230206083215.723e7f72@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y4oKU8Vq.4Poa98BNgIabft";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y4oKU8Vq.4Poa98BNgIabft
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  03b6f71ceeb1 ("nvmem: core: fix cleanup after dev_set_name()")
  6b868c1a2ec0 ("nvmem: sunxi_sid: Always use 32-bit MMIO reads")
  957b1f840ce0 ("nvmem: brcm_nvram: Add check for kzalloc")
  9afef75ce71c ("nvmem: core: remove nvmem_config wp_gpio")
  a895af2746e3 ("nvmem: core: fix return value")
  b02c75889942 ("nvmem: core: fix registration vs use race")
  b3a9be9040b7 ("nvmem: core: initialise nvmem->id early")
  ba716d020bc8 ("nvmem: qcom-spmi-sdam: fix module autoloading")
  c976fd0b6970 ("nvmem: core: fix device node refcounting")
  ee29286033ef ("nvmem: core: fix cell removal on error")

--=20
Cheers,
Stephen Rothwell

--Sig_/Y4oKU8Vq.4Poa98BNgIabft
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgIF8ACgkQAVBC80lX
0GxTiQf6AkJYodDTPiOa4n6t7CkPJImut2Gn1z/9fXzngOVCbDm9E7La+1HcaU3v
vDdc1ULqsjr/yukSjhBH4MWmfXVkV0ged91FV9Tald659friPoqIX1ldJuKXKJN3
F7VLhJwqi5K6kxOuZrZStMHL/6upHp5yqfJqZn4RluHRFN4vrYGe+wQVnO7TdaEn
tlc5MefH4pCWcqZCXSjdVyOHTB2SYJGkN2BWyV31WZomqCXkIwON0bjsOD4yeumm
iZEoC990EiePTqD01PH5hPJpeGQCBuymT21Ihoba7DesD54urh8CmsQEJ1atefF/
ti+/6u5pKUvR5nrCYmrJQhfPKwFr2A==
=5lbL
-----END PGP SIGNATURE-----

--Sig_/Y4oKU8Vq.4Poa98BNgIabft--
