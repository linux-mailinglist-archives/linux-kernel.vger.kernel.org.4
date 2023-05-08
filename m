Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07226F9D29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjEHBAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjEHBAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:00:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34D9100C1;
        Sun,  7 May 2023 18:00:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF2yR2xP0z4x2c;
        Mon,  8 May 2023 11:00:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683507615;
        bh=is29ud6fO0bk7+y0eLHfWVfETXtpHGeauUmrzSMz7MU=;
        h=Date:From:To:Cc:Subject:From;
        b=nMRNxSy8lysYWrfnuEwGUCcWUwSJIIDEmuSG636QxaoFxTz8NEyJRH831Hs7SBdPf
         pLvQhYbPbss8CAXJzIIEVNyIZ431sHm+EqgAOKpfGmSgbLsxvhUhUGIZZiM7OHY7wx
         +PEth9uddWzKajzoUs8yrmlW9AGAISTObzuEsEX2IR/Q1CgKNYXvDIsXNAUO1q8+Wl
         MMMavi+oejtcpDwnu+ZuaP7i0gvh5f8tMUsEXBdrFXGKApPP8vwxGkCogNFTuwKChe
         fNbkWCF0mQoINgT2uy2EMoirlDu0kT2JjwjB+iljV770cK1E4asqcZuoVjTtSbDmSY
         NX+NiXQb7034w==
Date:   Mon, 8 May 2023 11:00:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nvmem tree
Message-ID: <20230508110014.28c3451a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AhUlIKP/7pgUhvl7Ns.Ieiw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AhUlIKP/7pgUhvl7Ns.Ieiw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  16faa4d80802 ("dt-bindings: nvmem: convert amlogic-efuse.txt to dt-schema=
")
  1fc7a13bb731 ("dt-bindings: nvmem: Drop unneeded quotes")
  288c1a9fe80c ("nvmem: u-boot-env: post-process "ethaddr" env variable")
  2a2d632546b0 ("nvmem: mtk-efuse: Support postprocessing for GPU speed bin=
ning data")
  31041798820c ("dt-bindings: nvmem: qcom,spmi-sdam: fix example 'reg' prop=
erty")
  31193db9eb5a ("MAINTAINERS: add myself as sl28vpd nvmem layout driver")
  3d1431431ce2 ("nvmem: layouts: sl28vpd: set varaiable sl28vpd_layout stor=
age-class-specifier to static")
  3d6ee188e379 ("nvmem: core: provide own priv pointer in post process call=
back")
  428773c09cff ("nvmem: nintendo-otp: Use devm_platform_ioremap_resource()")
  4918e974941f ("dt-bindings: nvmem: Add compatible for SM6375")
  4976f5118fad ("nvmem: core: add per-cell post processing")
  4e0fded75a6b ("nvmem: stm32-romem: mark OF related data as maybe unused")
  4ea39c120414 ("dt-bindings: nvmem: convert amlogic-meson-mx-efuse.txt to =
dt-schema")
  5c859c752509 ("of: Move of_modalias() to module.c")
  5ffaa8952e8a ("of: Fix modalias string generation")
  6861ff20b635 ("MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintaine=
r")
  6c0ba03da802 ("nvmem: core: introduce NVMEM layouts")
  767af398b9b2 ("nvmem: core: allow to modify a cell before adding it")
  78872a4a8d11 ("of: Rename of_modalias_node()")
  7a7370e37795 ("nvmem: bcm-ocotp: Use devm_platform_ioremap_resource()")
  7f34d9b1e9fa ("dt-bindings: nvmem: Add compatible for SM6350")
  819e1c034bf5 ("nvmem: imx-ocotp: replace global post processing with layo=
uts")
  8311c5234776 ("nvmem: core: support specifying both: cell raw data & post=
 read lengths")
  85dadc8012c6 ("of: Update of_device_get_modalias()")
  93797d122cc9 ("nvmem: cell: drop global cell_post_process")
  98cc732187db ("nvmem: core: handle the absence of expected layouts")
  a000203f2348 ("usb: ulpi: Use of_request_module()")
  a7c3fcac3703 ("firmware: xilinx: nvmem: zynqmp: make modular")
  ac9c852c8eda ("nvmem: layouts: sl28vpd: Add new layout driver")
  b06041e2f94b ("nvmem: core: request layout modules loading")
  c60363be9b76 ("nvmem: layouts: onie-tlv: Drop wrong module alias")
  c90221f303ba ("dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cell=
s")
  cd804ecf3da6 ("of: Move the request module helper logic to module.c")
  ddeb62c833fb ("nvmem: layouts: onie-tlv: Add new layout driver")
  e61131ac0765 ("of: device: Kill of_device_request_module()")
  ed688cdd43e0 ("nvmem: layouts: sl28vpd: Use module_nvmem_layout_driver()")
  f37f76f47c8e ("nvmem: layouts: onie-tlv: Use module_nvmem_layout_driver()=
")
  f4276728c089 ("nvmem: vf610-ocotp: Use devm_platform_get_and_ioremap_reso=
urce()")
  f55b96d3f8b9 ("nvmem: Add macro to register nvmem layout drivers")
  f77d82b82db1 ("dt-bindings: nvmem: Fix spelling mistake "platforn" -> "pl=
atform"")

--=20
Cheers,
Stephen Rothwell

--Sig_/AhUlIKP/7pgUhvl7Ns.Ieiw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYSZ4ACgkQAVBC80lX
0GwQtAf/QxZ6pXzclLwC2g7GBLEXCvSRKfvNRHWH1CJf0lgQ8FY70yU2jZimnOuu
ca/67n2CBO5ZYDYMLkbqRHYJUL8E8zb8rbjXyI45tlB3O584U630VcYbqofXB6V1
oVwnAsGqGaz7/7SPkiKStXSCCj5Ynib2Uh+1jbmJyCHRCddK1ERxfsu9wSbIt7F0
XvdSPvLd0W8fzf3AtoZLlX9RMVQ8x9ctbl8jN6NtJDB2gSPGkv5EwIHHDcO6R0Lh
c1vQl4HN4qZRVXyx0SJQr2vZ+3DU6dTHIMkbQO10KLqkF6IaYIHw0jrxEkiE3DbB
Wtk9MoQQw6QPAxVswWwbL0ds2MD4jw==
=+9GM
-----END PGP SIGNATURE-----

--Sig_/AhUlIKP/7pgUhvl7Ns.Ieiw--
