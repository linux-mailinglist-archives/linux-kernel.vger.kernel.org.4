Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBDF6900FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBIHOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBIHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F07D83;
        Wed,  8 Feb 2023 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MhFrf85hQtqD5mQa4ZU2zg8z1KkDk1n+Nd8Z/FzHqwQ=; b=Z8YhvkL9xVrr1AFgFqihqbcCbW
        fVc2gSXjc/AZ5EgLTHUlBIAiFmPMgGLlSIcD3A+0F8E+QM8+GHYdufVcrG2R1A2eF/RgPEvLwYLkX
        S7TxDOdReAxMIvyxDPPXwCNTyokFWtioNk76KTvSH9T5gZ3YoM27ngiYZKAepR6s8zTjrctzL8tFE
        8XFaUohGuzj60l/tgFlAaBOOabAypjijZ8b3sSWdTbMX5T2eSmRZUcrvWQJ/oOKgcEfpwetBbuzsP
        I5qZpu3GXOpwgqCvDyrRpR1172mHAlcTHJOEgtkXBdbuZoIKMlE8ecc+NAC7/qpq5izKDaNaEiWBI
        Ml0FyPjQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18A-000LPt-Kp; Thu, 09 Feb 2023 07:14:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 04/24] Documentation: fault-injection: correct spelling
Date:   Wed,  8 Feb 2023 23:13:40 -0800
Message-Id: <20230209071400.31476-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/fault-injection/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/fault-injection/fault-injection.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -235,7 +235,7 @@ proc entries
 Error Injectable Functions
 --------------------------
 
-This part is for the kenrel developers considering to add a function to
+This part is for the kernel developers considering to add a function to
 ALLOW_ERROR_INJECTION() macro.
 
 Requirements for the Error Injectable Functions
