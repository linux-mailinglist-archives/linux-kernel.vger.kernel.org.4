Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02866E9A13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjDTQ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDTQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:55:31 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603B5266;
        Thu, 20 Apr 2023 09:55:14 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id c17-20020a4aa4d1000000b005418821052aso831485oom.6;
        Thu, 20 Apr 2023 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682009713; x=1684601713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpWRid5cmCr0SjsRhGTnuvLDk1kP0ktA07Mc2yuVwzg=;
        b=hrCkm3v0lPvEh5WcfNQ8A72ib23453Pklu0dKzjJ6OPLQQZNE9m1/O3Ba9pyWgO8bh
         AeEbyidca4tDwBPuhM9x46UHBhNmZgjN2cVb3Is7tup/xUO/4OLVcvr/cMP0n7rMOB8n
         qV2EWIkBV+Ya4JsuaeQZR0UtRWd3nMZWcvnHrYPxD9Mw9QZzWL+0mY6CI8aUsRcO+qQT
         9nYuw13C144FzmPSpKAOpY2/D6w4qBDQR6lyx2PwN/sFdexXNKbJLqHeIAAWYRXelr6w
         cbTSwNgWrGfXXK5113BNEoTiI+OUmmqMJP+KYZqO0HiZVRoBcAPUimMSK7EkRxKybB4R
         XYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009713; x=1684601713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpWRid5cmCr0SjsRhGTnuvLDk1kP0ktA07Mc2yuVwzg=;
        b=fCJmWfaH3ZDXMIwTYJTMj3hQyzEm4AwVt7JceKtovv4NiHvSG8tYSbYa5rumIzt1uz
         H6CuhSwg0aIFikto8Zu5MkVtrMdxj2zYlt/P16T5J9clbiFuROhZRyzz4h0ky1kDkwsU
         KqEiKrtFuQx3qtr4kuUMhr3RKor5VqyeRTTn9/RiZ0AlLsk+SQVKf0g8A3RZrdd9H9rc
         kk+RvkBA+3ZthrbwDFHOBYEwynhYzHvJEraRlbM2isS6jr0UuvkmedcPtHntgUsywqT5
         Nu5r7juyB3/Lpy7aL8vb/68XlxdVxs6d4MNYyNFDF8jrMwkMXwLnCziw2yWTnANL4ck5
         gxpA==
X-Gm-Message-State: AAQBX9dGbWDGypDPwn6bUwZcsNQSkED8k5ctgsIi0qz8gSrg125LVYhg
        bHCI0aonee1BsKQ6Enu6u6s=
X-Google-Smtp-Source: AKy350Y1cDONqVLv8t632CLRxjrRwLeh1FZP4I/U+6wffWnW8ySXbVTBwC5DG//mLBp6F+wgFqEEAA==
X-Received: by 2002:a4a:3315:0:b0:545:3076:9e6b with SMTP id q21-20020a4a3315000000b0054530769e6bmr1269076ooq.6.1682009712936;
        Thu, 20 Apr 2023 09:55:12 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:d090:9746:e449:eb46])
        by smtp.gmail.com with ESMTPSA id s129-20020a4a5187000000b005252e5b6604sm791913ooa.36.2023.04.20.09.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:55:12 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v11 14/14] HP BIOSCFG driver  - MAINTAINERS
Date:   Thu, 20 Apr 2023 11:54:54 -0500
Message-Id: <20230420165454.9517-15-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420165454.9517-1-jorge.lopez2@hp.com>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
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

