Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242876F9D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjEHBMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEHBMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:12:38 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FEE30FF;
        Sun,  7 May 2023 18:12:37 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 2219913A8;
        Mon,  8 May 2023 03:12:29 +0200 (CEST)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:message-id
        :date:date:subject:subject:from:from:received:received:received;
         s=dkim20160331; t=1683508345; x=1685322746; bh=loaQVxuGjORJ8yHe
        oDhk8cT5JpTAlWq6FTSlwxm2dGA=; b=N3zOOitZRetFO4EHkratTgvyVwjvUsgk
        dnKsNw1n5YygFLZWZeKK4Eomg5bIGkAGw16XR2zx9/N/obRXjwKl3RNRjE0j7abe
        xt+TMGHjjIxyZMhM9VwDWbmYDt2I/yuVdwZdKbCzxawx1BGTE/DFdNgkHsbupB8e
        QNrnG7daPhwXXMUr8IYqEROY5CcoGEZonVN6Cqbas3DX9Rqp+ZMDFai7PfJDP0vC
        zKMeyzzxytod5iwhvauBdStLWhhvxbYvEQM9QK7TNRylph1rDHoGXtL8V5+E1H10
        fwsaA51Dff4wFa+jhiAJp3IgvMiTf+sYvlQ6Cqtoei1FYbVnaSBMOMx5sQpJUL6o
        ceiDwUDwv60eei6RFRu2YiB37wwru1KNMPZDZ96wtZ6PUYFr5GTwWCtFwTX9A2+N
        QS6qvUx0nn3XzEaIis9Ka07iKeBXcIi9T5LsOQT8iQJj2zmxSScTwmIcQX2jLaDL
        R82UQohEFLgQciM+4pmtd8L1ad9o29osDWfVYHR5Xo27FZNE+WOxyHUj/9zpRb9p
        isj1lUzWQwWIEStDs4eJisZiVlA1FyFQgmhK551uc+uRdjSU0v3QInBfCpBC7j0F
        QkB8ysbpHnZCrPGnqgBOi+d9GR9a7jnwgrh1VyUGSiQCdYbxtM56osnNty0I+pTB
        uqe9DrmqiQs=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ByqfJU6EFTsM; Mon,  8 May 2023 03:12:25 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id 83B3F14EC;
        Mon,  8 May 2023 03:12:15 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id CC37713EAE;
        Mon,  8 May 2023 03:12:13 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech, kernel test robot <lkp@intel.com>
Subject: [PATCH v5 0/2]  support config of U-Blox Zed-F9P GNSS
Date:   Sun,  7 May 2023 18:11:57 -0700
Message-Id: <20230508011159.263322-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <alison@she-devel.com>

Add generalized support for setting arbitrary configuration of the
U-Blox Zed-F9P GNSS.  Employ the new functionality to set the baud rate
of the Zed-F9P if the devicetree specifies a non-default value.

Tested with 6.1.22, only on a U-Blox Zed-F9P GNSS.

V5 -> V4 Wrap all new code in a CONFIG_OF=y check and fixes
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305070938.8vWQFfIQ-lkp@intel.com/
V4 -> V3 Lookup device-specific properties by matching driver data.
V2 -> V3 Add email recipients whom I foolishly missed the first two times.
V1 -> V2 Fixes error identified by kernel test robot:

Alison Chaiken (2):
  gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
  dt-bindings: gnss: Add U-Blox Zed-F9

 .../bindings/gnss/u-blox,neo-6m.yaml          |   1 +
 drivers/gnss/ubx.c                            | 242 +++++++++++++++++-
 2 files changed, 232 insertions(+), 11 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

