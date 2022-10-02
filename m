Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36B5F273F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJBXmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 19:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiJBXmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:42:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9957B32D94
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 16:42:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so8397431pgb.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nBwF90pcIfh6GRwU6cpt0vmJWG9cDZH3z3WIrcLz5YE=;
        b=FaTigLz8IORgfJoMn5fUUHTGlPYGPvZu3GjLKbHoXG6p1xC0618KmmUqAet84dw7yj
         1Jihh9K9koqMc2JL/sb3TkCkx0fjJ7IRFqBbQ5RJjK7hpPHU548inICnZvb3moNqKSYu
         gh8NqwOBe63qJIY2dV/F2CmpSgBYcaP/+9PEHpp7JLSbZPYLPMhKN1ZDOn1iGgqYVXNv
         U+rKaPL98HBuOSza6EBOKEHokW3UOb79EGzbbDDfTGdd+IQSAmguHefseFnOjO/tM5F6
         /+R/d9ZpOdTCD+UiydTTo9r6COYTaEuP41SoRZ3RkPG9pgFvRkthZ13gYQ28Z53TI+BG
         COzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nBwF90pcIfh6GRwU6cpt0vmJWG9cDZH3z3WIrcLz5YE=;
        b=lH2oeYfXM/miKSy56/Fi/eVZlFIXfLGSldJjy9NB0doHA5hSwA6WxNhc7Kciqwtbgt
         TwJHBB1tDO46Mxf2sHJ47fPpFuJ/f7AO+zKd6tJOk6L0lRxvas1vrJqKm3GwudY1gbgE
         mimMWlMJEd7H/C/JbdWTwTIDuOoLZob40IU1tqh1iA7bghRcKGn5kgTYm2Mo8ZaZYtoN
         pGZCFaSlwlwg3CbXGlsv3AFfRrwh0YMNsvPZPZHGetu2K/Jan8k4PBFZbxJ1Cmhr19Ad
         XSSQ+QzymL1zwW8C3zUZ+rUKGOxAiSkxPxpIw+ZiG4DBh06K8lebQec+/oOn7knTvsPK
         64Hw==
X-Gm-Message-State: ACrzQf2A9y1mZBH2jfH3iZYCxoCwrmpLZhjPsIGKcZ3kRbZ1lk8is+Pu
        mOKcfa+eYUxqBCPUmTkSi4Q=
X-Google-Smtp-Source: AMsMyM4Z59BYphjBrlwx/7tFU9vLgn/N4C9Sme77ZwrfoMDCLGo1MXPXgLXVjaSETJsidR8dTmigEQ==
X-Received: by 2002:a63:1e21:0:b0:43a:b17f:cd13 with SMTP id e33-20020a631e21000000b0043ab17fcd13mr16481063pge.553.1664754126964;
        Sun, 02 Oct 2022 16:42:06 -0700 (PDT)
Received: from sophie ([89.46.114.181])
        by smtp.gmail.com with ESMTPSA id 21-20020a630a15000000b0042b291a89bfsm5308759pgk.11.2022.10.02.16.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 16:42:06 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 5/5] memblock tests: remove completed TODO item
Date:   Sun,  2 Oct 2022 18:41:38 -0500
Message-Id: <5df0bb56e4f32ae2734b7a74c65530d84012b4de.1664753535.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664753534.git.remckee0@gmail.com>
References: <cover.1664753534.git.remckee0@gmail.com>
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

