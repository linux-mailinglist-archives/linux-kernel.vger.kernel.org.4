Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5A602B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJRMDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiJRMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:02:31 -0400
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA1BEAD9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:01:27 -0700 (PDT)
Received: by mail-pf1-f196.google.com with SMTP id y8so13821717pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0jiE6G+beoQsyJkTi8DfZte8UyVW5LiFJH4O1RCA1M=;
        b=BWZQCJZprj6JVgsYTcQNog48I9ZJwgP/Wz/fCjhl7un7cUVrwZohQKq2KlQp3kmO/q
         podF/tLEfSmUxwLgVM0Ve4C3JoAtuSLsrICofiCOf5HilAuj08LI9I+DBjqq8Dows2jg
         zJVJq7Y0XWptvGsrfpdIt+ZOsUC8euaneR3/qzwBHlhPgSp8aIdduarVezALTCWP+ckk
         8AZRa8gO+fRMCL4C9GTECDlDPYMMKbPNsfyPYGqudjQKojt0NjyDqyjreNVwtQGZTAfl
         g+bh/rFVb+qyYz3Ech7mB3TVrFFl8FRII8Ay37cpUpnXf1Y6aRLnsxSijwXAbNpebvCU
         ub0A==
X-Gm-Message-State: ACrzQf3S5wkftv3aaVVwL4CN0sYaGG/GiJi4+Y4UXBtbvaEl00z81JVo
        M0MxZb9j/n8bOmOvJfwpaQ==
X-Google-Smtp-Source: AMsMyM6QmN3oiQ60nOFLZVsqEqZaRFYhva+6a+ix3xTcZUqE+KlSRclrXuikvR2XVy6Yqp0QfV3OZw==
X-Received: by 2002:a63:2bd5:0:b0:434:ea9a:ace2 with SMTP id r204-20020a632bd5000000b00434ea9aace2mr2357040pgr.323.1666094486975;
        Tue, 18 Oct 2022 05:01:26 -0700 (PDT)
Received: from localhost.localdomain (ns1002484.ip-51-81-243.us. [51.81.243.185])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b0043b565cb57csm7893851pga.73.2022.10.18.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:01:26 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH 1/5] tracing/histogram: Fix incorrect description in histogram.rst
Date:   Tue, 18 Oct 2022 20:00:52 +0800
Message-Id: <20221018120056.1321426-2-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018120056.1321426-1-sunliming@kylinos.cn>
References: <20221018120056.1321426-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b94bc80df648 ("tracing: Use a no_filter_buffering_ref to stop using the
filter buffer") switch the hist trigger to not use absolute time stamps but
left the documents incorrect, fix it.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 Documentation/trace/histogram.rst | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index c1b685a38f6b..5eecf2e1c2cc 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1667,12 +1667,11 @@ features have been added to the hist trigger support:
 
 A note on inter-event timestamps: If common_timestamp is used in a
 histogram, the trace buffer is automatically switched over to using
-absolute timestamps and the "global" trace clock, in order to avoid
-bogus timestamp differences with other clocks that aren't coherent
-across CPUs.  This can be overridden by specifying one of the other
-trace clocks instead, using the "clock=XXX" hist trigger attribute,
-where XXX is any of the clocks listed in the tracing/trace_clock
-pseudo-file.
+the "global" trace clock, in order to avoid bogus timestamp differences
+with other clocks that aren't coherent across CPUs. This can be overridden
+by specifying one of the other trace clocks instead, using the "clock=XXX"
+hist trigger attribute, where XXX is any of the clocks listed in the
+tracing/trace_clock pseudo-file.
 
 These features are described in more detail in the following sections.
 
-- 
2.25.1

