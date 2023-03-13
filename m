Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A26B7AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCMOsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCMOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:47:59 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03FE73AE0;
        Mon, 13 Mar 2023 07:47:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4AF273200754;
        Mon, 13 Mar 2023 10:47:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 Mar 2023 10:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1678718826; x=1678805226; bh=1Tl9Nr3VhFjj5+5e3yKZreEBB/EH+2rar2/
        gd2lLpXA=; b=d2rPMRNTIeokJyFEBrVmTqwi3gtFTmPCpy53c8Fc7o7S8tQyOSc
        s6o0rKPt7Jhy0+XLmYDo7s9dj9yqgEQbk5uECyYwupqcliA5OfoxJExFOEIWVjT1
        xEDfmgoyHiJANuD+7hBwYV7QoLyqhbTjJ+eHCFXwdQIzfQoC3ewfgkPihIqkCJ1t
        AIyrZ5EpA1QPzL6FmgpLpssPsrxULiixiUHLmfVKD0kCj4qb/L81soJqBNOS/te1
        uS+6sqknTV9EjL35fbCOKEyHTx3QAMsssjb9M5Nsq+kX4dKCuUQwSF2nscg5Y/Ro
        P0WwyOO8iNnlWxL2mK/96sHTdTMgJqlT+Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678718826; x=1678805226; bh=1Tl9Nr3VhFjj5
        +5e3yKZreEBB/EH+2rar2/gd2lLpXA=; b=Qe9NUyfii0X8qGtpIJdfZ+WAJGDAX
        B5bwPvBfoVRMzlVshV+oR4H9JDhoxGRKA4cf4+A3Elf6TKzXH1pyihqTICnqDBi/
        FXhPSbQw9NRvbz6qkQUiGDq8m5qEdaUUd11hkqRph1tJjWtLoFhD8aVjbkElYHRq
        k4/rdxhKRZtNhsKa7M1NaXMsCh0XIriJrGS8iviblCa+T2TFEWVBAElnODwhXxV+
        VlHSTPI44Y8dwD4s/igl4E0ZLnkogUX3btnMa1HyqCWsK6zQZQcWEi/F7fksF3Gs
        X/E+YH8MK6Rmu2CEvtZOIA4s4DUGDe0+sL4jqwtiuEM6mduGj/JXZxe+w==
X-ME-Sender: <xms:ajcPZCeqDmW82XO-1poX6vs7pPT0rlEyV1qCkj1M75Nr1dKYIjKQwQ>
    <xme:ajcPZMOYByqTQ7-8S6M17rf_6IhvY0eBiL6CadCCiCfM8QorPygU-3jjfCdhnY2Gg
    sZuBYV3u7IhGo8>
X-ME-Received: <xmr:ajcPZDiVn51LSkzhwCm2fBfR__o3pitHNtBZ26fJxfqXhdc29ICoqriv7qwBLrMMUI1aMXbvfCh07fzy9RzWXR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhimhhonhcu
    ifgrihhsvghruceoshhimhhonhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeuveehgedtfeegfeduvdefudeuudffffffjeevueeg
    fedufeeiudegudegvedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhimhhonhesihhn
    vhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:ajcPZP9EhuGuGV7mv2jtWDuOweifcNLk4PAFlXUB9t9YvVIgPH2iEg>
    <xmx:ajcPZOs-gKH6FcHu3xLvXh0Zk8W0rnPNNa6rBBqvCL8PWO5UmhlYQQ>
    <xmx:ajcPZGGIrEdI5jHYE3WzFVrth9GFLj3AVHZ91N1TBugNPRLWwjm5NQ>
    <xmx:ajcPZH4eXkJoSDXs4hl2C7u3CyNeuJ7pAya71KX6ic4jMYjPnom4xQ>
Feedback-ID: idc5945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Mar 2023 10:47:04 -0400 (EDT)
From:   Simon Gaiser <simon@invisiblethingslab.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Gaiser <simon@invisiblethingslab.com>
Subject: [PATCH v2] ACPI: s2idle: Log when enabling wakeup IRQ fails
Date:   Mon, 13 Mar 2023 15:47:10 +0100
Message-Id: <20230313144710.3516-1-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable_irq_wake() can fail. Previously acpi_s2idle_prepare() silently
ignored it's return code. Based on [1] we should try to continue even in
case of an error, so just log a warning for now.

Discovered when trying to go into s2idle under Xen. This leads to a
system that can't be woken, since xen-pirq currently doesn't support
setting wakeup IRQs [2]. With this you get at least some helpful log
message if you have access to console messages.

Link: https://lore.kernel.org/linux-acpi/20230313125344.2893-1-simon@invisiblethingslab.com/ # v1
Link: https://lore.kernel.org/linux-acpi/CAJZ5v0jahjt58nP6P5+xRdtD_ndYPvq4ecMVz6nfGu9tf5iaUw@mail.gmail.com/ # [1]
Link: https://lore.kernel.org/xen-devel/20230313134102.3157-1-simon@invisiblethingslab.com/ # [2]
Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
---
v2:
 - Based on feedback switched to only logging a warning instead of
   returning an error.
---
 drivers/acpi/sleep.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 4ca667251272..6b30dea94fae 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -714,7 +714,13 @@ int acpi_s2idle_begin(void)
 int acpi_s2idle_prepare(void)
 {
 	if (acpi_sci_irq_valid()) {
-		enable_irq_wake(acpi_sci_irq);
+		int error;
+
+		error = enable_irq_wake(acpi_sci_irq);
+		if (error)
+			pr_warn("Warning: Failed to enable wakeup from IRQ %d: %d\n",
+				acpi_sci_irq,
+				error);
 		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
 	}
 
-- 
2.39.2

