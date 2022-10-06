Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E158A5F6E54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiJFTmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiJFTmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:42:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F5A222C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59D6EB82124
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 19:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BFFC433D7;
        Thu,  6 Oct 2022 19:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665085324;
        bh=Vjn3/IWlZgc9uh7DrPGzPPYEW7lNqkukvFRgwpoixv4=;
        h=Date:From:To:Cc:Subject:From;
        b=aSb6+vzlvEWPZqOKebtI8LA/nJZK2R56YGHxcTL8aTK/GW8STbSOnzjVGpj53a/Q3
         vjAa3aSFWD6C71PdMzJ3DFOtV3fZCsl13uT6GSMS/XjXEym0NZhsAKdWhq1ofTHKgm
         nWo0TGuiIN8QkX9rs1Rw1FE80WpN38VbGEShzTKkRHIIHJgjRbYa/UHVfSaj5ve8Ck
         vo8ilafDKtQEe3YHltSBSpDRpsll+6l2v9zSGp/g+1A/bzD+k/lzEo1fDs1sAIXf0L
         pL+D5IVtUTLIubSZ6r7G3/zb18IultPzzZkdhJOyl8744gSRt+joM6oPDFxts62Ne/
         nWaNFsO7RRgZg==
Received: by mercury (Postfix, from userid 1000)
        id 4E1ED1063D1B; Thu,  6 Oct 2022 21:42:01 +0200 (CEST)
Date:   Thu, 6 Oct 2022 21:42:01 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for v6.1
Message-ID: <20221006194201.qdf4biulcdfw3mdu@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dzqjgsu2csxrjpgz"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dzqjgsu2csxrjpgz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.1

for you to fetch changes up to 811908159e7ee583e30565018a08284cf5ddae77:

  HSI: nokia-modem: Replace of_gpio_count() by gpiod_count() (2022-09-20 17:29:29 +0200)

----------------------------------------------------------------
HSI changes for the 6.1 series

 * completely switch to gpiod API
 * misc. small fixes

----------------------------------------------------------------
Andy Shevchenko (1):
      HSI: nokia-modem: Replace of_gpio_count() by gpiod_count()

Jack Wang (1):
      HSI: omap_ssi_port: Fix dma_map_sg error check

Jianglei Nie (1):
      HSI: ssi_protocol: fix potential resource leak in ssip_pn_open()

Linus Walleij (1):
      HSI: cmt_speech: Pass a pointer to virt_to_page()

Miaoqian Lin (1):
      HSI: omap_ssi: Fix refcount leak in ssi_probe

Wang Qing (1):
      HSI: clients: remove duplicate assignment

 drivers/hsi/clients/cmt_speech.c        | 2 +-
 drivers/hsi/clients/nokia-modem.c       | 4 +---
 drivers/hsi/clients/ssi_protocol.c      | 2 +-
 drivers/hsi/controllers/omap_ssi_core.c | 1 +
 drivers/hsi/controllers/omap_ssi_port.c | 8 ++++----
 5 files changed, 8 insertions(+), 9 deletions(-)

--dzqjgsu2csxrjpgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM/L4gACgkQ2O7X88g7
+prWQhAApxBNjRGGXe2I5bMF60gbFuJWNmMdM47wrfn4/3X44HS0AHUcDSQLMTBa
4KO6UZNtZpxk2ehkFJ1lgAt+xBwwpXvap/nUcHLh1HnnCfgozADNuYGiAu6Ziak4
6AotFGJ2Rn7lr0JAbS7C0/rzCBSU/sHsllgzW92GR64qAqTH0WTcUf3ypn+4D8Od
lis9BhpD/vfcBYboQOYF7u3o6Nx/NrtFn5yuBiVAIiwDzhRQJAdyowEuzddkd1Vw
CU5nE8cMrees3uE6jTIzhLdWJcSI6UJGtNtkNNu7iaEx9AJGo1E5FnLmnEGtosXJ
kiaHdJOz50uPl6d74STAm1ivtKyr8kxlqDKtCFHyKbxQ1mxF5Du+joCCG6xhgyc4
D1NcTBV14KmBR67PUrHCxT46Z1rCxTl2hfW8ASEOGmFqjSXgH7bLHiyvk4k/SYuv
OTzH+kbV2c2dRiQaYv3LdPwm0Aa9xaDaG3kq+Yy8glMQ+AWDQBtnS3hMlW8ZApnH
oCKO2iz8RaxPFdrDvWmLaIQ8wQ5vfK6lGuewHWxDP63ckB0XpUoDZLEksjh04WaV
2k26lZFuFGtEdrcvkXMjmjOXqUS9QCPDtiZII2PX17KOaYCxvGmEwjG6daLUqI4q
GtdtcCykMZfI+nW7qDGrO/3b1KDddBoDwmpvDJkQdal7kLPxBGk=
=hFg8
-----END PGP SIGNATURE-----

--dzqjgsu2csxrjpgz--
