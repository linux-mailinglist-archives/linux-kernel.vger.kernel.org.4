Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C3B65DAE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjADRED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjADREB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:04:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342CF111F;
        Wed,  4 Jan 2023 09:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672851841; x=1704387841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X/EkGee7Pj5qNDLMpAQBGqMhOGz29NotewQQ/b7paFo=;
  b=Swo3ed/AOKiT/vaTqQugGHDFVmowJQFonuWxnule3xIIJic8SJLOh49W
   Z+ZHLPEKWc0nWiwvaBhh+KUBIaUzoaIDbzlqgFqMDEYUoIoCNUavN8fR3
   sPRphOHIkJ8tVkaG5/7vwjvGPWpiF83R2mPMQwT6JIb8Cr1E4Onnj77/l
   2AQ9yEu/cknEEt4o8NsoZcvUwj55pAIYZHQNAaNjGsTo+ZO6NxIJFIiRZ
   DYIyaiNbuCPIoDipZEs3MN5JzExwLaHYQm33a8wQqYaugYsfTT7GJV7pL
   igOkpOjdrXUQiP+rkgmOjU/Rh+w33sRybvN1qjKT/NavWWFDV7WzHsjdP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="320693722"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="320693722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="685806985"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="685806985"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2023 08:59:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pD76S-004O7w-2i;
        Wed, 04 Jan 2023 18:59:00 +0200
Date:   Wed, 4 Jan 2023 18:59:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 3/3] wiegand: add Wiegand GPIO bit-banged controller
 driver
Message-ID: <Y7WwVCqDCXFrTqR9@smile.fi.intel.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-4-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104133414.39305-4-m.zatovic1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:34:14PM +0100, Martin Zaťovič wrote:
> This controller formats the data to a Wiegand format - appends
> checksum if one of the defined formats is used - and bit-bangs
> the message on devicetree defined GPIO lines.
> 
> Several attributes need to be defined in the devicetree in order
> for this driver to work, namely the data-hi-gpios, data-lo-gpios,
> pulse-len, frame-gap and interval-len. These attributes are
> documented in the devicetree binding documentation file.
> 
> The driver creates a dev file for writing messages on the bus.
> It also creates two sysfs files to control the format and payload
> length of messages. Defined formats are 26, 36 and 37-bit, meaning
> the payloads for these formats are 24, 34 and 35 bit respectively,
> as two bits are allocated for checksum. A custom format is also
> supported and it is set by writing 0 to the format sysfs file.
> Custom format does not calculate and append checksum to messages -
> they are bit-banged as inputted.

Brief look at the code makes me think that this is something from 10 years ago
with slightly removed dust to make it compile. So far I have noticed:
- explicit castings where it's not needed
- bad indentation here and there
- using direct dereference in the cases when we have specific getters available
- NIH this and that

...

> +What:		/sys/devices/platform/.../wiegand-gpio-attributes/format
> +Date:		January 2023
> +Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
> +Description:
> +		Read/set Wiegand communication format.
> +		0 - custom format, payload length is specified by
> +		payload_len file
> +		26 - 26-bit format (24 bit payload, 2 bits checksum)
> +		36 - 36-bit format (34 bit payload, 2 bits checksum)
> +		37 - 37-bit format (35 bit payload, 2 bits checksum)
> +
> +What:		/sys/devices/platform/.../wiegand-gpio-attributes/payload_len
> +Date:		January 2023
> +Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
> +Description:
> +		Read/set Wiegand communication payload length. File is only
> +		writable if custom format is set.

Why all these attributes? What is special about them and how they are specific
to the hardware in question?

To me it all sounds like layering violation: a GPIO driver that has to be
generic provides a complete custom ABIs which we usually put on the upper
layer (in the kernel as a child driver or in the user space).

-- 
With Best Regards,
Andy Shevchenko


