Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5685B6523EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiLTPsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbiLTPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:48:02 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1753C45;
        Tue, 20 Dec 2022 07:48:00 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 914C1201E61;
        Tue, 20 Dec 2022 16:47:59 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A7C3201A61;
        Tue, 20 Dec 2022 16:47:59 +0100 (CET)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D4E3D1820F59;
        Tue, 20 Dec 2022 23:47:57 +0800 (+08)
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        manjunatha.venkatesh@nxp.com, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: [PATCH v6 0/2]Uwb: Nxp: Driver for SR1XX SOCs Patch Series
Date:   Tue, 20 Dec 2022 21:17:45 +0530
Message-Id: <20221220154747.2372597-1-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a sixth version of a Nxp Uwb SR1xx driver.
Following changes are done with respect to patch series.
- Device Tree Document for SR1XX SOCs patch added
- sr1xx driver updated with previous review comment


Manjunatha Venkatesh (2):
  dt-bindings: uwb: Device tree information for Nxp SR1XX SOCs
  misc: nxp-sr1xx: UWB driver support for sr1xx series chip

 .../bindings/uwb/nxp,uwb-sr1xx.yaml           |  65 ++
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |  11 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/nxp-sr1xx.c                      | 728 ++++++++++++++++++
 include/uapi/misc/sr1xx.h                     |  13 +
 6 files changed, 825 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
 create mode 100644 drivers/misc/nxp-sr1xx.c
 create mode 100644 include/uapi/misc/sr1xx.h

-- 
2.38.1

