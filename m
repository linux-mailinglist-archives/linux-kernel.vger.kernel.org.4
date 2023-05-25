Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555827118EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjEYVUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjEYVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:20:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5F5194;
        Thu, 25 May 2023 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685049616; x=1716585616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IgpzydzNnToHzm2hMhoMWZb9obYT7vJVAr4yJgMYc6o=;
  b=XTh0tqrd++oIJxkcb1H5Y1JRo0DWeswkuMFQh493n5EBfGU3GMDAuFZ2
   GPoEj9VOJ2RSVqpO/p215yjC6Zqk846/R/iFqeWwIPh+na8fXOEyDLgNg
   fPeFr6jF/OVvtpy5Sez+QAQN5+t98k0TLROkCNMCOw8FEdiNt8FRbybDF
   dYOqI9DHw9OXpQfS94KXFI4TW9F6xnWFLmOl05IvFe1L/P5TzDbxnS+dj
   lfGqr27MMveaTCI2mS0qNB3IaKceWWI3JUxHM72k2u70QQDAFnyr1q3h5
   HeRRB5hWSQjcIq/4TSjw8pB02bpTxneGP3eZNbELrJlCxaZWfACgUXjns
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="357281111"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="357281111"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 14:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="699153919"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="699153919"
Received: from dinguyen-mobl1.amr.corp.intel.com (HELO [10.92.18.74]) ([10.92.18.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 14:20:14 -0700
Message-ID: <b36bd5d9-a7dc-b478-9b89-ed3b10bd6725@linux.intel.com>
Date:   Thu, 25 May 2023 16:20:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2 3/6] hwmon: (socfpga) Add hardware monitoring support on
 SoCFPGA platforms
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
 <20230508212852.8413-3-dinh.nguyen@linux.intel.com>
 <9459547a-0ff9-9972-602d-3098b616602b@linaro.org>
From:   Dinh Nguyen <dinh.nguyen@linux.intel.com>
In-Reply-To: <9459547a-0ff9-9972-602d-3098b616602b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 5/9/2023 1:57 AM, Krzysztof Kozlowski wrote:
> On 08/05/2023 23:28, dinh.nguyen@linux.intel.com wrote:
>> From: Dinh Nguyen <dinh.nguyen@linux.intel.com>
>>
>> The driver supports 64-bit SoCFPGA platforms for temperature and voltage
>> reading using the platform's SDM(Secure Device Manager). The driver
>> also uses the Stratix10 Service layer driver.
>>
>> This driver only supports OF SoCFPGA 64-bit platforms.
>>
> (...)
>
>> +static int socfpga_probe_child_from_dt(struct device *dev,
>> +				       struct device_node *child,
>> +				       struct socfpga_hwmon_priv *priv)
>> +{
>> +	struct device_node *grandchild;
>> +	const char *label;
>> +	const char *type;
>> +	u32 val;
>> +	int ret;
>> +
>> +	if (of_property_read_string(child, "name", &type))
>> +		return dev_err_probe(dev, -EINVAL, "No type for %pOF\n", child);
>> +
>> +	for_each_child_of_node(child, grandchild) {
>> +		ret = of_property_read_u32(grandchild, "reg", &val);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "missing reg property of %pOF\n",
>> +					     grandchild);
> Where do you drop child reference?

Not sure what you mean here? Can you clarify?

Thanks,

Dinh

