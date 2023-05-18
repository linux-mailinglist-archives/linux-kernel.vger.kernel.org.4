Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D81708C86
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjERXrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjERXri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:47:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CD3E57;
        Thu, 18 May 2023 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZySnlc2Ml9xHMuunSy4Tjl3AX6LIZep9S+GkxtV0tZE=; b=yeNVEuhHvJPqncFuyGKgjR8JyH
        MCruxXJ225HX1uwdRUGDxZBwPjW3z7fKLUw9JSYdonwqPrXv5Ah9KbkWkNClPpjOdrDyziQf77UbN
        SGTedecdDzYGgMYAHaY5VKugybmf5/UtSb+a817qYka+zjcdQXtg+CKLeaWUs9AtOdkwfYZgAPsfX
        DAhTxRD+WjMM4//yGTQurTd7hQS4NZMAEvJYsntLGnzjoEbXiRgrAkXx+8H0IkXW10cN/KNSPBN0a
        ycXfjO7tqx4m+IC+pk9Ys2GZHLYDNfeNPs2qSZLRen8dvxp6ZoLhAVkYu6R0yczet7xpOtnKihkfZ
        QV9IL1wg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pznLM-00EUvN-30;
        Thu, 18 May 2023 23:47:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Athanasios Oikonomou <athoik@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH] media: frontend.h.rst.exceptions: add more dvb define exceptions
Date:   Thu, 18 May 2023 16:47:35 -0700
Message-Id: <20230518234735.20289-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building documentation reports multiple warnings for undefined DVB
frontend labels:

Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-11-45'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-4-15'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-14-45'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-7-15'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-11-45'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-4-15'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-14-45'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-7-15'

so add those symbols to the ignore list to prevent the build warnings.

Fixes: 1825788e2a96 ("media: dvb: add missing DVB-S2X FEC parameter values")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-media/202305162245.wtaLIXf3-lkp@intel.com/
Cc: Athanasios Oikonomou <athoik@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/userspace-api/media/frontend.h.rst.exceptions |    4 ++++
 1 file changed, 4 insertions(+)

diff -- a/Documentation/userspace-api/media/frontend.h.rst.exceptions b/Documentation/userspace-api/media/frontend.h.rst.exceptions
--- a/Documentation/userspace-api/media/frontend.h.rst.exceptions
+++ b/Documentation/userspace-api/media/frontend.h.rst.exceptions
@@ -142,6 +142,10 @@ ignore symbol FEC_26_45
 ignore symbol FEC_28_45
 ignore symbol FEC_32_45
 ignore symbol FEC_77_90
+ignore symbol FEC_11_45
+ignore symbol FEC_4_15
+ignore symbol FEC_14_45
+ignore symbol FEC_7_15
 
 ignore symbol TRANSMISSION_MODE_AUTO
 ignore symbol TRANSMISSION_MODE_1K
