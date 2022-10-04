Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32E5F4024
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJDJol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiJDJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:43:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362313FB1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:41:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j16so8502052wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=lTRrmobpQmhWQxPmOHsAlI+7MzWc30kqTg7yDRM8zig=;
        b=dj6uLicMJVfUKq61X1r7P3A3fpmzoC2tvvAKYI2o+M1kEZG/hKTeG/NpUW5JpO9etj
         qqBX3+5WoRybTpGWtfHpFLyl9BSAcdaZRVeATPwUuJKsSMf+vyzwwJrHoL+ZbBoxwwQx
         /HWCEjOZPqkOfsAxz+ZvPRgBi6eFTlbIiXXHE7tOc2vL2PHTIDIOVTCSPFjz8Sh+hKoh
         lZFingxYx2leYsY1N7NzzeZ0tCFXuvwxo7T5sbfBDO1aQ/NtHv2cydwGKIGl4/JtsbwO
         i8LFecjTX9ZIeI9ckO+AZcFiwzjgZTzUEYaqYfiQUaSp027sTa0xKzzTEsvBJOQvD/FR
         KdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=lTRrmobpQmhWQxPmOHsAlI+7MzWc30kqTg7yDRM8zig=;
        b=lafHU5Dc+NrGKNOIwWVeOXJrzTWIn/u36bc7VLUqm6sjSIASNpEm49Eqbb5o23aQy4
         0PVQSLa+srmEZCNuTlArncQDpDuetZvvzPme4hWEFfEmwsSEmPUnaUaIYI9jiGL7C7Ji
         NFQIGFkleTbVi1FhhIJzNdm+qsI6qP1gJzSpFwzyUZcR6p4bDjXT6cF6qo2cJyCBPiNi
         hgUC3TRWdFF4IcaDmAlvyYhdPDY3S28rXcZct646fNmnK+G3BNJZr7Nafm1XzKO138Vt
         UZghbUf0EBuRNXoZ+msHcMKH0VdJWTPrxLJNHaj4amBJX9QE25xjHctTbOAExLlDr8at
         x8Mw==
X-Gm-Message-State: ACrzQf2sQ9IDKuLiSfaIfHqPwq37B3CzsCk7wTDWT2Wvxr9FK6umIKMB
        G8LKtlaxV2abN72f1bdwYFXQkw==
X-Google-Smtp-Source: AMsMyM55wyzrUt4P+WFYEP/1zqiNhtYdg3/kIjds4GHcsfaZyGOfOJwpmaMrwFK68B0d9C8XcMAl1g==
X-Received: by 2002:a05:6000:2c1:b0:226:e7d0:f098 with SMTP id o1-20020a05600002c100b00226e7d0f098mr15999036wry.578.1664876476464;
        Tue, 04 Oct 2022 02:41:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c456:8337:99aa:2667? ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.googlemail.com with ESMTPSA id l13-20020a5d4bcd000000b00226dba960b4sm11998980wrt.3.2022.10.04.02.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:41:15 -0700 (PDT)
Message-ID: <58a7d685-e9e9-e47a-1e20-41b18302e6a7@linaro.org>
Date:   Tue, 4 Oct 2022 11:41:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [GIT PULL] thermal drivers for v6.1-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

this is a pull request for more thermal material for v6.1. I've dropped 
the trip point rework as a lock issue has been spotted on exynos.

Most of the changes are fixes. There are more pending changes for the 
thermal drivers on the mailing list but they require some more review, 
so they will have to wait for v6.2

Thanks
   -- Daniel

The following changes since commit 2e70ea7fb9873e642982f166bf9aaa4a6206fbec:

   Merge branches 'thermal-intel' and 'thermal-drivers' (2022-10-03 
20:43:32 +0200)

are available in the Git repository at:

   ssh://git@git.linaro.org/people/daniel.lezcano/linux.git 
tags/thermal-v6.1-rc1-2

for you to fetch changes up to b0c883e900702f408d62cf92b0ef01303ed69be9:

   thermal/drivers/qcom/tsens-v0_1: Fix MSM8939 fourth sensor hw_id 
(2022-10-04 11:21:43 +0200)

----------------------------------------------------------------
- Used the platform data to get the sensor id instead of parsing the
   device in the driver and remove the dedicated OF function (Daniel
   Lezcano)

- Fixed Kconfig dependency for the QCom tsens driver (Jonathan
   Cameron)

- Fixed missing const annotation for the RCar ops driver and removed a
   duplicate parameter check (Lad Prabhakar)

- Fixed a NULL pointer dereference when calling set_trip_temp() (Lad
   Prabhakar)

- Fixed the fourth hardware id in the QCom tsens driver (Vincent
   Knecht)

----------------------------------------------------------------
Daniel Lezcano (2):
       thermal/drivers/imx_sc: Rely on the platform data to get the 
resource id
       thermal/of: Remove the thermal_zone_of_get_sensor_id() function

Jonathan Cameron (1):
       thermal/drivers/qcom: Drop false build dependency of all QCOM 
drivers on QCOM_TSENS

Lad Prabhakar (3):
       thermal/drivers/rcar_thermal: Constify static thermal_zone_device_ops
       thermal/core: Drop valid pointer check for type
       thermal/core: Add a check before calling set_trip_temp()

Vincent Knecht (1):
       thermal/drivers/qcom/tsens-v0_1: Fix MSM8939 fourth sensor hw_id

  drivers/thermal/Makefile          |  2 +-
  drivers/thermal/imx_sc_thermal.c  | 68 
+++++++++++++++++++++++++++++++++-----------------------------------
  drivers/thermal/qcom/tsens-v0_1.c |  2 +-
  drivers/thermal/rcar_thermal.c    |  2 +-
  drivers/thermal/thermal_core.c    |  2 +-
  drivers/thermal/thermal_of.c      | 44 
--------------------------------------------
  drivers/thermal/thermal_sysfs.c   |  8 +++++---
  include/linux/thermal.h           | 10 ----------
  8 files changed, 42 insertions(+), 96 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
