Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8C61916B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKDGuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiKDGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:50:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D0DB7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 23:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667544642; x=1699080642;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=q040YY6IfTO8zwrwAiF7g0BqW0FZCt8RdRgr5l1GCD0=;
  b=DrwcPlNwTbT7ju5cNzMXWaIQkZL1YSDyuGk2st9aUQRzaIwv5OiqY+p7
   wUbVsmTI/qyz+tw71TouIUHDw+7B9CQ64gOG4Xjv6KQ2aPbtwz+pTH4ec
   deNbYtXvAjjkXFqW8+JVbXfTsVih/49nky21xrLTX0+BNNywCgu7+uly4
   GT3nhaHMFQOpFAa9W3lL7mX2rgYQ7nIfR+fHg4yQfzbeCX5QNmiwnADgd
   Y0EwG2uhC/l0A7ms0Kc7YszNmWwpMVv6d2w/O55Y5fX3dMHA1hCoUzqTG
   fUVPQNludaWjoNvDOE+ZTwTveGGXh1onvp4+thgO9A+CQFXV/DG0zdjZD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="396196512"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="396196512"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 23:50:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="740514691"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="740514691"
Received: from yuhongwe-mobl.ccr.corp.intel.com (HELO [10.254.215.240]) ([10.254.215.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 23:50:41 -0700
Subject: Re: drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3289
 pvr2_hdw_get_tuner_status() warn: inconsistent indenting
To:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202211012349.5BDBLCup-lkp@intel.com>
 <202211011441.0AB5FB92B6@keescook>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <41e51edd-4246-717d-550c-87a4320aeb99@intel.com>
Date:   Fri, 4 Nov 2022 14:50:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202211011441.0AB5FB92B6@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 5:42 AM, Kees Cook wrote:
> On Tue, Nov 01, 2022 at 11:19:40PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   5aaef24b5c6d4246b2cac1be949869fa36577737
>> commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
>> date:   9 months ago
>> config: x86_64-randconfig-m001-20221031
>> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> smatch warnings:
>> drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3289 pvr2_hdw_get_tuner_status() warn: inconsistent indenting
> 
> Hi!
> 
> I have no idea why this is being reported to me. The fortify changes
> have nothing to do with the indenting in pvrusb2-hdw.c. :)

Hi Kees,

Sorry for the noise, the commit here is not the root cause, we'll add it 
to ignore list.

Best Regards,
Rong Chen

> 
> -Kees
> 
>>
>> vim +3289 drivers/media/usb/pvrusb2/pvrusb2-hdw.c
>>
>> 432907f750b27a drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2008-08-31  3279
>> 432907f750b27a drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2008-08-31  3280
>> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3281  /* Return information about the tuner */
>> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3282  int pvr2_hdw_get_tuner_status(struct pvr2_hdw *hdw,struct v4l2_tuner *vtp)
>> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3283  {
>> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3284  	LOCK_TAKE(hdw->big_lock); do {
>> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3285  		if (hdw->tuner_signal_stale) {
>> a51f5000b79100 drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2009-03-06  3286  			pvr2_hdw_status_poll(hdw);
>> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3287  		}
>> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3288  		memcpy(vtp,&hdw->tuner_signal_info,sizeof(struct v4l2_tuner));
>> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20 @3289  	} while (0); LOCK_GIVE(hdw->big_lock);
>> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3290  	return 0;
>> d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2006-06-26  3291  }
>> d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2006-06-26  3292
>>
>> :::::: The code at line 3289 was first introduced by commit
>> :::::: 18103c57b0168ebc0401702d483fe131f0aecc7a V4L/DVB (5081): Pvrusb2: VIDIOC_G_TUNER cleanup
>>
>> :::::: TO: Mike Isely <isely@pobox.com>
>> :::::: CC: Mauro Carvalho Chehab <mchehab@infradead.org>
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
> 
