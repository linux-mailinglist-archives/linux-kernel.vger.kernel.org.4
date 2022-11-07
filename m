Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B0361EC13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiKGH3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiKGH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:29:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77911E2A;
        Sun,  6 Nov 2022 23:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667806103; x=1699342103;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RVVZwPv9xI3vAAY4CJDjah66RkUABieq8JbrCVHaIZw=;
  b=jqtgWo+GPpuWKlcqhqN9tlP6l0K1b/kNTBC58qxHjifY7hW6CeW+a/lF
   NiEt/m+M/8RlmVTlRJdxgrA/nfr9Wd3KpctsfhsC6WqB9yykBIwHdH5LM
   BdIUDwuEFtRfyomrIIXb2addbsoULsK2TbAzuR+20x7bJ9/fWSXI9zecd
   TUcJq+OMQk3zUOFvoIVDF57iMDxaKMmbBX5JEiGPkaXD3Q/y40uSYNdFH
   SlUU7StOAhu6KGmHs+AF3M4KruxX7KEueCYQi6sbx/W3uLWCZxD3wVual
   uYdDTIbcaRCs3quxf+nzCIlJ8CUXSguv/2y8VRzZF/ooJLlgbKhQjKYso
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="311480074"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="311480074"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 23:28:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="669040361"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="669040361"
Received: from mylly.fi.intel.com (HELO [10.237.72.55]) ([10.237.72.55])
  by orsmga001.jf.intel.com with ESMTP; 06 Nov 2022 23:28:17 -0800
Message-ID: <dfa28659-033f-f694-cddf-ebb049c293ba@linux.intel.com>
Date:   Mon, 7 Nov 2022 09:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v1 1/1] platform/x86: p2sb: Don't fail if unknown CPU is
 found
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>
References: <20221104154916.35231-1-andriy.shevchenko@linux.intel.com>
 <MN0PR12MB6101C1FEA748E52D42CBC734E23B9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y2VKWJlFvixnFu/p@smile.fi.intel.com>
Content-Language: en-US
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <Y2VKWJlFvixnFu/p@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 11/4/22 19:22, Andy Shevchenko wrote:
> On Fri, Nov 04, 2022 at 03:58:22PM +0000, Limonciello, Mario wrote:
>> Isn't it "Comet Lake"?
> 
> Right, thanks!
> 
> In any case I would like to have Jarkko's Tested-by before proceeding with
> this. Hence v2 is warranted to appear.
> 
Yes, iTCO registration works again with this patch and is functioning, 
i.e. able to reset the machine.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
