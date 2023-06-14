Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B9730805
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjFNTVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjFNTU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:20:56 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B3B213F;
        Wed, 14 Jun 2023 12:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686770450; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e+FzeiGmNyPUcMNfIoFrMokIUBpwxFNnsbXhzQtr7tU7CfBtBDWs/shxjnNi5sAB4G
    j3Xzr0NNGiR86ueeKzgw8jd2mqUpS+vZsUNMqb243whVTYm9QLfULVw7eyDsSHM5QWly
    OlO3kCLWxONMcbgWpU0jp1ILS/x/46Kcdwzn0nL+LZzX1JvU9fHEbYhcFAOEOAQ4nfUB
    UBh0kFjYVv2+rp4sF9JFzjNp1iCd+73blPG1bOZXTFPWGGxl3bJvyqW1R41n5F0AncIt
    okmKsl1B8gUSXZII4bY4P/BfyE4tzpMQCNwV5SYEMfV0kHF1LZQgX95ZPs8xlno2/FWT
    PR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686770450;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=LdeZ5ShzM18y4oy4q0pM7ga3Ybusf7cQdOu55GJ4/fM=;
    b=tMgPvQdPiE4sjQrE43YGJcftGU4EGRFN9SuxfDpGmEkoFTTFoxHsSWPuEnAxwEaHDt
    b3euHjIaN+AW9XbBAAicwEthYqj9CXgZupocZOFWLvN0XG2rUsi278mvvXJKWBmZM/ZO
    X0DLCDTWLTZcWvSViK7vpY/wdTNN0z0xJh5gNuauJjW+6EG4Kf/e2p/vmEkhzzCXJWc3
    NLuo4yJPnG1z2qz6heLk8oMR+JFcuZaD/mmhy2+iWPKtHxb5wTxI4mVfWJOKpfkZHiZF
    n3hbAP/QvErdveLHp3DADDGnaHCMyEtVIy0wfCivMrafXdW9PupSDjzFRsCuU/Xt4xwe
    lV+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686770450;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=LdeZ5ShzM18y4oy4q0pM7ga3Ybusf7cQdOu55GJ4/fM=;
    b=RDIc6K+fuXpn+9U5xbQluGWN1tgqNZJYFYq4GDD0iS3/xDUUFGzInbbvzPajYjB73X
    l2DFMTkStTsx+PL8CM6AtcKiaxcWDRBYfp8JuHyxoS3b8qAyI3FU7xF20N3LgN+g0fHD
    3QjAkWZo0Osgpw8PVDsXPd/bTu1yCT7TGBIUzdTdwDPDmXD40tOKyxS1aggktUombb8v
    64uOcLHy/PeP4J01/bPiumT0NACjWecbgBMoT+kow05FaR51v0jJY10Aq8W1H572TWi+
    nF1pe6nC75hQkW7GgsKvGdsvEK1j3/49DTvE/Tww1abEjKyDXKhxSFJkdJJoWbUD9kC9
    nqpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686770450;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=LdeZ5ShzM18y4oy4q0pM7ga3Ybusf7cQdOu55GJ4/fM=;
    b=59cCZ4+6c3YKIGO5o78XtZ1x4mwKdt3EUHOR88YMGTRprtTBgUWfX3GIK4tenqjbTP
    aa/Rbkx//GSW5G0FNSAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5EJKo0hs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 21:20:50 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 21:20:42 +0200
Subject: [PATCH v2 1/2] of: reserved_mem: Try to keep range allocations
 contiguous
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-dt-resv-bottom-up-v2-1-aeb2afc8ac25@gerhold.net>
References: <20230510-dt-resv-bottom-up-v2-0-aeb2afc8ac25@gerhold.net>
In-Reply-To: <20230510-dt-resv-bottom-up-v2-0-aeb2afc8ac25@gerhold.net>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now dynamic reserved memory regions are allocated either
bottom-up or top-down, depending on the memblock setting of the
architecture. This is fine when the address is arbitrary. However,
when using "alloc-ranges" the regions are often placed somewhere
in the middle of (free) RAM, even if the range starts or ends next
to another (static) reservation.

Try to detect this situation, and choose explicitly between bottom-up
or top-down to allocate the memory close to the other reservations:

  1. If the "alloc-range" starts at the end or inside an existing
     reservation, use bottom-up.
  2. If the "alloc-range" ends at the start or inside an existing
     reservation, use top-down.
  3. If both or none is the case, keep the current
     (architecture-specific) behavior.

There are plenty of edge cases where only a more complex algorithm
would help, but even this simple approach helps in many cases to keep
the reserved memory (and therefore also the free memory) contiguous.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/of/of_reserved_mem.c | 55 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 948efa9f99e3..7f892c3dcc63 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -77,6 +77,57 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 	return;
 }
 
+/*
+ * __reserved_mem_alloc_in_range() - allocate reserved memory described with
+ *	'alloc-ranges'. Choose bottom-up/top-down depending on nearby existing
+ *	reserved regions to keep the reserved memory contiguous if possible.
+ */
+static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
+	phys_addr_t align, phys_addr_t start, phys_addr_t end, bool nomap,
+	phys_addr_t *res_base)
+{
+	bool prev_bottom_up = memblock_bottom_up();
+	bool bottom_up = false, top_down = false;
+	int ret, i;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserved_mem *rmem = &reserved_mem[i];
+
+		/* Skip regions that were not reserved yet */
+		if (rmem->size == 0)
+			continue;
+
+		/*
+		 * If range starts next to an existing reservation, use bottom-up:
+		 *	|....RRRR................RRRRRRRR..............|
+		 *	       --RRRR------
+		 */
+		if (start >= rmem->base && start <= (rmem->base + rmem->size))
+			bottom_up = true;
+
+		/*
+		 * If range ends next to an existing reservation, use top-down:
+		 *	|....RRRR................RRRRRRRR..............|
+		 *	              -------RRRR-----
+		 */
+		if (end >= rmem->base && end <= (rmem->base + rmem->size))
+			top_down = true;
+	}
+
+	/* Change setting only if either bottom-up or top-down was selected */
+	if (bottom_up != top_down)
+		memblock_set_bottom_up(bottom_up);
+
+	ret = early_init_dt_alloc_reserved_memory_arch(size, align,
+			start, end, nomap, res_base);
+
+	/* Restore old setting if needed */
+	if (bottom_up != top_down)
+		memblock_set_bottom_up(prev_bottom_up);
+
+	return ret;
+}
+
 /*
  * __reserved_mem_alloc_size() - allocate reserved memory described by
  *	'size', 'alignment'  and 'alloc-ranges' properties.
@@ -137,8 +188,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 			end = start + dt_mem_next_cell(dt_root_size_cells,
 						       &prop);
 
-			ret = early_init_dt_alloc_reserved_memory_arch(size,
-					align, start, end, nomap, &base);
+			ret = __reserved_mem_alloc_in_range(size, align,
+					start, end, nomap, &base);
 			if (ret == 0) {
 				pr_debug("allocated memory for '%s' node: base %pa, size %lu MiB\n",
 					uname, &base,

-- 
2.40.1

