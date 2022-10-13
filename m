Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C305FDF3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJMRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMRqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:46:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67D7213ECC4;
        Thu, 13 Oct 2022 10:46:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED9491424;
        Thu, 13 Oct 2022 10:46:36 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DFB63F766;
        Thu, 13 Oct 2022 10:46:28 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com, wzmuda@marvell.com,
        dan.carpenter@oracle.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 0/1] Add ARM SCMI Powercap driver
Date:   Thu, 13 Oct 2022 18:46:11 +0100
Message-Id: <20221013174612.393830-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patch builts on top of recently introduced SCMI v3.1 Powercap protocol
to implement an ARM SCMI Powercap driver which takes care to expose via the
Powercap framework all the SCMI Powercap zones that have been discovered
asking the SCMI platform firmware.

Basic testing has been performed against an emulated SCMI platform
supporting SCMIv3.1 Powercap protocol using powercap-utils.

A couple of fixes spotted with Smatch by Dan have been squashed into this
patch in V3.

Based on v6.0.

Thanks,
Cristian

---
v2 --> v3
 - rebased on v6.0
 - added review tag
 - squashed Dan Carpenter fixes into this powercap patch:
    https://lore.kernel.org/linux-arm-kernel/20220906142337.1697569-3-cristian.marussi@arm.com/
    https://lore.kernel.org/linux-arm-kernel/20220906142337.1697569-4-cristian.marussi@arm.com/

v1 --> v2
  - using clamp_t() to simplify normalizations
  - cleanup style in block of var declarations
  - refactor scale conversions code
  - add MAINTAINER entry
  - refactored normalizations and added dev_dbg

Cristian Marussi (1):
  powercap: arm_scmi: Add SCMI Powercap based driver

 MAINTAINERS                          |   1 +
 drivers/powercap/Kconfig             |  13 +
 drivers/powercap/Makefile            |   1 +
 drivers/powercap/arm_scmi_powercap.c | 509 +++++++++++++++++++++++++++
 4 files changed, 524 insertions(+)
 create mode 100644 drivers/powercap/arm_scmi_powercap.c

-- 
2.34.1

