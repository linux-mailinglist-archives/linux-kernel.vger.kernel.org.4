Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005916A8332
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCBNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCBNFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:05:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2773400F;
        Thu,  2 Mar 2023 05:05:12 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s11so3299615edy.8;
        Thu, 02 Mar 2023 05:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuLOWhWrC2ZYcXfdcOiL8yPuEBe7t2pO8CMXuZCt8xw=;
        b=ktrq8nUVhNvC1Qu22L5/jX0bNGgKqOYkpcPF9GEnKyWlv9TUBPegtLkSmjT/ua2C4W
         E/fWKL5aVyd8srHxUvyf2Dgh7z9CJY3GLV075C3XSzXJeqvnkpzPVmcAR1rrMVr2+Ki2
         h6osqCEAsMdKDoSmD8VybU1bw3q+P8eu3MhxMm1EXRUdHpDwpg20pfkHOS8iYV2Vo5Tq
         bhCa3Q46sKSTmtnpNH2mydP04cOGpNkiE6p6O7ptvh7wNLnFMzMY3xiES0lPz4Ua8CAW
         AX53e/mHN8h46B9CGgduEq4sT4+2/6+IVGxWn+R0vTdGIZyH8UregVuwZakroFH+JTu7
         aM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuLOWhWrC2ZYcXfdcOiL8yPuEBe7t2pO8CMXuZCt8xw=;
        b=tuc95lTbXjxF/E8TB1MfA/448Vk5ZYXYuqsavF7U9nbGJEvbjjDudZK+Tv+lRp1y5H
         lDspMPA2a/qDNyUzVJffa8jc6XF09i+6jc6zS+iSomyHTFG+jqJlGAR1HgX9hmc7SDU+
         VwvCUKmqTAGHAWbI89usTlRw98P9/kE5rh01tLQVJpGfUe5DbBBkheHnTnnHadwHuuv6
         Xb5J8voZE2aw1NYUnt0tXdEdJwJf9H0PRTBZoXiCo140I5IXav++AIV0HvLC7PyAtv+q
         5oZAbqCRxX4WK7wVtBUe065bJZa8421UtmxFvDzmuXaqbjXsEt1G9ZT27QOOO1JiAvZk
         rUlQ==
X-Gm-Message-State: AO0yUKXGs9ciwPUyEXQKTLE4szZ/sWaR+5VqH6+iTPUCBm6Cy47T7FSY
        IDCTpfbJC/WXxnLdj2wrdDJ1+qrlGeo=
X-Google-Smtp-Source: AK7set/jJ4KfZUe6vszyiFhHzlD7yUojvpO8zjksHWQah5yt+7I9bXne5ed3TwHNfDo3Gz/MtKlOww==
X-Received: by 2002:aa7:c612:0:b0:4ad:7224:ce9d with SMTP id h18-20020aa7c612000000b004ad7224ce9dmr10155537edq.17.1677762311297;
        Thu, 02 Mar 2023 05:05:11 -0800 (PST)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::dc02])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b004af759bc79asm6932903edi.7.2023.03.02.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:05:10 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v2 0/2] iio: Add kernel-docs and rename iio_trigger_poll_chained
Date:   Thu,  2 Mar 2023 14:04:34 +0100
Message-Id: <cover.1677761379.git.mehdi.djait.k@gmail.com>
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

