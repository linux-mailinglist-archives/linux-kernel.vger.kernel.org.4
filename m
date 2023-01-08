Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8447666193B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjAHUWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAHUWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:22:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779B9F599
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:22:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t5so1849533wrq.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF0KYZTK8QJNvtuEmjEBv0Uobp1zLO6Frlg8xQpiDQY=;
        b=oykHx1VBFGqHeEeU/T0fOpgU8yKVSyaaHkI9wiqZXYRplC+7cMsaGiBNLCB4JERLhJ
         B7hZTUK8sNVDoyCGzXJixRHDAIvTxZkJAW2NAqaQifbMbzaTMY3yRl2VvfhBbMHihVP8
         U5mjD6gV5GJZsJ2UBRo9nf6T6yPljZqNyyUeXRbiq7Sv82RBap5qCc9I4UpfDY7GDFCq
         w6vFhEqpygJo6+7gNA9SRgXqQNAtGCScnWcAF02LYXRVoSqSyC9asEQYvm8TZ8E/4NMR
         rHYVNUwIRIttIUL/beCm8Upd/8Y9X0SWFr9WV7nB1mo4i90NgZOMkHd3OGf2fxvc9pNN
         ow4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jF0KYZTK8QJNvtuEmjEBv0Uobp1zLO6Frlg8xQpiDQY=;
        b=2XgGpIHjbWpR2QDqZrkZE2U5Z9ARogDtVH1tuy+OYj1eRpa9Iuoet07J9DOaPAMUwq
         ByFMxE4fuNu+/W/x2NnFnnSbYaWLK1K2lSshsYzNk3IvXyTHeb0bHRk1EyQvY7lTACf8
         RhmELxu6YkjAI8b3S50YzMDY/N9uac6eKrlNn9sYB3xeGBeIXsROv/F1lQXkzM9OVI4j
         Gxu1Xu8PefAhu/R+fdsO9fECKZZMk6DEoBLL+IoWQhQl9HDfMHiUqgVzN9HMdlBuPyj6
         4BkrFq/mD/4XI5QUlI8whPPu6dpJ2xWCpFRY/fY+5vSg3SwkUkQDYGi7uI5U8aDfOFRY
         uBMg==
X-Gm-Message-State: AFqh2kqeqyhqh/VnD2F3MtJI3enq+HN9znlaIioGOk6FCWDdQbEfPbtp
        XRo1Zi47Ly9X3GhX81pKTiGOuQ==
X-Google-Smtp-Source: AMrXdXumY/IjM9BzQccvh+V/4dRS5DcghPax3xvD7ryg8A6oSHhaK6kQIvkyicpd39XFx5kC2Tkaiw==
X-Received: by 2002:a5d:6dc4:0:b0:2b4:e5e:1e16 with SMTP id d4-20020a5d6dc4000000b002b40e5e1e16mr8092345wrz.35.1673209330825;
        Sun, 08 Jan 2023 12:22:10 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id s10-20020adfea8a000000b002421ed1d8c8sm6652754wrm.103.2023.01.08.12.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 12:22:10 -0800 (PST)
Message-ID: <72fcddd3-0429-4e23-ab68-2a502f451966@linaro.org>
Date:   Sun, 8 Jan 2023 21:22:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Xu Panda <xu.panda@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] generic trip points for the thermal framework
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

here are the changes for the generic trip points which were postponed 
during the last release. They have been in the linux-next branch since 
November.

The following changes since commit b878d3ba9bb41cddb73ba4b56e5552f0a638daca:

   thermal: int340x: Add missing attribute for data rate base 
(2022-12-30 19:48:37 +0100)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/generic-trip-point

for you to fetch changes up to 3a151494dc04c76add577ae66e8a04f900638aaf:

   thermal/drivers/armada: Use strscpy() to instead of strncpy() 
(2023-01-06 14:14:48 +0100)

----------------------------------------------------------------
- Rework a large bunch of drivers to use the generic thermal trip
   structure and the opportunity to do more cleanups by removing unused
   functions in the OF code (Daniel Lezcano)

- Fix some locking issues related to the generic thermal trip rework
   (Johan Hovold)

- Fix a crash when requesting the critical temperature on tegra, this
   fix is related to the generic trip point (Jon Hunter)

- Use strscpy() to instead of strncpy() (Xu Panda)

----------------------------------------------------------------
Daniel Lezcano (32):
       thermal/core: Add a generic thermal_zone_get_trip() function
       thermal/sysfs: Always expose hysteresis attributes
       thermal/core: Add a generic thermal_zone_set_trip() function
       thermal/core/governors: Use thermal_zone_get_trip() instead of 
