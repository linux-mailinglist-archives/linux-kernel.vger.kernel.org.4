Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CEF6D6E83
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjDDVAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbjDDU74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:59:56 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A418469E;
        Tue,  4 Apr 2023 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aEJvhdz8vFgj+pWW6Gpsk1VWZm3g73dhXzFqGRKbxbI=; b=VmvKJQIvSX4/Oq148L9Zf5TnYB
        fQIH0MiOuqhTq4MjxO4da9RjxW6bg9vRqGRSzoLvWYcfKVtQ8VYn6ebvytdM28ljHkyrw0Wkg6ZIq
        wNolvEvCw028oas1dzwZ+NWYOUSrrorsHCpr4Q97fb0ig9ouyJ6PU4UlvKHPN5MpugunWgFpFRA5/
        P5KAQ42npTweD149avzHfnshio7FZFn4f8xMC4DJzMP2n9oAKvU4KYhgv/JOz+985kjeiz3Pv8TdT
        8pT2JHnrWAduOyAse3xdub4LldrwPIMQX3Wh9LqQrF0g0g/uSUa3THHQ+W87IXj0sCdhrN6KGL7xr
        TD1OVWCA==;
Received: from p200300ccff1e1f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff1e:1f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pjnki-0007u8-JY; Tue, 04 Apr 2023 22:59:44 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pjnki-00EuLc-11;
        Tue, 04 Apr 2023 22:59:40 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony@atomide.com, afd@ti.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v4 2/2] MAINTAINERS: add board bindings list to OMAP2+ files
Date:   Tue,  4 Apr 2023 22:58:44 +0200
Message-Id: <20230404205844.3553159-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404205844.3553159-1-andreas@kemnade.info>
References: <20230404205844.3553159-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add list of OMAP2+ boards to the corresponding section

CC: linux-omap@vger.kernel.org
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40e26624ff24b..c41476a7504cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15363,6 +15363,7 @@ W:	http://www.muru.com/linux/omap/
 W:	http://linux.omap.com/
 Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
+F:	Documentation/devicetree/bindings/arm/ti.yaml
 F:	arch/arm/configs/omap2plus_defconfig
 F:	arch/arm/mach-omap2/
 F:	drivers/bus/ti-sysc.c
-- 
2.39.2

