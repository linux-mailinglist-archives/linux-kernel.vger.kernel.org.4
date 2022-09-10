Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3EF5B46A5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIJO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIJO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:29:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4FA14D11;
        Sat, 10 Sep 2022 07:29:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q9so4158258pgq.6;
        Sat, 10 Sep 2022 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=OytxOtWCSeSs4T/BX4uXUFFrqjuTvmWI55mJDpvgYCE=;
        b=a2a7ZHdghgMqf173OCs2hKXOmDlQmbUCUKrjSYgZwehuvzrjUB++Qg05gcNJM3DQ1s
         xE6BgASrFsholZnWLugYpTFmRiVukmxCSE/i2pg/SaDsWoYwleTCDSq/+EVs/41ffh1g
         NxtG6k2psjYuL3XJgd0SzdLwWInmR78oYjeHEKXdA/vlKmSrhXL4E+qc7QTfnsYGRG3R
         BNN1oCB3DJWLJi067ut33Og5yeW/tAzGMSR196Ka/VlQJIcVEwhmZW7hccjlickjyEUH
         /HCv6t1kj9gOwOENDBBPd9ltMf5WF6awG28lOK+s0uNxCkwBThWsyru1+vUYVYEFLaHP
         XW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=OytxOtWCSeSs4T/BX4uXUFFrqjuTvmWI55mJDpvgYCE=;
        b=QNCpw2N9wfqDKjwFtBwsUsiP5hcpcqmcpzI6dF5wfGyHbta9yae2NMZwrFNxy9ADgN
         qrX6alvduplc1x/EFt1xsrnhgjpu7fyCi7aseWoqYI2sifqMpEuRlYDLO24gftuLC7cz
         669PTLX4+5IpRYerQKRtNeXEfGHh9nFKRa7xJ2yWF290icebNgC962guqJn+0xPZtSSy
         lJe0GyDhGsNSuAvduoMefTZmkWS7Rs97ZogdrKrXkwTAY1WGfq2ReYNcr2H/R1fCn/dK
         18Dl2+gf8r0wFPouWw1iYLi2ZUf1mitKpdRLJvSIEpZRKxDc1jF0QsaFfEGepNT0taJO
         +tqw==
X-Gm-Message-State: ACgBeo1aziR1C9gzpZyJzMi9oxTF49xmnTQVyNbh7LAd2l3mVetbqzII
        aY1imswopPeKbFgEfYP49HJAuXc9w205nA==
X-Google-Smtp-Source: AA6agR6Ef+KduPRW0JcdkI29+K3hdvHtHgCNQjfAO+6cnd6gufw92qIAz6mapPq5ss9gBsGqltV2RQ==
X-Received: by 2002:a05:6a00:d4b:b0:53f:4690:d31 with SMTP id n11-20020a056a000d4b00b0053f46900d31mr14287879pfv.73.1662820184836;
        Sat, 10 Sep 2022 07:29:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902714f00b00174f61a7d09sm2298979plm.247.2022.09.10.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 07:29:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.0-rc5
Date:   Sat, 10 Sep 2022 07:29:42 -0700
Message-Id: <20220910142942.1152413-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v6.0-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.0-rc5

Thanks,
Guenter
------

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.0-rc5

for you to fetch changes up to 88700d1396bae72d9a4c23a48bbd98c1c2f53f3d:

  hwmon: (asus-ec-sensors) autoload module via DMI data (2022-09-09 10:45:08 -0700)

----------------------------------------------------------------
hwmon fixes for v6.0-rc5

- Fix severe regression in asus-ec-sensors driver which resulted
  in EC driver failures.

- Fix various bugs in mr75203 driver

- Fix byte order bug in tps23861 driver

----------------------------------------------------------------
Alexandru Gagniuc (1):
      hwmon: (tps23861) fix byte order in resistance register

Eliav Farber (6):
      dt-bindings: hwmon: (mr75203) fix "intel,vm-map" property to be optional
      hwmon: (mr75203) fix VM sensor allocation when "intel,vm-map" not defined
      hwmon: (mr75203) update pvt->v_num and vm_num to the actual number of used sensors
      hwmon: (mr75203) fix voltage equation for negative source input
      hwmon: (mr75203) fix multi-channel voltage reading
      hwmon: (mr75203) enable polling for all VM channels

Eugene Shalygin (1):
      hwmon: (asus-ec-sensors) autoload module via DMI data

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |   1 -
 drivers/hwmon/asus-ec-sensors.c                    | 408 +++++++++++----------
 drivers/hwmon/mr75203.c                            |  72 ++--
 drivers/hwmon/tps23861.c                           |  10 +-
 4 files changed, 278 insertions(+), 213 deletions(-)
