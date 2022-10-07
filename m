Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848615F7699
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJGKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJGKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:01:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19ACA8794;
        Fri,  7 Oct 2022 03:01:38 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a10so5179919ljq.0;
        Fri, 07 Oct 2022 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DfhB8jvaZ+NX5O/W6U8PGiRnsQleUaLd7heHBLzUhM=;
        b=B2Hr7KIYLqdlgqBWIF1ylrBnKIo+/FHDGnjhpVzD/cDbwWuGodJu4KPh9dgmn8SQje
         cSWbK8apPRkKJngwKUOj57nvX0niu7SaBe2+S2UkTZgv7aHiIUVLWRBWf1Xao4CZMUJ1
         l90GwXLAT71HdT3sD+Q0ecH2xGGMH6O5/0GCHqLU4DiGh+FTAr95k6pbgFjgYdgVq1VU
         aENrX2Qgojj+t4h1WTdqqempffi8neDZvZiYehbzTJBWiriSSLOavgwwdIIHwYwGqIqC
         B5mwyxVzT6BT9WE+RcHxURFL3+dGO1Hlm+vhislFn8LaqdQumNJO+W9fjJfW0X/ZTu36
         m05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DfhB8jvaZ+NX5O/W6U8PGiRnsQleUaLd7heHBLzUhM=;
        b=CEQtpG6Kr9CSaLzFXPolRPsZD48S2QQPjmtWbE39q00nC2cvYRx15XX/Ws07sdLEFC
         mLhZ5VJbLlULJW5i8sqbyHgI0vAqtTUttO5Sp4cIPNLIo1Pn5WhhphEPlZdDv5qE0Exi
         0p9US0UK50D2lKsM/H88ZcQoMrFwaP/9hi9S/1DPppS+tSSxP7BYDBOC9oce6WdRD2u5
         DgYpBtXn0nyxFi+4s7E0bIB521FJqPu+rfRGd145qDrGTmfDlUVFDZUced8LgGy4UUK0
         RXQ1/az8JyT6ipfLLVsHLBQ54utjLeg0AXymj6q1qXVad/BrhS+PIRXbfOdzxYrd9f7E
         gZgg==
X-Gm-Message-State: ACrzQf06AtDrVBBlP2BryP7l3LTyRikLyN6/3vhkhBPiT8fJjTrvFn6G
        uli+kQpddm6zldgHyba9Tjg=
X-Google-Smtp-Source: AMsMyM5EtI1u2e5hy90i1u5NHtzhbsVaZ4Dvovfk7AKn3YGsZDBUpI9TUw2FGcfwqq/BxjYyUpI+FQ==
X-Received: by 2002:a2e:7804:0:b0:26c:463c:493c with SMTP id t4-20020a2e7804000000b0026c463c493cmr1417457ljc.521.1665136896974;
        Fri, 07 Oct 2022 03:01:36 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p18-20020a19f012000000b00499bf7605afsm235115lfc.143.2022.10.07.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 03:01:36 -0700 (PDT)
Date:   Fri, 7 Oct 2022 13:01:34 +0300
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
Message-ID: <20221007100134.faaekmuqyd5vy34m@mobilestation>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
 <20220930095247.vqtdc53rr66uaiwv@mobilestation>
 <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
 <20221004145049.74ffhcp7wpxw4ufz@mobilestation>
 <YzxueNRODpry8L0/@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzxueNRODpry8L0/@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:33:44AM -0600, Keith Busch wrote:
> On Tue, Oct 04, 2022 at 05:50:49PM +0300, Serge Semin wrote:
> > > 
> > > This particular condition for hwmon is not something that prevents us from
> > > making forward progress.
> > 
> > If you consider the hwmon functionality as optional (AFAIU you are),
> > then just ignore the return value no matter the reason. 
> 
> That is not an option. This function does IO, and the controller may not be
> usable on the other side of that, which means initialization must abort. We
> can't just ignore errors; we just don't need to report errors that don't
> prevent forward progress.
> 
> > If the problem
> > caused the hwmon initialization process to fail turns to be critical
> > it will be raised in some other place which is required for the NVME
> > driver to work properly. Otherwise the hwmon module initialization may
> > still cause the probe procedure to halt, which makes it not optional.
> > That's what I meant when was saying about "the function and its
> > caller semantics not implying that".
> > 
> > >  
> > > > > The
> > > > > driver can participate in memory reclaim, so failing on a low memory condition
> > > > > can make matters worse.
> > > > 
> > > > Yes it can, so can many other places in the driver utilizing kmalloc
> > > > with just GFP_KERNEL flag passed including on the same path as the
> > > > nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
> > > > either finished or executed in background anyway in all cases. 
> > > 
> > > This path is in the first initialization before we've set up a namespace that
> > > can be used as a reclaim destination.
> > > 
> > > > Don't
> > > > really see why memory allocation failure is less worse in this case
> > > > than in many others in the same driver especially seeing as I said
> > > 
> > > The other initialization kmalloc's are required to make forward progress toward
> > > setting up a namespace. This one is not required.
> > 
> > Anyway what you say seems still contradicting. First you said that the
> > hwmon functionality was optional, but the only error being ignored was
> > the no-memory one which was very rare and turned to be not ignored in
> > the most of the other places.
> 
> > Second you got to accept the second
> > patch of the series, which introduced a one more kmalloc followed
> > right after the first one in the same function nvme_hwmon_init(). 
> 

> My comments on this patch were intended to be applied to all similiarly added
> uses.

How could I've possibly got that from your "The rest looks good,
though." and nacking only this patch with the message "The hwmon is
not necessary for the rest of the driver..." ?

Anyway due to all these uncertainties it's better to have a second
opinion on the patches before re-spining the series.

@Christoph, since you've already started reviewing the pathchset could
you have a look at the patches #1 and #2 of the series? Please note
the @Keith' comments regarding the memory allocation failure handling
in there.

-Sergey
