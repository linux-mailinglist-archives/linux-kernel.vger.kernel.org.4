Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F7704F77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjEPNiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjEPNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:38:06 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1086CA;
        Tue, 16 May 2023 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Tc4N6cacmpKk5k4on8VEF7pB3edhIp5X8MzTz70xu0Q=; b=V4ydLiGbTg7AztiSATz1zSo8dd
        DlIqofKsUzJRdOOOpdJkrzr2lEM6WLJUl85oHIz7IEhdy0L+1m3enmVBD8rqHhx7IMz/0rPeDb4IS
        uz4zS3Q3eaVS8qxMrJPKO0CtQdJzn3GyeAswiDYe28gMofn0hyBOvKM79cwYKmDTQt8ChzlHd5/lG
        hVzYTnuPZtlfEEybVZDjanyl9Y4fVsvDdgjvQNEeg9O3DMjclBjVYYYylhCE1ppgrYwU/w99xYO77
        jJsgQTdV0hPKWRkgF3vMNiDOkyHqfhTBB0VllVO6OAHqiOuV/w1aPTyc+oJtYj4vr9kkqKFcniFk3
        mPWZNKmg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1pyudb-000AJG-94; Tue, 16 May 2023 15:22:47 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1pyuda-000NS5-RA; Tue, 16 May 2023 15:22:46 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     robh+dt@kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>
Cc:     devicetree@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff property
Date:   Tue, 16 May 2023 15:22:24 +0200
Message-Id: <20230516132225.3012541-3-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516132225.3012541-1-sean@geanix.com>
References: <20230516132225.3012541-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26908/Tue May 16 09:24:20 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new optional "fsl,pmic-poweroff" property.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
index 9573e4af949e..5183a7c660d2 100644
--- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
@@ -26,6 +26,14 @@ properties:
 
   interrupt-controller: true
 
+  st,pmic-poweroff:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      if present, configure the PMIC to shutdown all power rails when
+      power off sequence have finished.
+      Use this option if the SoC should be powered off by external power management
+      IC (PMIC).
+
   onkey:
     type: object
 
-- 
2.40.0

