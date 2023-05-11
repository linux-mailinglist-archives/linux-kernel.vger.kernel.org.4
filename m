Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810376FF7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbjEKRBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbjEKRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:01:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B54E57
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:01:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab05018381so82307945ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683824506; x=1686416506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiNPfQZ2SsTlTZ73Scqtrooa5dsdeP/h86336+fdM1I=;
        b=btXNXw42KXxaiNsJfsqp5Wn/dVNYLwALdAKbsBkh72TWh49seYq5HQC2VAXmesyVIq
         RQizzGe1z14+Elg2CtqSOHZSGJ2O/8ajGCUK/97zqwP8TWERhC7H5GtimBpTHCvrI1az
         NoiTUVsB6QX1uN/Y5a09s7En+QHiE3dROXxFmtZsa+sMrH5E8tPFrfdQCKGufOGpVy2e
         ZMxAyNOZs7D9JLraOVC9YAFr0/iGCM+ZTfBp/Lgb4GG7CfEhlCfwakIMYtTY0rfuCeAY
         gL6FUvDP5Uz8T8e0yWRXaNhO3w4RPcgUTiyuM21VVDATl5mP29FwEu7srA9YPtk1AknF
         G/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824506; x=1686416506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiNPfQZ2SsTlTZ73Scqtrooa5dsdeP/h86336+fdM1I=;
        b=h/NXHf+r7hUX1WA6GdZjnNtMoz9lVPBhSFLqa+Ku4920YrK5b3SG4Go3AwxsgNqYV6
         nkBy8huTqP8CZTcG106Rtwnr3uxjXMNSJm/nuFIvgHDSj4O/5sSE0e959nhYhTmjZX6G
         ru9wvTz7p5aqQ+jW6ak30f5neEu0JFo0ifr1l/eWZUTJXT+pp2UkEq+0V2vRt/r4wA6G
         zOJAO7r7DDDtxiertrAfQYhGOtM1YvXAHUNLjDwcS5kysBMt0ZjydmBszKrKKOjYbxiR
         Rp36oToxptvSYTRDzN9rj78Fq7oYSsqrHVPyUKbpYd2kDKcbe90ZWvpyjuVYy9EwQKqS
         y1rg==
X-Gm-Message-State: AC+VfDwWP3ZisBInKWbK1/ilh1bc+jkH1fF/AyjwnnhWSC5Ue8sW3TQV
        ctgypKzrAxgQiw4Ufa4rgo1K6CCR1kw=
X-Google-Smtp-Source: ACHHUZ4o0Bf3QbfPBXc9XNpV2pcC/+8tTbPve3WNz79HOKvxqC66aXpXZ2bTOl5FJ50kdm9rHhXDoA==
X-Received: by 2002:a17:902:f7d3:b0:1a6:dfb3:5f4b with SMTP id h19-20020a170902f7d300b001a6dfb35f4bmr20711948plw.55.1683824505778;
        Thu, 11 May 2023 10:01:45 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-94-72.dynamic-ip.hinet.net. [36.228.94.72])
        by smtp.gmail.com with ESMTPSA id r7-20020a170902be0700b001ab0083c6c9sm6156240pls.261.2023.05.11.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:01:45 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARC: fix incorrect THREAD_SHIFT definition
Date:   Fri, 12 May 2023 01:01:38 +0800
Message-Id: <20230511170139.343434-2-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511170139.343434-1-minhuadotchen@gmail.com>
References: <20230511170139.343434-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current definition of THREAD_SHIFT is (PAGE_SHIFT << THREAD_SIZE_ORDER)
look incorrect. It should be (PAGE_SHIFT + THREAD_SIZE_ORDER) because
the following equation should hold:

Say PAGE_SHIFT == 13 (as the default value in ARC)
THREAD_SIZE_ORDER == 1 (as CONFIG_16KSTACKS=y)

THREAD_SIZE == (1 << THREAD_SHIFT)
            == (1 << (PAGE_SHIFT + THREAD_SIZE_ORDER))
	    == (1 << 14)
	    == 16KB

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 arch/arc/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index 6ba7fe417095..9f9dd021501c 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -22,7 +22,7 @@
 #endif
 
 #define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
-#define THREAD_SHIFT	(PAGE_SHIFT << THREAD_SIZE_ORDER)
+#define THREAD_SHIFT	(PAGE_SHIFT + THREAD_SIZE_ORDER)
 
 #ifndef __ASSEMBLY__
 
-- 
2.34.1

