Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274CD65B754
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 22:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjABVQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 16:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjABVP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 16:15:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B82BF2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VdMnbSfEG88K3BFkESb9PC5ij8pRol7/foeqkxVRATE=; b=QOBCy3Z10WG7KbX/gcG3/KcqcP
        ODxLFcXaVEY7/39h/UXN/RBTBZYrgYwV8KKGtwPqf45b2ACiE+Le1iEy1gtjWrLcbZSXbAxoiak2D
        F/jCLURPbWK5iyOZc2WVuqldkLA/xdKx/MNSp8nw7xTeHPM5Ah+FvjbFG3wVYji2jEy3EGi6QOCqS
        JYdzp+cGBhnc27bGpbZRdyWo/rMStQRXmmWXbNj7prsT13vrRrHdVh/e5MXhXTn8h8iqHWzXtUsI9
        xtacQma4zHvDD4+3PCLZGjCL0c/yi9MVvsACldc8YW/nuGIwxcbbStmfXdmn7xo1DuBTbFOz9TUzZ
        UAjV+S+w==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCSA0-00EIoz-1W; Mon, 02 Jan 2023 21:15:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] test_firmware: use kernel-doc struct notation
Date:   Mon,  2 Jan 2023 13:15:54 -0800
Message-Id: <20230102211554.25629-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
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

Add "struct" to the kernel-doc notation to prevent a warning:

lib/test_firmware.c:98: warning: cannot understand function prototype: 'struct test_config '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_firmware.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/lib/test_firmware.c b/lib/test_firmware.c
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -50,7 +50,7 @@ struct test_batched_req {
 };
 
 /**
- * test_config - represents configuration for the test for different triggers
+ * struct test_config - represents configuration for the test for different triggers
  *
  * @name: the name of the firmware file to look for
  * @into_buf: when the into_buf is used if this is true
