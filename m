Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F196139E2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiJaPSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiJaPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:18:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F88DE80;
        Mon, 31 Oct 2022 08:18:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q9so30338245ejd.0;
        Mon, 31 Oct 2022 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTV1RDq/tqDmxPZjQ5buJyVBHl/4xI27X2Mwsnm3/U8=;
        b=R6xRqcKQmu00dy1Cfnxt+XFMnppMpjDHkI+/jH9MTTupl6brGVib0eZesPU9DhNRI9
         mY6+FqzbE30I3It9nOMuqluV6gYcP0xygz4ZK95tbAmjAvFeQDTs6ZDGqepvyjxekf1z
         Xash2POIGK6RMge1cJA9jultjlSzgCXAuj4L2KZ0moaChoR4Ngz8tmI2aeTMi9bIsDsp
         +jsL1e6OAGxVVbz39FLrFqu0cYlESAlDLU7wUJGoIzwd7QP0FbCfMukbBrsk4LZ8IsR1
         w9k7DayNzBb+0lpk5bD4NL+Qv7Sl2IRsumn+HLtvb5aORkiyeQuTYDTijJNcdO7if+dj
         vPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTV1RDq/tqDmxPZjQ5buJyVBHl/4xI27X2Mwsnm3/U8=;
        b=CxYdWhjiGCYwKcCO/JPtGur53451QDarWXjTpZSJf3SOCM9rMqJqzox+jSWSC7fyxF
         sjJE1aacLrZ3qZ5fnph6dfQGi+DHOwRU9KXaZowrDSbzA5kSs8Gb7lzUM4MfeZKWG9vD
         rdK2KAd2VCWf/fg75u2bKLsh5dPuu+LuiIRbAnUw4IZuygzbba5HD9IbxFzLQWykgBS5
         3hvYhSqqGd7uMeuBbmYCYFhDuY0yv7eRFD3pS/MvpAnEsKwLxUggrbxvdOgqlUXv0ihA
         KNR1eVMsNT+/wMfcbeLOtflhd28p7BGGD7lF2WZ3SG5YTmOZATJL+l+C36aCKOgrB5Fs
         0WfA==
X-Gm-Message-State: ACrzQf29hSnxwzSQARor539D2B/O/uNYeAAH9JmENGecxsaDEkPRIVuI
        UTPhHdlPAgRgWi+ZxXmFLXw=
X-Google-Smtp-Source: AMsMyM5oEFz72DTLsasj9GphB8VANdv7H6HI866he5Oo33ldWNk8V7nCVUxTrI/S+TbdbZxkphCHWg==
X-Received: by 2002:a17:907:845:b0:731:2f6c:6dbd with SMTP id ww5-20020a170907084500b007312f6c6dbdmr13364159ejb.551.1667229506461;
        Mon, 31 Oct 2022 08:18:26 -0700 (PDT)
Received: from felia.fritz.box (200116b826e26a00101a4a419a6960a9.dip.versatel-1u1.de. [2001:16b8:26e2:6a00:101a:4a41:9a69:60a9])
        by smtp.gmail.com with ESMTPSA id u25-20020a056402065900b00461cdda400esm3386142edx.4.2022.10.31.08.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:18:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] power: supply: core: repair kernel-doc for power_supply_vbat2ri()
Date:   Mon, 31 Oct 2022 16:18:08 +0100
Message-Id: <20221031151808.826-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function power_supply_vbat2ri() does not have a parameter called table,
despite it being mentioned in the kernel-doc comment. The table is actually
obtained from the info parameter, the battery information container. Hence,
./scripts/kernel-doc -none drivers/power/supply/power_supply_core.c warns
about this excess function parameter.

Adjust the kernel-doc comment for power_supply_vbat2ri() for make W=1
happiness.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 4b5fb172fa99..9035e349bf53 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -870,7 +870,6 @@ EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
  * power_supply_vbat2ri() - find the battery internal resistance
  * from the battery voltage
  * @info: The battery information container
- * @table: Pointer to battery resistance temperature table
  * @vbat_uv: The battery voltage in microvolt
  * @charging: If we are charging (true) or not (false)
  *
-- 
2.17.1

