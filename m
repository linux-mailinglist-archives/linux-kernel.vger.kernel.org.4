Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83E261098B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ1FJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1FJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:09:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7601B2308;
        Thu, 27 Oct 2022 22:09:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f140so3925676pfa.1;
        Thu, 27 Oct 2022 22:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtBU5C0unJboqOWp7PReuenbHBA6rpjnojXvyNkWrrs=;
        b=K6iLH28+qSWBCuiWDoUpKioO+g8xeG6r7BNbVaXEtJtnTcYYy9z/+mnrh9C7WgCDmG
         KbsxCXbEb3Yn7y/a+POJCklqNgfCBe6TAt5AXQJ2dVfH3a6+JAE67CQk9W8nZ5ymHmf2
         SNYAA0+wRt/qdQws47FC4PAySVBeHlYnMc205NE09GmoPF9qJAkExKKCDeBIV443CBon
         EPOv0c+VPC+5rRblU/b9XKP9+cTW6K8LZmwABs0reU4yWrX5Rzn59LBOE7Hjv05ha9U7
         levgHY7XJzPFFVqo4PYNoPuinPEjs5AbWsQBRyeU4a/m3CtqkrGlv0tNcosj8wQbl4QE
         7Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtBU5C0unJboqOWp7PReuenbHBA6rpjnojXvyNkWrrs=;
        b=sBa0HKZ2Sxn2Kk7g+3Nb3RqOylJ1va4g7aTNatHOSN/1za9I1q6aCmMXsVB+BNRs+o
         cHPJPXnPX6f9gj6Qf65YR2hqZoiMRe4BHIIsnRYOktvgTl0EYrhDnnaC7elxgqCUuyko
         jabc9hywPiv0UPYS1qDXl4A/Z+Af81kzm2sBhgXDAXR23bwxorfSHc/2znDB3ntYNNKk
         Vws6DHdf+sGRj+GtxX3ymw1/qTI4ROtvGgmmZrEslyo8q5IG9MEFhYDGxhWrseKVQ9bc
         Y+AZYkmSA096V+ZCJmGXzqagzuOU7ZnICL4V1DokGvHERSmOaHucSzSmvsmodEaKsrns
         V5Hw==
X-Gm-Message-State: ACrzQf3BukVjQYeDwI0Ih3UodF4xAia6JrTzvJ9aT6pw9RXsQwEm4mwV
        G7zg6mmPTWfZoCI5k6Now9E=
X-Google-Smtp-Source: AMsMyM5dop9KHtxRywC+Tc2hVtJh7shsaRdX8NDuhmaxtOplaBhGWeQQ7slzJzpEfb07SOoguLTS7A==
X-Received: by 2002:a63:e942:0:b0:46f:469a:2658 with SMTP id q2-20020a63e942000000b0046f469a2658mr9158818pgj.302.1666933750951;
        Thu, 27 Oct 2022 22:09:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ea9a:801b:ed52:2db1])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090a12cf00b00205fafa6768sm3441671pjg.6.2022.10.27.22.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 22:09:10 -0700 (PDT)
Date:   Thu, 27 Oct 2022 22:09:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: twl4030-madc: add missing of.h include
Message-ID: <Y1tj8+WSOMlio9D0@google.com>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
 <20220927154611.3330871-3-dmitry.torokhov@gmail.com>
 <YzMisM73yj/APB86@smile.fi.intel.com>
 <20221001180705.7002796a@jic23-huawei>
 <Yzi7sBI+kEHrJjHz@google.com>
 <20221002135744.770ae2fb@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002135744.770ae2fb@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 01:57:44PM +0100, Jonathan Cameron wrote:
> On Sat, 1 Oct 2022 15:14:08 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Sat, Oct 01, 2022 at 06:07:05PM +0100, Jonathan Cameron wrote:
> > > On Tue, 27 Sep 2022 19:20:00 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >   
> > > > On Tue, Sep 27, 2022 at 08:46:11AM -0700, Dmitry Torokhov wrote:  
> > > > > The driver is using of_device_id/of_match_ptr() and therefore needs
> > > > > to include of.h header. We used to get this definition indirectly via
> > > > > inclusion of matrix_keypad.h from twl.h, but we are cleaning up
> > > > > matrix_keypad.h from unnecessary includes.    
> > > > 
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > > Applied to the togreg branch of iio.git and pushed out as testing for
> > > 0-day to take a look.
> > > 
> > > Note that this is 6.2 material now - if that's an issue for the matrix_keypad.h
> > > cleanup then feel free to take it via the input tree with
> > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > but shout in reply to this so I know to drop it from the iio tree.  
> > 
> > OK, it is not urgent, but I do not want to lose matrix keypad changes...
> > 
> > How about I'll wait to see where the rest of the patches end, and if
> > they end up in 6.1 I'll queue twl4030-madc.c through my tree together
> > with the header change?
> > 
> > Thanks.
> > 
> Ok. I'll drop it for now - let me know if I should pick it up once everything
> settles down.

Because the other patches have landed in 6.1 timeframe I picked up this
patch and the header change myself.

Thanks.

-- 
Dmitry
