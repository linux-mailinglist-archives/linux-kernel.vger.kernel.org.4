Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF7C702A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbjEOKQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbjEOKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:16:11 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A632102;
        Mon, 15 May 2023 03:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684145544; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=T8Uit922Ztk76khdVJSDdctVn6H1THgKHsSXYuvr+EKjImFJ5E7zJF9AMM91JczFgG
    t51IDdXavoFrTxcE/+JkConLRr1Pkv1O+T3VtExVAejK7bNZxrXK0h39sqExka9ZsIHm
    DvXiaURmi8hEVPj3+xKcKomyd0nAtI4Lk3mIKfYUhlUxMvepW+YIEFLwtEIf/LCdIsVH
    vlIahSVpxljh0uVZe2qaPECyxSP64xUD3TmVtBWCMuoVbLHDw4Soe2AYnEg4iJrArT02
    RUyU4/PPRxPKsdG7Zk4RzMjOUe4PxO++QVMKdhAHxz3PBBY/7BIstevhZRL1nuZEfx6y
    zyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145544;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=jfB/CpVNa1JJ+lCLjNohI5jzcdCGpDmi64bliceUj4E=;
    b=bC09aaEomTGV5NEiEiq0AOH/urBGNKEM/WfGT+qgQdfFrtI1BqsuKHJ9rXf7fdGCia
    sbCiafS8l1vCkM7XzRFX+q+mSSqBmEOM6xurlqtD2/t1Df14fsHxQdYAWdfKyM0lYY7t
    gh27yhgwLDWHIlFERSFxMlrI7kRb7D9cc5NrvKAp8ReVEARTMNHBK+2TqetvpsCpgNZv
    OIdtIHGiTYrFBkw2SwOdTyIYl0i3gXYtdY6eBSFHYE6Kv+odNenRcW6AA6SNV9pgcKFv
    hwQwOEGklFA/Lf5YkLRwtZID+ZC+fXpJA0x/HW6XAq/jUTFWqtC1rn+lyP0ou/hER5Ou
    ka1A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145544;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=jfB/CpVNa1JJ+lCLjNohI5jzcdCGpDmi64bliceUj4E=;
    b=WROWHfEyjMq/Q/G1dolZPFwt4ZlT+ICnNtbgViYYzlfQwkEAcmL27Ezq8Lgr7439eC
    BHXmRl2eUjMEHnQyIVMgB+VoM6XCZNrMzH3/QOiOnP+MqFYha4Lj64im5n3vXH7Ea4Ch
    pxDms+Cf58akmv1XgezvGTPHzGCcJlMiBWvmWrVme3esZ30esR1G9NVpTGprb/U0r2Du
    5oWM7c7l9c2VO1PjNuvrjwOuIElJo/1fcV+mZ+ypA4i1UcxaKvWpVo+6fKbu9IKW3qEg
    4J95wqHk6h4KpGZ/1NZh8PVKGBKmyTVPT+d0CHWhahqMNmES7W5IBQ4RiIV64udkyLCF
    /FGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684145544;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=jfB/CpVNa1JJ+lCLjNohI5jzcdCGpDmi64bliceUj4E=;
    b=0IzAm2OSKSa3+6O4Nfm1SUdH5UqnTb2zgC4j3SBLyKUO0zGxZdG3JlmLSrT7PZHhsE
    1vgoLsnBEKs5RsAFeoBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4FACO1JH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 15 May 2023 12:12:24 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 15 May 2023 12:12:17 +0200
Subject: [PATCH 2/5] of: reserved_mem: Implement alloc-{bottom-up,top-down}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-dt-resv-bottom-up-v1-2-3bf68873dbed@gerhold.net>
References: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
In-Reply-To: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memblock_set_bottom_up() to specify an explicit allocation order for
dynamic reservations with "alloc-ranges". Since the default value varies
between architectures the previous value is saved and restored after
trying the allocations.

If neither alloc-bottom-up or alloc-top-down are specified the previous
implementation-defined allocation order is preserved.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/of/of_reserved_mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 948efa9f99e3..6443140deacf 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -89,7 +89,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 	phys_addr_t base = 0, align = 0, size;
 	int len;
 	const __be32 *prop;
-	bool nomap;
+	bool nomap, prev_bottom_up;
 	int ret;
 
 	prop = of_get_flat_dt_prop(node, "size", &len);
@@ -130,6 +130,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 			return -EINVAL;
 		}
 
+		prev_bottom_up = memblock_bottom_up();
+		if (of_get_flat_dt_prop(node, "alloc-bottom-up", NULL))
+			memblock_set_bottom_up(true);
+		if (of_get_flat_dt_prop(node, "alloc-top-down", NULL))
+			memblock_set_bottom_up(false);
+
 		base = 0;
 
 		while (len > 0) {
@@ -148,6 +154,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 			len -= t_len;
 		}
 
+		memblock_set_bottom_up(prev_bottom_up);
 	} else {
 		ret = early_init_dt_alloc_reserved_memory_arch(size, align,
 							0, 0, nomap, &base);

-- 
2.40.1

