Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DFE5E75F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIWIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIWIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:40:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953AAA50DD;
        Fri, 23 Sep 2022 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663922408; x=1695458408;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iejbR8WlaYF8JWGPcuXfUF5HflRzNVutSIIKS7awbhI=;
  b=iRVD1vsOZRCMbmDA2fOe9blB3xuTBIWPYo+8ZzvQxgg0EjfXy3HXp0hK
   cP6mVDYC8WVrBAfRShLsaObA7gZbWd0sOrPdHg5/NnUx3ZxkgpKmzmiEs
   H7I6zhUWxR9PIEtz3qCUCfeptJ0XcQRP6gA69KYeWAPaEgruUeatcIlLu
   c+EsMJ46Kxal5Fhk1KYuyab5C/H4/FCZSMTRqlTbqBXJh7jd3609p3NyV
   re0KmRmfci+vUw862CTGLpkKJeoWnJgZg4N/ZwB6bhjbRDI7Eruab6Pxn
   VjClUqhxONXT211D0KqJ3Uz4bQKqwp6nasopLJOTZitnTCUjTZX9pYR5l
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287661204"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="287661204"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:40:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="620141860"
Received: from kanglong-mobl1.gar.corp.intel.com ([10.213.38.10])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:39:48 -0700
Message-ID: <9a1ae0b5d7a5ee3c870195e942d58bdd9b3b71db.camel@intel.com>
Subject: Re: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
From:   Zhang Rui <rui.zhang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Date:   Fri, 23 Sep 2022 16:39:42 +0800
In-Reply-To: <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
References: <20220922133800.12918-1-rui.zhang@intel.com>
         <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

On Thu, 2022-09-22 at 09:53 -0700, Dave Hansen wrote:
> > Changes since V2:
> >  - changelog improvements based on Peter' feedback
> >  - Remove combined tags
> 
> I fixed those up and started testing your v2 yesterday.

Thanks for doing this.

>   Can you
> double-check that this:
> 
> 	
> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=cpuid1f
> 
> Looks the same as your v3?

There is no code difference.
Just that I have updated the subject and changelog of patch 1/8 per
Peter' suggestion
https://lore.kernel.org/lkml/8496afee057d63b83a7ff02ec7f1de8c2d0e97ae.camel@intel.com/

thanks,
rui

