Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59A467DDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjA0GmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjA0Gka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A0774A43;
        Thu, 26 Jan 2023 22:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FDxzjxLQ3iThQJWVe7KoxaXq3Dwe6ny+CisIu+7g3jI=; b=hBnMOzWE2sJ4Mz+cE/0JDGC1AC
        6cTfaQDIBbTWUMLlxS/V+3+KiiwSCGOxbq+mpgjBfyljV1zmjFBKCPjPWqYd7psatiHRPCMnIZQXH
        EZ26AoOJ2pRau0rIppAEiub2xh1dgZiuF55HDWEtb9u657I8m0nEIRJi/rt323qkQoAq77OCCegfB
        LbI6w/DiyJuCLdAx8Ihe/lCjombwlCIVfxYm2CdfaeIQDM0KeOpf+PaKXiK37ssBkYuNXIlU47olV
        OzlQuDJFXvyR64LAYJnFLGl20PQ6ErUqbZw8rlR3w+ukGD9u5MjHKk7NknI12NfKLuMU2nv+CFMaD
        pRi0WjDg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPS-00DM0u-BG; Fri, 27 Jan 2023 06:40:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 35/35] Documentation: xtensa: correct spelling
Date:   Thu, 26 Jan 2023 22:40:05 -0800
Message-Id: <20230127064005.1558-36-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/xtensa/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/xtensa/atomctl.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/xtensa/atomctl.rst b/Documentation/xtensa/atomctl.rst
--- a/Documentation/xtensa/atomctl.rst
+++ b/Documentation/xtensa/atomctl.rst
@@ -23,7 +23,7 @@ doing a Cached (WB) transaction and use
 operations.
 
 For systems without an coherent cache controller, non-MX, we always
-use the memory controllers RCW, thought non-MX controlers likely
+use the memory controllers RCW, though non-MX controllers likely
 support the Internal Operation.
 
 CUSTOMER-WARNING:
