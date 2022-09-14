Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461C55B8A81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiINOaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiINOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:30:09 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9119007;
        Wed, 14 Sep 2022 07:30:08 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AED171A179C;
        Wed, 14 Sep 2022 16:30:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 754531A17A0;
        Wed, 14 Sep 2022 16:30:06 +0200 (CEST)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EBBE01820F59;
        Wed, 14 Sep 2022 22:30:04 +0800 (+08)
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        manjunatha.venkatesh@nxp.com, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: [PATCH v5 0/2] Uwb: Nxp: Driver for SR1XX SOCs Patch Series
Date:   Wed, 14 Sep 2022 19:59:42 +0530
Message-Id: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a fifth version of a Nxp Uwb SR1xx driver.
Following changes are done with respect to patch series.
  - Device Tree Document for SR1XX SOCs patch added
  - sr1xx driver updated with previous review comment

Manjunatha Venkatesh (2):
  dt-bindings: uwb: Device tree information for Nxp SR1XX SOCs
  misc: nxp-sr1xx: UWB driver support for sr1xx series chip

 .../bindings/uwb/nxp,uwb-sr1xx.yaml           |  63 ++
 MAINTAINERS                                   |   6 +
 drivers/misc/Kconfig                          |  11 +
 drivers/misc/Makefile                         |   3 +-
 drivers/misc/nxp-sr1xx.c                      | 794 ++++++++++++++++++
 5 files changed, 876 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
 create mode 100644 drivers/misc/nxp-sr1xx.c

--
2.37.2

