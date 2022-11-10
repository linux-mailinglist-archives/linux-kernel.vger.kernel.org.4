Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698AE624AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiKJTaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKJTaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:30:04 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716912C113;
        Thu, 10 Nov 2022 11:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1668108603; x=1699644603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDpziAWNUqBndZUtbjYtRch804qXiiHiQIaigI/ii6M=;
  b=strBXGw7OR9LH3CdCNOp20jENoatk1BbXnr8G3sCHxiWT+RWClwOOd78
   g6kBthWwDDfJ3OffdO5g8jl6FWGny1dgjhS4DSnr0PjvTH5CpFD0OCfiD
   /VE93ke/LgSE7r+6002y1tOO5QQjERb2aIWs5pZ4OXdsVhwqXBe3Kvdvl
   U=;
X-IronPort-AV: E=Sophos;i="5.96,154,1665446400"; 
   d="scan'208";a="149660788"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:30:00 +0000
Received: from EX13MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id 19C6F161632;
        Thu, 10 Nov 2022 19:29:56 +0000 (UTC)
Received: from EX19D035UWB004.ant.amazon.com (10.13.138.104) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 10 Nov 2022 19:29:55 +0000
Received: from dev-dsk-grecojay-2b-e6934ae5.us-west-2.amazon.com
 (10.43.161.14) by EX19D035UWB004.ant.amazon.com (10.13.138.104) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.20; Thu, 10 Nov 2022
 19:29:55 +0000
From:   Jay Greco <grecojay@amazon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jorcrous@amazon.com>, Jay Greco <grecojay@amazon.com>,
        "Jean-Baptiste Maneyrol" <jmaneyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: iio: imu: Add inv_icm42600 documentation
Date:   Thu, 10 Nov 2022 19:29:33 +0000
Message-ID: <20221110192933.13616-3-grecojay@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221110192933.13616-1-grecojay@amazon.com>
References: <20221110192933.13616-1-grecojay@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.14]
X-ClientProxiedBy: EX13D17UWB004.ant.amazon.com (10.43.161.132) To
 EX19D035UWB004.ant.amazon.com (10.13.138.104)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the required documentation for the icm42631.

Signed-off-by: Jay Greco <grecojay@amazon.com>
---

(no changes since v1)

 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 488349755c99..13c9abdd3131 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -31,6 +31,7 @@ properties:
       - invensense,icm42602
       - invensense,icm42605
       - invensense,icm42622
+      - invensense,icm42631
 
   reg:
     maxItems: 1
-- 
2.37.1

