Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F12697987
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjBOKIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBOKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:08:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212F2CC5F;
        Wed, 15 Feb 2023 02:08:12 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id d40so19978615eda.8;
        Wed, 15 Feb 2023 02:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6MCLus7og6tH4wyNJPR/gMALnQD+WF5etbQB128KZw=;
        b=d3mwB5owrz8EKeNgg8t0aARG54UPa0BBrGXl59LsISXfpTki/raaEZKUATx1vF34Mw
         e2DqR1iOhcYAOYDPKvq2XOOWSNEPzgy/YxsYdH49e4nkTFWXhy/0J6GhefBeHpfLZSZ8
         p2uSTf66hDOSPpZ6Jh1Gz4gnSt6EklWCKD5r3aV2gtvqwNjl3woGUinT56yLegkgkVQU
         cd3IQz4LZ9qB3g6x+dhv4Rb2X2A4KCOomGFCeCctMvn5b6KiPy8tyoKkTaCVgKhKlYRx
         p8ALh6CIGqNfECOKGFoYCgEVAzqToweKpUtX7qPBOKkAedwaLwP49nqy7N0Qyx9CgTxQ
         M09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6MCLus7og6tH4wyNJPR/gMALnQD+WF5etbQB128KZw=;
        b=y4ihc1PscV5rmrWkI03CurEh2Je3r3CMtj+SFedSxev1dBfB1A0IDX0y8sk8fGzdkW
         PMYl0SkCPhXQzPMinC9U1CkChTV2ZbdgijhviSglhR5gP6IdlXQIBPq2VRBEw31++Tvr
         +AoamnH1TItGiqhPuhNrggSovpyZeWQBUdAtPd2a382qfQ7CONf9s98ztaXp6z8c8xg2
         vuwCIvF5Wtgt3pXpHq/TNR+7IHMErlX/0FSPc1EXefzKEwCasB/rIhRh35aUiEWFOKzD
         LmuZo7wGC9DNKJHH8AnJxtjSGx/8jFJ41dx8joNEZXoYhH4JIBxpx9Q3tXKFAriCRJ8A
         7f6Q==
X-Gm-Message-State: AO0yUKUveRCxSyZ/aHdn4oohA30oy7A82dMcKEKZkFNwO+9guz79DSch
        EQOgbTmtUaygapqe8le7HKs=
X-Google-Smtp-Source: AK7set+jl73xD3wOWKJkZohFLNswWW494tqPrziSN7TM8LbEHBH9mqWWUh9VybAtGt5Fs6rp5pC5Jw==
X-Received: by 2002:a50:ec85:0:b0:4ad:66b:84a6 with SMTP id e5-20020a50ec85000000b004ad066b84a6mr1308568edr.13.1676455690998;
        Wed, 15 Feb 2023 02:08:10 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:983e:41b3:46f3:e161])
        by smtp.gmail.com with ESMTPSA id g21-20020a50d5d5000000b004acbecf091esm4715020edj.17.2023.02.15.02.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 02:08:10 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs/mm: Physical Memory: correct spelling in reference to CONFIG_PAGE_EXTENSION
Date:   Wed, 15 Feb 2023 11:08:08 +0100
Message-Id: <20230215100808.9613-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5d8c5e430a63 ("docs/mm: Physical Memory: add structure, introduction
and nodes description") slips in a minor spelling mistake for the config
PAGE_EXTENSION.

Correct the config name in the physical-memory documentation.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/mm/physical_memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 3f3c02aa6e6e..f9d7ea4b9dca 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -210,7 +210,7 @@ General
 ``node_page_ext``
   For UMA systems that use FLATMEM memory model the 0's node
   ``node_page_ext`` is array of extensions of struct pages. Available only
-  in the kernels built with ``CONFIG_PAGE_EXTENTION`` enabled.
+  in the kernels built with ``CONFIG_PAGE_EXTENSION`` enabled.
 
 ``node_start_pfn``
   The page frame number of the starting page frame in this node.
-- 
2.17.1

