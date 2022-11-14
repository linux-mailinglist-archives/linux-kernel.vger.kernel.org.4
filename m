Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C4C627854
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbiKNI7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbiKNI7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:59:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ED21D0C2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:59:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p12so9482526plq.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CqCziBDyF1eskwQchllhGeXcXMIreg6dgBMSZX9rCUg=;
        b=K6bPwA26LU2IKEK9IwihTK0Qm/R0I1Ya4IO3H99L9uaNLG6ObQxW6iQ2zsyajXR/sC
         6R64uHHJ2ztfJPobIkCg+pKwDFKkQRgzWCJ25PHwJ9EtLpFZTb5DX+lR79QRHtLZzavc
         qWRUN13ESED7KlVEgzzAQG4Hh4k5Ub67ZiNiXEQ6WvJxYs1gaCKIuhgR3gWQcHbzoMSl
         6N+qbCeO1nRz238+V3/tliBZ+laCEa6QsAp5XwlWyN3/iOgCPvC+Qu54sWJzBW57Pny1
         xYrB0+idhA0hiDGwPMMv7o0qrj8kVq4emEymjYKiikVjTIn6WTAFEYkxzWb4wMrRVaA6
         pxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqCziBDyF1eskwQchllhGeXcXMIreg6dgBMSZX9rCUg=;
        b=S/a0TYzUfGdWVquQU05w+JaZC2d+oAZ5/0ff5Zt13+5jALv7sWdRQAQmF/W5QH994B
         Mp2ijYalx9zhnyRtVpcCqcZsIIdWybzdeHKfZNcabKa6C3FqVl2n1UPbVD8D+6IcqySF
         Lx9I4QpH09O8C9akPTe5wsMtu5itZIqsrEySoSRPgwv1aNZXW7KncuksXPojipX25dgQ
         bxpBwKXvtL4UVTJVZuYRmTXMVEEfqhue8cCAdEssUJXXSg2XDzempXt/Y1DNlSP5ScKq
         fB/u5YAZo92snAd2d3Abqo9iU8hBJYcXEae8ud+ph9VnUxcfaH9fis/bENtUW+EHbTR5
         G3nQ==
X-Gm-Message-State: ANoB5pkFoP8TWBDdpbQ/lZl+PK4YjmkX4fBIA/dv/TG9YDUwk5qMc3bb
        9l5vSe3NfmwtFOvDQ2l1Avg=
X-Google-Smtp-Source: AA0mqf4oWVQDjwGR8UOJcIOjRgoDE9/Ne22MAGbMnh6UZ9wZYXU1gClzZWK+qIFC2kqXT/ZM6yKy6A==
X-Received: by 2002:a17:902:8c8a:b0:188:ca57:8945 with SMTP id t10-20020a1709028c8a00b00188ca578945mr2223200plo.116.1668416353136;
        Mon, 14 Nov 2022 00:59:13 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b00186c54188b4sm6841932plc.240.2022.11.14.00.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 00:59:12 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:59:06 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     Randy Dunlap <rdunlap@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: include: linux: slab: kmalloc_trace undefined when compiling
 drivers
Message-ID: <Y3IDWt9vINpCtXjP@hyeyoo>
References: <Y2/Luovqgz8O+Kqa@rhino>
 <f83aca33-3a5f-97ac-625e-aa7c72bf60ba@infradead.org>
 <Y3AXVRAoZA5YEho+@rhino>
 <1df133ef-d5e9-f323-7c67-fc9ffed04274@infradead.org>
 <Y3A9waTkehESUyn+@rhino>
 <abdb1b8d-859d-669b-6bbf-604febb643b2@infradead.org>
 <Y3BGimp2LmRqV9oy@rhino>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3BGimp2LmRqV9oy@rhino>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 08:21:14PM -0500, Ian Cowan wrote:
> On Sat, Nov 12, 2022 at 05:11:27PM -0800, Randy Dunlap wrote:
> > 
> > 
> > On 11/12/22 16:43, Ian Cowan wrote:
> > > On Sat, Nov 12, 2022 at 04:34:18PM -0800, Randy Dunlap wrote:
> > >>
> > >>
> > >> On 11/12/22 13:59, Ian Cowan wrote:
> > >>> On Sat, Nov 12, 2022 at 09:21:34AM -0800, Randy Dunlap wrote:
> > >>>> Hi--
> > >>>>
> > >>>> On 11/12/22 08:37, Ian Cowan wrote:
> > >>>>> When compiling drivers (speficially drivers/pci/hotplug), I am receiving
> > >>>>> the following modpost error for both `kmalloc_trace` and
> > >>>>> `kmalloc_node_trace` on the staging/staging-next branch:
> > >>>>>
> > >>
> > >> Ian, what do you mean by "on the staging/staging-next branch"?
> > >>
> > >> What kernel version are you trying to build?
> > >>
> > >> The .config that you sent is for v6.1.0-rc1.
> > > 
> > > I am building from the staging repository (gregkh/staging) and my
> > > working branch when building is staging-next. So I am trying to build
> > > from staging and not a particular version. I have also run `make modules_prepare`
> > > and updated the .config per that script. However, when I do build
> > > v6.1.0-rc1 from the main repository (torvalds/linux), I run into the same problem.
> > 
> > Have you built the entire kernel already and then you are trying to build
> > only drivers/pci/hotplug?
> Yes, I did build the entire kernel already and then I'm just trying to
> rebuild that module.
> 
> In `include/linux/slab.h` if I remove the lines between `#ifdef
> CONFIG_TRACING` and `#else` (lines 473-480) and then the corresponding
> `#endif` and leave lines 481-499, I'm able to compile that module
> without issue.

I don't get what the problem is.
In case kmalloc[_node]_trace() is undefined, it's replaced with kmem_cache_alloc[_node]. 

Is the kernel built with same config on tree?

-- 
Thanks,
Hyeonggon
