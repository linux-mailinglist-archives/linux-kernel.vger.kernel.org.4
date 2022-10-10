Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C985FA2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJJRrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJJRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:47:44 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343E69184;
        Mon, 10 Oct 2022 10:47:43 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id i9so7576526qvo.0;
        Mon, 10 Oct 2022 10:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jv86Vf+p1vocEHP4ncmuBlZBjtxstd5HAmslvFY0pLg=;
        b=yixWe+3cCe8KmtUEFfL/J7lJAfbYmd4xSGWfgV//8i/JiqMjilUOlkk+AZczIF1mal
         RtBfmFNVCiQoHmEdlopyQPky9WqPk5lsDp3dVpphjWVd/KZ/Rx/fZDQSuJAsGqRWPX/o
         hTcFj2P5CCxaThGs47d3LwLdqCumPNl0eav+dmd/HE4ckJ9p1ILMCgTQmZajuxx3zhgK
         hlON1zM1WGFYMsj931Ssh8zsVmyw9MOAz0g9LfCpHbWf0UM4kAJrJIb8EuHtuilLhhm8
         dNRVtqTbY0/AKDJ695dHA3lfXdZu1RXL7cLh+y7udZ5AzfLHeA/a43FWzYhOgQPbKKCF
         hKbg==
X-Gm-Message-State: ACrzQf2eIEcnhZGdV8vPvpGX5QPT+unJ1OhQAVYVB3Q2O6syTgZ+T+oA
        1tXdkZKJPQnm6YyNucVGaCrYyKQ4FxtpUBujf1L9Ze41MLQ=
X-Google-Smtp-Source: AMsMyM4ts/yrVkZ/rwo1rX5dF+U9YbdwmlS+g6Emy1R6Ka4W26Z9PtrVHLaHRvmePk+CdJhX0Jhu5QXzR4yU/x9b6dQ=
X-Received: by 2002:ad4:5d48:0:b0:4b4:12a4:8a2f with SMTP id
 jk8-20020ad45d48000000b004b412a48a2fmr3179433qvb.85.1665424062417; Mon, 10
 Oct 2022 10:47:42 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Oct 2022 19:47:31 +0200
Message-ID: <CAJZ5v0i_sK86N5i3sVRE1cdb7TgHOCGnMV5+5JuQewwwLBEp0Q@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.1-rc1-2

with top-most commit e021563fd09e1fd4041a6a573ec10fb5b5d275b0

 Merge tag 'thermal-v6.1-rc1-2' of
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit a5088ee7251e5106a4efa9588a73866eb4b4154e

 Merge tag 'thermal-6.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive thermal control fixes for 6.1-rc1.

These fix assorted issues in the thermal core and ARM thermal drivers.

Specifics:

 - Use platform data to get the sensor ID instead of parsing the device
   in imx_sc thermal driver and remove the dedicated OF function from
   the core code (Daniel Lezcano).

 - Fix Kconfig dependency for the QCom tsens thermal driver (Jonathan
   Cameron).

 - Add missing const annotation to the RCar ops thermal driver (Lad
   Prabhakar).

 - Drop duplicate parameter check from
   thermal_zone_device_register_with_trips() (Lad Prabhakar).

 - Fix NULL pointer dereference in trip_point_temp_store() by making it
   check if the ->set_trip_temp() operation is present (Lad Prabhakar).

 - Fix the MSM8939 fourth sensor hardware ID in the QCom tsens thermal
   driver (Vincent Knecht).

Thanks!


---------------

Daniel Lezcano (2):
      thermal/drivers/imx_sc: Rely on the platform data to get the resource id
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

---------------

 drivers/thermal/Makefile          |  2 +-
 drivers/thermal/imx_sc_thermal.c  | 68 +++++++++++++++++++--------------------
 drivers/thermal/qcom/tsens-v0_1.c |  2 +-
 drivers/thermal/rcar_thermal.c    |  2 +-
 drivers/thermal/thermal_core.c    |  2 +-
 drivers/thermal/thermal_of.c      | 44 -------------------------
 drivers/thermal/thermal_sysfs.c   |  8 +++--
 include/linux/thermal.h           | 10 ------
 8 files changed, 42 insertions(+), 96 deletions(-)
