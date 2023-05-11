Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D3D6FEB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbjEKGBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjEKGBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238D530C7;
        Wed, 10 May 2023 23:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3635641DF;
        Thu, 11 May 2023 06:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5ACC433D2;
        Thu, 11 May 2023 06:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683784868;
        bh=Utc7Og0AJ3hMUXcuPoc5Qe9YwMUiMJIgT1Su886wP0o=;
        h=Date:From:To:Cc:Subject:From;
        b=oIpMyVev9yH7kfYY17Y12q4G8IzPE/gbz3b1oafMWVz1hhynGowsEOMKXrLykye7I
         SrbM8tOmg3nCELyWxDazg4p9K0ic+rKSNW1p8vdrnKYRerik6MrK59upEvigPJCEWo
         vYSdfsqMC635GMq9VQL6pHdOuXW6RqelmWtWoGVEn84URh9eZ040P71AgXGb9HbTbB
         I59FwKWIREII5eWXEuaYYLhUJ4POazYi3cPmT50CX1TrUaiBpYqlMi4N88PJKu8rfX
         iAlk3lfSlJUnln0f39/b4JHxqTIA02vlnaUQSPiubnfhfWBaTXynuxV7CkYYlnpcPj
         kZqFuL+A9DrXg==
Date:   Thu, 11 May 2023 07:01:03 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.4-rc2] media fixes
Message-ID: <20230511070103.263505ba@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.4-2

For a couple of fixes:
  - fix some unused-variable warning at mtk-mdp3;
  - ignore unused suspend operations at nxp;
  - some driver fixes at rcar-vin.

Regards,
Mauro

---

The following changes since commit ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab:

  media: nxp: imx8-isi: fix buiding on 32-bit (2023-05-08 09:10:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.4-2

for you to fetch changes up to ae3c253f595b31ff30d55b4c50b4470e56bc4e0d:

  media: platform: mtk-mdp3: work around unused-variable warning (2023-05-0=
8 12:11:25 +0100)

----------------------------------------------------------------
media fixes for v6.4-rc2

----------------------------------------------------------------
Arnd Bergmann (2):
      media: nxp: ignore unused suspend operations
      media: platform: mtk-mdp3: work around unused-variable warning

Niklas S=C3=B6derlund (3):
      media: rcar-vin: Gen3 can not scale NV12
      media: rcar-vin: Fix NV12 size alignment
      media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNA=
TE

 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c    |  3 +--
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c |  6 +++---
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c  | 21 +++++++++++++++--=
----
 3 files changed, 19 insertions(+), 11 deletions(-)

