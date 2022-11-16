Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5916462C77E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiKPSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbiKPSRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:17:50 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1BC63B9D;
        Wed, 16 Nov 2022 10:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1668622651; bh=pIy+Cj4xeM9LppiDe7/6ny/Pcoi/J/hwJx6TzU3v4ro=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=AXzbQSLAJDcu4HNQLJNbJ5qfIfns0U4WKU2+WzGnHbOaLQg5GlDJVOmPlyjW+R7wK
         BkSV55r7qXaZg6EYvV7NMSXv8hKTSqedTMFclEag/uwzTPe9ULdOa/H7VkLuGLNMmm
         bRwi16pwO7AhjgAZQWKTZAoZj6xGeirT8sD8YVew=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Wed, 16 Nov 2022 19:17:31 +0100 (CET)
X-EA-Auth: IJtCEAs0o9qqKsgtvJnDm5gJesMXrinNUyhAJLVS/KolLnLBrB6Zo/MqXNJYALKJzINTJbAcvA2zNYbMQofn9bDXyBnA3GcvN9BoYe8Jofc=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v5 0/2] Input: msg2638: Add support for msg2138 and key events
Date:   Wed, 16 Nov 2022 19:17:10 +0100
Message-Id: <20221116181715.2118436-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the continuation of v4 [1] from which the first 3 patches
have been merged already.

v5:
  - keep only the non-merged patch
  - remove double-negation in call to input_report_key() (Dmitry)
  - change keycodes retrieval to use device property API (Dmitry)
  - due to previous point, add a check and a warning if more than
    the supported number of keys are found.
    Should that happen, ignore the keys in excess.

[1] https://lore.kernel.org/linux-input/20221110171952.34207-1-vincent.knecht@mailoo.org/T/#t

Vincent Knecht (2):
  dt-bindings: input: touchscreen: msg2638: Document keys support
  Input: msg2638 - Add support for msg2138 key events

 .../input/touchscreen/mstar,msg2638.yaml      |  4 ++
 drivers/input/touchscreen/msg2638.c           | 57 +++++++++++++++++--
 2 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.38.1



