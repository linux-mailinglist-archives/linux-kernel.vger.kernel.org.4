Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE46B2689
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCIOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCIOOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:14:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859B993C4;
        Thu,  9 Mar 2023 06:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678371193; x=1709907193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3A65IKB9d2IfLyHPo1ILLZ4ADkCpExI8AS30ua1GCVc=;
  b=LFnIFa2oy9cRbTo4OzS9IWHzz+tM4YrnopE/dyvvJ7RfwB6nCdwSnwvg
   Ph8ZbjETf1/WwJ6XxFSRvegTaJfdUwoNQmGL90M5h2RKidbiJyHcba9f8
   a1oNsOflRNVCUJ/ZQIrkq7MjUd87+adaaPuD6DDzyK6zhpP+lH1b+zXpy
   nXxXCuKN0gt+Kh5yH4UWbGn1JhDzd99VD2v8oLcO+MK0rLbSasprnYeRE
   O4i7wJU0/8lMSaGAuX45N+qjNDq5lwQm5dzsYnQnDy22lr+u50oVBOxFT
   8JGUNr/22YVOO1SJw5RXLeUehwUe9WsN5+szWFKKr0RVVXxSOCDnoWGW8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364093939"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="364093939"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:13:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787575064"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="787575064"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.219.30])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:13:01 -0800
Message-ID: <ef2f8faf-76cc-d221-8281-cc7b8cb68485@intel.com>
Date:   Thu, 9 Mar 2023 16:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/4] Revert "dt-bindings: mmc: Add bindings for Intel
 Thunder Bay SoC"
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, rashmi.a@intel.com,
        ulf.hansson@linaro.org, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org,
        mgross@linux.intel.com
Cc:     kris.pan@linux.intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, vasavi.v.itha@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com
References: <20230124054427.28808-1-rashmi.a@intel.com>
 <20230124054427.28808-2-rashmi.a@intel.com>
 <c850df25-57b8-3172-8e5c-c466dc8556cd@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <c850df25-57b8-3172-8e5c-c466dc8556cd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/23 13:31, Krzysztof Kozlowski wrote:
> On 24/01/2023 06:44, rashmi.a@intel.com wrote:
>> From: "A, Rashmi" <rashmi.a@intel.com>
>>
>> This reverts commit ab991c05c42853f0b6110022db9bf30fcc6323dd.
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
>>
>> Revert Thunder Bay specific code as the product got cancelled
>> and there are no end customers.
>>
>> Signed-off-by: A, Rashmi <rashmi.a@intel.com>
>> Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>wq
> 
> Stray characters.
> 
>> ---
>>  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 25 -------------------
>>  1 file changed, 25 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>> index 4053de758db6..0d5d21dd30bb 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>> @@ -88,12 +88,6 @@ properties:
>>          description:
>>            For this device it is strongly suggested to include
>>            arasan,soc-ctl-syscon.
>> -      - items:
>> -          - const: intel,thunderbay-sdhci-5.1   # Intel Thunder Bay eMMC PHY
>> -          - const: arasan,sdhci-5.1
> 
> Instead should be made rather deprecated, unless you are sure there is
> no single person in the world using the bindings (e.g. with BSD or
> bootloader)?

I am sorry but this is not clear to me.  As I understand it,
the hardware was never released, so the binding serves no
purpose.  Should it be removed or "deprecated"?

