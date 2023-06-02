Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF96720AB5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjFBVAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjFBVA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:00:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8628E44;
        Fri,  2 Jun 2023 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tML0IzPFBtLerBMNlD1/rTkDJlPPcitapvPwY9vPC0M=;
        t=1685739626; x=1686949226; b=j2Q4K5+PW784UIb9ZDlEGWKuXq5F8nfShe0nNeOI1Qhj8Ks
        RWySFDZHTmK49Mtsr30Ghp6UJlbbq0wW8xo2PGDKJWeycREsadmODk7IZwkXIfLYkUl4Mcpm/Y/PG
        9mOTkxJvqrMG+vij1jadhc/8P0nQSYc2xjTu1eTCpdTnfay/GzlTuUBcvqehiiqAuHP6wao8K2nrL
        /u6LReRqJ6kSnuAP0HDemNT1t6H+6dmrfujbDJgm7JEQwbTUZbSZskdmjRkvSBye4/SawDA6WQcOw
        FVduz9dk8BnN3KnjCUbEnGF0+ljAvfeukcoZnVUyaJRjNChCr4IPjQsfOopZctEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q5Bsk-00BgEs-2o;
        Fri, 02 Jun 2023 23:00:22 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] kbuild: enable kernel-doc -Wall for W=2
Date:   Fri,  2 Jun 2023 23:00:14 +0200
Message-Id: <20230602230014.ca0aede8195f.Ibd08cad396b630b68d93b2469905ad55b375af65@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602230014.a435aab03cee.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
References: <20230602230014.a435aab03cee.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For W=2, we can enable more kernel-doc warnings,
such as missing return value descriptions etc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 scripts/Makefile.extrawarn | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 40cd13eca82e..d77eb2474a67 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -85,6 +85,7 @@ KBUILD_CFLAGS += $(call cc-option, -Wunused-macros)
 
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN2
 
+export KDOC_WALL=1
 endif
 
 #
-- 
2.40.1

