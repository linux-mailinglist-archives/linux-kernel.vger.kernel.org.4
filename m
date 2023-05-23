Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A530770D584
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjEWHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjEWHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D7995;
        Tue, 23 May 2023 00:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F1A662FDC;
        Tue, 23 May 2023 07:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E05FC433EF;
        Tue, 23 May 2023 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684827866;
        bh=YYPt1zyTJKiH8Fltff0MHnchssuoppFK1zFRpoB3bk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNBonFNY3gVrFDiX0bbqfRZrpCLiYh/vNwi1w3OMBdQdqeReLkWDxdXIhzQ6ERnSG
         Cb29lpTW8/e8Z6OdUG9YPmkOED1X8C3KHcP7GsPJ48C/8EBJoTKmb8Cl3WLjG1IP1i
         3mwuUqhQQDFk/yrH8PEGK0K8zj4Tg3Ndth1GAWzaxoMcYxdRJ9aJfSiVmgoQUWtv8O
         c3G2Y7y83JZzt5PP+nCf15X3iF89YoB67OTxyrKoQ1Wp5G3m/G9S/0uF8zg7LGwCwx
         sOmb0GNu3KLK3Cew2fumCxRHDG1WB27VpWFH/nFrq1Du9CCjTjo9AOFjJn/CBNDllB
         8eCITwhUkSG4Q==
Date:   Tue, 23 May 2023 08:44:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, macro@orcam.me.uk,
        baolu.lu@linux.intel.com, yi.l.liu@intel.com, jirislaby@kernel.org,
        rostedt@goodmis.org, revest@chromium.org, gehao@kylinos.cn,
        akpm@linux-foundation.org, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, alex.williamson@redhat.com,
        akrowiak@linux.ibm.com, mark.rutland@arm.com,
        ye.xingchen@zte.com.cn, ojeda@kernel.org, me@kloenk.de,
        milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: [GIT PULL] Immutable branch containing TPS6594 core (MFD) support
 due for the v6.5 merge window
Message-ID: <20230523074416.GA2174496@google.com>
References: <20230511095126.105104-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511095126.105104-1-jpanis@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As promised.

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-tps6594-core-v6.5

for you to fetch changes up to 325bec7157b3859b45b9471447f5d130ab8a8723:

  mfd: tps6594: Add driver for TI TPS6594 PMIC (2023-05-18 16:06:14 +0100)

----------------------------------------------------------------
Immutable branch containing TPS6594 core (MFD) support due for the v6.5 merge window

----------------------------------------------------------------
Julien Panis (1):
      mfd: tps6594: Add driver for TI TPS6594 PMIC

 drivers/mfd/Kconfig         |   32 ++
 drivers/mfd/Makefile        |    3 +
 drivers/mfd/tps6594-core.c  |  462 ++++++++++++++++++++
 drivers/mfd/tps6594-i2c.c   |  244 +++++++++++
 drivers/mfd/tps6594-spi.c   |  129 ++++++
 include/linux/mfd/tps6594.h | 1020 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1890 insertions(+)
 create mode 100644 drivers/mfd/tps6594-core.c
 create mode 100644 drivers/mfd/tps6594-i2c.c
 create mode 100644 drivers/mfd/tps6594-spi.c
 create mode 100644 include/linux/mfd/tps6594.h

-- 
Lee Jones [李琼斯]
