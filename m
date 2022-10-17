Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C72600D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJQLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJQLU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:20:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE41788D;
        Mon, 17 Oct 2022 04:20:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q9so24244833ejd.0;
        Mon, 17 Oct 2022 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9t/qNpTv9ITKXNmBoaXQjDh/SDRGL5ElwdwTk6muWw=;
        b=LQ1HCRx4f33bI6jQrqSGmqqAM4gla6eNep3FmMyulePrS9NOk0NNirMtl9NTjXf2qh
         +gI3SDKkLaV85ptTk1WzlgxFp6VF6XSz2QR7y8JHyx9tMLI7GyEuPdYU5OYutAruE9bL
         gMVpT/LMw/LmmB3KGPcy1/8RG70IuIYCmujXF5CInEB3ZauYdc29c+/1YXbaiDX5Cq1d
         TfExOnlm8qGOZgHmqZslFmOzEFmOshqUp0t5NxHS2W+ddN1+IE9FvgjvUVx/G5Ohi60Y
         o9F5sJBko74D9b+I0g02xlHwW/gUZ0UCRQ5seW11yEpjwHpKo4P+a/N3EULjlJjAontE
         iC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9t/qNpTv9ITKXNmBoaXQjDh/SDRGL5ElwdwTk6muWw=;
        b=1GdKT1tH+ClJQE+5+Z46uPfwGmR5jLH8xJSHlXjd8/h85dB7RCq2mQqoKJWFY9AHp+
         Zx9Rzwb9PuXsE/p1cAJG6lY2LAokbn36HfVNYoy/ltoNI8yVcjJdIlnVfjM8IOwlWh51
         8czRwE7xoCX2nHenqWQX4YexrdRyrEzZBdWpoDzpD9tZMdk3qiNte9Zpj/XD/9c/sGz3
         KNGro9+5kv6l7321o6TyldmzsW3KEqm+A3nv4PNuqASib7W8DPSXnSObMq8SVcGOKfoI
         Qr65ntk6t0VNqQTOYnBZ+PVxEtiwsz8xyd13zxhD6ehSVASg4qjIks93XtgFnU8dA4N4
         dBUQ==
X-Gm-Message-State: ACrzQf2Mw7DdMTyswhpdCY2iZ5DDMvrSXWFmvm3gX5Ow7AdWRIfP3sLT
        KHpfaTlxfoH3Dys0duY1ZFE=
X-Google-Smtp-Source: AMsMyM7Oc9daSe0mUSiKWp3t0WQbxw7e/0TFnbVatKH0B/PSBZ0zJPvXpDOiRoiEOFR1G1c8e21Ffw==
X-Received: by 2002:a17:907:8a1c:b0:78d:ef44:7759 with SMTP id sc28-20020a1709078a1c00b0078def447759mr8404473ejc.441.1666005620904;
        Mon, 17 Oct 2022 04:20:20 -0700 (PDT)
Received: from arch.localdomain ([111.119.183.53])
        by smtp.gmail.com with ESMTPSA id ku16-20020a170907789000b0078cb06c2ef9sm6043391ejc.8.2022.10.17.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 04:20:19 -0700 (PDT)
From:   Mushahid Hussain <mushi.shar@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>
Subject: [PATCH] Documentation: Fix spelling mistake in hacking.rst
Date:   Mon, 17 Oct 2022 16:20:26 +0500
Message-Id: <20221017112026.88324-1-mushi.shar@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Fix `botton half locks` to `bottom half locks`.

Signed-off-by: Mushahid Hussain <mushi.shar@gmail.com>
---
 Documentation/kernel-hacking/hacking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index 9a1f020c8449..1717348a4404 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -120,7 +120,7 @@ You can tell you are in a softirq (or tasklet) using the
 .. warning::
 
     Beware that this will return a false positive if a
-    :ref:`botton half lock <local_bh_disable>` is held.
+    :ref:`bottom half lock <local_bh_disable>` is held.
 
 Some Basic Rules
 ================
-- 
2.38.0

