Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E1460F890
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiJ0NJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiJ0NJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:09:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725EB15719;
        Thu, 27 Oct 2022 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666876185; x=1698412185;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MCLBFO3GdgdeuhUJUcNaR1oNkl/w8+FZPyXKz03sSkk=;
  b=Csfqd9Cu3JJB1BTToBAV+lVY4mjIRmbY5Tfai5/ygWpuXicNLnDXhmvi
   +MsMJUZMP6dFGjGBSwOoro34Cf4lNsjOC0heHg5plHZiNIlcKFOzYrGLI
   gmCX5R57IJuSglyxHU6M+buMnyauaqp63bqs8XKrCuVOHxF9ZWYWXhpJJ
   dyaN/3FeKW76W3fC4/IOuJap86SbZIEbXTdA2VtMTUedzlCqRMOKcQYRO
   Zsye/bHJu0d7LOrj/8hFZ5zfdzD06PXaboiG68eb5HiNKVOodd5v6FLfU
   sugchdMByhnDmyTYpgiS6e7jVY4jBPLkBqW+DGuLiqd5kf3ztRvsfqBJg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309912630"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="309912630"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 06:09:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="757692314"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="757692314"
Received: from djohn1-mobl1.amr.corp.intel.com (HELO [10.212.54.86]) ([10.212.54.86])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 06:09:35 -0700
Message-ID: <86b64496-71e0-7e2d-0911-f67e1684db20@linux.intel.com>
Date:   Thu, 27 Oct 2022 08:45:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 6/6] soundwire: qcom: add support for v1.7 Soundwire
 Controller
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sanyog.r.kale@intel.com
References: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
 <20221026110210.6575-7-srinivas.kandagatla@linaro.org>
 <e3ebba30-65ec-183a-eb91-c5147c28441d@linux.intel.com>
 <619a829e-d902-eba9-537e-176a8acb149c@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <619a829e-d902-eba9-537e-176a8acb149c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> @@ -1582,6 +1597,7 @@ static const struct of_device_id
>>> qcom_swrm_of_match[] = {
>>>       { .compatible = "qcom,soundwire-v1.3.0", .data =
>>> &swrm_v1_3_data },
>>>       { .compatible = "qcom,soundwire-v1.5.1", .data =
>>> &swrm_v1_5_data },
>>>       { .compatible = "qcom,soundwire-v1.6.0", .data =
>>> &swrm_v1_6_data },
>>> +    { .compatible = "qcom,soundwire-v1.7.0", .data = &swrm_v1_5_data },
>>
>> is this line intentional, it looks odd that 1.7 is compatible with 1.5,
>> but 1.6 isn't?
> This is more around the data rather than compatible, 1.6 data is marked
> with sw_clk_gate_required = true which is not the case with 1.7.
> 
> from 1.5 we use same frame shape info for 1.6, 1.7, except that 1.6 had
> this sw_clk_gate_required flag set.

probably worthy of a comment to show intent and explain the differences?
