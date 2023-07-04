Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73532747963
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGDVDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjGDVDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:03:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1639810C9;
        Tue,  4 Jul 2023 14:03:31 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1688504608;
        bh=jbuSoqRMhzPRGDqEOj7GbSYGStk9q68+nfDVDFfIYZk=;
        h=From:Subject:Date:To:Cc:From;
        b=bGkweJ794JmmVfgxTLgjYK550ygLtrWMHmBiuvhVIL0LA6ASD2LOXJBaFumsOJFY2
         +lX6NidkgD7Xebf3x+pExjSGcYvmtMNzncuZXS8It5X3Fbx/Ai2A9uxvQIcpRiy3/5
         iZQ7dfHXdpvS6w1zr0ljHbhxn0pd9fEx5CxEY6W8=
Subject: [PATCH 0/2] platform/x86: thinkpad_acpi: lockdep support
Date:   Tue, 04 Jul 2023 23:03:16 +0200
Message-Id: <20230704-thinkpad_acpi-lockdep-v1-0-60129548a738@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABSJpGQC/x3MTQqAIBBA4avErBPsD6mrRIQ5Yw2FiUYE0t2Tl
 t/ivQSRAlOEoUgQ6ObIp8uoygLMpt1KgjEbalk3UslWXBu73WuctfEsjtPsSF4oJNujsn21dJB
 bH8jy83/H6X0/Ud86AGcAAAA=
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688504608; l=601;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jbuSoqRMhzPRGDqEOj7GbSYGStk9q68+nfDVDFfIYZk=;
 b=IHtg3/hynCvHsKnNvwKePQhZ9CcGpO3NqWiRP3PTAPABieoutwNtXLusQcBZgmP+0fX/6PJw2
 Q44HqUOfIh1B4QQoB+Ve0A2z86X7XoK5l+i/Hb3EI4nbWjmhz0+DP7A
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate locking requirements in thinkpad_acpi through lockdep.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      platform/x86: thinkpad_acpi: take mutex for hotkey_mask_{set,get}
      platform/x86: thinkpad_acpi: use lockdep annotations

 drivers/platform/x86/thinkpad_acpi.c | 45 ++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 17 deletions(-)
---
base-commit: 03275585cabd0240944f19f33d7584a1b099a3a8
change-id: 20230704-thinkpad_acpi-lockdep-7def9d7f91b5

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

