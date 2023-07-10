Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653974CD36
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGJGjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGJGjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:39:23 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5184E137;
        Sun,  9 Jul 2023 23:39:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 95B15602A11D5;
        Mon, 10 Jul 2023 14:38:41 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        irusskikh@marvell.com, rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, steve.glendinning@shawell.net,
        iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, mostrows@earthlink.net, xeb@mail.ru,
        qiang.zhao@nxp.com
Cc:     uttenthaler@ems-wuensche.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linuxppc-dev@lists.ozlabs.org,
        kernel-janitors@vger.kernel.org, wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 00/10] Remove unnecessary (void*) conversions
Date:   Mon, 10 Jul 2023 14:38:28 +0800
Message-Id: <20230710063828.172593-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuych <yunchuan@nfschina.com>

Changes in v2:
	move declarations to be reverse xmas tree.
	compile it in net and net-next branch.
	remove some error patches in v1.

PATCH v1 link:
https://lore.kernel.org/all/20230628024121.1439149-1-yunchuan@nfschina.com/

wuych (10):
  net: wan: Remove unnecessary (void*) conversions
  net: atlantic: Remove unnecessary (void*) conversions
  net: ppp: Remove unnecessary (void*) conversions
  net: hns3: remove unnecessary (void*) conversions
  net: hns: Remove unnecessary (void*) conversions
  ice: remove unnecessary (void*) conversions
  ethernet: smsc: remove unnecessary (void*) conversions
  net: mdio: Remove unnecessary (void*) conversions
  can: ems_pci: Remove unnecessary (void*) conversions
  net: bna: Remove unnecessary (void*) conversions

 drivers/net/can/sja1000/ems_pci.c             |  6 +++---
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 12 ++++++------
 .../atlantic/hw_atl2/hw_atl2_utils_fw.c       |  2 +-
 drivers/net/ethernet/brocade/bna/bnad.c       | 19 +++++++++----------
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c     | 10 +++++-----
 drivers/net/ethernet/intel/ice/ice_main.c     |  4 ++--
 drivers/net/ethernet/smsc/smsc911x.c          |  4 ++--
 drivers/net/ethernet/smsc/smsc9420.c          |  4 ++--
 drivers/net/mdio/mdio-xgene.c                 |  4 ++--
 drivers/net/ppp/pppoe.c                       |  4 ++--
 drivers/net/ppp/pptp.c                        |  4 ++--
 drivers/net/wan/fsl_ucc_hdlc.c                |  6 +++---
 13 files changed, 40 insertions(+), 41 deletions(-)

-- 
2.30.2

