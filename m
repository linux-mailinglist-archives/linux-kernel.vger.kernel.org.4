Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF1971099C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbjEYKOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjEYKOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:14:09 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176161AB;
        Thu, 25 May 2023 03:13:49 -0700 (PDT)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 8616934252F;
        Thu, 25 May 2023 13:13:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:message-id:mime-version:reply-to:subject:subject:to
        :to; s=mta-01; bh=jGmhcQLCB71u6CFOkzc4q61oNS37ufBvWxlILeEyD1o=; b=
        pqRuqy/2on5hXwwWMH5YbWtu8bPtTSX5bY+7xcB7rP6FXHjaPhQNcdlzjB6uPwxw
        xJN78fpOmJqhQFOUwh9AvcU4MjzP2XwhJlEZf7Pra1s8HjuWlbyWzt+NAQfCW0xh
        6CecrFI/i90Yd3KMSn7vcEZHGTVZYxpBquhUoQMe17s=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 7AD283423E9;
        Thu, 25 May 2023 13:13:47 +0300 (MSK)
Received: from xpad.Home (172.22.2.87) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 25 May
 2023 13:13:46 +0300
From:   Vladimir Barinov <v.barinov@yadro.com>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vladimir Barinov <v.barinov@yadro.com>, <linux@yadro.com>
Subject: [PATCH v2 0/2] leds: add Awinic AW2026 driver
Date:   Thu, 25 May 2023 13:13:41 +0300
Message-ID: <20230525101341.2036563-1-v.barinov@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.2.87]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This adds the folowing:
- LED driver for AW2026 chip
- Document Awinic AW2026 DT bindings

Datasheet file can be found here:
https://www.awinic.com/en/productDetail/AW2026DNR#tech-docs

Vladimir Barinov (2):
[1/2] leds: Add Awinic AW2026 LED driver
[2/2] dt-bindings: leds: Document Awinic AW2026 bindings

---
This patchset is against the 'kernel/git/lee/leds.git' repo, 'for-leds-next' branch.

 Documentation/devicetree/bindings/leds/awinic,aw2026.yaml |   93 ++
 drivers/leds/Kconfig                                      |   10 
 drivers/leds/Makefile                                     |    1 
 drivers/leds/leds-aw2026.c                                |  578 ++++++++++++++
 4 files changed, 682 insertions(+)

