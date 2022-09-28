Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3705EE03D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiI1PZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiI1PYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:24:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F97CBADF;
        Wed, 28 Sep 2022 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664378618; x=1695914618;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xo6XKYqI3oPo+JJpKrktAR7Ec7OSHFgLsMM1Nyu1Bpg=;
  b=ekkimzVcJ4y1kFMT6KWeK7WuEnEFTKHvOH0vjx6/nNXPARahjqp/x5PA
   aUnwwgGlg7FcFwjfzKXnJEuxct9TU1gO1BWlt+YTM/Xl18OAbGRrEHXHX
   y//apaf0zQ53i71hmlpWz4kunjNdGD5oYIvFGaUoWBHlcQyutR3pCm1sU
   hh51M3J3IlGmvgkgOhYUHn/lJsFt9UOncYOaBbFaCrLiJM+GefFxWLUcs
   I43UgKZk4jjIQnTx7eOhuK62amPsvnsxvrY2wQ3SLc6otsWznHZrePIcU
   +J6Xo9+mFnDxSxghk02SerCddpjXboUAzQt6Q+oXk+cAdBOBibg3GIr69
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="281346483"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="281346483"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="573074617"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="573074617"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2022 08:23:33 -0700
Message-ID: <c1d537ad-5a2d-24b1-bfc3-165deebbbfa7@linux.intel.com>
Date:   Wed, 28 Sep 2022 18:24:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3] usb: xhci: add XHCI_SPURIOUS_SUCCESS to ASM1042
 despite being a V0.96 controller
Content-Language: en-US
To:     Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
References: <20220926193140.607172-1-jens.glathe@oldschoolsolutions.biz>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20220926193140.607172-1-jens.glathe@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.9.2022 22.31, Jens Glathe wrote:
> This appears to fix the error:
> "xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
> current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
> often) when using a r8152 USB3 ethernet adapter with integrated hub.
> 
> ASM1042 reports as a 0.96 controller, but appears to behave more like 1.0
> 
> Inspred by this email thread: https://markmail.org/thread/7vzqbe7t6du6qsw3
> 
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Adding this to queue

> ---

In the future, As Alan also pointed out, please list the changes since last version here.

Something like:

changes since v2
  - add subsystem to subject line
  - removed host 0.96 version check

Thanks
-Mathias
