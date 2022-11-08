Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7D562114B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiKHMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiKHMrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:47:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DF951C29;
        Tue,  8 Nov 2022 04:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667911638; x=1699447638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zvBFCIqzdoTj9UnYmptO+ryXyIdI3ESvdJd9r6IDuZA=;
  b=SkmUVBJYf6sES4vKCpC6lpcTFsQ3lpgOSOT0HSeWEmOjgMs3YI0cr5Kd
   F6ztZxuXTdnkBnXA0Z43JHFFsK2kxU5ZNJzPmzgQpnddvzWuhYevO7SXs
   TO1VKjEmhBIRTpvYa0D7KTnZ1YHVdleGWtwXe/OpXaBnmpxQqS2WLbJq/
   cA9oWBVBqnCCf4ZmvOvzJUZMPyl3kaFjA3T0eIDOMmYWECXflWaaQECgR
   yfDzkFMmqSrS7EPSXuHm5TJNQ/gbrb1DlWhrkQ1TTb/trC9EqEpCxeUAE
   FSHFe4c6LQA2/4kwRO8KSK3yHAa7Pl8cGnyBB9p8cRk1doI19aMDYsThV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374955747"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="374955747"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:47:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699910525"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699910525"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2022 04:47:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osO0Y-0098GB-0o;
        Tue, 08 Nov 2022 14:47:14 +0200
Date:   Tue, 8 Nov 2022 14:47:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Gilles BULOZ <gilles.buloz@kontron.com>
Subject: Re: [PATCH v2 0/4] 8250: DMA Fixes
Message-ID: <Y2pP0VSW4uSyoqrS@smile.fi.intel.com>
References: <20221108121952.5497-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108121952.5497-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:19:48PM +0200, Ilpo Järvinen wrote:
> Here are a number of 8250 DMA related fixes. The last one seems the
> most serious problem able to corrupt the payload ordering.

Thank you for the update!
LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> v2:
> - Tweak configure logic to match Andy's suggestion
> - Cleaned up the tags from the oneliner patch
> 
> Ilpo Järvinen (4):
>   serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs
>   serial: 8250_lpss: Configure DMA also w/o DMA filter
>   serial: 8250_lpss: Use 16B DMA burst with Elkhart Lake
>   serial: 8250: Flush DMA Rx on RLSI

-- 
With Best Regards,
Andy Shevchenko


