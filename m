Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA562CC72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiKPVRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKPVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:16:50 -0500
X-Greylist: delayed 10740 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 13:16:48 PST
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F304C258;
        Wed, 16 Nov 2022 13:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1668633397; bh=a9KYl1hIoBIvL/U20k0sy5lGRkz1Wjptty6bd6cHvaw=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=alsFQWzlcynUT9NOYcOgTHGgXhAJFF9oZsXszQFUGVu992kSCjWuNnmQiPXt2v4pK
         SUPKJOsBixG7l4j1DMGN352f28hjLwHWL1T2z6V0s1Y4LcMGoG0FDYXmU1aRDIQJR4
         i1sDJ2BK3zp3PrGPY5gGp0UNWGhDvHyG7qkq8xUw=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Wed, 16 Nov 2022 22:16:37 +0100 (CET)
X-EA-Auth: uD+aQfuNBm/LqnABbr3Z0uz4NmqWq5ah2sr48xayCWyEU7CEcCNESIjFTPXu3QQahqr3/+CrAB+zNOu7VJtBDWE7jFUZMpwxGimeb5RRoLM=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v6 0/2] Input: msg2638: Add support for msg2138 and key events
Date:   Wed, 16 Nov 2022 22:16:15 +0100
Message-Id: <20221116211622.2155747-1-vincent.knecht@mailoo.org>
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

v6:
  - use property_* functions instead of fwnode_* (Dmitry)
  - use %zd format instead of %ld to print ARRAY_SIZE() (Dmitry)

v5:
  - keep only the non-merged patch
  - remove double-negation in call to input_report_key() (Dmitry)
  - change keycodes retrieval to use device property API (Dmitry)
  - due to previous point, add a check and a warning if more than
    the supported number of keys are found.
    Should that happen, ignore the keys in excess.

Vincent Knecht (2):
  dt-bindings: input: touchscreen: msg2638: Document keys support
  Input: msg2638 - Add support for msg2138 key events

 .../input/touchscreen/mstar,msg2638.yaml      |  4 ++
 drivers/input/touchscreen/msg2638.c           | 57 +++++++++++++++++--
 2 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.38.1



