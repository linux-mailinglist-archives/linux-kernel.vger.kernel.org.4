Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF6634B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiKVXhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiKVXhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:37:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5CFF41
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:37:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id ci10so8322838pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney.org; s=google;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXREoY6IalOfAmwpvzIhPYj8XLXiTvIZQIbuCU5nvp8=;
        b=Jk5QE8gqF/vU8ZoSNIYM4ZebM9hf4ktQVyAE+s0TfAxdJug0x59/Qzx4Rqdvo+Qufw
         YepypkzF23DBfv7E6W2VBvVO15IV2+NP3TwNq2+ShmIy42vEK00eEu8+zffD5p+M85Qr
         EpmnZMrqFgo5risQhcy/MGYxF1xwj83wI22DATkvgm52IXOJR33bq5PyZzUn1mOD7HFO
         TtnY8MVFTtjSumXzdtpzZ+t48WuvfbxQDWx1ESpe1g3CArHeBvMuEYcqLoX6NNuakyDY
         kKgZU0G8M1yX7fisvzz/MDItPh2uoS72GbZI3+SV7rTEXAl5lwODK51f7aO151soa9N3
         bUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXREoY6IalOfAmwpvzIhPYj8XLXiTvIZQIbuCU5nvp8=;
        b=r+z4ljq1N5xbrwNIOirZSCVta8L2yn2cqbHQMivejOG3s4S+oNsaO2iTWFOja3sK/N
         fvlD89zS2rLGEoAw8MauqxQtvSJqiYq/tmBDCc7SOa/2eRmHCnFP81Sdn2Jahd2qKYiV
         4Brv6u7a3d1GjFYwn79AYO4B8nqzd/Qj+RlHAQ7YclXyINcLnxxSXzVxvk0JqHlTA6FW
         Ixg8tcDy3Idb3ZTpFeAHRIF77YWNGFpWFVvUY4zCYswpuhADcjRXQkBEM5iLnu6shZmg
         hSh1MJ4C12ndagE9NzvZHV2jUBH5t5JkiTuhEI29h4gC5cA1o5u6gGJF2JGROoAnACx/
         WuZg==
X-Gm-Message-State: ANoB5pmXkrc5bWtCFN/IEiULGpNaTXSWMj0LLtuZk0rlGClhZVQR9zA5
        f7h6F2mmsjeJ7ZDwfwEviN4yvA==
X-Google-Smtp-Source: AA0mqf4/ZfGw6ah0ZdB0vb6fgNjKwn2A5f3Nxw/l0DoQ6OgcoSbP4IVaXMfmB1VStvnuGl5C+y3ZEQ==
X-Received: by 2002:a17:902:db09:b0:188:7dca:6f4d with SMTP id m9-20020a170902db0900b001887dca6f4dmr19411533plx.68.1669160248980;
        Tue, 22 Nov 2022 15:37:28 -0800 (PST)
Received: from localhost ([2601:647:6400:20b0:5605:dbff:fe00:eccc])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902c40600b0018911ae9dfasm7935927plk.232.2022.11.22.15.37.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Nov 2022 15:37:28 -0800 (PST)
Message-Id: <381fbc430c0ccdd78b3b696cfc0c32b233526ca5.1669159392.git.mforney@mforney.org>
From:   Michael Forney <mforney@mforney.org>
Date:   Tue, 22 Nov 2022 14:18:25 -0800
Subject: [PATCH] iommu/amd: Fix typo in macro parameter name
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Michael Forney <mforney@mforney.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IVRS_GET_SBDF_ID is only called with fn as the fourth parameter,
so this had no effect, but fixing the name will avoid bugs if that
ever changes.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1a2d425bf568..099ca3ed7d73 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -85,7 +85,7 @@
 
 #define LOOP_TIMEOUT	2000000
 
-#define IVRS_GET_SBDF_ID(seg, bus, dev, fd)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
+#define IVRS_GET_SBDF_ID(seg, bus, dev, fn)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
 						 | ((dev & 0x1f) << 3) | (fn & 0x7))
 
 /*
-- 
2.37.3

