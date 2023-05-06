Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5916F94D8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 00:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjEFW7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 18:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjEFW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 18:59:17 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2431CFF8;
        Sat,  6 May 2023 15:59:16 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 9F2F714E6;
        Sun,  7 May 2023 00:59:14 +0200 (CEST)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:references
        :in-reply-to:message-id:date:date:subject:subject:from:from
        :received:received:received; s=dkim20160331; t=1683413954; x=
        1685228355; bh=IeHcnYGT8x5oIMpt7vaj6WJo5TzDUMMrc5PAh+gHWeM=; b=z
        fgKWJa8uV1RgS2NdN8w0kuxjfjMP3YHg7U/v8JIyuDfD/k+c7jQNe3WPVAd2+DtN
        F6wlcewrN+yGmYV+11IjBmpkuQD4Jx/eX7DTg8m5++L2aMbj1YgQroF6VS/TfEb0
        1K2JESO3ZiBok7mXWJQuZ4PgZYHOlQPBnPNMzZ7dIf1wXklKgZq70BZxxitg5kYs
        H9x161EE2MMT20+SfYie2r+EJJBgsrvYrl1GkWjNn0yVzYlwDR02UhIsz+PjcPhe
        D5pnm+5qxp2ZOW9plfduf/F57eISCy5H8TpdX6pAS45IJ738f60oCZABOZTA0EvX
        9mq6ctDRi9GFYXdwA8IF5VrbRa+tSUjGX6beCNOjllSohUVYzrQZPayI9twCUEdH
        SqDQHLSV+naAWwRsNFYOsz2B1u4/AAJkr46TfageRkp09IpTWsz6eMbqwBYP3ZxM
        SBQHadbyJYNOseYKJUqPO4Xs9Hqx9LUgny+LD/yBkJdOLnz3NLlebQY9Duk43Cwh
        YoHC0vKr6NWg4LibETsn64phiQHuxbOGCTMrYAS5AIFUM8mWX/a7P/UToPONNOAi
        sGs4FJJCS9r6sGd8NQ2FggLv5FcIkLfHAWsfiJ4R3wq8UnETe9VSoWwgrFcbVKz2
        6PUvNV5IstS7IEH1ceM/5AfSezKPYfUqC8VzXBKcdU=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RXbxy0783O9m; Sun,  7 May 2023 00:59:14 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id 975D9821;
        Sun,  7 May 2023 00:59:13 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 02698D202;
        Sun,  7 May 2023 00:59:12 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Date:   Sat,  6 May 2023 15:58:49 -0700
Message-Id: <20230506225849.2752103-3-alison@she-devel.com>
In-Reply-To: <20230506225849.2752103-1-alison@she-devel.com>
References: <20230506225849.2752103-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

Add support for the U-Blox Zed-F9P GNSS device.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
---
 Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index 4835a280b3bf..86b65d4d9266 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -21,6 +21,7 @@ properties:
       - u-blox,neo-6m
       - u-blox,neo-8
       - u-blox,neo-m8
+      - u-blox,zed-f9p
 
   reg:
     description: >
-- 
2.39.2

