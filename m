Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD26EE23D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjDYMvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjDYMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:51:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EEADBB8D;
        Tue, 25 Apr 2023 05:51:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E1934B3;
        Tue, 25 Apr 2023 05:52:20 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5B7F3F64C;
        Tue, 25 Apr 2023 05:51:33 -0700 (PDT)
Message-ID: <108babe4-20cb-e637-e7da-7d04127d2a9e@arm.com>
Date:   Tue, 25 Apr 2023 13:51:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/4] devres: Provide krealloc_array
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com
References: <20230320145710.1120469-1-james.clark@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230320145710.1120469-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2023 14:57, James Clark wrote:
> Changes since v2:
>  
>  * Remove change in qcom_geni_serial.c in the last commmit and replace
>    it with a comment instead
>  * Whitespace fix
> 
> Changes since v1:
> 
>  * Style fix
> 
> -----------------------
> 
> Hi,
> 
> I had a use for a devm realloc_array in a separate change, so I've
> added one and updated all the obvious existing uses of it that I could
> find. This is basically a copy paste of the one in slab.h
> 
> Applies to v6.3-rc3
> 
> Thanks
> James
> 
> James Clark (4):
>   devres: Provide krealloc_array
>   hwmon: pmbus: Use devm_krealloc_array
>   iio: adc: Use devm_krealloc_array
>   serial: qcom_geni: Comment use of devm_krealloc rather than
>     devm_krealloc_array
> 
>  .../driver-api/driver-model/devres.rst          |  1 +
>  drivers/hwmon/pmbus/pmbus_core.c                |  6 +++---
>  drivers/iio/adc/xilinx-ams.c                    |  9 +++------
>  drivers/iio/adc/xilinx-xadc-core.c              | 17 +++++++----------
>  drivers/tty/serial/qcom_geni_serial.c           |  5 +++++
>  include/linux/device.h                          | 11 +++++++++++
>  6 files changed, 30 insertions(+), 19 deletions(-)
> 

Hi Greg,

Is it possible to take this one? Or at least the first commit?

Thanks
James
