Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E913164F77B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 05:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiLQEBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 23:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLQEBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:01:15 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B903311C03;
        Fri, 16 Dec 2022 20:01:13 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id x11so4281132qtv.13;
        Fri, 16 Dec 2022 20:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFfxeKa66hYXkFi3UHZXAAdyvPyXsgLD8aUDMER0Xic=;
        b=pnS88Y6c8Y4NozTvoPHC34wzOZ0x6iCPAlKHgDHO6l+w5lJgTdu70HLqj4dBWT2ovG
         fnQxNjWfJqAuqXmPps1+dKj/1EBkqCIE2vYObrBdQqqN6CjlyAYhwBkMUXCXJ6eTSBHy
         ReVhrRw74i3FLMz8S3B2Bl3oEkWcLVQwxVSCvLJcgFYIIx/dIMXSWsqVc28syprG6oVf
         3Io0r+7G4OXPt/lHrsyMquXlZ6zuD3VGHyTQNJeK/Jzrijr1HtuoIRTpfpgc4v+F4XXn
         E/GvFFAAUeixCMRGV7WGeI9tTRsHvKKvQN36u8rF4YNz5v9/Dh3c2L9EFhxuASYuxCFR
         75MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFfxeKa66hYXkFi3UHZXAAdyvPyXsgLD8aUDMER0Xic=;
        b=Nx9q7o+d7d7qATughXUPjLas7Hcnh+BQGfxlNBGOMJlhW/tv3QQ98ZCNUkOHBBHEnf
         COWvhkFch/o+QrkA9omTlS/gWKdou1A0g6YwJcPDfKXn+HWsAo0LKsqnvzn00p+S7BlG
         ezbEoKuT7MINriAYypG8qc85nybSpnk2iYmMLam9oZef2uiqpBcEBCCaRpSx+NLy6ly+
         FXCoercCXLaMHMosuV4ymueElfWnZNWDEugdCMw9yoK6eUDX92vhdJcvrxlwBUmXhDD6
         MaXQ3VqcJwKM61MSkMIE5QXxR2E0+pAEgNocNfNI6EhFZ9K35IeIAkWy1zhc+vQ0zz4W
         M5Og==
X-Gm-Message-State: AFqh2koyuF4G1Onz83i2BSFT1OajXiMpzvsQLvAu2bayhdk05L3J6Dr4
        DZ7Y7/3ZDq9Ma6PYj3KYvkURNaou9TJi1Q==
X-Google-Smtp-Source: AMrXdXs4pJASqKve49gAnlSKEW77m/rSdTUpfNKo9rxVq9oSgJFL917vVXm3H6rY2YxjapsG5XvQJw==
X-Received: by 2002:ac8:528d:0:b0:3a7:e838:11da with SMTP id s13-20020ac8528d000000b003a7e83811damr2484522qtn.58.1671249672846;
        Fri, 16 Dec 2022 20:01:12 -0800 (PST)
Received: from Slackware.localdomain ([191.96.227.93])
        by smtp.gmail.com with ESMTPSA id bm24-20020a05620a199800b006fa4cac54a5sm2833718qkb.72.2022.12.16.20.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 20:01:12 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] scripts: kconfig: Corrected the misspelled word in kconfig help text
Date:   Sat, 17 Dec 2022 09:29:19 +0530
Message-Id: <20221217035919.19855-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/sash/slash/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1: corrected the misspelled word
 scripts/kconfig/mconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 93dc4850ff2a..a82cac8916ab 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -164,7 +164,7 @@ static const char mconf_readme[] =

 "Search\n"
 "------\n"
-"Press forward sash(/) anywhere will bring up search dialog box\n"
+"Press forward slash(/) anywhere will bring up search dialog box\n"
 "\n"

 "Different color themes available\n"
--
2.38.1

