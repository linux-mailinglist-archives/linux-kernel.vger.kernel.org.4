Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277DC5EB0E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIZTFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiIZTEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:04:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5689676E;
        Mon, 26 Sep 2022 12:04:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b6so8506566ljr.10;
        Mon, 26 Sep 2022 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AeGYPkz2x8jcvNXUE5KPVrnPBM5osWqcHiU7r2l4Ujs=;
        b=XYFoUF7rhLBiYKg3bdP9IKfPBnKpMmi9C52dIyzF4IOPmFbAANkfjxNTZLk6zCMmDl
         A3mq7wBdllf83I19p0J9fy81moHDQ6VFqmatYzDRmOiEjbRIB583+kVaLgJdlO4aESkO
         U4WoMdBdmJrTOi0b78lJjT5+BQmSGdxUcxzYStdXcWU3OeVlGZcF5VbQRjWs5tWnEVL6
         D96yOaTXgvA6RYsYbBtcy5275B8I9z+kV1Dup6ArESWHRsxQsObui/DPiQYR7B3toN1a
         kkxW/r0GTnJ0Oy1OwVKXToO7oK/rjbHSOXn4K5CbpWdL0h1QKkTgDPw0Qo/0Dy/yCyyT
         F/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AeGYPkz2x8jcvNXUE5KPVrnPBM5osWqcHiU7r2l4Ujs=;
        b=bX0SlDRCxyFWTLbL8ifLvi6JeV73WVEFYbelUzU6rAk6C5EWNGZ8yevKNJqYEmms2g
         iPHV/LkmkVXYCvCddyPAUAeBWzitSLv19ckNge4cY/mBaPeRcslRLu+YNa5y//7mPWBF
         kjq4fsVt8b2XoLIljiDoibZ84/fBQx+ZbS6asW8KDa8pBwfYnBjR4oqWzDqno/BYBjpJ
         WlzTyyW24Q9EP9E8wgAc63DlNQPr8no57EUJzwSmHPxUKr/A8LyZmXCwf7KJrvJ3hoA8
         mmavD9nP71exEw/LUcZ0R47ztUVxFq67eQeYCCoBKikWIuYK20dPxHeCWJjTWx2VDhgU
         Mmjg==
X-Gm-Message-State: ACrzQf2o9udo9n8cNbjJu/V5nf04Jc4koNrfI/m/GT+uso59X06F0wQD
        hnBNzTxhYn/dorS4EeuQ+R8=
X-Google-Smtp-Source: AMsMyM4Exx0LUG/MKfdR62HORsHNUq7/T8J0dlOM8Y7tMjvWP9YsMaHOr+jd54V/Yx7HRvGTYCqRHg==
X-Received: by 2002:a2e:ba15:0:b0:26c:1798:b178 with SMTP id p21-20020a2eba15000000b0026c1798b178mr7710795lja.19.1664219045898;
        Mon, 26 Sep 2022 12:04:05 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b004896ed8dce3sm2623603lfg.2.2022.09.26.12.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:04:05 -0700 (PDT)
Date:   Mon, 26 Sep 2022 22:04:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220926190402.zyngr6bq6sicv6uw@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <20220910053045.GA23052@lst.de>
 <20220910123542.tzxg2blegw55z5fj@mobilestation>
 <20220912082909.GA10666@lst.de>
 <20220925222325.irltbraf4e2j4vtq@mobilestation>
 <20220926143959.GA19918@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926143959.GA19918@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:39:59PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 01:23:25AM +0300, Serge Semin wrote:
> > IMO both the approaches seem unclear if a reader doesn't know what
> > they have been introduced for. Anyway do you insist on using the
> > kmalloc-ed buffer here instead? If so I'll resubmit the series with
> > this patch updated accordingly.
> 

> I don't like the __aligend version too much, but I can live with it if
> you strongly prefer it.

What about converting the NVME hwmon driver to using the kmalloc'ed
buffer (seeing the rest of the NVME core driver prefer kmallocing the
buffers) and adding the ____cacheline_aligned modifier to the opal_dev
buffers?

-Sergey
