Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFC867DDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjA0GmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjA0Gk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E51A7518D;
        Thu, 26 Jan 2023 22:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cA6T2rGcZFPoEfN/pA7j1nNyVL8luA41tT+PQdfQNSw=; b=HWknLcAIjh9Fkh5d1ma+UIr645
        jOKj9rUzceLeVMsHNJWwNUdraSxK+nyoWeMoaLiDMYV+9mfRDG+7YFq/3XOeOg6pLhjamZcRD7wWh
        UYzZiNBDMA44rpcjpTHJR9kCws6N7Ca4XmAswdQNlACPxOrSwwvXRnokpLuWaMEUyEZLRpR/W3gKh
        iYi2vTlntVActvZW9evbVEXXEzgw2dicbtgd76Nwc7AJnziMERckgeqXOoJgifFnx2UMqTwOE09nW
        uDLdJDCAngGrRYQXXr4nHW+a9ouXQ0ArVvo3gZt3DLx6onJRBtZkBsngXG/n0cC5EMpkkkhJo432q
        zcLu1N3Q==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPR-00DM0u-DO; Fri, 27 Jan 2023 06:40:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 33/35] Documentation: w1: correct spelling
Date:   Thu, 26 Jan 2023 22:40:03 -0800
Message-Id: <20230127064005.1558-34-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/w1/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Evgeniy Polyakov <zbr@ioremap.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/w1/w1-netlink.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/w1/w1-netlink.rst b/Documentation/w1/w1-netlink.rst
--- a/Documentation/w1/w1-netlink.rst
+++ b/Documentation/w1/w1-netlink.rst
@@ -66,7 +66,7 @@ Each connector message can include one o
 zero or more attached w1_netlink_cmd messages.
 
 For event messages there are no w1_netlink_cmd embedded structures,
-only connector header and w1_netlink_msg strucutre with "len" field
+only connector header and w1_netlink_msg structure with "len" field
 being zero and filled type (one of event types) and id:
 either 8 bytes of slave unique id in host order,
 or master's id, which is assigned to bus master device
