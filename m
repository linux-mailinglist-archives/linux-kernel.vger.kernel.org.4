Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE874C14F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 08:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjGIGup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGIGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 02:50:43 -0400
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Jul 2023 23:50:41 PDT
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B7DF4
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688885439;
        bh=tuqL83ggHiBrgm7wdRGtAfEK9cuBv6+QOt3TztaqU4w=;
        h=From:To:Cc:Subject:Date;
        b=S+eMIb5+IgGH3bfc3QVs89te3/90hiAI0mM8pb/BDnRD1ISz8eYHoubFtCpX7Ke7u
         +6V/vgJgRstntuov62C4n0fpxBd9oq5P/rDFOtb8g7xX0kEAqM6LQqs3SbyrrpiwHx
         ofWMF+soa9kiSMD0mjVSsq7HJGx9oeLbsDNifAnk=
Received: from linkpc.nju.edu.cn ([58.213.8.104])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id C4E90C60; Sun, 09 Jul 2023 14:49:14 +0800
X-QQ-mid: xmsmtpt1688885354tfvoegbls
Message-ID: <tencent_54C2A2746A83BA29EE92248CE9683F0C6509@qq.com>
X-QQ-XMAILINFO: OBjl3voOPnzhg1GUojRXhnKaYr9GA3dnRrjrkLCZKnqt6fSLSRmyYwpHrz1n3I
         k5wDLsiVaLh1GDVENuHYHRxphxmw3jrO1bLh8UZK7eKdF/+7FRn1lzDOgDpTyx7lxFe3APAaA1D4
         /l+15Y8Zc1KhqqTbyp/VoW23QyCVVQlNpYADE+fQK1DyqV40kSOty4zwkmQJx5JJVnKu6IPAziB3
         wc6Z1tNr6Ai87L+aQ6UF15crmRH64ADuuKubvLPjq/3n9I3f6iMW+Kz36ZVveTVeBvsncQkpMocw
         TNQAodYeyMZND4qq+5dJF/v/4XCbsoJSs/tcACR5xJwkEf2dK5YwIffp1f2DEiQfWHsVWOJKfU+y
         Co5M2KrBkXcUilDfW2M4sgwb1qAdRfEjXw1qYXy/pM6NyQ4dG0cIJxHYWZe2coS+kn232GzE0lGl
         88qg5DAE0iL3n5MVM1XbCSldH+sfpTayE6Hwdhbb0BE/loWAuY70hADbb9wx0D5g2jh1thufhIeF
         7ZtajibiZq9qZZf8XApwXwCYC19RsLsVyPJlDawfwbcUC31fnLBi6cFQ0mLbj1gSSOHOyDU/CqGA
         RitCx+BXcB0MDmgFf5okaTy9+j6qvcqqHe/zB6XMX/8Ff1VYB2nu0T1JgiWsd1rG8zcG7gw1GD7+
         Db/49OFrQz9cCrnxFRye3FT9mvS+E91oylj/H7I1hfgVdoCzJOAafC3NBxvz3+q27TmLGDopoU79
         rrI/k+M/d21BjwS214FrwQuPA50UFEj39QXSe8IYyGB3j9jvLPYULeVANj1nvmLHfGSa+83+WmaF
         cCTgirFSRcQVfz+LPYXuv/r9MDFkuboV+S5l/XFllO9iDMqz3IxO/XJL6xxcH/6kwYwaJPRc3qO7
         g7mbHlVxciAN60uFUTK+7UwXkTtkEg0iQVF4+gmuM1I19Nu0rtZNP1axQIIE5Z/G9yACNJmmzct8
         Fr0L3UytsCxl1bkHz7Wn7m4Rma4Iin9Ih5H6jlb0S98EHfpR2EjbLhQLcLm6Z0KMWcqMjFMI2LAM
         JeAxDQ8hYPFJnM112Dj5GstwRbkzBpm8KRJjb5Uw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Linke Li <lilinke99@foxmail.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Linke Li <lilinke99@gmail.com>
Subject: [PATCH] MIPS: Fix undefined behavior in PAGE_MASK calculation
Date:   Sun,  9 Jul 2023 14:49:12 +0800
X-OQ-MSGID: <20230709064912.384862-1-lilinke99@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linke Li <lilinke99@gmail.com>

Make PAGE_MASK an unsigned long, like it is on x86, to avoid:

../arch/mips/include/asm/ginvt.h:44:20: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
        addr &= PAGE_MASK << 1;

In the MIPS architecture, the PAGE_MASK definition in arch/mips/include/asm/page.h leads to
shifting a negative signed value, which is undefined according to the language specification.
To address this issue, the PAGE_MASK definition is modified to be unsigned long and ensure
well-defined behavior.

Signed-off-by: Linke Li <lilinke99@gmail.com>
---
 arch/mips/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 5978a8dfb917..3061a5586954 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -33,7 +33,7 @@
 #define PAGE_SHIFT	16
 #endif
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
+#define PAGE_MASK	(~(PAGE_SIZE - 1))
 
 /*
  * This is used for calculating the real page sizes
-- 
2.25.1

