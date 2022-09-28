Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274575EE4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiI1Sv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiI1SvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:51:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0571D69DE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:51:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n10so21122974wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=16+5dv0qnNhx6JJsrfYMj5avSapIxDYnZwLey3uPyQg=;
        b=liDvQbxk/EoMr/RqyMl+cdXil9bCJfBXUMEWwISjr1/6KKLL33C+or7Nc4xd9U8uYu
         ppj7p5ezFlutNtvLaRGlaPMzjM5Vtqd1+rn1sEIAMaOal890tbts2syCO4QDhEZUhq8w
         NN8Uc3e9OEIngJozNx4h3VwRxrv8fLPt7+lyVofT4zv0QMXdKRTfLeLNC79sssksjB0p
         bpH6QHEbw6cVb7CxcHVqpnH5w/8KMC9atztez4035krqZVkBLlG0BGdt2tsKLwJQLHwA
         rgRItJ0GFUCo9lrfyF6Vwk+JhXJiw1SLu8iashfPT6s+YtBMIJivAPLVzVC2QfypkRBk
         +u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=16+5dv0qnNhx6JJsrfYMj5avSapIxDYnZwLey3uPyQg=;
        b=gidFxmf/hCnL1p0WupF+/vxPPrMbYozuqZZxGqWe44D4ZeWMxIec1OVTMlE9Cn7vrE
         RJ7XeVt5pMBBD15VD46w0CkhsFvxIEGbxV6TyVifk4SPgOpzRBEPJM4OWVtEEf+jjI24
         qkCz2ClxalvtUKLBIBXi6L7rHC+rUgh2RiPy1T4wFK1n1knnlSSOSwzG6G8VME6qzJbk
         ZnR6IXthfEH3NJNGMJAnjjR4P6UlDpYUbNtg3JLig0k1ExgfbxSFD97ngbGyTY1QWs3p
         ToqsRDw37QzddsVq98/bXlWuAaAqctISIgwE+XP6jemM0oHd4Pp0qhPlGyyf+n9EKzh9
         9ekw==
X-Gm-Message-State: ACrzQf1inEnGV7WCChMlWwd9jDklfq1gJe/fZmPQBMhucPiKReGgwQPi
        1zqE0ci98dlfpD5l+e7sGISA80whTQ==
X-Google-Smtp-Source: AMsMyM7KyKkX2OfVKPSdGmQwxfojBPfXLVyaS8qUeZDIJoloJlGj/mjwf2JECi+V4KJ5mFIqh6pXsA==
X-Received: by 2002:a5d:550c:0:b0:22b:1942:4bf6 with SMTP id b12-20020a5d550c000000b0022b19424bf6mr20868846wrv.520.1664391080047;
        Wed, 28 Sep 2022 11:51:20 -0700 (PDT)
Received: from octinomon ([2a00:23c8:2f02:3b01:3ea1:40:8650:189])
        by smtp.gmail.com with ESMTPSA id ck16-20020a5d5e90000000b0022cc4b7861fsm3033420wrb.97.2022.09.28.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:51:19 -0700 (PDT)
Date:   Wed, 28 Sep 2022 19:51:17 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     hsweeten@visionengravers.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] comedi: Convert snprintf() to scnprintf()
Message-ID: <YzSXpf/I/QbN6szd@octinomon>
References: <YzHxcb5VzWeSNKo0@fedora>
 <YzKS/3z2cQsFFfxD@kroah.com>
 <041a4643-decf-55fe-90a4-4728fc029220@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041a4643-decf-55fe-90a4-4728fc029220@mev.co.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 04:45:53PM +0100, Ian Abbott wrote:
> On 27/09/2022 07:06, Greg KH wrote:
> > On Mon, Sep 26, 2022 at 07:37:37PM +0100, Jules Irenge wrote:
> > > Coccinnelle reports a warning
> > > Warning: Use scnprintf or sprintf
> > > Adding to that, there has been a slow migration from snprintf to scnprintf.
> > > This LWN article explains the rationale for this change
> > > https: //lwn.net/Articles/69419/
> > > Ie. snprintf() returns what *would* be the resulting length,
> > > while scnprintf() returns the actual length.
> > > 
> > > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > > ---
> > >   drivers/comedi/comedi_fops.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> > > index 55a0cae04b8d..e8a0142d5894 100644
> > > --- a/drivers/comedi/comedi_fops.c
> > > +++ b/drivers/comedi/comedi_fops.c
> > > @@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
> > >   	mutex_unlock(&dev->mutex);
> > >   	comedi_dev_put(dev);
> > > -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> > > +	return scnprintf(buf, PAGE_SIZE, "%u\n", size);
> > 
> > Ick, no, you should use sysfs_emit() if you really want to change these
> > functions to "do the right thing".
> 
> There was a patch to do that by Xuezhi Zhang.  It got to PATCH v4.  I should
> have replied with a "Reviewed-By" tag, but I'd already done that for the
> earlier versions.
> 
> https://lore.kernel.org/lkml/20220901013423.418464-1-zhangxuezhi3@gmail.com/
> 
Great, it's good to know how to fix the warning anyway.

Thanks,
Jules
