Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B560660DEED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiJZKjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJZKjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:39:45 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06C34D4C9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666780641; bh=2o2vObTUWUB0Kdk6K5kLMVJ/u7FvQKx9DpX0JHVrhzY=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=n9MF0KHexYUfDnyDE20lf405Xu6eQgg5AD5PItaKVVcUlo/0pSqv2Uo8X9GKspeLF
         kIQHC/9qfA8NkdVphP9gpGmrjfwXyXJgkE0cfHw0ToeWMZHAGe1rSE8zlb0NOCrEd3
         8Py/EIBBA+0A8igYR+rev85Ac5ZXBOYREYl3lbPs=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Wed, 26 Oct 2022 12:37:21 +0200 (CEST)
X-EA-Auth: H2CtVnUc+erUdiJhAzCjTta69U9/k8Kq8sa4I6xa+4zRi0CNntGfIIw5oc42fnlqqx4kU74pVOSz5wALBQUyjFZB9nU7T7yB
Date:   Wed, 26 Oct 2022 08:58:44 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192u: remove unused macro definition
Message-ID: <b7053d8737c048d6a878609f0ec24d66b18c5abd.1666754500.git.drv@mailo.com>
References: <cover.1666754500.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666754500.git.drv@mailo.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pre-processor macros that are defined but are never used should be
cleaned up to avoid unexpected usage.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 00c07455cbb3..0b3dda59d7c0 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -230,8 +230,6 @@ struct cb_desc {
 #define ieee80211_unregister_crypto_ops ieee80211_unregister_crypto_ops_rsl
 #define ieee80211_get_crypto_ops	ieee80211_get_crypto_ops_rsl

-#define ieee80211_ccmp_null		ieee80211_ccmp_null_rsl
-
 #define free_ieee80211			free_ieee80211_rsl
 #define alloc_ieee80211			alloc_ieee80211_rsl

--
2.30.2



