Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A46F8C2D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjEEWCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjEEWBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:01:41 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C1D6A55;
        Fri,  5 May 2023 15:01:02 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6a5f765d595so1473687a34.0;
        Fri, 05 May 2023 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683324062; x=1685916062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpWRid5cmCr0SjsRhGTnuvLDk1kP0ktA07Mc2yuVwzg=;
        b=cva9g2Xu+/d4NTUnciZerQb1yQy7aWUHBFv3uzCixXhk9tswLjCS8lBHo+vOn9qhKK
         y2QMOXFNtxY8rKHGXrnxxsTTJIzl5BD8Y97D+NHJkb2ZtRsGfDkqVoPe5C3phMLRLigJ
         SXaZuieXfZ0xJkwa4DjvcW7m3tq81SM2cI8xSG6tWle7dwrCe3HJ9D2dTOvEjXwsSBds
         An3FrCo2Ei7e/QGRwROVMB/ITOhkkC4QMI3W5n7FJaK6MnWHrj7kFWd0VPn2q66P9qU+
         s3lt2+wKNl7OqK7ob7rS65LmELTlzvTpPzeIC1WC8UlkdTHCYRgI26SWzM5eWX2eFFz0
         6h9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324062; x=1685916062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpWRid5cmCr0SjsRhGTnuvLDk1kP0ktA07Mc2yuVwzg=;
        b=V7+pAM1LPqOkQ77TKRWvkMGE31OrmDLfc10A9ZYP4ZQB/SEIjCaBD7WnxvEMFnBxbX
         mLu5tQvR54ve7P2sgeUkbV698jnq8UtkWgMdqM8gT1B45ClI0l01HZbqF2fg/CGJIiQ2
         8bJjZPqECVBmt6S0c/wHilwkIbkZ0urka+3q9R51t6SuiUKLx7kPlkNaQ/bASqerNLiC
         Lr+9XxYwhHq23QfctOhz/xd/u00i6GY33Lvo/477NGRQWebooR1NmI7JKsA1XnqF/WsJ
         B/opTUq1yg/AJzNwOWT+bH4HkIwqyxeKPGGCbrFf0IRs80yig4T5xog54mVdNZDWBCLK
         UscA==
X-Gm-Message-State: AC+VfDxj/SbM6SwFUrWpHUscRgQPs5VIVfCYMQ8vdVUK/ldo0fzMydOW
        rA5sT9oOIZ0/xRLVw+d061+Pj+TxTW4=
X-Google-Smtp-Source: ACHHUZ50O3hP1H6lDP3RdVnLHRaQ5RCU0NtARl+hE39Jg7gb9De+ur+misidhOui9Eet6qM6wqDLxQ==
X-Received: by 2002:a9d:75c8:0:b0:6a8:b659:d46e with SMTP id c8-20020a9d75c8000000b006a8b659d46emr1516959otl.8.1683324061904;
        Fri, 05 May 2023 15:01:01 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:90cc:2e0a:7522:8ecc])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830060f00b006a61bef7968sm1359547oti.53.2023.05.05.15.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:01:01 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v12 13/13] HP BIOSCFG driver  - MAINTAINERS
Date:   Fri,  5 May 2023 17:00:43 -0500
Message-Id: <20230505220043.39036-14-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505220043.39036-1-jorge.lopez2@hp.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Many features of HP Commercial notebooks can be managed using Windows
Management Instrumentation (WMI). WMI is an implementation of Web-Based
Enterprise Management (WBEM) that provides a standards-based interface
for changing and monitoring system settings. HP BIOSCFG driver provides
a native Linux solution and the exposed features facilitates the
migration to Linux environments.

The Linux security features to be provided in hp-bioscfg driver enables
managing the BIOS settings and security solutions via sysfs, a virtual
filesystem that can be used by user-mode applications. The new
documentation cover HP-specific firmware sysfs attributes such Secure
Platform Management and Sure Start. Each section provides security
feature description and identifies sysfs directories and files exposed
by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its
behaviour and capabilities, many of which are related to security.
To prevent unauthorized changes to these settings, the system can
be configured to use a cryptographic signature-based authorization
string that the BIOS will use to verify authorization to modify the
setting.

Linux Security components are under development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c9011f5fc17..7d1f261af539 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9367,6 +9367,12 @@ S:	Obsolete
 W:	http://w1.fi/hostap-driver.html
 F:	drivers/net/wireless/intersil/hostap/
 
+HP BIOSCFG DRIVER
+M:	Jorge Lopez <jorge.lopez2@hp.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/hp/hp-bioscfg/
+
 HP COMPAQ TC1100 TABLET WMI EXTRAS DRIVER
 L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
-- 
2.34.1

