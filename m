Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0AC64573C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiLGKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiLGKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:12:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CEA4092E;
        Wed,  7 Dec 2022 02:12:02 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n3so12861568pfq.10;
        Wed, 07 Dec 2022 02:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+P1xMnkCCBz9CXQ/HSo+U65ScICwkDZ83BVNMvEKZk=;
        b=NZsAuyNjTb4ztrX0KgkavB2VvvMs21qQi3kR56jkqnPSEYFcfuCrPgNJqSvgnfBFVp
         6SmeY90qC82fFxB0YYLdKwSaG9Gng35gGvug8pg6bDX8APJNPwcgYtOb5iAdChL6fGve
         3k98IbCHJgV+/WG8SQhubAQ9NQShX2qOdqye5lONQ0aKW44Z2m60t3sc8nCzzcQn+Zyn
         Dp29sAAS0JG1mLNe53IO/3NMbj5jjdMqLLEd2gW0ZOAQxM6vx83lmLIkE8UdxNohsEtb
         rKosAsRiItTOhnaw0ydWwbR5b/Ln0gsgLkg163grxi0ApWKYChjOlx3Xwwend6dp3C3C
         BM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+P1xMnkCCBz9CXQ/HSo+U65ScICwkDZ83BVNMvEKZk=;
        b=4K3nMixH91XkNA2c1Hlcrt2Vq6VqAbzHZ4xWt29/ACBK5sQa2jsCN2eqGT6UI9BhEH
         4h2XP9RYzdfwccCsZMYjD3sRbaAQYYPZbEEBPDt0RkN1AzQ1ViyuhldZfLb+p+JZiDhO
         GE08ebMW1XExF1vEMw7BXF8LaRXNrMysWdgtdTLw6zph3FN+eSXXcHULPjhjwTveyKtw
         dYpwvfZLipgBaY13+INW/Sakk+bn5tQSNBsH3UDlRMSsjk5eKugE0Egd67gwGAGET3pM
         v+wlVY8veU3WPiTZUmQLeoMxPVwzNz6VqXcqaYNV4/d2f2vEBwnYvpiJYFNWb7gi9h+8
         xtxQ==
X-Gm-Message-State: ANoB5pkD0iemhl/V5Gl4mJW+m+xXZ2yczo2bNOTPJO0AWUTHGwmWyQvP
        qlGOTZTAjNsEVyls4TL8fgU=
X-Google-Smtp-Source: AA0mqf6HUg62PrOsODpLPCv8Q5It7/v8kLLYdJaBk9BU/+DnNWPO1P84+r0fZhFEy8CQmMCCfOD58Q==
X-Received: by 2002:a63:cd44:0:b0:478:1391:fc43 with SMTP id a4-20020a63cd44000000b004781391fc43mr42038466pgj.431.1670407922191;
        Wed, 07 Dec 2022 02:12:02 -0800 (PST)
Received: from sol (110-174-14-241.tpgi.com.au. [110.174.14.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b0017f72a430adsm14257355plg.71.2022.12.07.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:12:01 -0800 (PST)
Date:   Wed, 7 Dec 2022 18:11:55 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
Message-ID: <Y5Bm6+ZKMaWCPDxi@sol>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdaQWZE6=BNEh5hSH9=jBK=TcLoD1uUb=JyNYmHFvaSAfg@mail.gmail.com>
 <Y41MxPthLjitvzEl@sol>
 <CACRpkdb67ygsEuZhRZ9TGmmNXhiU2LsuefD0-48xtCLx3fq-KA@mail.gmail.com>
 <Y5BjJmz5Mvdr8cAR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5BjJmz5Mvdr8cAR@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 11:55:50AM +0200, Andy Shevchenko wrote:
> On Wed, Dec 07, 2022 at 01:06:46AM +0100, Linus Walleij wrote:
> > On Mon, Dec 5, 2022 at 2:43 AM Kent Gibson <warthog618@gmail.com> wrote:
> > 
> > > My preference would be for the driver API to be extended with a new
> > > callback for the output buffer, say get_output(), and have the existing
> > > get() always return the input buffer.
> > 
> > This has a certain elegance to it, as it cuts to the bone of the
> > problem and partition it in two halves, reflecting the two pieces
> > of hardware: input and output buffer. Also follows Rusty Russells
> > API hierarchy.
> 
> The (one of) problem is that not all hardware may support input and output
> be enabled at the same time.

Exactly - and you want to hide that from the user.

> What would that new API return in that case
> and how it would be better with get() returning the value depending on
> direction?
> 

It would return an error for whichever is not supported.  So get()
returns an error when the input buffer is unavailable, and get_output()
returns an error when the output buffer is unavailable.  And that is for
whatever reason, e.g. the selected mode or lacking hardware or driver
support.

It is better because the user is explicitly informed that the buffer
they are trying to read from is not supported by the current
configuration.  And they get to choose which buffer they want to read
as they see fit - not have that selection made for them by magic.

Cheers,
Kent.
