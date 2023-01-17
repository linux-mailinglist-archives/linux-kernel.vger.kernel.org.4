Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D9666D972
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbjAQJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbjAQJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:12:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A43B65C;
        Tue, 17 Jan 2023 01:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673946337; x=1705482337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aHYPToS/jABucyxHBUjjp3ckI/iQBTA/kh5jyn5eAU=;
  b=dvqCifhKMRekRHAjX3InjzFw9Ho93bCyYJBxl+LkeIZnwu2DEhHBwil/
   ENLX5OknAIW7KLVs0/eiPV4cDU/xvJXgORNKQ9d2uUWTYqZ4RTQe3T5I4
   JLdz+vmGOVwBrSja/y5fT9VhuUs800cLa8BkLa4TBy/bgW9aGgQahopEt
   PASYPHWvqBvKigYF1jq7WK3py0WI9/cUOHQcHq/vfqYgfeK43aVl0CqBb
   z2768nxpftNtJPwqXcQAp+sFhKF2z9N1MRl8pQNeBb3O2+95t/pQo4t0k
   9qm7Fv/Abise6EM9LEJ6BDwsV609py5C29YYvjHZMRrDYECnNyD7n8SA9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324700983"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324700983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783174107"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783174107"
Received: from tronach-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.40.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:43 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 04/12] tty: moxa: Make local var storing tty_port_initialized() bool
Date:   Tue, 17 Jan 2023 11:03:50 +0200
Message-Id: <20230117090358.4796-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
References: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return type of tty_port_initialized() is bool, use matching type for
the local variable.

Also reorder the local vars to reverse-xmas-tree while at it.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/moxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index bc474f3c3f8f..2d9635e14ded 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1664,8 +1664,8 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 		u16 __iomem *ip)
 {
 	struct tty_struct *tty = tty_port_tty_get(&p->port);
+	bool inited = tty_port_initialized(&p->port);
 	void __iomem *ofsAddr;
-	unsigned int inited = tty_port_initialized(&p->port);
 	u16 intr;
 
 	if (tty) {
-- 
2.30.2

