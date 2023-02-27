Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FEE6A43CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjB0OJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjB0OJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:09:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C933596
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YjGPAr6Sp29E62Gk0cXJTGmExlUuZDb0WBWJO8kQCuw=; b=rDzRWuB3K6/CfENKKSefj7FQs7
        vOMngL626grQnQhzz6v8XOBS/NAX1dowYD4mj51VR1h4D9jV+ghSrzrA3Azz5iU+FWQSLqpC+sW+C
        3FaMM0OfQ3C76ZVsDoKFdrhmQWcuAtgt/qX08gYGDobT9SRY9SEMRC61echfxQUdSDXALiOLa/5Sy
        dO/9jHund/hF0TCrtn14uAkws/cYTAXDVcEHlXk7z+XY5tT+biij4E3lH5Bf96W47Ksxhd9/vkY4r
        QBDyEgWWlzZ6ws5lnwWPt7HxmIRWgrIg90fGQuOvl0WlPuPrtuXVxYfUCD5q1P+iArF8D2+UBhO0y
        iq6ohQGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWeBH-00EF0T-1U;
        Mon, 27 Feb 2023 14:08:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 599EC30030B;
        Mon, 27 Feb 2023 15:08:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BE41235D5684; Mon, 27 Feb 2023 15:08:42 +0100 (CET)
Date:   Mon, 27 Feb 2023 15:08:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: vmlinux.o: warning: objtool: mptscsih_abort+0x7f4: unreachable
 instruction
Message-ID: <Y/y5aucdGL7U+W7a@hirez.programming.kicks-ass.net>
References: <202302271743.78emit6I-lkp@intel.com>
 <Y/ykNfK+1G8ZNYSU@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ykNfK+1G8ZNYSU@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 12:38:13PM +0000, Mark Rutland wrote:
> [adding Peter and Josh, given objtool]
> 
> On Mon, Feb 27, 2023 at 05:28:53PM +0800, kernel test robot wrote:
> > Hi Mark,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   f3a2439f20d918930cc4ae8f76fe1c1afd26958f
> > commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
> > date:   5 weeks ago
> > config: x86_64-randconfig-r026-20230227 (https://download.01.org/0day-ci/archive/20230227/202302271743.78emit6I-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c27cd083cfb9d392f304657ed00fcde1136704e7
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout c27cd083cfb9d392f304657ed00fcde1136704e7
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=x86_64 olddefconfig
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202302271743.78emit6I-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> vmlinux.o: warning: objtool: mptscsih_abort+0x7f4: unreachable instruction

> > 07ef  2fb7bff:	e8 00 00 00 00       	call   2fb7c04 <mptscsih_abort+0x7f4>	2fb7c00: R_X86_64_PLT32	mpt_halt_firmware-0x4
> > 07f4  2fb7c04:	e9 75 fb ff ff       	jmp    2fb777e <mptscsih_abort+0x36e>

this is one of those noreturn things again... objtool was clever enough
to figure out that mpt_halt_firmware() does not return (all it's control
flow ends in panic()) and hence it 'knows' that +7f4 will not be
executed. But GCC didn't figure out the same.

