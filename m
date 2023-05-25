Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43943711870
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbjEYUts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEYUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:49:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98CA97;
        Thu, 25 May 2023 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685047783; x=1716583783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M3hydNvGn1B4ey9GeGKTs3TFBTlEgyvaKvG4ZpFXN2s=;
  b=ZCa2mqzUTlBVKnZ1MtxyHdMo8x56FtifHJnMaCJ84zUQFjWLv0hxM4cY
   8ZuMNjXqwaNXtl76v2AVnPMe95yZs9XxiiJuFKOgWDgBo9diiOIpalC48
   TyZPR37i5XTnRgOcMnDnTi/2ndKAXcSA0+47bmQacJ1OGx+X+el7dlFbA
   qFN5HtuCidJF/xPoqcaxSbDIDeuX0PQ0zWijr0BA81E9rymS3ndFgdkGS
   gumQ2c0tt9avt0DmAUeGdQxGf9x29xSZYJq9oFLfAMdxXBSyy5QkZOm0g
   Y1kfMQKe1Q+M727g35dnl3wdNTdUZy8hawUixMpvTNkPupnHE/cwwSl8q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="356407478"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="356407478"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 13:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="829239914"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="829239914"
Received: from dinguyen-mobl1.amr.corp.intel.com (HELO [10.92.18.74]) ([10.92.18.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 13:48:01 -0700
Message-ID: <e1e0895e-4c8d-6453-d098-972beb4d0255@linux.intel.com>
Date:   Thu, 25 May 2023 15:47:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2 3/6] hwmon: (socfpga) Add hardware monitoring support on
 SoCFPGA platforms
To:     Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
 <20230508212852.8413-3-dinh.nguyen@linux.intel.com>
 <4aa37522-9072-ac8d-0ba7-c2234c3228bc@gmx.de>
Content-Language: en-US
From:   Dinh Nguyen <dinh.nguyen@linux.intel.com>
In-Reply-To: <4aa37522-9072-ac8d-0ba7-c2234c3228bc@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

On 5/8/2023 7:57 PM, Armin Wolf wrote:
> Am 08.05.23 um 23:28 schrieb dinh.nguyen@linux.intel.com:
>
>> From: Dinh Nguyen <dinh.nguyen@linux.intel.com>
>>
>> The driver supports 64-bit SoCFPGA platforms for temperature and voltage
>> reading using the platform's SDM(Secure Device Manager). The driver
>> also uses the Stratix10 Service layer driver.
>>
>> This driver only supports OF SoCFPGA 64-bit platforms.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
>> ---
>> v2: clean up race conditions in probe/remove functions
>>      move changes in service driver to a separate patch
>>      fix undefined 'ret' value in socfpga_read()
>>      fix up socfpga_hwmon_err_to_errno() to handle signed integer
>>      add platform specific dts binding
>> ---
>>   Documentation/hwmon/index.rst         |   1 +
>>   Documentation/hwmon/socfpga-hwmon.rst |  30 ++
>>   drivers/hwmon/Kconfig                 |  11 +
>>   drivers/hwmon/Makefile                |   1 +
>>   drivers/hwmon/socfpga-hwmon.c         | 408 ++++++++++++++++++++++++++
>>   5 files changed, 451 insertions(+)
>>   create mode 100644 Documentation/hwmon/socfpga-hwmon.rst
>>   create mode 100644 drivers/hwmon/socfpga-hwmon.c ICENSE("GPL");

Thanks for the review. I've addressed all of your comments in V3.

Dinh

