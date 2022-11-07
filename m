Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7BD61EF85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiKGJrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiKGJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:47:35 -0500
X-Greylist: delayed 2018 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 01:47:34 PST
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8671742C;
        Mon,  7 Nov 2022 01:47:34 -0800 (PST)
Received: from host-ubmmyvj.static.zeelandnet.nl ([217.102.255.198] helo=mail.zeelandnet.nl)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <mike.looijmans@topic.nl>)
        id 1orxtj-00016D-V4; Mon, 07 Nov 2022 09:54:33 +0100
X-Sender-IP: 204.168.188.16
Received: from phenom.domain_not_set.invalid (016-188-168-204.dynamic.caiway.nl [204.168.188.16])
        (Authenticated sender: glasveze@delta.nl)
        by mail.zeelandnet.nl (Postfix) with ESMTPA;
        Mon,  7 Nov 2022 09:54:08 +0100 (CET)
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-rtc@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: rtc: ds1307: Add support for Epson RX8111
Date:   Mon,  7 Nov 2022 09:54:07 +0100
Message-Id: <20221107085408.28341-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: 217.102.255.198
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: SB/global_tokens (0.00272519686927)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT84HAmXDrak62ISD7MDA5A7PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wqSBOxlRVmV45FJ8CYZCUIt8C9mOBdONdnsxgsk1D2pwpi
 79/9lCWegUcH0YAeiESZu3hhVxUr+XbzYNuhZTyMN2jRpXv406oGDMCZBpfLj6tXYKbjfBt0vNkw
 cgcqpVi2EeDr8t3Z6zKdUQQxqR+SNjz3rkBrmCeUsHTfzqlbREQW59v6OzLaYvRKiPHtemyFp+Fb
 q4/dza6vunvz714/oUhDTJc8JF+XcA6Coahq6p9OU3mS/dDcjm11n8LBBaHmFYGlZcUx+feeIofU
 vaKO2wvHbfwld3xCwVQvwEuT74WwDyq/Nv4s81lckG+lIDvnx8yeplRO3sLIqUlSH7OGQQJWpNFf
 IrI9o3HL432ZkXLwENyZMPyeFLnoLT8oU4J5ip9csxSp5vs/cqLV2uCxa1gbjNr6zuq/msj6Lhvp
 vuDB+q8tdeTHeaut22yP2PJxAZuIytYBPaHe1r36ekBjoLoOc/cuTx5izBB4vDJo75HWAoddgXQw
 hX0bgQM/NQzAznOAUImGZ//xcQKfbL7egPacf1SEo03G99/UIdTGSFjTsZRW5VqyvaeMWA2+RBXp
 D59QdM/f9KJhSSfjTAUyLIywuTEI0kISK7u1AZUYs3NofNjT1oDBvJQtMIHPcVtYe7ERN3HHxFjX
 YLlttEV1+/5W5+zU8lWY6rju5hxPyAc8I07FTFcjpdfX/Jcr87ciF4YonbkVO2PUjQCgejWG/gXy
 CqWmPgffPsl4eG9LUHZn0HrRDnLnZ852fb3E4hoxzFQacs7vQRDI1X8MhtLrVdedPS0ZKWYGDxP4
 bm0tXIBvHwWS2MhtCcgqeX9Zchdoh9VoIekQHpwUfpYnEThmw/mwIQ9kzAAqBOEV406mI5N7efIT
 B+/xrftEfewwGTqvpVFKdMPCmCxgDmATtnDZnWrF+C9myP/AxQ/B0u0sl2oeA9rb47uAGdIJwe/d
 DL921bkn7bebrPKsrBkER41T0z6bhalFEM/pjPCQA+BAlgSU/nzBkyxPcgBtPVrWxiKQanUl0Ewx
 po60Ztqjl+7BLqqughUzQLrV0KR+CasIdaXCBfrmeYK8zgsf5hgnJcP/h8APlf2P6dpQsddkjLHr
 eL7FwJbXl3T/igMoCpp5k+ewp8wxtcXgs9dII53Mh+MSuRiGDjN98X3Nl4UFl9YcoKxhfyAlRS/e
 WdITuOAzdpAv9Li9J+PnOe4auO+Cjkw6V5e2HJtcKidgYBP/KMQZZJx675xB/yl1ErnBxiCZrSRW
 4RPBB8BFstI1Wbmb/HHdhFxMiLYEP2q9G4ugDu0B5/eYuJyja1pmN+nUwcYeaQ==
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

