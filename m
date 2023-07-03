Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3274653D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjGCV7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGCV7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:59:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34CB187;
        Mon,  3 Jul 2023 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688421540;
        bh=H/KBXidTpVeidX5tm+aeVy2pCnf4ftDThjVnQ+04sAU=;
        h=Date:From:To:Cc:Subject:From;
        b=q4z+CEvZAfg7Y/gbgPIFmJtCAyGAxL9dU2Leip4hlc/xnH9saK1U/SLXQCSVnNzZb
         PetSuJoBj3rwBnvKokv+9Zc+RZnEO0nfYeYt7pym1InCvPpnzAarzOiqe8pRNEAoAg
         s4JIyINKwhIcgnwSJW9ZS1a743PNS3ekrHko3uzeGKW7sqZ/B3V9aeHxmBSGT5Rugx
         2LQF4a4565hmV1FU84kuZrezZvcYDllxax4BFe+pq85uSq2a47aduXWbT5LtMsRjo9
         bTQKl4VvNCcT4n8lJFt+uN01PUEqCIeo/m5+zmtvDkYKobitwPxkn76n4bAbH+if2l
         BmTDoXY2i1Lvw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qw0F031Kyz4wqX;
        Tue,  4 Jul 2023 07:59:00 +1000 (AEST)
Date:   Tue, 4 Jul 2023 07:58:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nvmem tree
Message-ID: <20230704075859.15896a37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TKG2Fr4BgpAwB7WZStS9.jG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TKG2Fr4BgpAwB7WZStS9.jG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  05f53e3c22a7 ("dt-bindings: nvmem: mediatek: efuse: add support for mt798=
6")
  0ce8763ca284 ("nvmem: brcm_nvram: add .read_post_process() for MACs")
  103066fdb0de ("dt-bindings: nvmem: sunplus,sp7021-ocotp: drop unneeded ad=
dress/size-cells")
  17baab60780b ("nvmem: rockchip-otp: Improve probe error handling")
  1bef72e31567 ("dt-bindings: nvmem: rmem: Add raspberrypi,bootloader-publi=
c-key")
  2881bbe70740 ("dt-bindings: nvmem: qcom,spmi-sdam: drop unneeded address/=
size-cells")
  366916db4af4 ("nvmem: imx-ocotp: Reverse MAC addresses on all i.MX deriva=
tes")
  3a0134e21d90 ("nvmem: rockchip-otp: Add support for RK3588")
  426b30ed585c ("dt-bindings: nvmem: qcom,qfprom: drop unneeded address/siz=
e-cells")
  42d033c4e47b ("dt-bindings: nvmem: imx-ocotp: support i.MX93")
  4d0c9ce1a7a2 ("dt-bindings: nvmem: layouts: add fixed-layout")
  4d47e9a76d5f ("nvmem: imx: support i.MX93 OCOTP")
  5dede99d255a ("dt-bindings: nvmem: Convert rockchip-otp.txt to dt-schema")
  619b1fa6c76c ("nvmem: rmem: Use NVMEM_DEVID_AUTO")
  6c1eb6948575 ("dt-bindings: nvmem: mxs-ocotp: drop unneeded address/size-=
cells")
  71f1b0883907 ("nvmem: rockchip-otp: Add clks and reg_read to rockchip_dat=
a")
  75dd9c7a421a ("dt-bindings: nvmem: convert base example to use NVMEM fixe=
d cells layout")
  945b20bee348 ("nvmem: imx-ocotp: set varaiable imx_ocotp_layout storage-c=
lass-specifier to static")
  ac1c0d15aedc ("nvmem: core: add support for fixed cells *layout*")
  bb7a2f40d773 ("dt-bindings: nvmem: socionext,uniphier-efuse: drop unneede=
d address/size-cells")
  cdaa055cdc73 ("dt-bindings: nvmem: rockchip,otp: Add compatible for RK358=
8")
  da5c9b4fcf32 ("nvmem: rockchip-otp: Generalize rockchip_otp_wait_status()=
")
  e86fba9eb891 ("nvmem: rockchip-otp: Use devm_reset_control_array_get_excl=
usive()")
  f724ffe47544 ("dt-bindings: nvmem: brcm,nvram: add #nvmem-cell-cells for =
MACs")
  fe0b59882c02 ("nvmem: zynqmp: Switch @xilinx.com emails to @amd.com")

--=20
Cheers,
Stephen Rothwell

--Sig_/TKG2Fr4BgpAwB7WZStS9.jG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSjRKMACgkQAVBC80lX
0Gx/wQgAmfC7FhvGiBmzg4rSUnppIR+QNZ7if3IF2XQJ2bCgPFproqAdDtlSYmvF
Y/MDeNJEAXjkR/bC9xYa+IoY0Ntw9e3kcohL2ONr593O77acg91hwCtgh6N2ORQg
dFlH+HrQBraB2lzM9xmSIDeFdZYgE2cG+O2E5aQ1dWPcgOXcJrt17PofNQcXilhD
+un/A04VfSfIRW7X8C7CVld20dL/p2UxPUTtAtQx2vh6IRHqjYiBh7dgYCHzOpRT
AcsQfoOfeAMLeaiovtKWNpGM9s2yTheZ8FbniLbPA0vegoHU03ntk0jBI7+WBBd5
qRBBrKGmc/YDcRshNUqz/q+iH7Om3g==
=xlCp
-----END PGP SIGNATURE-----

--Sig_/TKG2Fr4BgpAwB7WZStS9.jG--
