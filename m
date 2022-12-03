Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B340B6418B8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLCUX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiLCUXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575F178B7;
        Sat,  3 Dec 2022 12:23:22 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h11so12906395wrw.13;
        Sat, 03 Dec 2022 12:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOvO2HnqhCcoAMqf0vw2As8rq+MktqC7v9VGicLXjm0=;
        b=foZZylZVvMiGtKxDtPj71EsG2/Y+86Ii623toNaqFR89zicruxSJRaubtpxjdltm07
         YX+R0Dk/mXSaIZUml+hCV+Op17xVz2Q7cWNIg1WOGNxW3GH89vk/vzZG1MpYZSnhogG2
         Gi97DihrWidg9EweugFX/2RwR7CMnai2zfPCCF6gDkpb0pMn+TCJYFo+FchNfSTiNGGV
         SdBhzHZExXav6KSsZeSQTHgt3F5CFKSGdPDIgak+8HqaK0OucqH/ePbtIbCDHSTzcHxL
         iF5Af5LFOsdMOacv9uqPIonPenTQoLvwGlOIZCHyONX4TOKeB7zXgalec66s+iY2ke8t
         WK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOvO2HnqhCcoAMqf0vw2As8rq+MktqC7v9VGicLXjm0=;
        b=ESmgSfw7URDUb0I/rE6L+A0DH5O/2zh992AOUmeqADgHzmmByUIgUzJOwxDhlIRUTd
         AVuZJ1MHBPqHKG18ixWWXMhRdbahmHraf64LTSZSG9jqPQo0PrEFE2+oJkQ9rgE7xzIa
         yOgXthMbLOuc3exTMpYzz4DV3m5qhhSUyD/e5B4MK8PQ6qYP3EfA+yj/aBxYfdA0hPWC
         a95pD0uDOwOf4uIa6fKdH61IkeXd7tTU1AXs1A1Mwuwa8cMaTQhjJF8dsPMW2l2RFgBl
         MmpTgn9mKUH/Eh4zZAyL2waTcGgG5oOeKP2rEGb7iVAuv3GlBvnH7+qTKgPwDzxprBNV
         iRHQ==
X-Gm-Message-State: ANoB5pkk1t+xqOldWSbEE/Tr9Jz3/vum7/PIZ92M1KHkfRxYlFWZxo2D
        grj9Mdho3AqmfiuJwULVPV4qjfVLRBM=
X-Google-Smtp-Source: AA0mqf7teL3+DG7oxHXDSHPnzjgpiuAKbWkSY7oDuMFM1EYPZBGxpI2fy+HE3uJKXQ0oovjcklOb1A==
X-Received: by 2002:adf:e648:0:b0:242:2206:7c60 with SMTP id b8-20020adfe648000000b0024222067c60mr4400879wrn.306.1670099000779;
        Sat, 03 Dec 2022 12:23:20 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:20 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/41] accept.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:37 +0100
Message-Id: <20221203202317.252789-2-alx@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203202317.252789-1-alx@kernel.org>
References: <20221203202317.252789-1-alx@kernel.org>
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

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man2/accept.2 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man2/accept.2 b/man2/accept.2
index 6e7fd2864..333d25ceb 100644
--- a/man2/accept.2
+++ b/man2/accept.2
@@ -20,14 +20,14 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/socket.h>
 .PP
-.BI "int accept(int " sockfd ", struct sockaddr *restrict " addr ,
-.BI "           socklen_t *restrict " addrlen );
+.BI "int accept(int " sockfd ", struct sockaddr *_Nullable restrict " addr ,
+.BI "           socklen_t *_Nullable restrict " addrlen );
 .PP
 .BR "#define _GNU_SOURCE" "             /* See feature_test_macros(7) */"
 .B #include <sys/socket.h>
 .PP
-.BI "int accept4(int " sockfd ", struct sockaddr *restrict " addr ,
-.BI "           socklen_t *restrict " addrlen ", int " flags );
+.BI "int accept4(int " sockfd ", struct sockaddr *_Nullable restrict " addr ,
+.BI "           socklen_t *_Nullable restrict " addrlen ", int " flags );
 .fi
 .SH DESCRIPTION
 The
-- 
2.38.1

