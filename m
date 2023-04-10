Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3996DC8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDJQBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:01:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E875597
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:00:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id jg21so13168487ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681142442;
        h=content-transfer-encoding:link:commit:signed-off-by:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLYER13K+NrI6zCmIwDtQmW2Dz0up0GnJYK0qZbJDm4=;
        b=Pi8SoQAAve+0OUvyEV+VkBuxRpHtC9TyBSEO1J8HAw/MUglKfGzRttwjA/kTdb7ahT
         hN3admwKoJTztCyhT/FItRSe6sFuQDOlP1ryVjfWx9uTAvo9UVsT06MQE8gYUuoAFxds
         I1b/2h9z7VMF7nlAEHd4itXmDR09fQ/sugUSyxDD08ufNgdQDDtU82KJm6KOwEXe0O+j
         kgMtLWvKJfq4kbflgEfRq99zc7xZQrZpmhkyMeuOHbcJwijK7JpQvNvjDsCDblEjexCG
         o+ZeoyW1N68XtLbBazuY8fT9bWu8x/jIVpHueMwTGRouWap9r4/NQ7Uhkf4noGDCi7xp
         hUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142442;
        h=content-transfer-encoding:link:commit:signed-off-by:mime-version
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLYER13K+NrI6zCmIwDtQmW2Dz0up0GnJYK0qZbJDm4=;
        b=F9ICfulJpyE8seUVN5xCzX/g/+Eb3YaR049DI3KWFi375owUv6kXDPMq1ZBoVzTiRL
         6WZOFs5idBdStVOuXGhvO50txJm6eFYbFe7M0Jnsv5ENaxJK5bDyCK5dLsrxfkn5N++Z
         Tndn5NPUHrPVLlqGAhVEoceaFNN9H6XxtyyWW7S8CrSc9b8VsbJWCOZDT5v3KjWAN1P+
         2zbo/wr77zXxGWW151H1VZEqL9Uc0hy7jmC5E2ZWVF/3OicpASDK4JM/54BdvffQJjAV
         4cMnk6Cr4qKTl/UZ2zauP8tVJT8vTsrDb73M7k4YSyaM08GBNotKUGOqlQCqO2XczjMt
         yQiA==
X-Gm-Message-State: AAQBX9cbwzzxJFE9wBRTKLIbjUU2oZeC25zA+EctOEJOAjpNF+vGGodD
        c4srwzx0mJFhbU4voBKmJzs=
X-Google-Smtp-Source: AKy350b2UmsDYb6+u+Vkh2+O0oeyflxo5OZ41wo9U/VYajIrNuSaEATSRJfZluAHwU59XNNRxiGldg==
X-Received: by 2002:a17:906:9bed:b0:94a:5615:6a80 with SMTP id de45-20020a1709069bed00b0094a56156a80mr7312228ejc.30.1681142442394;
        Mon, 10 Apr 2023 09:00:42 -0700 (PDT)
Received: from localhost.localdomain ([79.142.69.160])
        by smtp.gmail.com with ESMTPSA id la26-20020a170907781a00b0094a8e06eaa8sm1095359ejc.185.2023.04.10.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:00:42 -0700 (PDT)
From:   Cem Kaya <cemkaya.boun@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     mario.limonciello@amd.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Cem Kaya <cemkaya.boun@gmail.com>
Subject: [PATCH v2] Add Dell G15 5525 Ryzen Edition to quirks list for acp6x so that internal DMIC works.
Date:   Mon, 10 Apr 2023 17:58:44 +0200
Message-Id: <20230410155842.177255-1-cemkaya.boun@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Signed-off-by: Cem Kaya <cemkaya.boun@gmail.com>
Commit: Add Dell G15 5525 Ryzen Edition to quirks list for acp6x so that internal mic works.
Link:   https://bugzilla.kernel.org/show_bug.cgi?id=217155
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index a428e17f0325..e044d811496e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5525"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.40.0
