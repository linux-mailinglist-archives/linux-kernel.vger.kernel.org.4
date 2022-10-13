Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9A5FE469
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJMVtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJMVs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:48:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F30216F40D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:48:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pq16so3194695pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=mpYh04Q3DjlI17Rhho09EJ79/GDmjZTt6la/N71F8B4=;
        b=zBZPybDZNWh0wskUsbS4NK/YN1WJN7j/VTZPGNWss6CuvIgFCDE/TUfG3dMIUyiHIP
         6vafwla//z3BmGexBI0dvVf9KRQfSDNsltnsG4Vhg81lm831akj3WNTxI/xvrmxakual
         4zvjv3TLF/XG8ts2lesWYruHX962zn9Mujg7xNoZU+IZJO5lLp0oAbs1ASDm/PzaS0xD
         DXA580Ycb6z2Hr75Gt9LVqxjDTFts36QaaVqYuq3Gat2dDfXPkN5iBZmZi6L3qmg5z8c
         xRCmOcQMjoWsfkCL/WCFvQOfqDrqLjEh0oBiRa0U9DN96g3Tz9GeCOhA4URiE8OrtnxK
         G2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpYh04Q3DjlI17Rhho09EJ79/GDmjZTt6la/N71F8B4=;
        b=FBpWWJ6hW18LKgBIQxPdvj2ZAIutrJIqLIcpbUjxzKo+HPFZHCCoJvNf/h3Sj/nYWd
         DRYl0JR37UUmUDA9OJhYs5MAecJ945hfdNMfkJ4eUSM51Bv4VdkkROQkNtlAy90UyYXl
         emud/kpjAilt65Qh06IPXPcOP9lTyG2chtnsgbNkIims1RyikfddOAOW7AC1T5OWk5Up
         0ZPi93wVmbL1W9EC/DgTuk+7pk7b8bTsi96uNQBFFWEsYfU3YAQW6tt9w6gfeT9UaWgD
         n3L6rkx52HdHQhgcF8r+AeEVSLYHI1CDhHjJQxGcYG1qA7HAmqxgO55+/vg5i9gM8X9W
         m1mA==
X-Gm-Message-State: ACrzQf3jV2DlI/lwKXwIuFrEe8LEyjkxHLg0JQVew9pDmJX9tHYD3IoY
        Y7y8qqAEgqr1vXWsklDw77i12xIMrnkMj52i
X-Google-Smtp-Source: AMsMyM5uSktAQYhJmahw0FgwYcraN3cyOGbXNxi5pDP7skcwP5gAuMAO+oUqTn+89Bhe/9HO9PMSgg==
X-Received: by 2002:a17:902:9048:b0:17f:93a5:4638 with SMTP id w8-20020a170902904800b0017f93a54638mr2029735plz.108.1665697736640;
        Thu, 13 Oct 2022 14:48:56 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79483000000b00562b389292bsm179728pfk.51.2022.10.13.14.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:48:56 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for awilliam
Date:   Thu, 13 Oct 2022 14:46:36 -0700
Message-Id: <20221013214636.30721-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     alex.williamson@redhat.com, kvm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3705c487450b..41a925931cc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21305,7 +21305,7 @@ M:	Alex Williamson <alex.williamson@redhat.com>
 R:	Cornelia Huck <cohuck@redhat.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
-T:	git git://github.com/awilliam/linux-vfio.git
+T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/driver-api/vfio.rst
 F:	drivers/vfio/
 F:	include/linux/vfio.h
-- 
2.38.0

