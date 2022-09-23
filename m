Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2C5E8223
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIWSyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiIWSyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:54:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB4012164D;
        Fri, 23 Sep 2022 11:54:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t3so993294ply.2;
        Fri, 23 Sep 2022 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lW7/qWZ/WvDrx96hAYFtSZz1LI0hioVV1pKSvBV48Rw=;
        b=Buvn+xZy6x48HfU0DONLmPql/ZRDhMcbgGPvGvOqXbbDHKF/Sq8xBuLakIrOgKgDNh
         gj9WZ99rTSMEll8i3Jy6U2FRqXqKxgFxVFYpPTxLso+efV7f0aF2wfomfCcLJi0E1cIX
         ZYVnE4W/kj1VOafrXBOWePZaf/jYHKrA82I1IlXPWBuCX4T+TLsWTMha+OE99S/Ao1rb
         rIfm6X/HxSb2VbO7xdVSGpA+WxYnghdax1gmbhxEYAsHiPN0kuPDKIj/S4pONyLZ4gbS
         EWGtWBmO2BOI0FsA2gtM5FWl8PPjRvDd5RK0tY/EUnJE+KfgoYr9IBuMIYLh8x0DIHDh
         OygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lW7/qWZ/WvDrx96hAYFtSZz1LI0hioVV1pKSvBV48Rw=;
        b=IxX9bLrQnkuQnfHDOzXduDZBtvxvwcWALbw20F73XgFY0pLev7C9ecvxQMNJlzJa42
         EhvN0NCswk27sqerszpYPYn6kHe9N0gVaRLcfB26SsTj5zqcDLkpZCRyYgpPAz6IgHpx
         srXPv227zjSj7ImBC1VfJySGRcnVZOs0aMjOLaULBmtclp/7oonwq9yub7YI4/VheExl
         1L7ufHBNcwbIR014ZETprPoDq0q7u33uwrf2WXfhtU16N55XKYRNxihZflzeV70/HsGY
         Eu/O1MYNXZosL50iYIwuJhFsWALKndsETOfJD8yylpIFkkXCe6mq9R9MYLC+PFJ0phFM
         WA0Q==
X-Gm-Message-State: ACrzQf34yzous0SZJ6Xnq5GJg9hbJAnuSTvj/hN+8X21Xo78oXXTRlEP
        2nIdAgfllV0v++DKeRki9lU=
X-Google-Smtp-Source: AMsMyM6ba0wSuF2CCXasqSH9WNielBVfIgSUnXbH9P8fY79O3NNNAwzoo44S68zY92KPhYqWU9DcAw==
X-Received: by 2002:a17:90b:1d07:b0:203:6732:e280 with SMTP id on7-20020a17090b1d0700b002036732e280mr22173931pjb.172.1663959244879;
        Fri, 23 Sep 2022 11:54:04 -0700 (PDT)
Received: from localhost.localdomain ([115.99.115.48])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b00176b3d7db49sm6490497plh.0.2022.09.23.11.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:54:04 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jagathjog1996@gmail.com
Subject: [PATCH v3 0/2] rtc: max31329: add support for Maxim max31329 RTC
Date:   Sat, 24 Sep 2022 00:23:56 +0530
Message-Id: <20220923185358.11023-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver and device tree bindings support for Maxim max31329 real
time clock.

Changes since v2.
1. Removed log messages from error cases.
2. Removed OSF check from _read_alarm(), _set_alarm(), _set_time().
3. Removed CLKOUT pin initialization in probe() since it is configurable
   during runtime.
4. Configure wakeup support when interrupt is successfully configured
   or if the 'wakeup-source' parameter present in DT.
5. Added check for 'years' in _set_alarm so that it doesn't' cross current
   century.

Changes since v1.
1. Move 'allOf' after 'maintainers' in DT.
2. Add 'wakeup-source' into device tree bindings.
3. Add wakeup support depending on the 'wakeup-source' parameter from DT. 
4. Remove unused 'dev' member from device private data structure.
5. Use '__maybe_unused' attribute for of_device_id table.
6. Initialize local variable 'events' to 0 in interrupt handler.
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
7. Add Reviewed-by tag for device tree bindings.

Jagath Jog J (2):
  dt-bindings: rtc: add Maxim max31329 rtc device tree bindings
  rtc: max31329: Add Maxim max31329 real time clock

 .../bindings/rtc/maxim,max31329.yaml          |  61 +++
 MAINTAINERS                                   |   7 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-max31329.c                    | 507 ++++++++++++++++++
 5 files changed, 586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
 create mode 100644 drivers/rtc/rtc-max31329.c

-- 
2.17.1

