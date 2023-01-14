Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225966AECF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 00:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjANXfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 18:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjANXfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 18:35:07 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC1A247;
        Sat, 14 Jan 2023 15:35:06 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w14so18772950edi.5;
        Sat, 14 Jan 2023 15:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cotKAnGSNZR0YjZladix62jgHe5lpxQaAFYHqTe708=;
        b=miszWXtcuJ9nwlWcBSR6eUN++o6TN2IEYVGNjKGUWW7U/vkco4/E7qAAZJV4gui0LJ
         RCG+s2EaElkr5cLHuw2acuAg7TcZTdsNVUsDTVuJq7QlH+BU1EftXJiWku2fIyoAHJdx
         4iNI7kdRrLAe0PIJw+YvPX5KUECJ2/VFX++/fVUMaXMQ7L8xNFLYyNjwM1n8sWx9FdzQ
         1IIpstVtSySd37cCXjsb7VGui+lGDblP9QmGrpNO5GVzDfbEhYUE8YrY2rX0tHAduJtg
         g1VXRpso7v/oIHp2BbaYx8WqK5oMkVDAdNbtRHUNwfjm1E7wVOkWlYgnk5rK/bIDXNdX
         Fd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cotKAnGSNZR0YjZladix62jgHe5lpxQaAFYHqTe708=;
        b=2Af3827mxXE4FewWca4MDGEGVjRCEn7AWjfpU6jmRXgteS2g0t3XOgvU3EtpfsSfV5
         cC5q1viVZlcqrf4hV2qBwIjfMdA/Q2gqBb/JSk/OpxOyljKgxhbzTngICu8iOowLvP3P
         Gb+iKOWG9+vUmR1X+yaY1WkfJkfiY8gXNLpexvw4kl2OQF2JAaKB616i9nZ96sLM0fO5
         aVTIkwioWITqZLAxTGXXmY3HfWeGJcTEIkrv7twDfaM4qDbNvEIUuexaa5LzljD7QrkF
         zi+/3Zi5srf2mrfIjiw9xK+2Na7pHpk6Vdu+U1ZzDL1ySr/WvPL6OhZNKZELZ6EXaMQ7
         c8LA==
X-Gm-Message-State: AFqh2kqbguhBYmrvn2t3b+2IRH2K4Au5P9gh8ndDXJ5A823JqMTJPCvx
        IPa1vEABmvqdFXPvYgd4IagAiHmMYos=
X-Google-Smtp-Source: AMrXdXvjzrQIUaW9aQ28BVLrEo7vqBPKaOk9o0w8kM1k7NSj1rkSEEloX49EAX9JaTySf29E4nUQUQ==
X-Received: by 2002:aa7:cd18:0:b0:49d:f700:b225 with SMTP id b24-20020aa7cd18000000b0049df700b225mr2417077edw.28.1673739305032;
        Sat, 14 Jan 2023 15:35:05 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7ae1-c100-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7ae1:c100::e63])
        by smtp.googlemail.com with ESMTPSA id d7-20020a50fb07000000b0049cbd334b13sm1967620edq.29.2023.01.14.15.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 15:35:04 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/2] ARM: dts: meson8: Add more L2 (PL310) cache properties
Date:   Sun, 15 Jan 2023 00:34:54 +0100
Message-Id: <20230114233455.2005047-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230114233455.2005047-1-martin.blumenstingl@googlemail.com>
References: <20230114233455.2005047-1-martin.blumenstingl@googlemail.com>
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

Add more L2 cache properties which are used by the 3.10 vendor kernel
but have not made it upstream yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 0f8bac8bac8b..a86f6afb8f87 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -651,6 +651,9 @@ &L2 {
 	arm,filter-ranges = <0x100000 0xc0000000>;
 	prefetch-data = <1>;
 	prefetch-instr = <1>;
+	arm,prefetch-offset = <7>;
+	arm,double-linefill = <1>;
+	arm,prefetch-drop = <1>;
 	arm,shared-override;
 };
 
-- 
2.39.0

