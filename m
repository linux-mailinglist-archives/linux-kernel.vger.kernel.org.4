Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF99622EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiKIPXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiKIPXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:23:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510DD6242;
        Wed,  9 Nov 2022 07:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668007416; x=1699543416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zG5k+jtwrR0fe/HNEmrBVzmcIDN1wrEsaTPW7Qt9gz8=;
  b=m0OEOo952ueP4RiuxvVIxcEdFd1jBpa3vOnCd1m8sTsKLZx0PxK2n/MS
   3rQGUjWKcPGfy/tf2Tt/9HVQcWq3HUIi+bI1oGknps/R5G/5eSCWKLV5c
   RsoXhmP7zSR64ey0uzv+FZT+y8F4yswktfIf1dlokT86Q71QjyOVldBj7
   Jk6HpnG27HxuE0Lj6Kk6OTz3bl50Y3l9vHvZgdfgiFAm56x4gg94a2tw1
   sKgdNKqKuXKDI4Xp2ANKEUWruS3Wodfd34YgKwFFIqCVw+EK0v8Epy8Y4
   VKRnURJXWwr3EN3Uz8g5EBz6ejpJN/DkIrR0mE9ZkpOfhUR0ZH6vr6z9R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337739221"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="337739221"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="881963251"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="881963251"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2022 07:23:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 992D1155; Wed,  9 Nov 2022 17:23:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: Put space between type and data in compound literal
Date:   Wed,  9 Nov 2022 17:23:56 +0200
Message-Id: <20221109152356.39868-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's slightly better to read when compound literal data and type
are separated by a space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

It also standard practice in the kernel:

$ git grep -l '(struct [^()]\+) {' | wc -l
1384

$ git grep -l '(struct [^()]\+){' | wc -l
306

 include/linux/pinctrl/pinctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 487117ccb1bc..f6ff2590657d 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -40,7 +40,7 @@ struct pingroup {
 
 /* Convenience macro to define a single named or anonymous pingroup */
 #define PINCTRL_PINGROUP(_name, _pins, _npins)	\
-(struct pingroup){				\
+(struct pingroup) {				\
 	.name = _name,				\
 	.pins = _pins,				\
 	.npins = _npins,			\
-- 
2.35.1

