Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C632C61221C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 12:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ2KFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 06:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ2KFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 06:05:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA086565F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 03:05:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k2so18416472ejr.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fl8+mzJictjs3GireUYTXHH7RABnWw9ZfcMds4yMhls=;
        b=TJsAezHyJwg9LWGx/KHjhjq6jcANXmu0/jmnJasufAjAglk5zfSzRsbQYpIvbgfyhG
         SKM0nfCWfvzGPzYKysu0JrYplGSnbMSeKj3gadS5toqkj4VY+UvibNdE1gY88zBjzx7E
         ZH4mxTfObgLtP3OP7Dwy2xhXkCvlGxm8/2oE4bpLE/m8faB75nbIbaH13LeLYkU2mAPz
         PRaGvEFrasmxU+9HK68JRjSJYGxT/S3wVovX6Mns5+w3/QrhY9K5xtqclkkgS3ixBbYt
         iH9AuA+JldvPJw5mJjKswXvsO3nle1TKOPPmdu85WUtBXGLPVdtdqvlZdW9i+Dnljxfl
         qAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl8+mzJictjs3GireUYTXHH7RABnWw9ZfcMds4yMhls=;
        b=hza+0oJuGptN6VyL8TAz98hMDwFCx9btfGp3wDD59dWwocEEi5jyxS9y1S+ZV57FJU
         8Zi5rkiE8AeBmFNTPllXwkAZBygeEx4QLttnyaSubzcnauXdmlOQxySG2zDRJ8gNM/4v
         VHY0pzLnWVcEwggfexlE1nW0R1FWhfOxJzUlb2Qiwb96PprchlwqrbY4GgG5pq8bsr5e
         svgIz8oHAcq48HM1XZnsfpgzjrnemS8WoXa3BQNcLFvJLqomvzVgEFS7Mlg9f3p3kPei
         c0nLB7YRRw44ivmM0o2Lf7UqPim3Af5tYOhw7U3qWNSlqzgGVdmVzxxSroE/1FlwogBU
         NE2Q==
X-Gm-Message-State: ACrzQf1OZ3WHDX78LMV4VdDZOUS/1VdvcSkiBXvFpQ4pSgyOflXg0vha
        oXhmfe4T6gdBuKk/S+RtYc99H6VBGQ==
X-Google-Smtp-Source: AMsMyM7lCg2EGGO46SRL5P5YkR6HrSuYa2o3HYo4oD+QVxoJwbWGLzYItLYnEhyNJs88zrNB5U3T8Q==
X-Received: by 2002:a17:906:7952:b0:787:a14d:65a7 with SMTP id l18-20020a170906795200b00787a14d65a7mr3386999ejo.108.1667037945462;
        Sat, 29 Oct 2022 03:05:45 -0700 (PDT)
Received: from p183 ([46.53.250.206])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b007030c97ae62sm485054ejh.191.2022.10.29.03.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 03:05:45 -0700 (PDT)
Date:   Sat, 29 Oct 2022 13:05:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rft, PATCH v1 4/4] kernel.h: Split out ARRAY_SZIE()
Message-ID: <Y1z697DtIBdp+Z9C@p183>
References: <Y1ay8k75fegxTcuG@x99>
 <Y1a3vpiy8RBGfbsI@smile.fi.intel.com>
 <Y1bWBedax9lP2E3K@p183>
 <Y1ecOl+UGdBV1ce3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1ecOl+UGdBV1ce3@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:20:10AM +0300, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 09:14:29PM +0300, Alexey Dobriyan wrote:
> > On Mon, Oct 24, 2022 at 07:05:18PM +0300, Andy Shevchenko wrote:
> > > On Mon, Oct 24, 2022 at 06:44:50PM +0300, Alexey Dobriyan wrote:
> > > > > include/linux/array_size.h | 13 +++++++++++++
> > > > 
> > > > All of this is pessimisation unless you're removing
> > > > 
> > > > 	+#include <linux/array_size.h>
> > > > 
> > > > from kernel.h which you aren't doing.
> > > > 
> > > > container_of.h is just as silly.
> > > > 
> > > > kernel.h might need _some_ cleanup (like panic and tainted stuff) which
> > > > is rarely used but ARRAY_SIZE()?
> > > 
> > > Are you suggesting to slow down compilation with inclusion of tons of unneeded
> > > stuff in the zillions of drivers?
> > > 
> > > Or you are talking that we need to abandon most of the headers and combine
> > > everything into kernel.h? I think this is what is silly.
> > 
> > It hard to escape kernel.h so you will be including it anyway.
> 
> It's very important to not include it in the headers.
> 
> And this split helps to it a lot. We have container_of() or array_size() used
> in macros and/or inliners that are usually appears in the headers. And if you
> know what dependency hell means, the kernel.h brings to it a huge mess.
> 
> So, try to be constructive, okay?
> 
> > Unless you delete, say, kstrtox.h from kernel.h, it is pointless busywork.

I'm very constructive.

Parsing 1 define is faster than opening/reading/closing a file to parse
1 define (it's 2 defines because of header guard).

Therefore extracting 1 macro into separate file without obvious future
growth is a pessimisation.

And if you delete #include <array_size.h> from kernel.h and fix all
compile failures (which you aren't doing apparently) backporters will
hate you for life.

I've tried to delete kstrtox.h, and even allnoconfig had dozens of
failures.
