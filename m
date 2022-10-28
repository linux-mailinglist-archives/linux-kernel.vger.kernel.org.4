Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1212611568
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiJ1PD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJ1PDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:03:54 -0400
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F69207532;
        Fri, 28 Oct 2022 08:03:49 -0700 (PDT)
Received: from host-ubmmyvj.static.zeelandnet.nl ([217.102.255.198] helo=mail.zeelandnet.nl)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <glasveze@delta.nl>)
        id 1ooQDC-0000TK-P7; Fri, 28 Oct 2022 16:19:58 +0200
X-Sender-IP: 204.168.188.16
Received: from phenom.domain_not_set.invalid (016-188-168-204.dynamic.caiway.nl [204.168.188.16])
        (Authenticated sender: glasveze@delta.nl)
        by mail.zeelandnet.nl (Postfix) with ESMTPA;
        Fri, 28 Oct 2022 16:19:42 +0200 (CEST)
From:   glasveze@delta.nl
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 1/2] dt-bindings: rtc: ds1307: Add support for Epson RX8111
Date:   Fri, 28 Oct 2022 16:19:41 +0200
Message-Id: <20221028141942.10442-1-glasveze@delta.nl>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: 217.102.255.198
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: SB/global_tokens (0.00196518661148)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+JXbjng4B8KCaTq3NTvS14PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wr4cCRmG2oKTFnKAAvDWJPvjDSqTwBCKJA01U6S0IF3CG1
 TXgY2TYLA02EG+6b19hUwqWpTVihCNBf6Y0ngLN9W55S5Odoi2XRRfrzh43Mii9G2t8Q2UJdUrYK
 bqcQwkqhSENMlzwkX5dwDoKhqGrqW1ZaarE32k/fZS9WDJcJpYZGB+n268qSza3XvlKKEFTbC8dt
 /CV3fELBVC/AS5PvDdqpp0PwvA0T6h+PF2lQM+UptZeMWqwM87Sr86NOUNNXJcphKwwtkJ0il/aM
 E1JAuAZvvM53msAYiwEKD8v9MuKVse1sVhWabI0/+PN3sIJkYWvWNZaZ0U+2WAj4IohtB5Wku8Z+
 HjscnTdG7OzuuhO9UWZR6DygHL2uL+fpoKfkmbmoofKALtn/uXeLjRifqraCXgGgCDOczZcC0s+1
 rMP5P71XxSY6Bud0I4P+npSUhdUKb/ejZlGAm5aYDC522S9lxf1W0a5eEMc7eunFGmvh9GiopPC0
 UD6wcbWJMl9n+3TblTAKGom+tz90NlkS2XisTmNxpUcDTKRyhJJrVG18n/RbDuZUqQqTgt7VC9CP
 AtwL+re6Uz43RIVa9gaV9SxdNCEKGT/Znx3aa/MYykHvm3Pq/TMVhLiLVSlbDnIwjZjn7QogpmK0
 eNWmS0n931/E3ahF5MMcDI7KdpjQKTxLZ9y9gIsjefalsT+at7OgkXa3w91ZfeRDvUeK4qGp36oy
 bTZpB4Wv6ElyTZU8c8TJRwRvw2AEVD26W3GQDiXO7ujGdCQPoAa02/HGzYqRDuOlu0DGJJ/yi3xl
 Qv+7Ye5iAwG6iqW74zZvnRHNN8yRiVjjk+nqGoPj2ahc7Nr7g8f4ANeGelsjxQhkhOscjNc7xQ2h
 dHEckmcQGOuBPq9rt4dOEn9WJA7yfGK6BkBGG0mLtmuzbfeFGb2hZWsDt/fmCo6d12yvI0wed/0Q
 udAWg/9etw9TIOEergZFaJ91hnCJ4odIJjOae1BAYoct5kI/cxiIQMFEDBGcoZ8K51uNKuJ4zqgJ
 4SeU8y5Ph884ctgzcDoFd+96Xw4QUNtTnctHmbpOK0RKd6E2YmmZo3u87jDsfKYWdCAewd7hjSHD
 v1yU8GDv9kO7wH7K9y8hX1+STHELjwkcdmgWo2JoBLv+psOGtMjI9qGEbmhFtfi+crcUX31Co0Zg
 NRr7F4I7T5HIIbgqOGhNKCbnOkqTNOYxCCw6fqSlOTqlv1QhfFxXVbH+G+02TrybDOP2Co+U5w==
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Looijmans <mike.looijmans@topic.nl>

The rx_8111 is quite similar to the rx_8030. This adds support for this
chip to the ds1307 driver.

This adds the entry to the devicetree bindings.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml b/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml
index 98d10e680144..a9590da64b84 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml
+++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml
@@ -30,6 +30,7 @@ properties:
           - pericom,pt7c4338
           - epson,rx8025
           - isil,isl12057
+          - epson,rx8111
           - epson,rx8130
 
       - items:
-- 
2.17.1

