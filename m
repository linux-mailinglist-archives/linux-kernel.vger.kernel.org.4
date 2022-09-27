Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6F95EC2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiI0Me1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiI0MeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:34:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C247AE9CD;
        Tue, 27 Sep 2022 05:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BC89B81A9A;
        Tue, 27 Sep 2022 12:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620CAC433D6;
        Tue, 27 Sep 2022 12:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664282058;
        bh=Awh1GCPS8AJJDjRzu2ULEBsb4bUujF+ykG7UzU2NEF0=;
        h=From:To:Cc:Subject:Date:From;
        b=DWXxMx62LB1ytHShijY26hMFrjt81AtfXpFEavkdsCV/Gu7zY4I2gWwSCvntekLes
         KIh7gweOm8Pp9HzN25c76AULLKLD4aIWGtc4zBGxiWw7/sluSApomrtlX6mdq9q7Bi
         X50l/5iVHxiraO3ekt6iz05+OwCB9UUm13YMibcQcPQ5u2nfTh7DhLDb9CCLy+MGes
         ZIR5zIINJGaGzV6lfPlGkggvqDLAKR7KaspxCqEM1MWaP//UbLFC0iXWu0dck62hWQ
         ZYqWVewDlYg7N2Rm2GkA5SBYVtzEInQRMnx87+sQhN+MxOO/gbnPRWpDn+8Xnmjj+T
         5atY3dSFFzITw==
From:   broonie@kernel.org
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Irui Wang <irui.wang@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: linux-next: manual merge of the v4l-dvb tree with the v4l-dvb-fixes tree
Date:   Tue, 27 Sep 2022 13:34:10 +0100
Message-Id: <20220927123410.342690-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the v4l-dvb tree got a conflict in:

  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c

between commit:

  a2d2e593d39bc ("media: mediatek: vcodec: Drop platform_get_resource(IORESOURCE_IRQ)")

from the v4l-dvb-fixes tree and commit:

  223afdf9caa07 ("media: mediatek: vcodec: Remove encoder driver get IRQ resource")

from the v4l-dvb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index d2f5f30582a9c,0abe1dac75b3a..0000000000000
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
