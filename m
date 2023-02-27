Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D086A4921
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjB0SDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjB0SDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:03:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017A226CF5;
        Mon, 27 Feb 2023 10:02:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id d30so29317088eda.4;
        Mon, 27 Feb 2023 10:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jA+Lt1N1sRGBhDWl8eAUrx1VsbjP+7nxRLZvfuV9NIM=;
        b=ohCq7HCXVyQHmixjagY46TJdfqaPloWcT8pxPH/Gd/2KvejziMGkQjLtU9SyUIetjD
         H49G8NSo/4F8TpHJoznnHd5KrKABX56Jj1H1tujuRv2qcoFWyeQHjLhJHiV6vu6misBO
         NqEfblGMFx4qdez2g2YwY2XzMLwkgs75wOr9kg/f3X8zY1oiNErM+HtVe7+vJODfhj7J
         KiEUTu+hb4yd5vRzGJGuqxTYRdn5p4RguOQOWQI3eJNMyil6NuN6qg6x4QbNayLwCDej
         AsH0Q8X5iFvgh2lbwk2oKD0p5Jp0lHEInymlCpW3Pk6DwMcPdqS/ruBdvZ54xzJihYxm
         Hc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jA+Lt1N1sRGBhDWl8eAUrx1VsbjP+7nxRLZvfuV9NIM=;
        b=arnJaMf+q7Xqge+SD39+fzTgbo/XgudHrNrQgFZsr9GVLBX4F0P7/gI6kqjaqm8JsY
         i7X0e0o9k1AS7cKsVbQVcU23Ord9aU0Enx3JpmNHU3fmWio2PVtKNRMqjxNfI+QuQONj
         wnxYGHC4wRSmG9E6+yjsle/Z9SMjA/Z51Ifa6Q741KJMfPHL5xdiD8KJ51wpOgoTXzo8
         HixKeCUzMIP3rEPDnldwEBWFzh2M6+CC8CVkO4+Kj0ihFHlz56MGR23S99XP30dcOSRb
         jv1wsFZXXrgcB6IluhDlY4WnWKXUPWGAelY80zbkqXJvcJhVijYzkqKYzpYYOASVnwq/
         ETrA==
X-Gm-Message-State: AO0yUKUgddVAJKiVIBDhheXTklrDtijGZsw4IMtW1ANBM/nSyeWOwKmm
        WbZ8ma/5pxfNufykBdw8tv3Vk/f7HaM=
X-Google-Smtp-Source: AK7set9U65ypVENKfxii9yz8Eom3G/RBCArjNLfMoocJz09WfGkr3p6/8QDtYUUxctM3O4CI3sXjRA==
X-Received: by 2002:aa7:df93:0:b0:4aa:c354:a0e7 with SMTP id b19-20020aa7df93000000b004aac354a0e7mr439596edy.25.1677520856884;
        Mon, 27 Feb 2023 10:00:56 -0800 (PST)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::dc02])
        by smtp.gmail.com with ESMTPSA id n30-20020a50935e000000b004af640933desm3423578eda.78.2023.02.27.10.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:00:55 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 0/2] iio: Add kernel-doc and rename
Date:   Mon, 27 Feb 2023 19:00:37 +0100
Message-Id: <cover.1677520155.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
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

The main goal behind the kernel-docs is to give a hint where the
functions are expected to be called. 

Renaming iio_trigger_poll_chained() to iio_trigger_poll_nested() came
from a Jonathan's suggestion in [1]

I am a little bit unsure about moving the kernel-doc of iio_trigger_poll
to industrialio-trigger.c 
My motivation behind it:
- having the source code together with the documentation tends to be 
better for understanding 
- make it easier to understand the _nested in iio_trigger_poll_nested 
(the call to handle_nested_irq)

[1] https://lore.kernel.org/linux-iio/Y+6QoBLh1k82cJVN@carbian/

--
Kind Regards
Mehdi Djait


Mehdi Djait (2):
  iio: Improve the kernel-doc of iio_trigger_poll
  iio: Rename iio_trigger_poll_chained and add kernel-doc

 drivers/iio/accel/bma400_core.c               |  2 +-
 drivers/iio/accel/kionix-kx022a.c             |  2 +-
 drivers/iio/accel/mma8452.c                   |  2 +-
 drivers/iio/accel/msa311.c                    |  2 +-
 drivers/iio/adc/ad7606.c                      |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c            |  2 +-
 drivers/iio/adc/max11410.c                    |  2 +-
 .../common/st_sensors/st_sensors_trigger.c    |  4 ++--
 drivers/iio/gyro/fxas21002c_core.c            |  2 +-
 drivers/iio/gyro/mpu3050-core.c               |  2 +-
 drivers/iio/humidity/hts221_buffer.c          |  2 +-
 drivers/iio/industrialio-trigger.c            | 19 +++++++++++++++++--
 drivers/iio/light/acpi-als.c                  |  2 +-
 drivers/iio/light/rpr0521.c                   |  2 +-
 drivers/iio/light/st_uvis25_core.c            |  2 +-
 drivers/iio/light/vcnl4000.c                  |  2 +-
 drivers/iio/light/vcnl4035.c                  |  2 +-
 drivers/iio/potentiostat/lmp91000.c           |  2 +-
 drivers/iio/pressure/zpa2326.c                |  2 +-
 drivers/iio/proximity/as3935.c                |  2 +-
 drivers/iio/trigger/iio-trig-loop.c           |  2 +-
 include/linux/iio/trigger.h                   |  8 +-------
 22 files changed, 39 insertions(+), 30 deletions(-)

-- 
2.30.2

