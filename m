Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDCF5FFD1B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 05:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJPDB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 23:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJPDBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 23:01:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9C23608F;
        Sat, 15 Oct 2022 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665889312; x=1697425312;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O/YlblrzBj6zpfBdbzfIJ1q8Y/H7ZHYPzfW5/lC3O88=;
  b=LOc0Z8UCFoWisYPgTOLg6+RheCbty/jc6v7Nu1TRs102mryW/3nnMgAx
   b5kTCE3kqGclVhu2Dzqbr+l3u7Ajjd/pRYoddFUatOSiKUSyuyzmmQd6D
   UIgcNBt623injnRgYHjuLX2uoY5X+iKyxef70SsUAwtW77VyFSKa/VnXn
   IVyi2M5cUJHcNWj0VQtpxUBH3sfh38TzubDoREVgiOQP+kNx0zR0jr78d
   /Pjz3txMeayY8SDGZB7daEaITFaV4F1+BraycPkAT+Tegg+xPBIChPQjN
   33PHxgj+mKddv0FTnyE4ThfrhR84NlIAoMwnSPw3LaAgcuNmDSdkski3b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10501"; a="369791219"
X-IronPort-AV: E=Sophos;i="5.95,188,1661842800"; 
   d="scan'208";a="369791219"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 20:01:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10501"; a="605763108"
X-IronPort-AV: E=Sophos;i="5.95,188,1661842800"; 
   d="scan'208";a="605763108"
Received: from yueliu4-mobl1.ccr.corp.intel.com ([10.254.210.67])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 20:01:48 -0700
Message-ID: <cc62b99f7762eeb5de271d87e1ceb8a69e56cb71.camel@intel.com>
Subject: Re: [PATCH V4 1/4] hwmon/coretemp: Rename indx to index
From:   Zhang Rui <rui.zhang@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jdelvare@suse.com, len.brown@intel.com
Date:   Sun, 16 Oct 2022 11:01:45 +0800
In-Reply-To: <ed901a64-7002-4a4e-1342-c06f9a398fd1@roeck-us.net>
References: <20221014090147.1836-1-rui.zhang@intel.com>
         <20221014090147.1836-2-rui.zhang@intel.com>
         <ad558e83-3e42-aefd-754d-e71f49dda206@intel.com>
         <ed901a64-7002-4a4e-1342-c06f9a398fd1@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

Thanks for taking care of this.
That totally works for me.

thanks,
rui


On Fri, 2022-10-14 at 10:20 -0700, Guenter Roeck wrote:
> On 10/14/22 10:12, Dave Hansen wrote:
> > On 10/14/22 02:01, Zhang Rui wrote:
> > > Use variable name 'index' instead of 'indx' for the index in the
> > > core_data[] array.
> > > 
> > > No functional change expected.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > 
> > Hi,
> > 
> > Thanks for paring this series down.
> > 
> > I think I'm also going to pull this patch out of the series before
> > I
> > apply it and just rework 2/4 to apply cleanly without it.  I just
> > can't
> > put this in our "urgent" fixes pile and keep the stable@ tag on
> > such a
> > trivial rename and keep a straight face.
> > 
> 
> To be fair, this patch was only submitted as a prerequisite to the
> next
> patch in the series because someone had objected to the use of both
> 'indx'
> and 'index' in the driver.
> 
> Guenter
> 

