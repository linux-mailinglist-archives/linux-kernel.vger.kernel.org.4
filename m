Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FAD6EBAA0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjDVRVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDVRVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:21:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8032212C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:21:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63d4595d60fso20046045b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1682184062; x=1684776062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/Iwxwf19giRiaEj5owcf/YVCgHFbeN6M1lbc9444FQ=;
        b=JhcABvhIW3GaMteWwLpvP3Hqr+PKPr65wM6hF2XYPgsbVIf5G3jUigiNV7UBMuO/OZ
         5VV208S3eHWQ88O5LcGnojDROcVJyh4vPE0U97yhevpbQ1/WvNxrLSMQmJL7psmYqubC
         iHcVAgxgqqoBzfp5OuCJ3IBb3jIaqvf4wOkeCpjwTqHP4X6WJeBRsdlHnZHUwMpeYFsy
         S4lxW+f47PyZrEDsAUHG1qJ99TgQushsf7xeNZoO4esAoF2M0ea/2UyARJJpXB4Gkd5n
         Px5Azge+0Pw32ZyLtg6w5snLZkJLata5KepdiGHDBv+TD/rgjBY1NnGqnX1yL3ANu4wg
         oZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682184062; x=1684776062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/Iwxwf19giRiaEj5owcf/YVCgHFbeN6M1lbc9444FQ=;
        b=JX1WEjynmgyRuU2QkNR5iD0j2JuiontVKECTb6sQSuuB9k3fP0Zm5lQJKd6XVYl93T
         idW2Uuxy0AynIuDoOJbULb+PCAlv/bFRM7zRv8BSIVg30wvrf1QxPgYFbS8A+XLCpGRb
         D3scqc3Qq8zBCUmt2mGPW3UuX4CUadh0S8rG68zZ5+7qSw/pZDoY9coHa3GQv4XnYnOH
         zWdkeTIDcNjGxLXJ9jFCluWV07z4nVVDQB2xI/tyqUnTp5TMoeOID/5bh6lsReW4bgAT
         Kdaxt4LvQ5vaDpKIF2c8vA/PfLkTc+X+Vc6iSMskSdQzMp5rp8e6z/ZWN8574K4SlSa7
         lY8g==
X-Gm-Message-State: AAQBX9c1R+hvmT8J5XiqCluxWOmOrUsM7TZXAjX2KBHqjjo9luZIn0aq
        rpLEG9nXBerTGjNvw8cbhFGS7Q==
X-Google-Smtp-Source: AKy350asm2xC4ELk9HOxk7QtNVh+S4xezinZtxnPHSV0fB2CGfYqFycRx1aGPk56NPBu5P8sTvQ1pQ==
X-Received: by 2002:a17:902:cecb:b0:1a6:8527:8e0f with SMTP id d11-20020a170902cecb00b001a685278e0fmr9432486plg.10.1682184062380;
        Sat, 22 Apr 2023 10:21:02 -0700 (PDT)
Received: from carnotaurus.. (c-73-252-184-87.hsd1.ca.comcast.net. [73.252.184.87])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709026b8800b001a04ff0e2eesm4261673plk.58.2023.04.22.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 10:21:01 -0700 (PDT)
From:   Joe Stringer <joe@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        bagasdotme@gmail.com, maxtram95@gmail.com, john.fastabend@gmail.com
Subject: [PATCH bpf-next v5 1/2] docs/bpf: Add table to describe LRU properties
Date:   Sat, 22 Apr 2023 10:20:53 -0700
Message-Id: <20230422172054.3355436-1-joe@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the map type and flags for LRU, different properties are
global or percpu. Add a table to describe these.

Signed-off-by: Joe Stringer <joe@isovalent.com>
---
v5: Use bold rather than verbatim for column header
v4: Initial posting
---
 Documentation/bpf/map_hash.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
index 8669426264c6..1314dfc5e7e1 100644
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
+**BPF_F_NO_COMMON_LRU**  Per-CPU LRU, global map   Per-CPU LRU, per-cpu map
+**!BPF_F_NO_COMMON_LRU** Global LRU, global map    Global LRU, per-cpu map
+======================== ========================= ================================
 
 Usage
 =====
-- 
2.34.1

