Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B0615465
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiKAVmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKAVmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:42:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC31D1EEDD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:42:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g129so14572695pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 14:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSHDc3o4H/7VbN5hmOhWDJwUTgNQ3lK69UcV9TK/T/4=;
        b=KHnOzRTsoFu5vAVo9yFbA4g16D98n0phDlNHDms8avBVGv0UxW6MLhwgtZUHDkxAgW
         2EQB/EXDs2iSl4Kv/gJXbTV6+IDrsNsY18NIE33ml5+JSXnbDQtmjnKdpnJQl+VxUFTz
         QmKP0X41NdeON7l8xtzywSuelDrRfmO2m0edk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSHDc3o4H/7VbN5hmOhWDJwUTgNQ3lK69UcV9TK/T/4=;
        b=UjOKHe9QS+yn13B1rijwP6fFokesmwk/Yc7SRtaGnr5rpY+4FWcWXvkKc4/L3nKFDf
         LYhpG3ArwGqet2OMTJG+pgmmpwvZRCVxF0aDeNYzUYH0dxG6z7xhhk6/UMomgzcQu32b
         j1PAkoWTJhngcx3utol9cGxgAjRkAgi68R5Rf5wDKzjopAJPIkt6ZNc0C3QlA+lU3pes
         wCcY+sAcRbki//WC9Ia/i8SzGxYkPDIWSmcweQjBTc0vJICDBBQ+iDwHiK584xRKZMIy
         LvRy/cFeAeHfKBhE9q0QeppVF5RC76vWuo2pd+nsmg6K0TAOS7vxf2QZx1iZLNRafZQL
         3ZrA==
X-Gm-Message-State: ACrzQf02O7rSCl33RvD8eZQIoCbqKAsbqppWXRyVruLDzOO0S+idlv29
        glUv7GoFMuRXeOXDWYz0x37ZZtJ6AhWdFw==
X-Google-Smtp-Source: AMsMyM7iEHMIp20UVlRjei8J64EoJAYNTUTOO55Y95V3KOXvRw314c1mkCfUvlSF/x6EdPZgBMTOzg==
X-Received: by 2002:a63:2b10:0:b0:451:5df1:4b17 with SMTP id r16-20020a632b10000000b004515df14b17mr18357653pgr.61.1667338938273;
        Tue, 01 Nov 2022 14:42:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78f27000000b0056bb36c047asm6984687pfr.105.2022.11.01.14.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:42:17 -0700 (PDT)
Date:   Tue, 1 Nov 2022 14:42:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3289
 pvr2_hdw_get_tuner_status() warn: inconsistent indenting
Message-ID: <202211011441.0AB5FB92B6@keescook>
References: <202211012349.5BDBLCup-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211012349.5BDBLCup-lkp@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:19:40PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5aaef24b5c6d4246b2cac1be949869fa36577737
> commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
> date:   9 months ago
> config: x86_64-randconfig-m001-20221031
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3289 pvr2_hdw_get_tuner_status() warn: inconsistent indenting

Hi!

I have no idea why this is being reported to me. The fortify changes
have nothing to do with the indenting in pvrusb2-hdw.c. :)

-Kees

> 
> vim +3289 drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> 
> 432907f750b27a drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2008-08-31  3279  
> 432907f750b27a drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2008-08-31  3280  
> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3281  /* Return information about the tuner */
> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3282  int pvr2_hdw_get_tuner_status(struct pvr2_hdw *hdw,struct v4l2_tuner *vtp)
> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3283  {
> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3284  	LOCK_TAKE(hdw->big_lock); do {
> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3285  		if (hdw->tuner_signal_stale) {
> a51f5000b79100 drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2009-03-06  3286  			pvr2_hdw_status_poll(hdw);
> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3287  		}
> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3288  		memcpy(vtp,&hdw->tuner_signal_info,sizeof(struct v4l2_tuner));
> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20 @3289  	} while (0); LOCK_GIVE(hdw->big_lock);
> 18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3290  	return 0;
> d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2006-06-26  3291  }
> d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2006-06-26  3292  
> 
> :::::: The code at line 3289 was first introduced by commit
> :::::: 18103c57b0168ebc0401702d483fe131f0aecc7a V4L/DVB (5081): Pvrusb2: VIDIOC_G_TUNER cleanup
> 
> :::::: TO: Mike Isely <isely@pobox.com>
> :::::: CC: Mauro Carvalho Chehab <mchehab@infradead.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

-- 
Kees Cook
