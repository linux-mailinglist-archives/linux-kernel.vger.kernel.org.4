Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3455640121
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiLBHkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLBHkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:40:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC22B0B60
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 23:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0dCXOpPa5VcMeZD1JNwijRb+T0fjwW9SfAbX9iBAGDs=; b=qWpfzOGP6CGenY9hd1tqbF8XY/
        aCaRmcznYx6ElAWP/AYmb8bTTRKbNiuNfMQkrpH5HTezKxsstTlZI6TixXX5Wb3SRTWTL9cVKugj/
        jRDxStqgCfaErZ5F3G3Ypf4uCoqXfhZc7+wf4MEtUFAgpKJDSGSj7KHY3j2j0QZpIFdPOUcZBdNYy
        vUvglLHmLfysA3ENgKbaupLoomYEeTc4tip3PY2BWslQNEBeEE3wzMXZ9DGH1ebZLh90ed6yqoizG
        4Ug0IdQLE2/iqiZoIlnq/sJ40dduw3lJO5UD52eshg4pR+4zdCBaftWonCcMNFQGHzQ+QJmgRxZXI
        eTtTa6kg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p10eS-00HW0q-Ro; Fri, 02 Dec 2022 07:40:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] seccomp: document the "filter_count" field
Date:   Thu,  1 Dec 2022 23:39:53 -0800
Message-Id: <20221202073953.14677-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing kernel-doc for the 'filter_count' field in struct seccomp.

seccomp.h:40: warning: Function parameter or member 'filter_count' not described in 'seccomp'

Fixes: c818c03b661c ("seccomp: Report number of loaded filters in /proc/$pid/status")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
---
 include/linux/seccomp.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/include/linux/seccomp.h b/include/linux/seccomp.h
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -27,6 +27,7 @@ struct seccomp_filter;
  *
  * @mode:  indicates one of the valid values above for controlled
  *         system calls available to a process.
+ * @filter_count: number of seccomp filters
  * @filter: must always point to a valid seccomp-filter or NULL as it is
  *          accessed without locking during system call entry.
  *
