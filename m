Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF205E68D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiIVQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVQyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:54:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C518EB132;
        Thu, 22 Sep 2022 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663865639; x=1695401639;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0tb64t9et9lz0+8sWEy9iCYzjX3AhOgWoGQQhACry9w=;
  b=jUSKaHHwwZbmaAEhj665dSoSt/C4Q4KRDoKbISSPgsffx4+w/PH7G84D
   6l1RGeDSPu4rJ64hq5+gHQhaP9JDm1WxIoK7hhSEirOL0NppFJ7x0I8gW
   tuBjsvgABkQFJ9xaTU4RLnHn2zfh3NcnjAlCzOP27gNTktlPMnZqYE5AD
   U78qolWtpPLTZbEmr4SlxFy2/GpCFpB97e1Htk5B1NRZZ68if0zgsamz5
   0ud6ZOz70BHlTY9pprcn7+N/xdWeU4K8pKWT4rKbLLCOniRgCVIp+s6iu
   HaGvRjT3cq77poEBLBmz7OtEZPNxtvZVptUgnPELqJ5hybkttWjpFYH/u
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283412772"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283412772"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 09:53:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="619868865"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO [10.209.58.200]) ([10.209.58.200])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 09:53:43 -0700
Message-ID: <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
Date:   Thu, 22 Sep 2022 09:53:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
References: <20220922133800.12918-1-rui.zhang@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220922133800.12918-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes since V2:
>  - changelog improvements based on Peter' feedback
>  - Remove combined tags

I fixed those up and started testing your v2 yesterday.  Can you
double-check that this:

	https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=cpuid1f

Looks the same as your v3?
