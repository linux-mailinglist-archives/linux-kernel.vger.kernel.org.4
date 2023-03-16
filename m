Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE36BCE98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCPLmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCPLmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:42:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FCF16AE1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:42:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so6405068edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678966921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMr7/L6ld7SqDWFk0PhUo8yDjIH51evoeIgT4UWaiFI=;
        b=DPX9wCK5DX9dDuFSFQxaOuW9KzEqwSBAneILt8bA3qCS4zodt+NsbmYpUUi5ITnflZ
         Ryu2r3kUpFrV4vYquR5v1u5yieoxJElcAbENLrg2zelpLyfhVvpZvXTNAjepClMrVPyJ
         BqI0MOAAzSh1/lMMUm/Aild4RNM6YsrEiMfKzJYvCqurXzBn3puOAaSS0lky7SI15trU
         eBSzi8lM2ewtvR1xMZeHgh1eEmvMS7+lRSAyGFR0z5ihHhgxIh+0LGQxy3kBMrPJxjUY
         JGIdfEmBt6kYhKSfAZ9xlC1AobiIeq0+UWkt7wIup78ln4SrqWIJf55ktEEouhtuMytd
         lIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678966921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMr7/L6ld7SqDWFk0PhUo8yDjIH51evoeIgT4UWaiFI=;
        b=Zbv+O80HkDRNmGtMscEBaigvd/+gyKEskHS0ghmgVTcOO0ZQQ5/wpGwZiBRu6kXVnZ
         KHYOJXnfKlkYK5qOkX8pBWyrVZWhMVWIaIDUT5q+lKcPA00nymaW/ahXAVP7ndC3mb7b
         u0m8gW77++CjWnqvBm4/Byd2fVqJSbIrIscAAlN9mRnFRFrslLQq5nLwpsfv+EcbHfYk
         1pk3UTg5RXUEYV0NI8AX/t3R2lGT0/fl3lNvkKS0zR7USD82ASojVRm31oR1tgG4xgyU
         0E+MK7p8jZ6IQ5Pd8/JqX/J9ZzEGmDo8z09eDNvvcly9hfUdDQ6iOAwLg9aZSn2WESGl
         gSLQ==
X-Gm-Message-State: AO0yUKWgWdmFYk1+fyBsyijKCzm4DrqxDcHiQ10TwuXIQiS2pZ8Se7en
        eFC/Ofdtu6KaSbMQNiWOQfpuG4tWWhDu36zz
X-Google-Smtp-Source: AK7set/nlcqfPSTpurU3LMoT4iZh16mGQ/VZfrEQNXgvk7cUgBg7lctz8Gz+E/J8o5VJghzlKgRVVQ==
X-Received: by 2002:a05:6402:495:b0:4fd:2363:16fa with SMTP id k21-20020a056402049500b004fd236316famr5657912edv.41.1678966920943;
        Thu, 16 Mar 2023 04:42:00 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id t10-20020a50c24a000000b004c0057b478bsm3732454edf.34.2023.03.16.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:42:00 -0700 (PDT)
Date:   Thu, 16 Mar 2023 16:41:58 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBMAhld/NOG93pcs@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
 <ZBG699SriXWy1I2K@khadija-virtual-machine>
 <16148020.1MiD057Pog@suse>
 <ZBHUr7bANuhnOnIV@khadija-virtual-machine>
 <20230315150656.GA2938956@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315150656.GA2938956@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 08:06:56AM -0700, Nathan Chancellor wrote:
