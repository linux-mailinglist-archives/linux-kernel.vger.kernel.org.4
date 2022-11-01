Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9057614745
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKAJxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKAJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:53:32 -0400
X-Greylist: delayed 1543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 02:53:29 PDT
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682613F79
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:53:28 -0700 (PDT)
Received: from host-ubmmyvj.static.zeelandnet.nl ([217.102.255.198] helo=mail.zeelandnet.nl)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <glazveze@delta.nl>)
        id 1opmgD-00068o-Tg; Tue, 01 Nov 2022 09:31:44 +0100
X-Sender-IP: 204.168.188.16
Received: from phenom.domain_not_set.invalid (016-188-168-204.dynamic.caiway.nl [204.168.188.16])
        (Authenticated sender: glasveze@delta.nl)
        by mail.zeelandnet.nl (Postfix) with ESMTPA;
        Tue,  1 Nov 2022 09:31:23 +0100 (CET)
From:   glazveze@delta.nl
To:     linux-rtc@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: rtc: ds1307: Add support for Epson RX8111
Date:   Tue,  1 Nov 2022 09:31:21 +0100
Message-Id: <20221101083123.11695-1-glazveze@delta.nl>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: 217.102.255.198
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: SB/global_tokens (0.00150102412276)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+fMveXxnfOZrgwa7/MvQYDPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wqSBOxlRVmV45FJ8CYZCUIt8C9mOBdONdnsxgsk1D2pwpi
 79/9lCWegUcH0YAeiESZu3hhVxUr+XbzYNuhZTyMN2jRpXv406oGDMCZBpfLj6tXYKbjfBt0vNkw
 cgcqpVi2EeDr8t3Z6zKdUQQxqR+SNjz3rkBrmCeUsHTfzqlbREQW59v6OzLaYvRKiPHtemyFp+Fb
 q4/dza6vunvz714/oUhDTJc8JF+XcA6Coahq6p9OU3mS/dDcjm11n8LBBaHmFYGlZcUx+feeIofU
 vaKO2wvHbfwld3xCwVQvwEuT74WwDyq/Nv4s81lckG+lIDvnx8yeplRO3sLIqUlSH7OGWzZxdxZO
 MNdUoc9FlEr2BnLwENyZMPyeFLnoLT8oU4J5ip9csxSp5vs/cqLV2uCxa1gbjNr6zuq/msj6Lhvp
 vjHGDmddzHap4I7VGqLLvI7oxlm7kP52ZxDqHbw/0OqAoLoOc/cuTx5izBB4vDJo75HWAoddgXQw
 hX0bgQM/NQzAznOAUImGZ//xcQKfbL7egPacf1SEo03G99/UIdTGSFjTsZRW5VqyvaeMWA2+RBXp
 D59QdM/f9KJhSSfjTAUyLIywuTEI0kISK7u1AZUYswOEpwFdG2jGwY6Bm9W/XNNE6vgDovKp0+yN
 qw90aRFIFnjEprciIL+rxAZ0QqLSHV9IlKha13El6tTzAeqsLP7TmwyWkFAKX6230SM4LCMeEY09
 Bx7bp0O2j1hLeSx525zuuPE0M/XzHi7X8V/cu68gr/U0flMcy2Vi/IcBgY4amwfEOQVUNYnWQ300
 Dp6cJDE37L8A/sfCSfmp70N6CAkTDnHxOK4BiYyvkz+/wZwwYqG/vijyG4aOcjbIor8orItFLNlw
 ZrFQlMFer4BtL1PbpJ3Vh8ibsqyxAqJtYGjzP6GMdt/ZiCCGoGagixCwW84NSDNfnkx0FX3OFUNq
 n1MpieaDJmOksitnbpZ9MQYjx/Om5AxPQGNBedVITG8AWxFjzL6tOKgqN6JvQh5n0fI612bG5S+Z
 Kxm29vhtcTbav+nPErDn/9w2ERKKH06cfjA78AQFw9bd8gj3LalWsUOocRk0/bWX1xH6FJm0Q3iP
 CmrxJ2+EokXE5CTwtF1RSNQwFbwWnhEwBi6hI73CcV6EcHXc0Zal25K9MsiopwSawNLQjZK6kKbb
 gNaJlD9A4g+m3nW06IBcbpAk9tBJy3OwmQm7DjpV7Sk6wVAJ6/XOJOG/iKSpBU+r0zgYp1Oa51OE
 Dgse489k7IVPaIjV8ZGYtKORiBOrYEFBQtHrezLP9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

(no changes since v1)

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

