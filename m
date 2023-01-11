Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1533C665892
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjAKKFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbjAKKEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:04:12 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEEED11D;
        Wed, 11 Jan 2023 02:01:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g13so22722619lfv.7;
        Wed, 11 Jan 2023 02:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UcPP1o1gIQ+AMRWHqG1bQnZMuMeBJxJwuShgYMSMgt0=;
        b=ffufMZqPn9j4XMdmTfRy4HXOM/0aobwJqcZqFaKxKgHTHqqfhkXqNILCiqI4MS7MjC
         gjHakG5xZUBS/5Bsnrrtd/alnbgNgovRk5mIUAkfl0w7tpEFHZ6PNKnbszX30L5rlpmZ
         eeki6YcXxJi7k2jPVRmzV7spHIAZotaNzaXEyznXFIgy3PsdbOQYdd91opfDFxPkqVuW
         y7Z8hL9DM+b/OxrbKKA5OJkBUFymZWsumyq0ZEcOA5AW3c0TdRfph+GehYBe+iE0Rcs5
         AhHn9fy1aR6Skd9RejGd2JSs4kuG1GeiR7SIxISjkVlnGS4u/iHdc96DWh+xx+xE+Io3
         XzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcPP1o1gIQ+AMRWHqG1bQnZMuMeBJxJwuShgYMSMgt0=;
        b=r/XxapZsaraVug+9n7ZDTr/A8vSefCLfMTY+vaMAeA2vh8mg8AULF9KuiQJe/npWJ1
         Upjj+7RLmwVxsMrPsr0WVOt9yX6sBXvGxY7dgg1DdVL9R/iWLE8iXOXoZzbQHtlUpTk7
         IcbOo3udZJciYpt+JMXu+sKQhbPh0uk6HlXjycLwmOPVBCqp+n/bP6yJ8HlFFy8hlXdc
         aF/wKSnuiUdbUQbYktwWo7tVtb1oKFipvz3W2trmwchBN6nwwvz2/ucXNJUJucL6nve7
         Zcq+SShpxI70Emo23un5ot67ydcOYEMyjglL7PdeQq7nrgQDELWVk0ZJnu96uzujrPC3
         n6lA==
X-Gm-Message-State: AFqh2kp0C7Gz2E87/vXDpmINHewxrCWaf25VMsB2dt1qGV0xVfgA7xwG
        et+ZWd8JjRw2f51FOzvtN5k=
X-Google-Smtp-Source: AMrXdXswH9b2Rs7IxM4ginoS/QJlALNbfLOGneEgsNiokBvV2y6osnwzATUtkvkZcZ2ojGluW4a0/w==
X-Received: by 2002:a05:6512:ea2:b0:4b5:5bcc:cbcd with SMTP id bi34-20020a0565120ea200b004b55bcccbcdmr21135950lfb.0.1673431283017;
        Wed, 11 Jan 2023 02:01:23 -0800 (PST)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id p37-20020a05651213a500b0049771081b10sm2653199lfa.31.2023.01.11.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 02:01:22 -0800 (PST)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: ethanolx: Add label for the master partition
Date:   Wed, 11 Jan 2023 13:01:04 +0300
Message-Id: <20230111100105.707-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add label "bmc" for the flash master partition. The master partition
is required for the firmware update in the OpenBMC ecosystem.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 6406a0f080ee..889b2fdd19cf 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -58,6 +58,7 @@ &fmc {
 	flash@0 {
 		status = "okay";
 		m25p,fast-read;
+		label = "bmc";
 		#include "openbmc-flash-layout.dtsi"
 	};
 };
-- 
2.25.1

