Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0006E9780
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjDTOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjDTOq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:46:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845244A0;
        Thu, 20 Apr 2023 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682001987; x=1713537987;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=llG0vdmQ3GbbFQezbra+B4SwkMPYTwzKiy7sh3sn9Fs=;
  b=EVzQ7I0ptt9wxb+pBii/1+KbPm4O2Awl3pEosZ4bicfT9OLNbIQYYyMI
   jmG2SyMuYJ8aP44UyOQ5n6tWMBmvOBhY4lyG8xRim4Ctr8pbtr6luhyX8
   45taG984eyjRLqvcGbqPZJzMN0tz3UC4NmkK5ANMUkQc7V8UiF1bCCew5
   +qbmp56/YtHBZn3fWpcJjXFlaxSo/9OaE7Mbu3PKvTCXH8acEemmPuSWb
   rV/Xhak5ZoLkoxy8vQjAHfv2dH7ERPPIUEGMqQV/sszHN1sk9ebAiEiOq
   QdrgVI4UZE6xqslYiHMhvOyHT3pzz3Hdhb0ZALsXymdn8NfpL9wb/Hk4h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="373656941"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="373656941"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="642163287"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="642163287"
Received: from shwetag-mobl4.amr.corp.intel.com (HELO [10.209.147.40]) ([10.209.147.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:46:22 -0700
Message-ID: <f6e4a78d-0199-3135-f85d-800457a731b0@linux.intel.com>
Date:   Thu, 20 Apr 2023 09:46:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] hwmon: (socfpga) Add hardware monitoring support on
 SoCFPGA platforms
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
 <20230410153314.27127-3-dinh.nguyen@linux.intel.com>
 <09730359-8731-e21e-3335-bf60ba7f1280@roeck-us.net>
 <a3e966f8-8e9d-7081-1665-9d2e87acb310@linux.intel.com>
 <8d158880-1e6a-5fdd-dae7-a7647794eb60@roeck-us.net>
 <a1a34c32-dbd4-7a77-ab7e-5e34af85900f@linux.intel.com>
 <ZD/UsuzhZmK3AFJn@smile.fi.intel.com>
Content-Language: en-US
From:   Dinh Nguyen <dinh.nguyen@linux.intel.com>
In-Reply-To: <ZD/UsuzhZmK3AFJn@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/19/2023 6:46 AM, Andy Shevchenko wrote:
> On Tue, Apr 18, 2023 at 12:29:40PM -0500, Dinh Nguyen wrote:
>> On 4/17/2023 4:51 PM, Guenter Roeck wrote:
>>> On 4/17/23 13:55, Dinh Nguyen wrote:
> ...
>
>>> ... and this contradict each other. If bit 31 indicates an error,
>>> this can not be a signed 32-bit value.
>>>
>> You're right! I've re-read the spec and should have the the code look for
>> the specific error values:
>>
>> 0x80000000 - inactive
>> 0x80000001 - old value
>> 0x80000002 - invalid channel
>> 0x80000003 -  corrupted.
> No, they are not hex. Probably you need to define an error space with it, but
> at least just use signed _decimal_ values.
>
> Instead of BIT(31) this should go as
>
> #define ..._ERR_BASE   INT_MIN // or equivalent if the type is not int
> #define ..._ERR_MAX ... // or whatever name is better
>
> Then in your code
>
> 	if (value >= _ERR_MAX)
> 		return 0;
>
> 	err = _ERR_MAX - value;
> 	switch (err) {
> 		...
> 	}
>
> P.S. I asked during internal review if the values are bit fielded when errors.
> AFAIU that time they are, now it seems different.

Can I ask what's wrong with this simple implementation?

static int socfpga_hwmon_err_to_errno(struct socfpga_hwmon_priv *priv)
{
         int value = priv->temperature.value;

         switch (value) {
         case ETEMP_NOT_PRESENT:
                 return -ENOENT;
         case ETEMP_CORRUPT:
         case ETEMP_NOT_INITIALIZED:
                 return -ENODATA;
         case ETEMP_BUSY:
                 return -EBUSY;
         case ETEMP_INACTIVE:
         case ETEMP_TIMEOUT:
         case ETEMP_TOO_OLD:
                 return -EAGAIN;
         default:
                 /* No error */
                 return 0;
         }
}

Dinh

