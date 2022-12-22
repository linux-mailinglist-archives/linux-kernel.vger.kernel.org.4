Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46065413A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiLVMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiLVMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:44:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C034122BF8;
        Thu, 22 Dec 2022 04:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671713062; x=1703249062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWQmDKFALW8K/hSRrtki7o79dxJHNQCSAB4XGxK8ljE=;
  b=RocVMvdiE93m8nkwpvxf9mE4IpvEb1uHI4Zcy1Hy1RYjs4K7g+QRdPAT
   H6NC4H6iskZsPmHf//HPcYEvTtI34+YGCYsES1aOkLiplgL5UDB3jFIPc
   ckEzcZ9SVFpoBZ+0iw9gud+Zov3z/5d54DJpil/DHStbQ8S4ySizyPIef
   krZIXMnng4MPbJW+YnjZsoEMsVUXx7vNKCi4vjy+9l9zEcKhuDsHYfCDU
   dtSmNm0qIvtDxBjEUmTXnaPHjE8ygQ9fuJ1rA3UhkOiWZ/kEboHenhPr5
   f+HfcIlFWPTPlTwVnZrO2rB+QvScBQfat1jl2Ljoz2EapM5IfCx4rR9v3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="347261028"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="347261028"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 04:44:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="682381751"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="682381751"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 22 Dec 2022 04:44:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p8Kvq-00DuaB-2s;
        Thu, 22 Dec 2022 14:44:18 +0200
Date:   Thu, 22 Dec 2022 14:44:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: simatic-ipc: correct name of a model
Message-ID: <Y6RRInVaXtOGr8hA@smile.fi.intel.com>
References: <20221222103720.8546-1-henning.schild@siemens.com>
 <20221222103720.8546-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222103720.8546-2-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:37:19AM +0100, Henning Schild wrote:
> What we called IPC427G should be renamed to BX-39A to be more in line
> with the actual product name.

Can you tell what does the current name mean?

Depending on that I would consider either your approach here or perhaps just
adding a comment in each of the places.

-- 
With Best Regards,
Andy Shevchenko


