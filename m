Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9910270AB24
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 23:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjETViw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 17:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETViu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 17:38:50 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86AE9;
        Sat, 20 May 2023 14:38:49 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 6F4229DA;
        Sat, 20 May 2023 23:38:46 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:message-id
        :date:date:subject:subject:from:from:received:received:received;
         s=dkim20160331; t=1684618723; x=1686433124; bh=eMERf6lDNoGOVdkb
        nyJmSR/kvIhnXnEspto8AHz1L+o=; b=MfQbWgh2WJz7Li8+JwiQfJlVbMs+6pab
        9hIVZgmFWHSbHPB8xEtMUSm38teYBW50FYLxVF1M6zBzJ7a1XADHkkO5rGSJD+pC
        dHAQaA833yF4xWMh1U/hviLK4bTXUzm9U6H9DxmSQjpbMM7adirnHOWSMDnclXjT
        uXZeVP3NERSrDc4H7mERh6XjXr73+M641vWM9sbo5sTstHTGzk9nGm7JDPh3R12p
        Ae3NNWHiSekCtNQxwduGpQZOcp1vTzUaSUeCVkuCvks4YUR//3VyMenIc4Trd7YM
        gmwZW+ZGC1Yp42ZPs2d7eSsEbh2fKFCaQOUsq3AuRl9t1YSlepdRUaOYMR78Ee9o
        SArUPFfFIq1E47L1BYZsePX33kfHhjNkzMeFKy80VEv/EwekHZf8eYIW/1Nik/tl
        GKgxZTY9aGAAosEZ/AeuwXUOJdZ/KpSnS3mTqc5UaRgYsJAZMiZLWwlx60PdgZbU
        7wVcojbMmirGJUA+2dBEiI9F5Bf9aXJiHkQfpQgZmF8mLZSozkx3BUZvC4ygbK6p
        Hbtnw/g1RofmFwiFAF6F6HZ4do4uq1J1BA1fy1f1HdmylUB0s38LCNBKnX6NDEpZ
        KHALzg6AU2Gal9/+4MwJgGln078umRiyxXDJFA6VSqhYI7AP/dxq+uhRJsjBS1P2
        Y+IO/WCDTH8=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t5UvcI6BUA5F; Sat, 20 May 2023 23:38:43 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 07EDC579;
        Sat, 20 May 2023 23:38:42 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 3AE1B2991;
        Sat, 20 May 2023 23:38:42 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH v7 0/2]   support config of U-Blox Zed-F9P GNSS
Date:   Sat, 20 May 2023 14:38:33 -0700
Message-Id: <20230520213835.1932087-1-alison@she-devel.com>
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

V7 -> V6 Fixed tag and version.
V6 -> V5 Change #ifdef to _maybe_unused and fix warnings.
V5 -> V4 Wrap all new code in a CONFIG_OF=y check and fixes
V4 -> V3 Lookup device-specific properties by matching driver data.
V2 -> V3 Add email recipients whom I foolishly missed the first two times.
V1 -> V2 Fixes error identified by kernel test robot:


Alison Chaiken (2):
  gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
  dt-bindings: gnss: Add U-Blox Zed-F9

 .../bindings/gnss/u-blox,neo-6m.yaml          |   1 +
 drivers/gnss/ubx.c                            | 243 +++++++++++++++++-
 2 files changed, 233 insertions(+), 11 deletions(-)


base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
-- 
2.39.2

