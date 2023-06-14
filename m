Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67A730802
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbjFNTU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjFNTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:20:55 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D02137;
        Wed, 14 Jun 2023 12:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686770450; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H9Used3f1rUY+MeicKUOFjtmWvhWi1ySBMGK4hWUDPfb0Ess51Zn1L0kn6oLa7KCES
    c66bxClua+I0W/AsDuN7vDqJou5sP16oIUerksxvtAAwnCehoa1zGC3vLG0a8DSSHyAf
    /BIjph+wwR9po5+II+ZzHDd1LG22ykP1nV/dGPvyGQirSC3k55Adm2sm2GqloUSe1Jyh
    NB4rMBBxVDWjk+jqLQNmf6sGQgbwpJFXV7DlFm/Q40TbskPOtNx+WnWsH6CV1XwC1jVY
    WLimTRJGQI76yJH6tL+sIs/KKXEKHMFEuPRuqVTiN7Obu2IlxT2NzirhXQ61olfVkxA8
    AbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686770450;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=UluM9+M229bqxNKRVyMbYxl7B1w1kAZMQitydXUBD28=;
    b=LX1+jTMNx6b/alGwho6Hc5NEj6rhNgW7VzcLoTy45n+tLx3E9Jd1de42Lc+YqMh17E
    Z7PSbTJflgu4x8ax1kNF2QzDilYbbK+bkUq9ZGL1R4un3dWrAB4UHSwK/E58SWhtOsKQ
    kL3gQCUIt8vYkMwrrVBqBYZF3YV0xmBqDxEPioYgqADH8hA1XXc5/ZGK+ebBa73/2b2T
    hSXxmvRtxYn8YKIdWqJJDVRWkNVLd6e+K58iAEaDwejTNsEJChH/h9AjkPUHHUKxvLUz
    YMQ6NFtNvX/RYnhfzM9skF0si3J+FKyearfD/sabWiV0OAHkA1YbRdbxaUnQdPGNTTSN
    bjVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686770450;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=UluM9+M229bqxNKRVyMbYxl7B1w1kAZMQitydXUBD28=;
    b=g7syv8W2y35nAZX50kYrrm3tfoG++XJKz8f5p/rigy3BltRtK4vL5TMuYszF1dwtse
    RufMsgIOEic/qkcj6bnu/5hJXDfChbQ1YUtMoyNbp5ZbOGjpxd9OkZtet9ivIrGu06eb
    FAx4KHKGXyBQu369DaIsfZlL1KsfTSfwpA9+UktwehWNVeMpZgOTCEqi4fEyz3yF90gF
    mn9vzsuG8Lo03aO7gBQTBYwvHyKOqF7znjlsZXi4dMnHw6dLt5YODu/4Ud3sU031qvFM
    noCiVSW28yZqX/KCbbRKSsYpRfBFcf6wrhB72V2IzBcJFU23AHCT/BNL9KnsEFcQuyrq
    JBdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686770450;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=UluM9+M229bqxNKRVyMbYxl7B1w1kAZMQitydXUBD28=;
    b=uujPduChBqw6UvhU+5eAOYzjNxBJui7UDaUDKg+a75Nab4ET2EAVTkP7v98EF9QCQf
    hOP/8HcWMipJCyuAnwCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5EJKo0ht
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 21:20:50 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 21:20:43 +0200
Subject: [PATCH v2 2/2] of: reserved_mem: Use stable allocation order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-dt-resv-bottom-up-v2-2-aeb2afc8ac25@gerhold.net>
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

sort() in Linux is based on heapsort which is not a stable sort
algorithm - equal elements are being reordered. For reserved memory in
the device tree this happens mainly for dynamic allocations: They do not
have an address to sort with, so they are reordered somewhat randomly
when adding/removing other unrelated reserved memory nodes.

Functionally this is not a big problem, but it's confusing during
development when all the addresses change after adding unrelated
reserved memory nodes.

Make the order stable by sorting dynamic allocations according to
the node order in the device tree. Static allocations are not affected
by this because they are still sorted by their (fixed) address.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/of/of_reserved_mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7f892c3dcc63..7ec94cfcbddb 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -268,6 +268,11 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->size > rb->size)
 		return 1;
 
+	if (ra->fdt_node < rb->fdt_node)
+		return -1;
+	if (ra->fdt_node > rb->fdt_node)
+		return 1;
+
 	return 0;
 }
 

-- 
2.40.1

