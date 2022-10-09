Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2385F88DB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJICYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJICX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:23:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98C636093
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:23:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f140so8088777pfa.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egU+pR1mu0fbwNOlCXxgUzq7eQbUYmzREvrHjyDBDLQ=;
        b=FdWJE/6vRDAn8HvbajJRjlWuKGPVVZTR6WsylqPO2APZ8f1RcKp5K9kqCiARH3Xq9U
         V5EnxnOTuyjLZ7nraOZ4hJL9HFQLuXXTypF7DuSg78Hcl7eB2DQNVtm+VEsqbLqrScXj
         bqfp0HFPy7pjoofF2hiOk6+zjPrkxK2WWrVo08cy6Kso9D7Jpt84VbaHa4i/ZFRw28hr
         4bswpnvPHNEPsOAIFef/2tH3zUYktDeBjOuFnxLHWuduMLfLYK5iTU6Gvd7Ycf7Gt80x
         cKmq/IlFz6SJSzpOfSDUEsLvV/45SjvobCKXVcHSPntydwzKr+D82DPMsZtbETHh1mbN
         5Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egU+pR1mu0fbwNOlCXxgUzq7eQbUYmzREvrHjyDBDLQ=;
        b=D1CaahxHlEjp8+MLpvnfywQuAeqeYAKgEwQq+F6z3vVN36uXPuLCurOqiptNARpJcg
         IltkVBXXlX3tiOd26mmcB4Mi/Hw9GbvJG1eDO8VJineJHzIqEo91BTMPsoVXoLABk/ya
         7vb6sg2l1rfFuBV7mDlgkTZX5FXGbSU3YLx1cD6tJc8Tu5JnsQALicVsCZAPi/55HzVb
         qbyT3PLI1EAwjMQxo4VU/EnteZ+Rg2c9mOUE0tCkncQiL7FprYBb4QcK1D/uXz52Nyji
         gCjofBWepDtTi+vPnNp6Ag0ePVIKc4OL4/IMyJFnFjTMFkFRIpS8du0gb+vwpDVEDjxr
         BTNA==
X-Gm-Message-State: ACrzQf0ZANZedcfyTtyjlzjejjahIiKVstzrMwQo1TawN6MYJjL2xU3X
        JRZjXM3CuT3JSacuY0WhfAbGyropogI=
X-Google-Smtp-Source: AMsMyM7o7JzcVNgFATm6Jdoddk7BfGlH243B6v/ltjwvoqVHJMMH9h0GiNCq1I8FeHbulnNpJtrPyA==
X-Received: by 2002:a63:ed0a:0:b0:442:2514:95f5 with SMTP id d10-20020a63ed0a000000b00442251495f5mr11113497pgi.402.1665282235332;
        Sat, 08 Oct 2022 19:23:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b00177f4ef7970sm4018521plh.11.2022.10.08.19.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 19:23:54 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 5/5] ksm: add zero_pages_sharing documentation
Date:   Sun,  9 Oct 2022 02:23:49 +0000
Message-Id: <20221009022349.315482-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009021816.315205-1-xu.xin16@zte.com.cn>
References: <20221009021816.315205-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

When enabling use_zero_pages, pages_sharing cannot represent how
much memory saved indeed. zero_pages_sharing + pages_sharing does.
add the description of zero_pages_sharing.

Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/admin-guide/mm/ksm.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index fb6ba2002a4b..484665aa7418 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -162,7 +162,7 @@ The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
 pages_shared
         how many shared pages are being used
 pages_sharing
-        how many more sites are sharing them i.e. how much saved
+        how many more sites are sharing them
 pages_unshared
         how many pages unique but repeatedly checked for merging
 pages_volatile
@@ -173,6 +173,14 @@ stable_node_chains
         the number of KSM pages that hit the ``max_page_sharing`` limit
 stable_node_dups
         number of duplicated KSM pages
+zero_pages_sharing
+        how many empty pages are sharing kernel zero page(s) instead of
+        with each other as it would happen normally. only effective when
+        enabling ``use_zero_pages`` knob.
+
+If ``use_zero_pages`` is 0, only ``pages_sharing`` can represents how
+much saved. Otherwise, ``pages_sharing`` + ``zero_pages_sharing``
+represents how much saved actually.
 
 A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
 sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``
-- 
2.25.1

