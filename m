Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E42620253
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiKGWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiKGWem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:34:42 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E017E18;
        Mon,  7 Nov 2022 14:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1667860482; x=1699396482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jt/YBdONby0Ay43voCBE2XQ7uTSd2dcm1nblv3TAkqc=;
  b=Ur+njDcpQGvwJHtlYp8gX+tFbQmc6tzzQO/z2+dzKOl2T0XSS8oRz6UB
   4CjQtW2slCuhglPLRouWPPyYH/g9aNJQ0FVUn5mZoS9NTjM3E6E9qk4Ll
   4I/O5EKlwOnmyOroGpJIDKuk6So9GbJfIN/hknU3UpYfMgjcqo4tdoLpw
   k=;
X-IronPort-AV: E=Sophos;i="5.96,145,1665446400"; 
   d="scan'208";a="277833800"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 22:34:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 5289CC325A;
        Mon,  7 Nov 2022 22:34:40 +0000 (UTC)
Received: from EX19D035UWB004.ant.amazon.com (10.13.138.104) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Mon, 7 Nov 2022 22:34:35 +0000
Received: from dev-dsk-grecojay-2b-e6934ae5.us-west-2.amazon.com
 (10.43.161.14) by EX19D035UWB004.ant.amazon.com (10.13.138.104) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.15; Mon, 7 Nov 2022
 22:34:35 +0000
From:   Jay Greco <grecojay@amazon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jorcrous@amazon.com>, Jay Greco <grecojay@amazon.com>,
        "Jean-Baptiste Maneyrol" <jmaneyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: imu: inv_icm42600: Add support for icm42631
Date:   Mon, 7 Nov 2022 22:33:49 +0000
Message-ID: <20221107223351.61142-1-grecojay@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.14]
X-ClientProxiedBy: EX13D48UWA004.ant.amazon.com (10.43.163.61) To
 EX19D035UWB004.ant.amazon.com (10.13.138.104)
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the invensense icm42631 as part of the
inv_icm42600 family driver within the IIO subsystem. The patch series
also includes the requisite changes to the dt-bindings documentation.


Jay Greco (2):
  iio: imu: inv_icm42600: Add support for icm42631
  iio: imu: inv_icm42600: Add icm42631 documentation

 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml     | 1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                  | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c             | 5 +++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c              | 3 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c              | 3 +++
 5 files changed, 14 insertions(+)

-- 
2.37.1

