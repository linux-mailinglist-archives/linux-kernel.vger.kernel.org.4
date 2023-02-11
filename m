Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD16932B6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBKQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBKQ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:59:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83CA26BF;
        Sat, 11 Feb 2023 08:59:09 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o15so4851838wrc.9;
        Sat, 11 Feb 2023 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBkYE1i7V7Gb2zy1Mx0KGE+HC1Mrumou1Jxzkf6EEuM=;
        b=b9KbvDEL0aw8o0PCi9XAGerGtsBALWi8mZn5crgkXiszm7QvD62el8b6+6MjMcIpzB
         MGweAmVlkD3TNMin+dec9jKEmxvrhhJS0+Yp90zyvUCwpRf2PQBQI2tDA+l1WUfII7GX
         Ly6rQCAdjK7bJB/zYBm1ejRHPQawyn7WGetqQHMWJi6QIeJ4+S0D0M3FkigLR7ItAjBG
         8+n6syT6oAwgs4jMYCzx25lFA/QHvzc+tB4knq/3eKsTkLAjT73C4RzwPm0Octiapizj
         Ssku8Uw/xgGa+d7eUqce31gBM4k2lQxa8+TAy/uguXqGnyiOYShqQEUHm2JfhYbIWq1R
         7HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBkYE1i7V7Gb2zy1Mx0KGE+HC1Mrumou1Jxzkf6EEuM=;
        b=Zs7QMdbrnwipBUMUtWjeDg3b2lGBD2wzJDtr3Dtt42f5VPSdmuaGGLebVapjd/Uvpg
         hUFWBSmao7Tcny5kUjRggiav/FLp7Dj4mMPhafpZJf+puZx8DfYq8pES6qJJbqbpdB61
         XskM4omljLKx9agn60X2agC5joO0CkTpzGGozX8vMnEvEbtRRyniNSVlDJHockVN0myG
         Wwd5ymXiOGEeK/jcnFyg5DMnfaFqopIJepMky3oO8sknFUPqjuNOOir7TZLTetM3EhPT
         ppuEXF4DHe9r0itCwpIcEL1ZFD816ip0PQMMHFyxkSRWHmozET79i0fqjmZiE7zX9G/6
         1L7w==
X-Gm-Message-State: AO0yUKW2Fu7XQrTE40W/ERu/vJkZcw5eOm2vhdG+m9+BLqZjaguE7yCa
        G5YJZIeY8Cd+iUvQSZIDIia073xnGBpVPg==
X-Google-Smtp-Source: AK7set9JPD4FLktPb4ijZxeI1eDXVBuaRM7Rw6wJEvSGSIg0+EvG2UbjLKQhsEZAg3pd3yNlZOk2YQ==
X-Received: by 2002:a05:6000:12cb:b0:2c3:4ef0:343e with SMTP id l11-20020a05600012cb00b002c34ef0343emr17097337wrx.5.1676134748306;
        Sat, 11 Feb 2023 08:59:08 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20d3:ac00:30d6:d4a1:e6f6:5876])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b002c54536c662sm5097893wrn.34.2023.02.11.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 08:59:07 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 0/5] hwmon: (aquacomputer_d5next) Add Aquacomputer Aquaero control
Date:   Sat, 11 Feb 2023 17:59:18 +0100
Message-Id: <20230211165923.17807-1-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Add support for controlling the Aquacomputer Aquaero 5/6 fan controllers. The
controllable settings include temperature offset, fan PWM and fan PWM mode.

The first two patches expand the capabilities of the control system without
changing functionality. Patches 3-5 add support for Aquaero control.

Leonard Anderweit (5):
  hwmon: (aquacomputer_d5next) Support one byte control values
  hwmon: (aquacomputer_d5next) Support writing multiple control values
    at once
  hwmon: (aquacomputer_d5next) Add temperature offset control for
    Aquaero
  hwmon: (aquacomputer_d5next) Add fan PWM control for Aquaero
  hwmon: (aquacomputer_d5next) Add PWM mode control for Aquaero

 Documentation/hwmon/aquacomputer_d5next.rst |   7 +-
 drivers/hwmon/aquacomputer_d5next.c         | 247 ++++++++++++++++----
 2 files changed, 213 insertions(+), 41 deletions(-)

-- 
2.39.1

