Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9A6D3B85
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDCBbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjDCBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:31:36 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1579410F5;
        Sun,  2 Apr 2023 18:31:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 04D7B320097D;
        Sun,  2 Apr 2023 21:31:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 02 Apr 2023 21:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1680485493; x=
        1680571893; bh=GX5wswwc9ioI6tRN/FjlVtZp/Nq/YYWiACOgX926AhU=; b=k
        jvI/wcSLRN6fbepGKRvkXa2+d9zF6mRgCctN8I5PvW0abPl/v99Kc7W9zmhQiQn8
        htgS1BnJecx2x4I2Aef98y45xPSwT42i68dTZ8BGVqiI60tZOBQpwyqN/HhB8OhU
        I7B9xgCpk1p1s1yZLOBx4uaNWub6U+R/+Ns75nT5oABdbYDu+FxJZ60Xc/bYB0I/
        pvOLQr9rhfDC5MCdEjopQ5TfKoZ0miaVIqR8fWRpotpte7NXCHRJk/dKw5zmsxBy
        9Uj7cv0xcl5i1ZoEB2kOlO7kcNL5zHQAA1qcGed8DhtiRLnsyOSgqsjxfZ2jCnDU
        17Hz7kDrdwQBr5eWQAdXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1680485493; x=
        1680571893; bh=GX5wswwc9ioI6tRN/FjlVtZp/Nq/YYWiACOgX926AhU=; b=N
        eadoCMTTS1OHj+Vfzz2utLNUDfg59wMkzdp0LD1oXdzCXuSzaMd5SZvqY8StZ8Ut
        lCCqvzzz9YJSy8SbGlsvehd8igxbTT+SVSHDnZsf+VylLPP59xXXvYgRQ2tZEolf
        5EjB4cEj/XUPtp0drfWD1/AHCyzJVaZ4B9dmNEi/f3whnSjGh+jU6x0Cmgq8lYRN
        3n+owPVVWKNQU3/Tpuu1ubTkWEbs6CygJMfnYE76nAI8HlQd322IsQR48g72BSRV
        tuN05HHpsVypBr3wVyT16czamhjR25lTYiP5EWrVej9L4EEAScjErNhQ/rLnl668
        pLGCJ1mI2rCa7ZGL96e5A==
X-ME-Sender: <xms:dSwqZKjXKNCjo2bcmlLG1Bg1TxzJmigzFk458uqxy1slp97QlSNi6Q>
    <xme:dSwqZLDe-hmNHRubbWfMjD66awYmSE2e5nOCetHKX0OBuhozweWqSCube2LxFiEnD
    gKmO26t4urx_OmbbtI>
X-ME-Received: <xmr:dSwqZCFJg1Xs7yfctVmCj9wMKEFPndIbqBvZ2Hzios-xJU3XyfvMStHs5Odi4rSQqI44VtX0Hn9uDeYwiAfCyZbuLuFhVl9gC6lt2xbRJJrFMuMdkzD7Yvj1380DVZcHYe1CKyxzKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepkeefudeutedutdegheejhfdvieehjefhleefgfevtdeivdfhleehiedu
    feegffeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:dSwqZDQ16anNhggnm38AxsUvYYojFlU05xkZB-9WP9mmzed6TG8clw>
    <xmx:dSwqZHwjTD5JjpFTZD7A8PhixewnT8ATesN0AILdCKtL5PxwnC38Xw>
    <xmx:dSwqZB4gg60M5zx4oP3eUbgPWNFAK1qrpYlCxDPP4eCzoThRl5Mb5Q>
    <xmx:dSwqZOx0mWjit4CZZznOF56tp_3Mqnfdul41SNQyDSweon6ILbriXg>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Apr 2023 21:31:32 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org, W_Armin@gmx.de,
        mirsad.todorovac@alu.unizg.hr, linux@weissschuh.net,
        Mario.Limonciello@amd.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: think-lmi: Clean up display of current_value on Thinkstation
Date:   Sun,  2 Apr 2023 21:31:20 -0400
Message-Id: <20230403013120.2105-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403013120.2105-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230403013120.2105-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ThinkStations on retrieving the attribute value the BIOS appends the
possible values to the string.
Clean up the display in the current_value_show function so the options
part is not displayed.

Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Reported by Mario Limoncello <Mario.Limonciello@amd.com>
Link: https://github.com/fwupd/fwupd/issues/5077#issuecomment-1488730526
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2: For some reason v2 doesn't apply cleanly so rebased and
started again. Hopefully this one works

 drivers/platform/x86/think-lmi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 87f832142d8d..78dc82bda4dd 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -920,7 +920,7 @@ static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *at
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
-	char *item, *value;
+	char *item, *value, *p;
 	int ret;
 
 	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
@@ -931,9 +931,12 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
 	value = strpbrk(item, ",");
 	if (!value || value == item || !strlen(value + 1))
 		ret = -EINVAL;
-	else
+	else {
+		/* On Workstations remove the Options part after the value */
+		p = strchrnul(value, ';');
+		*p = '\0';
 		ret = sysfs_emit(buf, "%s\n", value + 1);
-
+	}
 	kfree(item);
 
 	return ret;
-- 
2.39.2

