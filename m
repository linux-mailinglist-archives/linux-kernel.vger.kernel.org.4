Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CBE6F0BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbjD0Scw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244555AbjD0Sct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:32:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA384E2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682620369; x=1714156369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vnmd/41cKMnfGgAjPjDLh5eyKzntOTLwVwNo2BXtXYY=;
  b=iGUaKd4KxGusxnKySiVx6iEHmILEo2bH/c+yQVWiJeBf1cPCwFFczToY
   5cCaZm389f9u2YCxeOznLBUNOARdDYoN7k1EUTV563CXU/rMDmh6KVhhy
   bMqfyCrqbR2tTFoe8+OM8PAGXXuWNWGm8KOjeYPMsF5a3kAPjW7aB1rrF
   UxU55e4hnYv3HwuojtMfcom8WZugHNvqEHjp1c6su+c98KT+G1QZI8Low
   N+rjuWuGUMbAhIJqWdOXr/zWjV6hg7wAZkSVzdz+ElneArKMnhrLV+X7d
   FO/68cpsXlDEEnP5DFPVqfAu2RggaQRRHvO0PYCVDtj5mh7SMUtYhpVeY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="336522256"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="336522256"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 11:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="806053580"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="806053580"
Received: from jonnaman-mobl2.amr.corp.intel.com (HELO [10.212.24.30]) ([10.212.24.30])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 11:31:00 -0700
Message-ID: <476035e9-d9c2-5943-4717-baf3ba72f4f5@intel.com>
Date:   Thu, 27 Apr 2023 11:30:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] x86/tdx for 6.4
Content-Language: en-US
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <20230427181548.1070481-1-dave.hansen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230427181548.1070481-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 11:15, Dave Hansen wrote:
...
> The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:
> 
>   Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git tags/test.1682619270.x86_tdx_for_6.4
Please ignore this one.  I manged to send my test email instead of the
proper one referring to the tip repo with a proper signed tag.  I'll
resend with the proper repo and signed tag.
