Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003C76F8881
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjEESM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEESM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:12:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EDE2D63;
        Fri,  5 May 2023 11:12:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so4072388a12.2;
        Fri, 05 May 2023 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683310374; x=1685902374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmHicytrcbhYG1LQpJweqPCoU5ghflJtHDrXHt4yT6U=;
        b=LTjpqnR/MCosrtY1yKegt6qzRoTGUGs5wivg06/+V9yNazqC3eWcCJzwGaHfaPAde0
         eHhpFSNANpCRVdZnkceyPVnLIgP54R/gcxUaa2outoCB9nTMDcMr53BrlCKXCftY+cWL
         Wp2XcLH1nhFV5Qq6nTk7lRSsSNp4RmGIuhk9LbtjUb1SUodBc47L2GwVQM6BLqFVoj4t
         2ACqncF4j1Rvzx6ppme+sxqwBw0WajzWrJiH2qv9+XBm9w+CmGbZc0+MzwkotK9pgawu
         sxGznNL+LjR3+NoUQuofOTz41wfRALRTuHlG8OeE0qLFGwBSR7fGabXgsiEqzaTw7q89
         IA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683310374; x=1685902374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmHicytrcbhYG1LQpJweqPCoU5ghflJtHDrXHt4yT6U=;
        b=cY6IzP8UVNxkwxNWgckWFgfcB7fyXa0OXGxyr/PN9TdaAd/2fA2nXqx1ZldDErozst
         ViZPv7PKgquSQ3Fd3CcDH1qx3qbiHnugigOyXEPxe1qPz619sazldwYVAWRrAzufSfqd
         fyULIgkug/9+0zZ9wpy8nnm7K4FoDiQpRqA9JwPOMZCzFdTvPz4Lq7wZ/Y6e8vLYY3le
         DYI/0zu9O1xB2s4mAoJzySsq5eAwXCYThP3GioUX4o3usuZ3mA0P5VcHHJ6QIt4JcUnt
         WFDmF64IzkNphLBmIU2nDvjCM+uiPg1p+fA5MVggYt4WVrn25fOV27fJMWpWyRPkc2Ov
         sg8Q==
X-Gm-Message-State: AC+VfDyqUTu7+Rd+FH4SRl2b9jhQTgisgNG/W/ZMde+xhebutfpsLXVG
        OJjIyUI/J8tw4OXE8bEmFL8=
X-Google-Smtp-Source: ACHHUZ7MB77ShmRRjIJoqa2u75q1Kh92hHgHg8dZCaaOOrcaFHYCMC1jEmav/1uigT2VaFVWMW5mXQ==
X-Received: by 2002:a17:907:720e:b0:94e:3d6f:9c0f with SMTP id dr14-20020a170907720e00b0094e3d6f9c0fmr1991467ejc.55.1683310374228;
        Fri, 05 May 2023 11:12:54 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::5908])
        by smtp.gmail.com with ESMTPSA id gz6-20020a170907a04600b0094a90d3e385sm1231676ejc.30.2023.05.05.11.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:12:52 -0700 (PDT)
Date:   Fri, 5 May 2023 20:12:50 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZFVHImk2U6wI3Dg/@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
 <20230425155734.ywdle4pv6y2wjk2s@intel.intel>
 <ZE0WopTBS8S08tjX@carbian>
 <20230430184910.48d6c1b4@jic23-huawei>
 <ZFFna3MUzEtBkMxr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFFna3MUzEtBkMxr@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Tue, May 02, 2023 at 10:41:31PM +0300, Andy Shevchenko wrote:
> On Sun, Apr 30, 2023 at 06:49:10PM +0100, Jonathan Cameron wrote:
> > On Sat, 29 Apr 2023 15:07:46 +0200
> > Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> > > On Tue, Apr 25, 2023 at 05:57:34PM +0200, Andi Shyti wrote:
> > > > On Tue, Apr 25, 2023 at 12:22:25AM +0200, Mehdi Djait wrote:  
> 
> ...
> 
> > > > > +	chip_info = device_get_match_data(&spi->dev);
> > > > > +	if (!chip_info) {
> > > > > +		const struct spi_device_id *id = spi_get_device_id(spi);
> > > > > +		chip_info = (const struct kx022a_chip_info *)id->driver_data;  
> > > > 
> > > > you don't need the cast here... if you don't find it messy, I
> > > > wouldn't mind this form... some hate it, I find it easier to
> > > > read:
> > > > 
> > > > 	chip_info = spi_get_device_id(spi)->driver_data;
> > > > 
> > > > your choice.  
> > > 
> > > I don't really have any strong opinion about this other than keeping the
> > > same style used in iio drivers
> > > 
> > > Again thank you for the review
> > 
> > I'm fairly sure the cast is needed because driver_data is (via defines)
> > an unsigned long, which you cannot implicitly cast to a pointer without
> > various warnings being generated.
> 
> Instead we have a specific SPI provided helper for the above, please use it
> instead of open coded stuff.

I will change it in the next version

--
Kind Regards
Mehdi Djait
