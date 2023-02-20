Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412AB69CB0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjBTMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBTMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:32:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FA776A7;
        Mon, 20 Feb 2023 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676896376; x=1708432376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vgSCEUc8iWaLUJXuISUE4WfvVHLMArLiY4LlOtGKzjE=;
  b=CeVYdhKqQX68jyRF9UBPb1yetaHoIyGVK5YUeJmex3hQKdNRmhHBYp6D
   oiru2zM86xdfNjwL9VZ41HyIG7jsNbRmoF8kMs8DNMBm+Tf7v+A6ZhirW
   X3Bx+ABbmp8qhYJNz0xlJ1m4P2vSThqzADqOAZcJjgR+os5uASi3v2Cd8
   Hgwcy6jFh6TKgHCtsk7xwEbad0JcbKV6FUOdm1VtIrw/b2oyioZblZpi5
   hSjDRMkTFsWph94G45J70Jsr/PCoe1AL2p4uzyMUxwVg15s4qVSfrxJOr
   fKmN+3Bf2GnX8AfjwPQZs0NIglClQR4bL+9gQl/BcZLCSruh443nN7Tbl
   g==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669100400"; 
   d="scan'208";a="201422084"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Feb 2023 05:32:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 05:32:51 -0700
Received: from marius-VM.mshome.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 05:32:50 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v1 0/2] adding support for Microchip PAC193X Power Monitor
Date:   Mon, 20 Feb 2023 14:32:30 +0200
Message-ID: <20230220123232.413029-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip PAC193X series of Power Monitor with
Accumulator chip family.

Differences related to previous patch:

v1:
- first version comitted to review


Marius Cristea (2):
  dt-bindings: iio: adc: adding dt-bindings for PAC193X
  iio: adc: adding support for pac193x

 .../bindings/iio/adc/microchip,pac193x.yaml   |  122 +
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac193x.c                     | 2072 +++++++++++++++++
 5 files changed, 2214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
 create mode 100644 drivers/iio/adc/pac193x.c

-- 
2.34.1

