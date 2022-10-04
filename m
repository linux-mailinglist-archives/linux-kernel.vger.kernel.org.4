Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7290C5F45EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJDOu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJDOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:50:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613AA62ABD;
        Tue,  4 Oct 2022 07:50:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d18so8430616lfb.0;
        Tue, 04 Oct 2022 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0Hn40CSUd9u1FNS+WIRJQMhD0PfBlmdUq9IyNX5yQ8A=;
        b=EyZjjX/3GJ3YRLyk8hhn5QEWqzCFf4PlbGe41bHvbGx7TdRABf8tAe/qRNZGRRJArC
         wO7x/JJLgqjW8NGOJsj6+6eALVIjVP0e6Z3aY7tcRZfR00DaFLkPMO22U+WFh79aeQd/
         VQ3sBsEWwSVrz5tCizef4R5netdI9nlLvFUi9UGzSnZd647yPqgH+zCYE+GE/yQaMLmf
         XFGRMiFUniLOKls9aO3+RKatXSBxPMzxdJWLdaBv6xc4IM6WQfkuCS1A/YZ4T0P/IcjA
         kwZKfnr0ghw3XivtacA4oTuejHvWTBp+555zVAhLcqxPghBijq9pKOj6PZuA0ZDoieDu
         U9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0Hn40CSUd9u1FNS+WIRJQMhD0PfBlmdUq9IyNX5yQ8A=;
        b=i4ULWCYdMgIjOdBGR1m37CwzIl8vah+mAv6L7+1pAZ5BHzdFuCpkJ6wLM4o3OdZMB0
         r1Hb0PotR2gFJuznfCQlIb/N33uvcqxlggqzoiVIAIqWciiBAI7havXXz3+fC2JiklnA
         hCkFH5OMlUiMpzPoIYXBaREE/Esru6Sony9Px2mszTXLVRT/u0o00f5dp57vPTcuzS+8
         V7OkIdGkgJFw8I69pDRtOLsEap7h1XcooxO0pNoKTsZyP5IP33b43olMdTr3jBnYnT8c
         afZxoA3XrgP6Y58aP2/zaVGOajCxApB77jl3GuB3SBVW/tQ57O5JyS9EGjdR7u6Yxh45
         Mpbg==
X-Gm-Message-State: ACrzQf3ozWPeEe/PgNQJ+UVrmyXwQYt0Nsi2cI7dLx+hWZA5i/gx5bHN
        pU34fDv801gyjNAvUL3lRpI=
X-Google-Smtp-Source: AMsMyM5xHx121xWdjc6Jdp/Vv6LqbJIYkiwnlPad3CEaFwaOgZMjZ6vZdghrd8V0TtOKHjNcb3ytrA==
X-Received: by 2002:a05:6512:12c8:b0:49b:817a:c2fc with SMTP id p8-20020a05651212c800b0049b817ac2fcmr9798920lfg.165.1664895051892;
        Tue, 04 Oct 2022 07:50:51 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id g14-20020a056512118e00b0048b0099f40fsm1935601lfr.216.2022.10.04.07.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:50:51 -0700 (PDT)
Date:   Tue, 4 Oct 2022 17:50:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <20221004145049.74ffhcp7wpxw4ufz@mobilestation>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
 <20220930095247.vqtdc53rr66uaiwv@mobilestation>
 <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 08:57:02AM -0600, Keith Busch wrote:
> On Fri, Sep 30, 2022 at 12:52:47PM +0300, Serge Semin wrote:
> > On Thu, Sep 29, 2022 at 05:53:43PM -0600, Keith Busch wrote:
> > > On Fri, Sep 30, 2022 at 01:46:46AM +0300, Serge Semin wrote:
> > > > Inability to allocate a buffer is a critical error which shouldn't be
> > > > tolerated since most likely the rest of the driver won't work correctly.
> > > > Thus instead of returning the zero status let's return the -ENOMEM error
> > > > if the nvme_hwmon_data structure instance couldn't be created.
> > > 
> > 
> > > Nak for this one. The hwmon is not necessary for the rest of the driver to
> > > function, so having the driver detach from the device seems a bit harsh.
> > 
> > Even if it is as you say, neither the method semantic nor the way it's
> > called imply that. Any failures except the allocation one are
> > perceived as erroneous.
> 

> This is called by nvme_init_ctrl_finish(), and returns the error to
> nvme_reset_work() only if it's < 0, which indicates we can't go on and the
> driver unbinds.

That's obvious. One of the my question was that what makes the no
memory error different from the rest of the errors causing the
nvme_hwmon_init() method to fail? 

> 
> This particular condition for hwmon is not something that prevents us from
> making forward progress.

If you consider the hwmon functionality as optional (AFAIU you are),
then just ignore the return value no matter the reason. If the problem
caused the hwmon initialization process to fail turns to be critical
it will be raised in some other place which is required for the NVME
driver to work properly. Otherwise the hwmon module initialization may
still cause the probe procedure to halt, which makes it not optional.
That's what I meant when was saying about "the function and its
caller semantics not implying that".

>  
> > > The
> > > driver can participate in memory reclaim, so failing on a low memory condition
> > > can make matters worse.
> > 
> > Yes it can, so can many other places in the driver utilizing kmalloc
> > with just GFP_KERNEL flag passed including on the same path as the
> > nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
> > either finished or executed in background anyway in all cases. 
> 
> This path is in the first initialization before we've set up a namespace that
> can be used as a reclaim destination.
> 
> > Don't
> > really see why memory allocation failure is less worse in this case
> > than in many others in the same driver especially seeing as I said
> 
> The other initialization kmalloc's are required to make forward progress toward
> setting up a namespace. This one is not required.

Anyway what you say seems still contradicting. First you said that the
hwmon functionality was optional, but the only error being ignored was
the no-memory one which was very rare and turned to be not ignored in
the most of the other places. Second you got to accept the second
patch of the series, which introduced a one more kmalloc followed
right after the first one in the same function nvme_hwmon_init(). That
kmalloc failure wasn't ignored but caused the nvme_hwmon_init()
function to return an error. If you suggest to forget about the first
part (which IMO still counts, but AFAICS is a common pattern in the
NVME core driver, i.e. nvme_configure_apst() and
nvme_configure_host_options()), the second part still applies.

-Sergey
