Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DAF63A0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiK1FnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK1FnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:43:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7286151;
        Sun, 27 Nov 2022 21:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rAZjs5UVPuF5bfxao1OY7vzICa60Q2zFN/Hm2qt2VHU=; b=CPlXT/MSLy7JhJ6JO5Jfwo++/p
        L8SaNZpnC+leKaKJV9IbxZimN4AISrYseGendIuLB91Ky60ID+0zESWRBQ8emK7crgXLXjtKUPz7C
        79lZxrt26G38UtVoULi3xyzrm6m7UBMETyz8YzleQ9D0SeAYwnmN5L8AQYdsvk2r0+gojaYKxEjAF
        1KgGjCcgz5+hXKM9f2VNnzdprOLlkDpPg6lmh0ihkbBbM60joL6ATuOC8FRQYEQecRMML9/KiUP3k
        F1uiN6vUDS7gRZzRq8L4Tjg3czSKeW4eu6QvE8rLtEIq5WKDyDs7m1zM3F+w60un/9vIgxL4bohZ+
        mf48/4Ag==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ozWvD-00COhF-1z; Mon, 28 Nov 2022 05:43:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-media@vger.kernel.org,
        Robert Schlabbach <robert_s@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH -next] media: dvb/frontend.h: fix kernel-doc warnings
Date:   Sun, 27 Nov 2022 21:43:03 -0800
Message-Id: <20221128054303.3124-1-rdunlap@infradead.org>
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

scripts/kernel-doc spouts multiple warnings, so fix them:

include/uapi/linux/dvb/frontend.h:399: warning: Enum value 'QAM_1024' not described in enum 'fe_modulation'
include/uapi/linux/dvb/frontend.h:399: warning: Enum value 'QAM_4096' not described in enum 'fe_modulation'
frontend.h:286: warning: contents before sections
frontend.h:780: warning: missing initial short description on line:
 * enum atscmh_rs_code_mode

Fixes: 8220ead805b6 ("media: dvb/frontend.h: document the uAPI file")
Fixes: 6508a50fe84f ("media: dvb: add DVB-C2 and DVB-S2X parameter values")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-media@vger.kernel.org
Cc: Robert Schlabbach <robert_s@gmx.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 include/uapi/linux/dvb/frontend.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff -- a/include/uapi/linux/dvb/frontend.h b/include/uapi/linux/dvb/frontend.h
--- a/include/uapi/linux/dvb/frontend.h
+++ b/include/uapi/linux/dvb/frontend.h
@@ -282,7 +282,6 @@ enum fe_spectral_inversion {
 /**
  * enum fe_code_rate - Type of Forward Error Correction (FEC)
  *
- *
  * @FEC_NONE: No Forward Error Correction Code
  * @FEC_1_2:  Forward Error Correction Code 1/2
  * @FEC_2_3:  Forward Error Correction Code 2/3
@@ -363,8 +362,8 @@ enum fe_code_rate {
  * @APSK_32:	32-APSK modulation
  * @DQPSK:	DQPSK modulation
  * @QAM_4_NR:	4-QAM-NR modulation
- * @QAM-1024:	1024-QAM modulation
- * @QAM-4096:	4096-QAM modulation
+ * @QAM_1024:	1024-QAM modulation
+ * @QAM_4096:	4096-QAM modulation
  * @APSK_8_L:	8APSK-L modulation
  * @APSK_16_L:	16APSK-L modulation
  * @APSK_32_L:	32APSK-L modulation
@@ -777,7 +776,7 @@ enum atscmh_rs_frame_mode {
 };
 
 /**
- * enum atscmh_rs_code_mode
+ * enum atscmh_rs_code_mode - ATSC-M/H Reed Solomon modes
  * @ATSCMH_RSCODE_211_187:	Reed Solomon code (211,187).
  * @ATSCMH_RSCODE_223_187:	Reed Solomon code (223,187).
  * @ATSCMH_RSCODE_235_187:	Reed Solomon code (235,187).
