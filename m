Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4F6D33B8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDAUHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDAUHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:07:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0368BB76B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 13:07:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f22so20456046plr.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680379621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55VzfyOLyKrmQayXTe0Ok8WFjIJZ8kHqyvefO/NMooI=;
        b=DLJRLpPzbqyNUw3Abs2sFgLvaXGi7PRyYhglY8RJuMhT2bGzYs13qdo9vcHy8Vbayb
         yqBSVM1y/zkE24q+o5FlsaacfP9aN6BG8wUosiwARFc0lqLqvuQ1i6grWf3G/8KWHbQf
         z3qjzED4miHFq/H8fCtMv1YkaRDARVK3SXKVlmfrToTx+VFIWzCH5u+/8jPKv8C9Ulla
         6yGsfl2NxWg6ylwO8+M8rjmNYnaBZ/QurAjEFPa37ljGSwahhJRc8HNFQtKBiR+QUndY
         MoGDMhVxdRdoCOqzMlZkTIYAAc2iHTgt6uJMiZvVK07dyRtA/cbz3bYfRNiY0LIP6Q8h
         JhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680379621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55VzfyOLyKrmQayXTe0Ok8WFjIJZ8kHqyvefO/NMooI=;
        b=dywRArPPqdm1F8kTFKg8IIDGqfdSUA1z0b4iPr+asnqXPNVd+0n6bzg+uV3F5w5wCh
         XJg2ziJpRQobbjros0xEq05hZ/QGMg1jSkk8gK0SVv7bOSfBpmgRIxHbJDrMD3+jZpng
         EFbivshCRdMPyVZvt1y8W3T/NjWCLcEqdW4RxyWQv959Wd/CDwHbBIcXon2dwHREsqLq
         WScIN0FR1BxWwCqnUthZehGY0ECbvWngfhsNs/bFItlGBSGt47ah88/p7NUiFiag+EK3
         3YV3lQLt8mNOpiHnE54jroU1nCVOGh1CJrTg2/TCJwc7Yxps9AbGxrRgjdRn83Jza1ZQ
         rRdQ==
X-Gm-Message-State: AAQBX9c4bD7P1OPbQ0ner/TcTHPKZjeQB3f9rrR81L2k9MKcb89Oi2jA
        MyAPw1OTK+JJhEsNiJBxcygCbw==
X-Google-Smtp-Source: AKy350Yh150VuTm0LhLpmUKQjFb0pncHhOGcACN5SniiiqnWOt5ZEt7LBALpW0X3mPg826OWUDIPXg==
X-Received: by 2002:a17:90b:4c4a:b0:23b:bf03:397e with SMTP id np10-20020a17090b4c4a00b0023bbf03397emr36423906pjb.24.1680379621427;
        Sat, 01 Apr 2023 13:07:01 -0700 (PDT)
Received: from carnotaurus.. (c-73-231-147-44.hsd1.ca.comcast.net. [73.231.147.44])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090300d400b0019f27fd7cecsm3715438plc.197.2023.04.01.13.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 13:07:00 -0700 (PDT)
From:   Joe Stringer <joe@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        bagasdotme@gmail.com, maxtram95@gmail.com, john.fastabend@gmail.com
Subject: [PATCH bpf-next v4 1/2] docs/bpf: Add table to describe LRU properties
Date:   Sat,  1 Apr 2023 13:06:50 -0700
Message-Id: <20230401200651.1022113-1-joe@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the map type and flags for LRU, different properties are
global or percpu. Add a table to describe these.

Signed-off-by: Joe Stringer <joe@isovalent.com>
---
v4: Initial posting
---
 Documentation/bpf/map_hash.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
index 8669426264c6..45d923cd16c4 100644
--- a/Documentation/bpf/map_hash.rst
+++ b/Documentation/bpf/map_hash.rst
@@ -29,7 +29,16 @@ will automatically evict the least recently used entries when the hash
 table reaches capacity. An LRU hash maintains an internal LRU list that
 is used to select elements for eviction. This internal LRU list is
 shared across CPUs but it is possible to request a per CPU LRU list with
-the ``BPF_F_NO_COMMON_LRU`` flag when calling ``bpf_map_create``.
+the ``BPF_F_NO_COMMON_LRU`` flag when calling ``bpf_map_create``.  The
+following table outlines the properties of LRU maps depending on the a
+map type and the flags used to create the map.
+
+======================== ========================= ================================
+Flag                     ``BPF_MAP_TYPE_LRU_HASH`` ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
+======================== ========================= ================================
+``BPF_F_NO_COMMON_LRU``  Per-CPU LRU, global map   Per-CPU LRU, per-cpu map
+``!BPF_F_NO_COMMON_LRU`` Global LRU, global map    Global LRU, per-cpu map
+======================== ========================= ================================
 
 Usage
 =====
-- 
2.34.1

