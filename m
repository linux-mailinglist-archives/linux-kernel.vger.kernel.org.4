Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEC17020D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbjEOAkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 20:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjEOAkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:40:43 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE510CA;
        Sun, 14 May 2023 17:40:42 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 08100126D;
        Mon, 15 May 2023 02:40:40 +0200 (CEST)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:message-id
        :date:date:subject:subject:from:from:received:received:received;
         s=dkim20160331; t=1684111234; x=1685925635; bh=scwQURvSKJBR0lm+
        FvAYEjMCy6XK60m9FLCtAzxekeo=; b=WmezPnO4KFPNadHpZv5Nlgt+r/9VMDst
        im9Iff/TjwnbDq8erJys3WUVm/czaM+Et8cq25I5VfVqpoTywpoICVK1ODP8ei7S
        rXyPAf5SS84czzYHZRBgMUgkD7ShaHfPzuCEvUaCXYHQUVcXKDeRKNO26YpRqIZ2
        J/qqQRnOkQN9ePaTggSh6CTVS8MnuxRN6h2cigCTKJboZQkaz52Gj98hZL5/+OUe
        lDEXorO5v45uuDMAehQR9qvcOQcuN8M+Vbix9ViFijgVv5tq4jpR2YMpPTJkwFgx
        O598NIUS8zsZ3pGBCxm+uHwt1XMALHQW+u8qcs3T0lzS437KOYY2Lc1gzYSK83eq
        Bexg6Hz/E4b1C0OFXdjq+1bMJOfe5/JQSyn5zbZn1ankYQqDuP9ZCLthSZ+J5n6Q
        JOLHNYkxWqLjkwZQ4cHaBIBx7zhXt+HfHmKhu8SST8BIKpNI1VhI2kdnLP6Y/LvP
        G0VhTmGKQ3KFdOj7BO8z44iORIXa4YE7DRdhy4VJNOaeiVqVfmcLpN06tpKXPILm
        OJyGb33xlVfCNP5sHhht2tyW1nOrZ3sK/K3+c77D9OTMMQIFcbOYmU43jqQ7CxCA
        9g3jCSq2Dx/LAxDs+rLPwAF0nXKbe9IPtKOWY4virg4kROgGwfWLCxdetOlE++zN
        yYVK/OMrMoA=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ImGuEhtW9N6F; Mon, 15 May 2023 02:40:34 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 9ABDD1238;
        Mon, 15 May 2023 02:40:33 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id DCBE83E6D;
        Mon, 15 May 2023 02:40:32 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH v6 0/2]
Date:   Sun, 14 May 2023 17:40:23 -0700
Message-Id: <20230515004025.1133572-1-alison@she-devel.com>
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

Thanks very much Krzysztof Kozlowski for your patient and helpful
advice.

V6 -> V5 Change #ifdef to _maybe_unused and fix warnings.
V5 -> V4 Wrap all new code in a CONFIG_OF=y check and fixes
V4 -> V3 Lookup device-specific properties by matching driver data.
V2 -> V3 Add email recipients whom I foolishly missed the first two times.
V1 -> V2 Fixes error identified by kernel test robot:

Alison Chaiken (2):
  gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
  dt-bindings: gnss: Add U-Blox Zed-F9

 .../bindings/gnss/u-blox,neo-6m.yaml          |   1 +
 drivers/gnss/ubx.c                            | 241 +++++++++++++++++-
 2 files changed, 231 insertions(+), 11 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