> Hi Khadija,
> 
> On Wed, Mar 15, 2023 at 07:22:39PM +0500, Khadija Kamran wrote:
> > On Wed, Mar 15, 2023 at 02:34:31PM +0100, Fabio M. De Francesco wrote:
> > > Aside from what I said and asked for with the other message of this same 
> > > thread, please take note that you can build a specific module if you prefer 
> > > not to re-build the whole kernel and other modules at the same time. 
> > > 
> > > I'm pretty sure that the instructions to do so are in the OutreachyFirstPatch 
> > > tutorial.
> > > 
> > > If they are not there, please let us know.
> > > 
> > > Fabio
> > 
> > Hey Fabio!
> > 
> > In the Outreachy FirstPatchTutorial under the 'Compiling only part of
> > the kernel' section there are ways to compile only some part of the
> > kernel.
> > 
> > I have tried using "make W=1 drivers/staging/axis-fifo/" and it says
> > 'nothing to be done for'. 
> 
> Is CONFIG_XIL_AXIS_FIFO enabled in your configuration?
> 
> > Should I start with the steps to reproduce? :'(
> 
> I did see a report of this same warning occurring with GCC but the
> report I commented on cane from clang/LLVM; using that toolchain may
> make it easier for you to reproduce this issue. The robot's reproduction
> instructions are fine but I think doing it manually is actually simpler.
> 
> Ubuntu 22.04 should have a pretty modern version of clang/LLVM, which
> you can install via 'sudo apt install clang lld llvm'.
> https://apt.llvm.org is another resource.
> 
> First, we will grab the configuration that was provided in the report:
> 
> $ wget -O .config https://download.01.org/0day-ci/archive/20230314/202303141159.6wN9HNP9-lkp@intel.com/config
> 
> Next, we want to make sure the configuration is synced, since we are
> technically changing compilers:
> 
> $ make -j"$(nproc)" ARCH=arm64 LLVM=1 olddefconfig
> 
> Finally, you should be able to build that object file and see the
> warning:
> 
> $ make -j"$(nproc)" ARCH=arm64 LLVM=1 drivers/staging/axis-fifo/
> ...
> drivers/staging/axis-fifo/axis-fifo.c:817:18: warning: implicit conversion from 'long' to 'int' changes value from 9223372036854775807 to -1 [-Wconstant-conversion]
>                 read_timeout = MAX_SCHEDULE_TIMEOUT;
>                              ~ ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/sched.h:296:31: note: expanded from macro 'MAX_SCHEDULE_TIMEOUT'
> #define MAX_SCHEDULE_TIMEOUT            LONG_MAX
>                                         ^~~~~~~~
> ./include/vdso/limits.h:11:19: note: expanded from macro 'LONG_MAX'
> #define LONG_MAX        ((long)(~0UL >> 1))
>                          ^~~~~~~~~~~~~~~~~
> drivers/staging/axis-fifo/axis-fifo.c:822:19: warning: implicit conversion from 'long' to 'int' changes value from 9223372036854775807 to -1 [-Wconstant-conversion]
>                 write_timeout = MAX_SCHEDULE_TIMEOUT;
>                               ~ ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/sched.h:296:31: note: expanded from macro 'MAX_SCHEDULE_TIMEOUT'
> #define MAX_SCHEDULE_TIMEOUT            LONG_MAX
>                                         ^~~~~~~~
> ./include/vdso/limits.h:11:19: note: expanded from macro 'LONG_MAX'
> #define LONG_MAX        ((long)(~0UL >> 1))
>                          ^~~~~~~~~~~~~~~~~
> 2 warnings generated.
> 
> Just repeat the last step as you investigate. If you have any further
> issues or questions, please let me know. For the record, I am not
> associated with Outreachy (I am one of the maintainers of clang/LLVM
> support in the kernel), so if I have messed something up or overstepped
> some boundary, I do apologize.
> 
> Cheers,
> Nathan

Hi Nathan! 

Sorry about the last email where I said that this is not working. I was
working in the wrong branch, my bad. 

This works! And it has helped me remove the warnings too. I have
replaced int datatype with long and the two warnings that were showing
are no longer there. 

I am working on [PATCH v5] and I will submit it in no time.

This was great help. :)

Thank you!
Regards,
Khadija


