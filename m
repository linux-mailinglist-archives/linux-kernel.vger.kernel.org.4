Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A345670EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjARAmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjARAld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22E53CE0D;
        Tue, 17 Jan 2023 16:19:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxRFh63nbz4xGq;
        Wed, 18 Jan 2023 11:19:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674001145;
        bh=99wDRjxrQLqpktGcF6RM5026lWVnSpjeJNcQIou38TU=;
        h=Date:From:To:Cc:Subject:From;
        b=stHtedjml8gnYb1pr/QZG8j93HsPzToD8QQuGuNb7bREvBkTkdx8B5kcIeNtyAmmF
         KODc2qNmSsIHgi+HDOsV2HcPSF6Th6lVMsRgMwLHuF0uulTKdd6IKJYj6G7C7cTlzf
         Ty3d1k8zK19ivxhC4u5zTtNuwstx4LqQK97kcgu3mNkUKYkop6WV/WR6cV/ws4TQSx
         gzjhM8p3RZ1xux708SQ7/0Om7Dc4RGi9FeU6lF3Rplj93Mv89CPH2NoCFR5y7TOyxk
         M/puu/AC9l3NPMMIHivFjWKac0/QhJL3FnK86hzXFFsQ+SuviVCOTm0D3j+W8LHMRk
         OHva4wGpBdquQ==
Date:   Wed, 18 Jan 2023 11:19:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the devicetree tree
Message-ID: <20230118111903.69dc4500@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xlb5usL_M28w1MEYm4I/N0h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xlb5usL_M28w1MEYm4I/N0h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the qcom tree as a different commit
(but the same patch):

  37483c262365 ("dt-bindings: clock: qcom,videocc: correct clocks per varia=
nt")

this is commit

  06839dfc8798 ("dt-bindings: clock: qcom,videocc: correct clocks per varia=
nt")

in the qcom tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/xlb5usL_M28w1MEYm4I/N0h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHOvcACgkQAVBC80lX
0GzALQf8CMFUvhLZ8edgCGYFSxXZeE9hk/2KAa3vf8zaJQmYAQPA0Wab1b/hw4ts
cHOzq4lwouGZLCGp6/Q+mfcFcgnKw6luUcYFtyGivh8eJagoa+G0PwYBAwbl0Hr/
3+D9ZTViZPjZvsM8u9vJ7rOEe/EiYgbeT0g3SAuUuUj8fEeIv52IBKAVe+J3gH7o
Y7EgsIDpGOxl+HUMT4ZmzAfuridkBMWvyPN0gzMIaLddI5/vzPn+WXs/AMkmSy9i
Zo/atibKRFN96OUx6ZSzsRsSW0FYSgruiIEb79DwyXHzokJBcx2b03y1Y3XsRLHw
dhnsA3CjJ/URW1YMEh0bpb5jPMQhEw==
=KQJ1
-----END PGP SIGNATURE-----

--Sig_/xlb5usL_M28w1MEYm4I/N0h--
