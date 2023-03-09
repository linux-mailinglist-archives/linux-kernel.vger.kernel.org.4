Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88E56B283B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCIPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjCIPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:06:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36CEDEBFBB;
        Thu,  9 Mar 2023 07:03:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10629AD7;
        Thu,  9 Mar 2023 07:04:26 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.48.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D12F3F5A1;
        Thu,  9 Mar 2023 07:03:39 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com
Cc:     James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 0/4] devres: Provide krealloc_array
Date:   Thu,  9 Mar 2023 15:03:29 +0000
Message-Id: <20230309150334.216760-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:

 * Style fix

-----------------------

Hi,

I had a use for a devm realloc_array in a separate change, so I've
added one and updated all the obvious existing uses of it that I could
find. This is basically a copy paste of the one in slab.h

Applies to v6.3-rc1

Thanks
James


James Clark (4):
  devres: Provide krealloc_array
  hwmon: pmbus: Use devm_krealloc_array
  iio: adc: Use devm_krealloc_array
  serial: qcom_geni: Use devm_krealloc_array

 .../driver-api/driver-model/devres.rst          |  1 +
 drivers/hwmon/pmbus/pmbus_core.c                |  6 +++---
 drivers/iio/adc/xilinx-ams.c                    |  9 +++------
 drivers/iio/adc/xilinx-xadc-core.c              | 17 +++++++----------
 drivers/tty/serial/qcom_geni_serial.c           |  6 +++---
 include/linux/device.h                          | 10 ++++++++++
 6 files changed, 27 insertions(+), 22 deletions(-)

-- 
2.34.1

