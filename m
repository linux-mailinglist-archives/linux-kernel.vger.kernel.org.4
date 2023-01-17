Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8166766D699
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjAQHDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbjAQHCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:02:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F7823D91
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Wi64WdfXbzpTYtW26wQUZcCVF3gVdPRVGbt0pscC0SA=; b=ZxIIMpP2ZY/GIb9kQcpFkEZI72
        YFVadi4LySX95LuiXeFv04RXOji20LV7YU+/jB6XPYgMmm6qR8nZTm/V1AfAFyo+grhBAtzE/j9DH
        s5iZSmLGziO6HRww/hisWPyrWYQZLycgL2UXfL+d/9SqhPjDvRrFukEdBxKdFim0dLm1YUBoPMIPn
        mpH6IX8VQLkqNgeVEuPVIwqrmbtljCiI5Xqb0vif6fTa7DDQRop0y2imjg3rc1sY+zw56wnw7gsR1
        WBEEkk01TgfRjXfDgv3h79qLhmU9AQ7z6n3DvFYWh7449mnvDCd4Oxjgh0M1C7fWYmgJeaYTRLTf8
        541bV+Fw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHfzW-00D7LY-B5; Tue, 17 Jan 2023 07:02:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] nvmem: rave-sp-eeprm: fix kernel-doc bad line warning
Date:   Mon, 16 Jan 2023 23:02:40 -0800
Message-Id: <20230117070240.31520-1-rdunlap@infradead.org>
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

Convert an empty line to " *" to avoid a kernel-doc warning:

drivers/nvmem/rave-sp-eeprom.c:48: warning: bad line: 

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/rave-sp-eeprom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -45,7 +45,7 @@ enum rave_sp_eeprom_header_size {
  * @type:	Access type (see enum rave_sp_eeprom_access_type)
  * @success:	Success flag (Success = 1, Failure = 0)
  * @data:	Read data
-
+ *
  * Note this structure corresponds to RSP_*_EEPROM payload from RAVE
  * SP ICD
  */
