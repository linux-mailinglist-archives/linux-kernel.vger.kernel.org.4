Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2961C5E9632
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiIYV1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiIYV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:27:23 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5292F2A432
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:23 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ml1so3345144qvb.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nBwF90pcIfh6GRwU6cpt0vmJWG9cDZH3z3WIrcLz5YE=;
        b=S7qexel6XAlqCjwi0wVqr6YuctHF0rOMPW2kQOhOOmUj/VpV1LZpJFTBEijtulu8IY
         OC/LhuHHbU5tdQXMe+LCi3WaInfbVb5dYef9PelYdG/trH/M2pQxXdppPx0skjitcY3s
         HXPB/BldM1a41/04mQwHfnDCYbk+5PSiWz63D2sxXF1j2cYuUg8pFw7XKINBexC/WxcX
         Lq6SAbrKU64gscU/ZfFubU5OQbPfLB8ZO9uABmFfcW2iE2mnw+AboYV2nlVZKJJC3Pva
         fj1phH+j5kAvpiwJ2B5WX93njWtzof2iY1crCGrb6OSJRGap08u/oRj4+FMe84TAgH3v
         R2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nBwF90pcIfh6GRwU6cpt0vmJWG9cDZH3z3WIrcLz5YE=;
        b=Zsnq8bYlkJ6aNCkZKUf2fbWwhLMqUQfDKuL8Ny9gUPO1f+H6Vdpoiez1AYViyeNa75
         15fxkq5wA6VwItwRE2mYa+SkqovXwtPZrMucwWYhoBN+UqbIf3Dz0CPeUupE2LWRZWW1
         OAAaBHdig+ew5a4KDRFX+jRO2jITEOgHzwkTfVF7+Qnpt+VWRRvxYKNCSPVQPIbLysnl
         xGAtJzCKHmaVGYPXze1QjCXI5BgPBookOXDXtrO2Is/vjaQzC/gd8o084KX8DViy963x
         Xi+KE1R4ydkHgjb2Dk04aHGnWSE/hSna1oGTyudeuVLggPMP+pjxKqauVbKQk66vqwVy
         ydNw==
X-Gm-Message-State: ACrzQf2msVX05PbBB5bQZVeBaVLrw/PevQztpAm6zpB8i3tY7oN0jy0P
        JaxnNPOC50Hl2sG+2OTtbB8=
X-Google-Smtp-Source: AMsMyM521toHgaGeHmadGVf7o9XYpOKnTERJaKheVqX1yAuxvvOxju1bBkWyRS1xAAduB6Z5QCWUPw==
X-Received: by 2002:a05:6214:4112:b0:4ac:6d95:1037 with SMTP id kc18-20020a056214411200b004ac6d951037mr14695393qvb.14.1664141242295;
        Sun, 25 Sep 2022 14:27:22 -0700 (PDT)
Received: from sophie ([185.156.46.189])
        by smtp.gmail.com with ESMTPSA id t14-20020a05620a450e00b006cbcdc6efedsm10776194qkp.41.2022.09.25.14.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 14:27:22 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 5/5] memblock tests: remove completed TODO item
Date:   Sun, 25 Sep 2022 16:26:56 -0500
Message-Id: <5df0bb56e4f32ae2734b7a74c65530d84012b4de.1664138929.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664138928.git.remckee0@gmail.com>
References: <cover.1664138928.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove completed item from TODO list.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/TODO | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
index 33044c634ea7..cb7fac47a643 100644
--- a/tools/testing/memblock/TODO
+++ b/tools/testing/memblock/TODO
@@ -8,10 +8,5 @@ TODO
                 likely that the current MEM_SIZE won't be enough for these
                 test cases. Use realloc to adjust the size accordingly.
 
-2. Add test cases using this functions (implement them for both directions):
-   + memblock_alloc_raw()
-   + memblock_alloc_exact_nid_raw()
-   + memblock_alloc_try_nid_raw()
-
-3. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
+2. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
    for the new region
-- 
2.25.1

