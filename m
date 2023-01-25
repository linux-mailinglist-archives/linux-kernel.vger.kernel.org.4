Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4241C67B1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbjAYLtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbjAYLtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:49:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CA1A5EE;
        Wed, 25 Jan 2023 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674647359; x=1706183359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J7U00k9Q+D1TPkOLwCq+yYQ4slP/XxUsiVgf+OA+wnI=;
  b=KKTVU35Ibiu0iF0yMwcI5mnlXUYs9LRWBjlvSM8p3PHSncJpgc2K9kji
   pZpQGgGSvMKacREia+g1fX0Cx+hI5g5scuTaHjetkMGZ6rdqYEk9kdR5L
   VcXTDT+tTI3rTebD/sSo3WdfrFQC0T66wRIRkHJY7e3EQN6/nmZyOUG6Q
   kwvBt9ZhJH75xmu5euuQgyT3N3Too9ZBWiP8Nq0azdOUf9hpD/7rlM2qu
   lP+vhPBkzIQ55Tw9YMa1zNxTgDgA23xR5jSyJMJrKYt1uQ7WZmoDNlByx
   Zca6EkxR+FF8lFzN9m/jfc/nGgof3QWlRjqIb+NrTPV/yY2DpZaDah7AZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="326564087"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="326564087"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 03:49:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="692927629"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="692927629"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2023 03:49:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pKeH8-00EpZy-2j;
        Wed, 25 Jan 2023 13:49:10 +0200
Date:   Wed, 25 Jan 2023 13:49:10 +0200
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
Message-ID: <Y9EXNmgMR1uHTgX4@smile.fi.intel.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-4-m.zatovic1@gmail.com>
 <Y7WwVCqDCXFrTqR9@smile.fi.intel.com>
 <Y7Ww67pIyjeLKBE7@smile.fi.intel.com>
 <Y9D2V1dz6/+EOa5D@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9D2V1dz6/+EOa5D@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:28:55AM +0100, Martin Zaťovič wrote:
> Hi Andy,
> 
> thank you for the notes, I am working on fixing them. You have
> mentioned, that it seems like the driver which should be generic
> provides specific functionality. AFAIK, the Wiegand protocol
> does not define the payload length of messages. Most devices use
> one of the three formats I have implemented - 26, 36 and 
> 37-bits. If I understand you right, the Wiegand GPIO bit-banged
> driver should allow one to send messages of any length and it 
> will be up to a device driver to make sure the correct message
> length is used. Is this the correct approach?

Yes. But it's up to you to come with a final design. I don't
know your hardware nor protocol, so I might be mistaken. Hence,
try different approaches and look which one is better looking /
maintainable / etc.

-- 
With Best Regards,
Andy Shevchenko


