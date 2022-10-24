Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416F26097B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJXBLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJXBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:11:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258E62937
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 18:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666573857; x=1698109857;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JpOLJa2DJbKLqReqcKJCaZ8/zuKk4vp2PYx+z3bASr8=;
  b=cmy2XGbZWU6IKBK9yDLWZ8IT0g+h4LngP3t1hS4oVdNpMw2pD5rtpkuR
   Rd6xleT1X+XxyA8o9A/b6CQ0PzadJcX8NYCs7wnJYwhu/uJQDjtyqxtZ7
   prguAqtOpIQV3pZUdWmzeIBcTeG5b3YkBpRWHnW4r1K+QB7I0xafg2410
   l3HcQZBRAb49IRMpKkMQTX1ZagamPpJaZngcGcl9zI1yf+05rzqECM0v1
   nShXGQYbKi+VmEYJu0Qnf/neEG2fRpc0z85AY2zjsdw1RfBQ+B7A4+GHK
   52Y6Acq3z7/vL5nfEBbYJNFjXNrTB/ikBIjigLET7/asXbEgkO/g1P0ob
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="371533110"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="371533110"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 18:10:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="662274284"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="662274284"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.212.138]) ([10.254.212.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 18:10:55 -0700
Subject: Re: [driver-core:driver-core-testing] BUILD SUCCESS
 59789f3418dd3c0a187490d49e900a59a5c8d732
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
References: <635484ed.ADi+2sBza+UlAhjj%lkp@intel.com>
 <Y1U0pINWo5yjUdc2@kroah.com> <Y1WZSysScBH0/6kd@smile.fi.intel.com>
 <Y1WbY903LjRATVwh@smile.fi.intel.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a762dca8-2458-c40b-7a35-80971c46ac84@intel.com>
Date:   Mon, 24 Oct 2022 09:10:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y1WbY903LjRATVwh@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2022 3:52 AM, Andy Shevchenko wrote:
> On Sun, Oct 23, 2022 at 10:43:07PM +0300, Andy Shevchenko wrote:
>> On Sun, Oct 23, 2022 at 02:33:40PM +0200, Greg Kroah-Hartman wrote:
>>> On Sun, Oct 23, 2022 at 08:03:57AM +0800, kernel test robot wrote:
>>>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
>>>> branch HEAD: 59789f3418dd3c0a187490d49e900a59a5c8d732  device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
>>>>
>>>> Unverified Warning (likely false positive, please contact us if interested):
>>>>
>>>> drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine type of argument 4
>>>
>>> Andy, this is due to your changes, here's the offending code:
>>>
>>> 	sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
>>>
>>> Now that dev_fwnode() is an inline function, the compiler is confused as
>>> to what function to select?  Maybe, I don't know, it seems odd, can you
>>> look into it?
>>
>> Hmm... I can't reproduce on my side.
>> Any (additional) information about compiler, architecture, etc?
> 
> I found the original report, but I don't see how to extract the defconfig /
> config it used. Can you send that file to me?
> 

Hi Andy,

The original report can be found at 
https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/thread/VE7CMY7FVIPYWHL4XMOCFWCNYTGZSTKP/

and config file can be downloaded from 
https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/message/VE7CMY7FVIPYWHL4XMOCFWCNYTGZSTKP/attachment/2/config.ksh

Best Regards,
Rong Chen
