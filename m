Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BCE6A53A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjB1H3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1H3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:29:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D890901F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:29:39 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so4741266wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7o3/v5H3v/D2/l1qgkCvqgReJV0ZPBMSP6fxlnoI9s=;
        b=ijLEMaw6uNP5MP/hEYRfSHuPAMCIoKJi13BQ5koGqKRHBR/yfmVxxfL/BTun69y2Mq
         eKJx9dW5X8zgWCYYkoDdflXHzh/ft77T7FWiiEbTzdEmGPjqPxuqmFWs8hV4xGwqVOTJ
         Jm2Lb7i3oKDRn60RhPAmvtcuF4uU+ilgXK9ypICxBz3h760glyoHgz0r0Pwre59oLG7Z
         WtUZX/Kaw2LrXxXJ4jQGXG4gSeTirhkITSOy9RlSe1BIYLrjSaunpz2jvsmQt+qfX8m9
         CwtqwImHcU/nZ4oMgCkdqlfY5nO1IBRdNuZOI0qra4/wmIV3Wm2B/wQopESCCOnkzsqe
         gwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7o3/v5H3v/D2/l1qgkCvqgReJV0ZPBMSP6fxlnoI9s=;
        b=Rzqng09aQ0DbZQCI55uEdlHNaGCADkXtgeFjoWJ16bgCWY7HaJDDlAFSij0eqEs42u
         fANz/uXzN9seB5ugV0S+2+QXHr+79O16u6fF+5rThfYZKIomNiPq8MQSUTdV2dYZRP3b
         4cpgjS7u9pwbdkKjAt71VPjAs/5X8FJpjfNGpjwqJo9JpVdWysk92GgHEItZpR0SPXEQ
         PQ+VpXs0gET2fHUNKTRDBN03S5WErlA4SoFmvR/uEzGoLSO/obIrOzse7dw+9UlySSP/
         DIqUlKst9Rw88Um2SK3QnJOnvpEaxN2NgH6XgGK0sYr4k6xARBf8osPJo9qKxD5NbAOJ
         B/oQ==
X-Gm-Message-State: AO0yUKUoVjHq16z+j2HI4d0Lty49OU5z9+eF6Szz5VZsotgZYD05CFLG
        ihpP9A72hVCBUHSMwLrmWIVF6R6VZEprNi3/
X-Google-Smtp-Source: AK7set/Lj0yHPkWGgCYSg+qsCDNd9A6kfzcS4yOFlehXutT54z3ExEriS9tZ3uoP3b3HnmYJ0UgSNg==
X-Received: by 2002:a05:600c:1708:b0:3eb:2de9:8aed with SMTP id c8-20020a05600c170800b003eb2de98aedmr1153707wmn.41.1677569377652;
        Mon, 27 Feb 2023 23:29:37 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003ea57808179sm14681425wmh.38.2023.02.27.23.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 23:29:37 -0800 (PST)
Date:   Tue, 28 Feb 2023 08:29:36 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230228072936.22ahmg6ggqk4v5wh@orel>
References: <20230224095526.ctctpzw3p3csf6qj@orel>
 <24a6dbe6aa2043c7812bf7e258786e13@EXMBX066.cuchost.com>
 <20230224120715.wgqnqmkadsbqusus@orel>
 <180fda36f9974809b436c52e4b3eda58@EXMBX066.cuchost.com>
 <20230227075942.rgl4hqnwttwvoroe@orel>
 <178ca008701147828d2e62402ff4f78a@EXMBX066.cuchost.com>
 <20230227114435.eow57ax5zhysz3kv@orel>
 <a6c319dd867f4f1d97e9d950b9e7c636@EXMBX066.cuchost.com>
 <20230228050457.zfbflfawctaccepv@orel>
 <ffd2e7849b764043bef606d9b8019506@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd2e7849b764043bef606d9b8019506@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 06:33:59AM +0000, JeeHeng Sia wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Sent: Tuesday, 28 February, 2023 1:05 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > 
> > On Tue, Feb 28, 2023 at 01:32:53AM +0000, JeeHeng Sia wrote:
> > > > > > > 	load image;
> > > > > > > loop:	Create pbe chain, return error if failed;
> > > > > >
> > > > > > This loop pseudocode is incomplete. It's
> > > > > >
> > > > > > loop:
> > > > > >         if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
> > > > > > 	   return page_address(page);
> > > > > > 	Create pbe chain, return error if failed;
> > > > > > 	...
> > > > > >
> > > > > > which I pointed out explicitly in my last reply. Also, as I asked in my
> > > > > > last reply (and have been asking four times now, albeit less explicitly
> > > > > > the first two times), how do we know at least one PBE will be linked?
> > > > > 1 PBE correspond to 1 page, you shouldn't expect only 1 page is saved.
> > > >
> > > > I know PBEs correspond to pages. *Why* should I not expect only one page
> > > > is saved? Or, more importantly, why should I expect more than zero pages
> > > > are saved?
> > > >
> > > > Convincing answers might be because we *always* put the restore code in
> > > > pages which get added to the PBE list or that the original page tables
> > > > *always* get put in pages which get added to the PBE list. It's not very
> > > > convincing to simply *assume* that at least one random page will always
> > > > meet the PBE list criteria.
> > > >
> > > > > Hibernation core will do the calculation. If the PBEs (restore_pblist) linked successfully, the hibernated image will be restore else
> > > > normal boot will take place.
> > > > > > Or, even more specifically this time, where is the proof that for each
> > > > > > hibernation resume, there exists some page such that
> > > > > > !swsusp_page_is_forbidden(page) or !swsusp_page_is_free(page) is true?
> > > > > forbidden_pages and free_pages are not contributed to the restore_pblist (as you already aware from the code). Infact, the
> > > > forbidden_pages and free_pages are not save into the disk.
> > > >
> > > > Exactly, so those pages are *not* going to contribute to the greater than
> > > > zero pages. What I've been asking for, from the beginning, is to know
> > > > which page(s) are known to *always* contribute to the list. Or, IOW, how
> > > > do you know the PBE list isn't empty, a.k.a restore_pblist isn't NULL?
> > > Well, this is keep going around in a circle, thought the answer is in the hibernation code. restore_pblist get the pointer from the PBE,
> > and the PBE already checked for validity.
> > 
> > It keeps going around in circles because you keep avoiding my question by
> > pointing out trivial linked list code. I'm not worried about the linked
> > list code being correct. My concern is that you're using a linked list
> > with an assumption that it is not empty. My question has been all along,
> > how do you know it's not empty?
> > 
> > I'll change the way I ask this time. Please take a look at your PBE list
> > and let me know if there are PBEs on it that must be there on each
> > hibernation resume, e.g. the resume code page is there or whatever.
> Just to add on, it is not "my" PBE list but the list is from the hibernation core. As already draw out the scenarios for you, checking should be done at the initialization phase. 

Your PBE list is your instance of the PBE list when you resume your
hibernation test. I'm simply asking you to dump the PBE list while
you resume a hibernation, and then tell me what's there.

Please stop thinking about the trivial details of the code, like which
file a variable is in, and start thinking about how the code is being
used. A PBE list is a concept, your PBE list is an instance of that
concept, the code, which is the least interesting part, is just an
implementation of that concept. First, I want to understand the concept,
then we can worry about the code.

drew

> > 
> > > Can I suggest you to submit a patch to the hibernation core?
> > 
> > Why? What's wrong with it?
> > 
> > Thanks,
> > drew
