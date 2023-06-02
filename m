Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D937202C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjFBNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbjFBNLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:11:40 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13CE79;
        Fri,  2 Jun 2023 06:11:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38c35975545so1749285b6e.1;
        Fri, 02 Jun 2023 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711464; x=1688303464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9HhW1QPOz6WTxYOa6mD6gfn6R8qH8lALXUH8QmZoMg=;
        b=fQ+qAfBQMjIuAyRlAvTPwfbf5Me5ZjpGp7P7C51kYjBG6myQT0L8e9fnKJMlORybYt
         Bw+ZdWD4uuHH2WWr4TyXroo9YXXsLKtl7/54p9ZLNgceLALBEJEtqDv2lEK392HXxMDl
         Po3SsGa3VAMdOX9/JgtL08ecHAZGBDPjz+PMU02R9cfosPtCCLCiXgQIbyjuXcKbgrgQ
         L4jk1lvVuVXwi2nu0Fy9ygqve/dMpvWKU4i36AwovhDjKkTc0cYIhLrWgsdTSdLS0Nio
         asORBip7bUgL5LMDcLct1OPW/6hJTRiSm1sA98sBvra59JaK1sWgFL0Emxgrq1lL1xLX
         rl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711464; x=1688303464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9HhW1QPOz6WTxYOa6mD6gfn6R8qH8lALXUH8QmZoMg=;
        b=TtrW52Ms91gAuImUVkZWCzsg+oM1RmxpC2VmXAqPUEoogWEbudt1kPLPzWzCPpbU4S
         jNWwpclI9TwBmdRynQXbi3OQmpssYq+fx7903glVLD6EzolFPF9Ef7jRdBc0YaJbN4kV
         hIknNNwCgN2Aupu9WrXrQXBzH9qW0un6J7rcL8q68de4SjBYaW6eQrFXsew2EleaYGro
         grsOKsUs0YkHbLyFqbekLxGqUPN+zY0n+oUJWWkwOmC596sihXTnDWjWqSD/6vb3OeVr
         PygSS2qLT3XbGRyhl6YgYnEiXSFz1JUrWSHsLST1V4ycsqAAEMsdi6Qo+zjWvvkySGmc
         DUUA==
X-Gm-Message-State: AC+VfDyM2a9QM1hk390RAowJokGO8PDL5Ek4i0JxynU/JkG9izfHhWkh
        A0lozM5797HrF3xbkfIrL3hr6wyFhb4=
X-Google-Smtp-Source: ACHHUZ747itczI8l3V7O4QkNLcuUjGdXcX1NaPUDKfDI8JJ/kf7SUwxb9g2OcGiDHfhQ6VVWtBzhhQ==
X-Received: by 2002:a05:6808:64c:b0:398:5478:b7fa with SMTP id z12-20020a056808064c00b003985478b7famr2436212oih.45.1685711463936;
        Fri, 02 Jun 2023 06:11:03 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:125c:6b6d:18e9:9361])
        by smtp.gmail.com with ESMTPSA id k17-20020a544691000000b0039a531d9b92sm483762oic.56.2023.06.02.06.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:11:03 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v16 13/13] hp-bioscfg: MAINTAINERS
Date:   Fri,  2 Jun 2023 08:10:44 -0500
Message-Id: <20230602131044.3297-14-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602131044.3297-1-jorge.lopez2@hp.com>
References: <20230602131044.3297-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 9af9ace0e348..648c986f5867 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9436,6 +9436,12 @@ S:	Obsolete
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

