Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108776C160B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjCTPBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjCTPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:01:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 067B9144A3;
        Mon, 20 Mar 2023 07:57:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1E7FAD7;
        Mon, 20 Mar 2023 07:58:02 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.18.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 87D3B3F71E;
        Mon, 20 Mar 2023 07:57:15 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan.Cameron@huawei.com
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
Subject: [PATCH v3 0/4] devres: Provide krealloc_array
Date:   Mon, 20 Mar 2023 14:57:05 +0000
Message-Id: <20230320145710.1120469-1-james.clark@arm.com>
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

Changes since v2:
 
 * Remove change in qcom_geni_serial.c in the last commmit and replace
   it with a comment instead
 * Whitespace fix

Changes since v1:

 * Style fix

-----------------------

Hi,

I had a use for a devm realloc_array in a separate change, so I've
added one and updated all the obvious existing uses of it that I could
find. This is basically a copy paste of the one in slab.h

Applies to v6.3-rc3

Thanks
James

James Clark (4):
  devres: Provide krealloc_array
  hwmon: pmbus: Use devm_krealloc_array
  iio: adc: Use devm_krealloc_array
  serial: qcom_geni: Comment use of devm_krealloc rather than
    devm_krealloc_array

 .../driver-api/driver-model/devres.rst          |  1 +
 drivers/hwmon/pmbus/pmbus_core.c                |  6 +++---
 drivers/iio/adc/xilinx-ams.c                    |  9 +++------
 drivers/iio/adc/xilinx-xadc-core.c              | 17 +++++++----------
 drivers/tty/serial/qcom_geni_serial.c           |  5 +++++
 include/linux/device.h                          | 11 +++++++++++
 6 files changed, 30 insertions(+), 19 deletions(-)

-- 
2.34.1

