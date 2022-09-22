Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577285E63D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiIVNjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiIVNif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:38:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D9DED69;
        Thu, 22 Sep 2022 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663853901; x=1695389901;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZCLkieSylmPBPkeksJ3PIh/eyjreS72A0W/+sGJ1CtQ=;
  b=JMb1LHftFX6PSU+m//uz9H3YNiCq3TR8pMui5//G8RjFpQaQHzgMGx0l
   kNzRNyaBxfd7K/dcdf6mAfHd51o6usuX6zZ4hMpNg7/0xyq9lfzIqOAKx
   0mZLMPeGjtiL12GjXuCn0Amb0QfhajIEoLUfUv+JGocarnY/5prF1DDk/
   bPcpJQS5e8nKNGv+IfkBVYE91jAX3MrH0gsODZJrqN264G0cVCY9eWyeN
   nocrzf7LmrUwwQpdRJ1b3pkKIr6FChdZNmTzed6IQZXQ4oFkt/kYWRXZP
   vD4TikH8/kAYD5t68FLfoX0jx0Trn9ED5m+rxl3aDE6aczt2nAu0ltKJl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="297894663"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297894663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:38:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762185514"
Received: from shengkai-mobl1.gar.corp.intel.com ([10.214.158.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:38:16 -0700
Message-ID: <886828d2bc145deaf159e513f844a64998828343.camel@intel.com>
Subject: Re: [PATCH V2 4/8] x86/topology: Fix multiple packages shown on a
 single-package system
From:   Zhang Rui <rui.zhang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com
Date:   Thu, 22 Sep 2022 21:38:12 +0800
In-Reply-To: <878e55f8-be4b-78bd-e1cb-5fbf674f6a02@intel.com>
References: <20220816051633.17775-1-rui.zhang@intel.com>
         <20220816051633.17775-5-rui.zhang@intel.com>
         <878e55f8-be4b-78bd-e1cb-5fbf674f6a02@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

On Wed, 2022-09-21 at 09:26 -0700, Dave Hansen wrote:
> On 8/15/22 22:16, Zhang Rui wrote:
> > Suggested-and-reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> "Please do not use combined tags, e.g. Reported-and-tested-by, as
> they
> just complicate automated extraction of tags."
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

Thanks for pointing this out.
Problem is addressed in V3 series.

thanks,
rui

