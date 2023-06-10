Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ACD72A938
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 07:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjFJFnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 01:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFJFnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 01:43:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292A3AB7;
        Fri,  9 Jun 2023 22:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YtwHiOdgRylwAtuEdQQWXA5364Cv1zQkXyiMou9I1v8=; b=fUWqeQKBGRpEmBYfycaAvNYYjS
        xs5MZ9vi/BqaQd/TfNL7bslPEnBvTPUJVXOkMpAhqiVuDorqDlbd7K07oc935mi/BP+Z/gi9HCyT1
        IFuInRt/8ZDwdnV+BZYc8YdZTx/l+cSNLDHkN38JXgBCvB9uuKbn3u9Db8SZ49k3cgEjVXaNSHOKc
        qOqQHvbBqFBZeVDPfoOUDJga5stws7VYd3v40DQYpyefyZqD46YQo80QYYUc67dF4i35lLADv3CF6
        GdBHnN2v6pAAtb1qjIqaI4g5MRETE5s/VprPism5ofrgwV6SsQwjA1zg7EuUaZaVAa3qwwRmGrKu9
        9+nyrVBA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7rNP-00FJ1m-0r;
        Sat, 10 Jun 2023 05:43:03 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: virt: correct location of haltpoll module params
Date:   Fri,  9 Jun 2023 22:43:02 -0700
Message-ID: <20230610054302.6223-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module parameters are located in sysfs, not debugfs, so correct the
statement.

Fixes: 2cffe9f6b96f ("cpuidle: add haltpoll governor")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/virt/guest-halt-polling.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/virt/guest-halt-polling.rst b/Documentation/virt/guest-halt-polling.rst
--- a/Documentation/virt/guest-halt-polling.rst
+++ b/Documentation/virt/guest-halt-polling.rst
@@ -72,7 +72,7 @@ high once achieves global guest_halt_pol
 
 Default: Y
 
-The module parameters can be set from the debugfs files in::
+The module parameters can be set from the sysfs files in::
 
 	/sys/module/haltpoll/parameters/
 
