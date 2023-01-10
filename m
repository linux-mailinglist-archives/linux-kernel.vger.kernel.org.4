Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBEC664084
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjAJMcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAJMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:32:02 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FD17040;
        Tue, 10 Jan 2023 04:32:01 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id u19so28110135ejm.8;
        Tue, 10 Jan 2023 04:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0Tu1ANer9+ofM7n91wNWxKquZURFG5C2aog/NU/x0c=;
        b=k3p8mNaQjB8sknQS3guObFuXuzhXFcNJ7TB1IdjYjNxuNmLZXxblcEyUq/0LpENO1B
         KAO/BbQxBmqa1tHzq8Ys88U/+5EL9IdG5oG8I6LM87ubr9U5ddFnERG2ll2Nt4nnq95B
         YhzpcTWKyBdnl4MUkmwLw+83kgxq3FyUK9KoZ0nDVvQMt3hiX0kzcl0/6Z41w6Oa4+XP
         7NeS8QyI4IC22RkVIAi2sIkCB8VM6kE9DbJHxEaiTqFzY+6DmZEdIlkAMADbPqIwKZr6
         Qy47WZdLBTGwlGXYQCWJJvFxOh3qOkpWz7AFQicS4EhhfmRL+Ffk5tXLuqgDVqlA8NYb
         vACw==
X-Gm-Message-State: AFqh2kpKh0QIYUTIrdU65QvZPRt3rhkRjfBefaPEKY/CoBOWwPIbVOhQ
        0k6XBkyqnyqP5hy3itcDu9GB8MM+EISP/eXpSEWPeUk8tg4=
X-Google-Smtp-Source: AMrXdXvO+DfyUVxCrQI9tVc8Y8QR3m/uEr9cKAd5cWk6OikdGrtEAsxVA8UgZ6wI6mwMNMraAdPd4W6D7qTePbqL/Rs=
X-Received: by 2002:a17:907:98ee:b0:7c1:5ff0:6cc2 with SMTP id
 ke14-20020a17090798ee00b007c15ff06cc2mr4913389ejc.246.1673353919580; Tue, 10
 Jan 2023 04:31:59 -0800 (PST)
