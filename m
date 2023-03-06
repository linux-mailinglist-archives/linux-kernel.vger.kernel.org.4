Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C446AC4D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjCFP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCFP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:27:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ECEB311E9;
        Mon,  6 Mar 2023 07:27:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39E2212FC;
        Mon,  6 Mar 2023 07:28:20 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3437D3F71A;
        Mon,  6 Mar 2023 07:27:34 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
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
Subject: [PATCH 0/4] devres: Provide krealloc_array
Date:   Mon,  6 Mar 2023 15:27:19 +0000
Message-Id: <20230306152723.3090195-1-james.clark@arm.com>
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

