Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DE76FDAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjEJJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjEJJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:39:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDD92120;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6439b410679so4463496b3a.0;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683711589; x=1686303589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2NBDXb4nxvHmcZ5o+kwswc4w1u/eM5fIihUYVQxTkA=;
        b=RgGpq5tRG3fW3RBqNicl02jLfEeNemnZiB4ma0JGnjXtQhLXalRnE59uft752aqRLj
         IWEV+jHfhcbVg03slPrT+aPltwwMMGjPSefCH9HHVo36QRX1M7fRZra7ZWE37yrVmSdS
         2z3ZL8o/pQHAGlSfdaxHOCC1sdQHux80EsR32uTYn/dRulvUHFcexc8XUGO3J8Psd6a/
         0O3/d5gjnd7jCWXCQtPVUxGsBCoIKZnMvk5m66fFpN0xIi2IPjd7cyAQEGk5GO+YDUc4
         blbnWJL7RgR9E2AlisUIogA8aQB11y+MqYjoHL9AI8IQhfX8RaZ/s/WTMSYFJ2yeME5J
         p7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683711589; x=1686303589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2NBDXb4nxvHmcZ5o+kwswc4w1u/eM5fIihUYVQxTkA=;
        b=aIMEZL5LbG/0CEfoTKtOVIzWUEP1g1FvdSsNo6DMAk+6Pwq20x+Bm4dR1gpQd7LwuV
         e3pc3gxx0lQEKr5n7/D6l/4A5+SWtpabYJmOOobJuN5WnSqL9COOjShNDsFl+sKNl6QL
         5ZWraV2aRGwCAwrXwAVKXryRes4+ZJM4TEsDV3V4E/I5xqIw7hpSqUDfImu9PI2fVgjr
         UrKB6Mf6tsFM0aiLg+2bNUYKwu5p2RuI4Q2b6V4eD8qlwp9mhqjiLYFAq1SX3U0u+vhZ
         Vqpc1YlUt6NTyIK57VLxgpb5RUOeMMzg3ehoFnc0jDsPeIi0eVDPLUeiZ/05t8VgN6my
         grHg==
X-Gm-Message-State: AC+VfDxJ47Chbi3pubmRMxlpjjTm6MKWgI1kqkjsR2R3S0jkh+wM2yDl
        /GzX5GLyWDM07CCrP4V83/eBCDMGnJk=
X-Google-Smtp-Source: ACHHUZ6DabYG1Vv6cDZd5nXBII6faFCQw91r4nP1OeinhKP39fao7M27BFATU5PYFb6Ua7tTz9c9aA==
X-Received: by 2002:a05:6a00:16c4:b0:643:9dcd:abba with SMTP id l4-20020a056a0016c400b006439dcdabbamr26052216pfc.29.1683711588735;
        Wed, 10 May 2023 02:39:48 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-71.three.co.id. [180.214.232.71])
        by smtp.gmail.com with ESMTPSA id c12-20020aa781cc000000b00640e14330d8sm3208038pfn.28.2023.05.10.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 02:39:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D2B3710670F; Wed, 10 May 2023 16:39:44 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 2/3] Documentation: scsi: dc395x: Replace non-functional twibble.org list
Date:   Wed, 10 May 2023 16:39:32 +0700
Message-Id: <20230510093933.19985-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510093933.19985-1-bagasdotme@gmail.com>
References: <20230510093933.19985-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=bagasdotme@gmail.com; h=from:subject; bh=LzIrktoa7qyVTTHSq1EJzJxY1Dta676HsiSzsB5Jf6c=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCnRaaFy7IHfP7dGKGpner0peV626M3J0i1Tj1/wDnggr 53C+fR9RykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZSacDwT4Xh85T6kt1Ou5Zr 9rwz1toWtDd0wYNH6WfDJz//dcS/+zLDHz42xrw2br5Qef7GKx+Ke3YpTCurfeWoaqwnIBJcZqL DBwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync mailing list address in the documentation to follow MAINTAINERS.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/scsi/dc395x.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/scsi/dc395x.rst b/Documentation/scsi/dc395x.rst
index d779e782b1cbe1..c413b629809bcd 100644
--- a/Documentation/scsi/dc395x.rst
+++ b/Documentation/scsi/dc395x.rst
@@ -15,9 +15,8 @@ This is a 2.5 only driver. For a 2.4 driver please see the original
 driver (which this driver started from) at
 http://www.garloff.de/kurt/linux/dc395/
 
-Problems, questions and patches should be submitted to the mailing
-list. Details on the list, including archives, are available at
-http://lists.twibble.org/mailman/listinfo/dc395x/
+Problems, questions and patches should be submitted to the `Linux SCSI
+mailing list <linux-scsi@vger.kernel.org>`_.
 
 Parameters
 ----------
-- 
An old man doll... just what I always wanted! - Clara

