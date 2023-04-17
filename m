Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806166E4425
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDQJk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjDQJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694D61B7;
        Mon, 17 Apr 2023 02:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9898B614E4;
        Mon, 17 Apr 2023 09:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6FAC433D2;
        Mon, 17 Apr 2023 09:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681724365;
        bh=G5C5rstyDPJTkrMWbCah2++jAPmMZtuh3VaoGEvcJ/w=;
        h=From:To:Cc:Subject:Date:From;
        b=WSag1yeLBtsqTloKUVVMt1zVN0+mL5TRyipBsCNGYrqdkpmOCET86CdauUDpmrVZH
         xWgzpWTvHa8dr4be3oDWDK5p0Qx0idQZ72V7UkynGEe1SRtB7pxBmamrQ16NhCf9fX
         LkAz22+nUUSPBpqbgE+Oxpyz8z+XFMo7miPOo/+gvK3mmx8rfCQwmiRMKV98pWY1t2
         k/W2m9IILMUoeVG+RQCDm09V5PeUeTPP4Ryd9sCBvH25lMpEHeYW78ZN66wV9E2XCN
         vNZkZVQx4soteNrmAtl9OyduAhY42qJ7mKTlzIfmENuS/xkQ+XXSIXX0A2Pxk13oKR
         Y2KOc3z8xYjzw==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.4
Date:   Mon, 17 Apr 2023 12:39:10 +0300
Message-Id: <20230417093910.1642934-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 6.4-rc1 merge
window. In contains cleanups and tiny updates. The details are in the
signed tag.

All patches have been in linux-next during the last two weeks. Please pull
into char-misc-next when possible.

Thanks,
Georgi

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.4-rc1

for you to fetch changes up to b7590f3841f47d5c6732db9a6d6474162109f487:

  dt-bindings: interconnect: qcom,msm8998-bwmon: Resolve MSM8998 support (2023-04-05 11:30:00 +0300)

----------------------------------------------------------------
interconnect changes for 6.4

This pull request contains the interconnect changes for the 6.4-rc1 merge
window, which this time are mostly cleanups.

Core changes:
  interconnect: Skip call into provider if initial bw is zero
  interconnect: Use of_property_present() for testing DT property presence
  interconnect: drop racy registration API
  interconnect: drop unused icc_link_destroy() interface

Driver changes:
  interconnect: qcom: Drop obsolete dependency on COMPILE_TEST
  interconnect: qcom: drop obsolete OSM_L3/EPSS defines
  interconnect: qcom: osm-l3: drop unuserd header inclusion
  interconnect: qcom: rpm: drop bogus pm domain attach
  interconnect: qcom: rpm: make QoS INVALID default
  interconnect: qcom: rpm: Add support for specifying channel num
  interconnect: qcom: Sort kerneldoc entries
  dt-bindings: interconnect: OSM L3: Add SM6375 CPUCP compatible
  dt-bindings: interconnect: qcom,msm8998-bwmon: Resolve MSM8998 support

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Dmitry Baryshkov (2):
      interconnect: qcom: drop obsolete OSM_L3/EPSS defines
      interconnect: qcom: osm-l3: drop unuserd header inclusion

Jean Delvare (1):
      interconnect: qcom: Drop obsolete dependency on COMPILE_TEST

Johan Hovold (3):
      interconnect: drop racy registration API
      interconnect: drop unused icc_link_destroy() interface
      interconnect: qcom: rpm: drop bogus pm domain attach

Konrad Dybcio (5):
      interconnect: qcom: rpm: make QoS INVALID default
      interconnect: qcom: rpm: Add support for specifying channel num
      interconnect: qcom: Sort kerneldoc entries
      dt-bindings: interconnect: OSM L3: Add SM6375 CPUCP compatible
      dt-bindings: interconnect: qcom,msm8998-bwmon: Resolve MSM8998 support

Rob Herring (1):
      interconnect: Use of_property_present() for testing DT property presence

Vivek Aknurwar (1):
      interconnect: Skip call into provider if initial bw is zero

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 41 +++-
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml  |  1 +
 drivers/interconnect/core.c                                      | 81 +-------
 drivers/interconnect/qcom/Kconfig                                |  2 +-
 drivers/interconnect/qcom/icc-rpm.c                              | 38 ++--
 drivers/interconnect/qcom/icc-rpm.h                              | 17 +-
 drivers/interconnect/qcom/msm8996.c                              |  1 -
 drivers/interconnect/qcom/osm-l3.c                               |  7 -
 drivers/interconnect/qcom/sc7180.h                               |  2 -
 drivers/interconnect/qcom/sc7280.h                               |  2 -
 drivers/interconnect/qcom/sc8180x.h                              |  2 -
 drivers/interconnect/qcom/sdm845.h                               |  2 -
 drivers/interconnect/qcom/sm8150.h                               |  2 -
 drivers/interconnect/qcom/sm8250.h                               |  2 -
 include/linux/interconnect-provider.h                            | 17 --
 15 files changed, 76 insertions(+), 141 deletions(-)
