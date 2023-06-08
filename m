Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224BD72851C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjFHQea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjFHQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:33:47 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9B30D3;
        Thu,  8 Jun 2023 09:33:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39a95068c9cso597936b6e.1;
        Thu, 08 Jun 2023 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686242018; x=1688834018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dxcaCUraZHsQPKZ4fvUP+STx85HK+1pWRwL495yIwI=;
        b=NG4RrAeSUBXIbIKt+7d/nBpdpCZNDLZ2KrrkhzoFM6/tGrsMlYvAkC9LfhswMwmw8L
         Q982nrWUZdaGera/POcJIDOsMNibsxSUxYxYY2eHE/eIETkmhbC7X8RbFhljEks03Dzn
         MEqf8OERJR9HSNM/lpa7TeVRUFIk7DWAKxXg/ej4tvm7u1b82TCfwxCttdEmWIspDcad
         ditLJ4VOxgM9XuyJiUxaxFhWmDOBm0CBJkREpCwyiG1FcSEJAyVG2TSgrOAJ3BFAv3Lr
         ad4WIZ7Op6dxnfLPAAPUhfjGL7uQmf9jE+rLMHnNQwN3PW1mR9SpUgLUwoqrAgBe1Rdi
         PbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242018; x=1688834018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dxcaCUraZHsQPKZ4fvUP+STx85HK+1pWRwL495yIwI=;
        b=N9kiVRCHjbbz/G8Wr5O95ajyV9jX2utS1ErUDDHaXZ1u6kHVDEvUUBdpV21TJDcJ1J
         Z7qbuB9Dfodm9F2rEhmtKTCY4LGz2eYvGIvMn1MqZDIyyqLWuLOlI3t+fXLOzGEKWA5d
         6+Ri0G6gJRQqgUC7R3V64eCLt7fDNik6xT42tzJ1Uc3HEoKMx1p02q7MJrfhaKTd8JDM
         SR1cMKb4fhOyeY8GHRBMquAIVM04FoHiAubbJXBVcFSEJX8LQsJP1xHMxG9fkNXDb7Mg
         2AEIOQK1s2f8bBr+fkXBpHPUcZkojrMgzzU/XpMDa2JRASAzgLuLXzGINXaJvgOyZA2/
         NOGQ==
X-Gm-Message-State: AC+VfDznkttYGGTU0qZ+SV6l/7XW+gy8PsN34vBDiPOt7TLjMZ+h2r0w
        of1Ee2iYBhzbF8L8DYv0EZE=
X-Google-Smtp-Source: ACHHUZ4Pb7NeGmDo6nHXDyXxLBJv7rN91QOEAT3lqGpnKJpY8Sa3DPl7fO37KNYrWi0nN+zPAWZzXA==
X-Received: by 2002:a54:4185:0:b0:398:15e7:529f with SMTP id 5-20020a544185000000b0039815e7529fmr5892877oiy.46.1686242018023;
        Thu, 08 Jun 2023 09:33:38 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:a60f:2d4d:e52b:2fca])
        by smtp.gmail.com with ESMTPSA id e10-20020acab50a000000b003942036439dsm577500oif.46.2023.06.08.09.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:33:37 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v17 13/13] hp-bioscfg: MAINTAINERS
Date:   Thu,  8 Jun 2023 11:33:19 -0500
Message-Id: <20230608163319.18934-14-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608163319.18934-1-jorge.lopez2@hp.com>
References: <20230608163319.18934-1-jorge.lopez2@hp.com>
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

Add list of maintainers for hp-bioscfg to MAINTAINERS list

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

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

