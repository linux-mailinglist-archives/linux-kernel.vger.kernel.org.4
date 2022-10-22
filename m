Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC5608D99
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 16:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJVODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJVODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 10:03:06 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5F1735A1;
        Sat, 22 Oct 2022 07:03:05 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f4-20020a9d0384000000b0066208c73094so3476545otf.0;
        Sat, 22 Oct 2022 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U9p+V/nJl92so9UrSEr1XwN0g/tS5oTIgIjGDQ5542c=;
        b=h28uo+W4L8UHSSpcPOKpvlFIfn21fJ8RtVsoHEKJ6TFeQeeuXcLUxvXh4SloK727ea
         6TfM5jnIuAiT7fccZ0+VR8LdUs8vMEXSycm7rj/hy9EBtlRex8jyPn7ICGb4otDxmSx3
         J4Bp+sjqFs3m6HmBMRabgAa4j+abKVBv82mQOW/rAtMXBZq6DsDX2L/6nsa7ewqpdS14
         BaH1DWYOR3AOl4qZR4E0FoYokUfr3SfNU+ftvBwMqe4197KdI514XHMKt9uzx9KKdtQt
         Lg+aKv4ZY2F4WA7l0+ysU1XnNrLnpmYXQX3ysLVgsKht2HxWa+Yyt8v3lry5Tj5RKP42
         Q7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9p+V/nJl92so9UrSEr1XwN0g/tS5oTIgIjGDQ5542c=;
        b=7trqoIWNp5wEV2StvzADndPIE/3gI1e6ZQXNsEGgpqjbtsKWU9VwhK+d52n4oNT5IA
         lD9Iq419jMLmbfNHJDRqeiFhRq1CU7H8jlhuaNyQlH8tzy8gFLOXToJ+HcfvBZ7kp0JN
         G0VTnGDGUHP+dv9OcuptS+CxR5c60uidZqmJGDs1JO3267XY+ek0TBp3z8Xj2op2o7NT
         3xzjRFNmo0W579jTnwnOOGBkEZqvEzv5mlcI5Y8uwWfMbnkiO9g3RwweHAIQgg+AqDwz
         aGNhaLBVve3fSNjSX+z6rFpwhw8ApxP4HwE+Z0rq22ggcKwidk+0pon2HelsUpBGKpoc
         iOeA==
X-Gm-Message-State: ACrzQf1m3+ZpMR2/I60x0FDCCtONWqYtBlFqTh5AesRjHOyu3NhAAxkj
        8oTHoCtVps/o5xLtazW1rilX99pBJ2A=
X-Google-Smtp-Source: AMsMyM7PmJEdBp+qOZe0ITk8dF/kUxZ+scmLdt4c1mPp2wQ+gbet9Dee2tUAmrWBwAb6+HmbjuR7/g==
X-Received: by 2002:a9d:e91:0:b0:661:c5f8:fed0 with SMTP id 17-20020a9d0e91000000b00661c5f8fed0mr12500132otj.161.1666447385219;
        Sat, 22 Oct 2022 07:03:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r10-20020a4a964a000000b00435a59fba01sm9758281ooi.47.2022.10.22.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 07:03:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.1-rc2
Date:   Sat, 22 Oct 2022 07:03:03 -0700
Message-Id: <20221022140303.1523868-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v6.1-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1-rc2

Thanks,
Guenter
------

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.1-rc2

for you to fetch changes up to 5619c6609130bce910736a61724a5ee033a0822c:

  hwmon: (corsair-psu) Add USB id of the new HX1500i psu (2022-10-22 06:59:12 -0700)

----------------------------------------------------------------
hwmon fixes for v6.1-rc2

- corsair-psu: Fix typo in USB id description, and add USB ID for new PSU

- pwm-fan: Fix fan power handling when disabling fan control

----------------------------------------------------------------
Matthias Schiffer (1):
      hwmon: (pwm-fan) Explicitly switch off fan power when setting pwm1_enable to 0

Wilken Gottwalt (2):
      hwmon: (corsair-psu) fix typo in USB id description
      hwmon: (corsair-psu) Add USB id of the new HX1500i psu

 Documentation/hwmon/corsair-psu.rst | 2 ++
 drivers/hwmon/corsair-psu.c         | 3 ++-
 drivers/hwmon/pwm-fan.c             | 5 ++++-
 3 files changed, 8 insertions(+), 2 deletions(-)
