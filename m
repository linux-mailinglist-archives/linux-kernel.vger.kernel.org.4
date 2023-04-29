Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B036F270C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjD2WwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjD2WwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:52:07 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B017F1BC2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:52:06 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 8FAC91282;
        Sun, 30 Apr 2023 00:44:05 +0200 (CEST)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:references
        :in-reply-to:message-id:date:date:subject:subject:from:from
        :received:received:received; s=dkim20160331; t=1682808245; x=
        1684622646; bh=IeHcnYGT8x5oIMpt7vaj6WJo5TzDUMMrc5PAh+gHWeM=; b=N
        U5NnRoNGy7ZB6Jtwdyvuy2WmjMRd3mK42iP4ePyTyvcs3Fwj433io5R+OCdMGNM2
        h2YnnVLOHN8r/kEdkpwpHDMcb7+tNne1iPWMCoJx2SyL8G/lI7m3RCPHB9fEN1xW
        pH0+uGfbBOQgTj+j6kT80ReEuU2aO2yyDJi7xkrWOEtXOmTwA+g9/Z72SKNpiwAm
        m9lq0MwKTgh9cCWN/djDn9BCxfo9fvFA+axoX/UPgQsPfs48NC0Y5rf7mEvcI8mq
        r6OOju3UHZv/QNIlaQP5e+4PqOEDoGP7s/P/SoE2Hba9D0nNftJ8qVcFATvk8RaI
        Tc56YR0XMwUvJNrMZRiMvWU33D3LZtL+UoGZHEm5ouuuGmScL0q8bh2BkJ+JaKRI
        /rFrtdqkYH6dDXXrgfBSI3jmwEIsUzlARaqrQ4nqUWqe/BpH3pAM2NMWs81/UXKf
        l0EDg3j+72TEFnAVTJQ2Fgx1RU3ym6M/EBzF8TaARKh2BlMrQk9kuRLo+fMXvidt
        uqcblM8vrxN1gAO9NRI/9KNYW95CofF4RNcv2rsD+qVqf9DIhQAuxxwdFDwQFfgY
        iTZMScZYWbISv0cBuCEDh9QYIaL7AVI1D3FfddejcD85orl0LPy0a8zuKjdnoeLd
        zk/syeAUxfS7Cr/KRHLDpuDkVe4MLh4A/TKDhRRxfk=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6mpo8D4eXiKF; Sun, 30 Apr 2023 00:44:05 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id D8F6D126D;
        Sun, 30 Apr 2023 00:44:04 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 6E7A65EBF;
        Sun, 30 Apr 2023 00:44:04 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Date:   Sat, 29 Apr 2023 15:43:49 -0700
Message-Id: <20230429224349.1935029-3-alison@she-devel.com>
In-Reply-To: <20230429224349.1935029-1-alison@she-devel.com>
References: <20230429224349.1935029-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

Add support for the U-Blox Zed-F9P GNSS device.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
---
 Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index 4835a280b3bf..86b65d4d9266 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -21,6 +21,7 @@ properties:
       - u-blox,neo-6m
       - u-blox,neo-8
       - u-blox,neo-m8
+      - u-blox,zed-f9p
 
   reg:
     description: >
-- 
2.39.2

