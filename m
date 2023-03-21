Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474006C38EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCUSKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCUSKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:10:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BED21A12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:10:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i9so14638613wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679422213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CcTyMNvBbaopJZP7W6LTt5OpFhIYB8Xn1nXJQSlLefI=;
        b=YPUUkli16izZ5m5JbGXAKg0IxA1wX2n/dqT6FwqvDqUfy+cRCWnZOuI893AgMF34aP
         ie9S29Jog54ei/mK8n6KuVSdDgtoIt7EY9QUS0yIobYtyxZWFimuLneyMugIwl4iEf6h
         DAsSp0MQwaRO0k0rulxFcGd+UG2GzF2ryVkk77AXNmQ+ZM+GQMiwjz/fuGOj9n4TrD9H
         w2JE/YiK+bpK4t/Ny5h7FSBuUpgV7aqbAplkzS8ZF++HB8HlRPbvbo6X+wkMSq383UMV
         85D9exBKrsA4vw9ZovrjP8JmgeutduWGh51AmjwMXdpuis6ONtb1k4Qdap0Uq1Fx8Fm0
         /BfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcTyMNvBbaopJZP7W6LTt5OpFhIYB8Xn1nXJQSlLefI=;
        b=EpuqG5WvkunBQxcZGznUOH0bq5sQWTZhEfrQhtBqcZN0H6dbjp70anFLYUZtyAqdBw
         dgfPhBOeZBGXle0Exb2Z1rmnQFU65VJJpDSWmrzcd48cr4XDpY4m5BZSxsxkZ/qSxI71
         TaSlivwveFPdcObCSSV6xrnD0lmmSEaiLUxTjrOlz2KOXbzawjY8DGU0CBQtN73nlMRu
         i9P3vyIJlSvcOzvtHQAlcLpTBGH0s4CRm0hermsL8plqNQVZLn28dyLWGWv/vK/QLfhx
         vsQFM7YTzQkqIHs1iitk13u+89JOVIOG1ReAH8WxJt+FgkXpKeKhnHJ/SlOVbjKM0tQC
         WaEA==
X-Gm-Message-State: AO0yUKWZfnCkS+57/7ghT3f3+BAOb02tmSZAB/Amny1Bh9Xwl1JEn1IE
        H8lt6qMS8As2KpHtszW/67Q=
X-Google-Smtp-Source: AK7set/Gu857TQGoYOTPU6EQouhqZy2GyJkobL7p3w8DsFG9d2WPaNeMIrq+jLnw6UO3i3BlYKMObg==
X-Received: by 2002:a5d:55c6:0:b0:2cf:f314:774d with SMTP id i6-20020a5d55c6000000b002cff314774dmr3289104wrw.44.1679422212616;
        Tue, 21 Mar 2023 11:10:12 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id c10-20020adffb0a000000b002c70c99db74sm11858260wrr.86.2023.03.21.11.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:10:11 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] MAINTAINERS: add myself as vmalloc reviewer
Date:   Tue, 21 Mar 2023 18:09:55 +0000
Message-Id: <55f663af6100c84a71a0065ac0ed22463aa340de.1679421959.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently been involved in both reviewing and submitting patches to
the vmalloc code in mm and would be willing and happy to help out with
review going forward if it would be helpful!

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b79463ea1049..69d19130af2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13419,6 +13419,7 @@ VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Uladzislau Rezki <urezki@gmail.com>
 R:	Christoph Hellwig <hch@infradead.org>
+R:	Lorenzo Stoakes <lstoakes@gmail.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
--
2.39.2