ops functions
       thermal/of: Use generic thermal_zone_get_trip() function
       thermal/of: Remove unused functions
       thermal/drivers/exynos: Use generic thermal_zone_get_trip() function
       thermal/drivers/exynos: of_thermal_get_ntrips()
       thermal/drivers/exynos: Replace of_thermal_is_trip_valid() by 
thermal_zone_get_trip()
       thermal/drivers/tegra: Use generic thermal_zone_get_trip() function
       thermal/drivers/uniphier: Use generic thermal_zone_get_trip() 
function
       thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
       thermal/drivers/qcom: Use generic thermal_zone_get_trip() function
       thermal/drivers/armada: Use generic thermal_zone_get_trip() function
       thermal/drivers/rcar_gen3: Use the generic function to get the 
number of trips
       thermal/of: Remove of_thermal_get_ntrips()
       thermal/of: Remove of_thermal_is_trip_valid()
       thermal/of: Remove of_thermal_set_trip_hyst()
       thermal/of: Remove of_thermal_get_crit_temp()
       thermal/drivers/st: Use generic trip points
       thermal/drivers/imx: Use generic thermal_zone_get_trip() function
       thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
       thermal/drivers/broadcom: Use generic thermal_zone_get_trip() 
function
       thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
       thermal/drivers/ti: Remove unused macros 
ti_thermal_get_trip_value() / ti_thermal_trip_is_valid()
       thermal/drivers/acerhdf: Use generic thermal_zone_get_trip() function
       thermal/drivers/cxgb4: Use generic thermal_zone_get_trip() function
       thermal/intel/int340x: Replace parameter to simplify
       thermal/drivers/intel: Use generic thermal_zone_get_trip() function
       thermal/drivers/exynos: Fix NULL pointer dereference when getting 
the critical temp
       wifi: iwlwifi: Use generic thermal_zone_get_trip() function
       thermal/drivers/mellanox: Use generic thermal_zone_get_trip() 
function

Johan Hovold (3):
       thermal/drivers/qcom: Fix set_trip_temp() deadlock
       thermal/drivers/tegra: Fix set_trip_temp() deadlock
       thermal/drivers/qcom: Fix lock inversion

Jon Hunter (1):
       thermal/drivers/tegra: Fix crash when getting critical temp

Xu Panda (1):
       thermal/drivers/armada: Use strscpy() to instead of strncpy()

  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |   2 -
  drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |  39 +---
  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 209 
+++++----------------
  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   2 +-
  drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |  71 ++-----
  drivers/platform/x86/acerhdf.c                     |  73 +++----
  drivers/thermal/armada_thermal.c                   |  40 ++--
  drivers/thermal/broadcom/bcm2835_thermal.c         |   8 +-
  drivers/thermal/da9062-thermal.c                   |  52 +----
  drivers/thermal/gov_bang_bang.c                    |  37 ++--
  drivers/thermal/gov_fair_share.c                   |  18 +-
  drivers/thermal/gov_power_allocator.c              |  51 +++--
  drivers/thermal/gov_step_wise.c                    |  22 +--
  drivers/thermal/hisi_thermal.c                     |  11 +-
  drivers/thermal/imx_thermal.c                      |  72 +++----
  .../intel/int340x_thermal/int340x_thermal_zone.c   |  33 ++--
  .../intel/int340x_thermal/int340x_thermal_zone.h   |   4 +-
  .../int340x_thermal/processor_thermal_device.c     |  10 +-
  drivers/thermal/intel/x86_pkg_temp_thermal.c       | 120 ++++++------
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  44 ++---
  drivers/thermal/rcar_gen3_thermal.c                |   2 +-
  drivers/thermal/rcar_thermal.c                     |  53 +-----
  drivers/thermal/samsung/exynos_tmu.c               |  62 +++---
  drivers/thermal/st/st_thermal.c                    |  47 +----
  drivers/thermal/tegra/soctherm.c                   |  35 ++--
  drivers/thermal/tegra/tegra30-tsensor.c            |  17 +-
  drivers/thermal/thermal_core.c                     | 154 ++++++++++++---
  drivers/thermal/thermal_core.h                     |  24 +--
  drivers/thermal/thermal_helpers.c                  |  28 +--
  drivers/thermal/thermal_netlink.c                  |  19 +-
  drivers/thermal/thermal_of.c                       | 116 ------------
  drivers/thermal/thermal_sysfs.c                    | 135 +++++--------
  drivers/thermal/ti-soc-thermal/ti-thermal.h        |  15 --
  drivers/thermal/uniphier_thermal.c                 |  27 ++-
  include/linux/thermal.h                            |  12 ++
  35 files changed, 618 insertions(+), 1046 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