MIME-Version: 1.0
References: <72fcddd3-0429-4e23-ab68-2a502f451966@linaro.org> <CAJZ5v0iSsg63KdfY79DHSeR+DnaQF2c7GoFZaUw3eHh4XNkWRA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iSsg63KdfY79DHSeR+DnaQF2c7GoFZaUw3eHh4XNkWRA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:31:48 +0100
Message-ID: <CAJZ5v0gX0KttHGFWAJU5urTfTQVqZeXjFOBrrovygQamwYs_4A@mail.gmail.com>
Subject: Re: [GIT PULL] generic trip points for the thermal framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Xu Panda <xu.panda@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 9:17 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Jan 8, 2023 at 9:22 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Rafael,
> >
> > here are the changes for the generic trip points which were postponed
> > during the last release. They have been in the linux-next branch since
> > November.
> >
> > The following changes since commit b878d3ba9bb41cddb73ba4b56e5552f0a638daca:
> >
> >    thermal: int340x: Add missing attribute for data rate base
> > (2022-12-30 19:48:37 +0100)
> >
> > are available in the Git repository at:
> >
> >
> > ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> > tags/generic-trip-point
> >
> > for you to fetch changes up to 3a151494dc04c76add577ae66e8a04f900638aaf:
> >
> >    thermal/drivers/armada: Use strscpy() to instead of strncpy()
> > (2023-01-06 14:14:48 +0100)
> >
> > ----------------------------------------------------------------
> > - Rework a large bunch of drivers to use the generic thermal trip
> >    structure and the opportunity to do more cleanups by removing unused
> >    functions in the OF code (Daniel Lezcano)
> >
> > - Fix some locking issues related to the generic thermal trip rework
> >    (Johan Hovold)
> >
> > - Fix a crash when requesting the critical temperature on tegra, this
> >    fix is related to the generic trip point (Jon Hunter)
> >
> > - Use strscpy() to instead of strncpy() (Xu Panda)
> >
> > ----------------------------------------------------------------
> > Daniel Lezcano (32):
> >        thermal/core: Add a generic thermal_zone_get_trip() function
> >        thermal/sysfs: Always expose hysteresis attributes
> >        thermal/core: Add a generic thermal_zone_set_trip() function
> >        thermal/core/governors: Use thermal_zone_get_trip() instead of
> > ops functions
> >        thermal/of: Use generic thermal_zone_get_trip() function
> >        thermal/of: Remove unused functions
> >        thermal/drivers/exynos: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/exynos: of_thermal_get_ntrips()
> >        thermal/drivers/exynos: Replace of_thermal_is_trip_valid() by
> > thermal_zone_get_trip()
> >        thermal/drivers/tegra: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/uniphier: Use generic thermal_zone_get_trip()
> > function
> >        thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/qcom: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/armada: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/rcar_gen3: Use the generic function to get the
> > number of trips
> >        thermal/of: Remove of_thermal_get_ntrips()
> >        thermal/of: Remove of_thermal_is_trip_valid()
> >        thermal/of: Remove of_thermal_set_trip_hyst()
> >        thermal/of: Remove of_thermal_get_crit_temp()
> >        thermal/drivers/st: Use generic trip points
> >        thermal/drivers/imx: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/broadcom: Use generic thermal_zone_get_trip()
> > function
> >        thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/ti: Remove unused macros
> > ti_thermal_get_trip_value() / ti_thermal_trip_is_valid()
> >        thermal/drivers/acerhdf: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/cxgb4: Use generic thermal_zone_get_trip() function
> >        thermal/intel/int340x: Replace parameter to simplify
> >        thermal/drivers/intel: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/exynos: Fix NULL pointer dereference when getting
> > the critical temp
> >        wifi: iwlwifi: Use generic thermal_zone_get_trip() function
> >        thermal/drivers/mellanox: Use generic thermal_zone_get_trip()
> > function
> >
> > Johan Hovold (3):
> >        thermal/drivers/qcom: Fix set_trip_temp() deadlock
> >        thermal/drivers/tegra: Fix set_trip_temp() deadlock
> >        thermal/drivers/qcom: Fix lock inversion
> >
> > Jon Hunter (1):
> >        thermal/drivers/tegra: Fix crash when getting critical temp
> >
> > Xu Panda (1):
> >        thermal/drivers/armada: Use strscpy() to instead of strncpy()
> >
> >   drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |   2 -
> >   drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |  39 +---
> >   drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 209
> > +++++----------------
> >   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   2 +-
> >   drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |  71 ++-----
> >   drivers/platform/x86/acerhdf.c                     |  73 +++----
> >   drivers/thermal/armada_thermal.c                   |  40 ++--
> >   drivers/thermal/broadcom/bcm2835_thermal.c         |   8 +-
> >   drivers/thermal/da9062-thermal.c                   |  52 +----
> >   drivers/thermal/gov_bang_bang.c                    |  37 ++--
> >   drivers/thermal/gov_fair_share.c                   |  18 +-
> >   drivers/thermal/gov_power_allocator.c              |  51 +++--
> >   drivers/thermal/gov_step_wise.c                    |  22 +--
> >   drivers/thermal/hisi_thermal.c                     |  11 +-
> >   drivers/thermal/imx_thermal.c                      |  72 +++----
> >   .../intel/int340x_thermal/int340x_thermal_zone.c   |  33 ++--
> >   .../intel/int340x_thermal/int340x_thermal_zone.h   |   4 +-
> >   .../int340x_thermal/processor_thermal_device.c     |  10 +-
> >   drivers/thermal/intel/x86_pkg_temp_thermal.c       | 120 ++++++------
> >   drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  44 ++---
> >   drivers/thermal/rcar_gen3_thermal.c                |   2 +-
> >   drivers/thermal/rcar_thermal.c                     |  53 +-----
> >   drivers/thermal/samsung/exynos_tmu.c               |  62 +++---
> >   drivers/thermal/st/st_thermal.c                    |  47 +----
> >   drivers/thermal/tegra/soctherm.c                   |  35 ++--
> >   drivers/thermal/tegra/tegra30-tsensor.c            |  17 +-
> >   drivers/thermal/thermal_core.c                     | 154 ++++++++++++---
> >   drivers/thermal/thermal_core.h                     |  24 +--
> >   drivers/thermal/thermal_helpers.c                  |  28 +--
> >   drivers/thermal/thermal_netlink.c                  |  19 +-
> >   drivers/thermal/thermal_of.c                       | 116 ------------
> >   drivers/thermal/thermal_sysfs.c                    | 135 +++++--------
> >   drivers/thermal/ti-soc-thermal/ti-thermal.h        |  15 --
> >   drivers/thermal/uniphier_thermal.c                 |  27 ++-
> >   include/linux/thermal.h                            |  12 ++
> >   35 files changed, 618 insertions(+), 1046 deletions(-)
> >
> > --
>
> Pulled and pushed out, thanks!
>
> I've merged my thermal-intel branch on top of this and pushed out the
> result into the bleeding-edge branch.  Please check my merge conflict
> resolution there.

It would not build due to tj_max being undefined in
pkg_temp_thermal_device_add().

Should be fixed in bleeding-edge now.

Rui, please have a look at that too.

Thanks!
