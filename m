Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F78652656
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiLTSeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLTSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:34:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB822AD;
        Tue, 20 Dec 2022 10:34:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u5so13262420pjy.5;
        Tue, 20 Dec 2022 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQens0GrM1j1Pq7PUe4p3v78cyMtzaMxKYhn1IUucHA=;
        b=KVQH4HSEoYXfhYy9BPbxjcmJJyRJOwuUUnOrSzK3I6YMzC5VQVGARBpkUi/6ISNopy
         JcnWiAuY+qVBakn/K/nqnHiMJ0wwhG3Dhzpt+jTCFUzgftjDtFUy0IGYN43LRxp2/sTx
         /V2kXMXtYIj36VGz6bCUmknaUbyRrU4N6YFCTuZenAWeepJRw9HlvVo/M4YVTJks5G+0
         Agck65PmvBL5zsRbDzU5EK1WVNSxFjZ/8XijKbwMMC3zGEaE/5bfo5plrc1HDvo+aUEL
         abdor5uMfBNBIs263+NtWaeKM2vEzjSCsgnfpHE5ybq1jPW0UYAZB2Dzw9wz6qnyzXV2
         +q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQens0GrM1j1Pq7PUe4p3v78cyMtzaMxKYhn1IUucHA=;
        b=NcvBy2FTdRtICJ0hysSZbgXZ5lBvdQSjO2fsOONv8quEGJKUMfgzJV+yQIH47BcF4I
         zXfivnVeFMAqkhNbE+rxyeeLn0q1CuV98IEOHk97soRG9NY1RyapxjxYUjuB5a2jeKW2
         4nAnID9yL8z/+rd9Sg3josqwa1ISk+BqqfYvSGhDV6wbwXRpimH3jIKIugK4zFPvYzVH
         2vT00HDjQc5+bl5Nr5nhTy+akQamwwlhZc6FAobT6fS2yrkm0ht7/4YqmFh1yCBnE9Ov
         LBycHlDf3X6lHN669/bT4uYgSOfwyVNGcAHNLiWWlALsBN2vKntPsNPC1eeKjGXi7loy
         OmvA==
X-Gm-Message-State: ANoB5plqhqv1972pEWdcqSLbZp50s9D77hbY9gNLOeQu9keDSGrJKYLs
        Payw2tdWjBvq9a4ClQXdt/c=
X-Google-Smtp-Source: AA0mqf77S0BUfRzfa17gO42AWg3BHLLiq7gzEbDlXrF3drVWMgYQM3/iXNuL1VK09NY1StV/hc64AA==
X-Received: by 2002:a17:902:b198:b0:189:fa12:c98a with SMTP id s24-20020a170902b19800b00189fa12c98amr54202554plr.66.1671561240231;
        Tue, 20 Dec 2022 10:34:00 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7206:404e:4820:d175])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b00188c9c11559sm9682906plj.1.2022.12.20.10.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:33:59 -0800 (PST)
Date:   Tue, 20 Dec 2022 10:33:56 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] gpiolib: of: remove of_gpio_count()
Message-ID: <Y6IAFOurfhYbq+/m@google.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
 <Y6G97zJwHaW+Kmo0@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6G97zJwHaW+Kmo0@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:51:43PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 19, 2022 at 11:20:12AM -0800, Dmitry Torokhov wrote:
> > There are no more users of of_gpio_count() in the mainline kernel,
> > remove it.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > After 6.2-rc1 there should be no more users of the APIs mentioned in
> > this series.
> 
> I believe you probably want to have this patch applied immediately to the GPIO
> subsystem after v6.2-rc1 to avoid new users.

Thanks for the reviews Andy.

I think Linus pulled all the changes removing these all APIs into
mainline, so it is possible to get it into 6.2 right away. Since
everything is supposed to go through 'next' we will probably catch new
users regardless, but I indeed would not mind having this in 6.2 and not
wait for 6.3.

Thanks.

-- 
Dmitry
