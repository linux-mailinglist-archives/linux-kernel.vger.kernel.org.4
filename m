Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9E62D8E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiKQLHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiKQLG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:06:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2719F31F9B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:06:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l14so3248679wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kYDg53wsGKutNyKBdN9lJQxQ/YinXUOzzbN1yqpmcgE=;
        b=N8GxB1tiMjXUW++FirZ1HVaPg7IPaKpd6YWD+02vgi4dVNbZcPrrSId5hbmJCJ7afR
         ZS69cVHASx2Y0eZ5uGHSoU6J7g7RGcXLs+ipXCpZ2o0p1ynf9xosyKKkCSLhj7krp21V
         ndQNsYd0tfst1Kl5WGGLucB6fi3fDS9DZxEEVeeMGMzhD6qLJi2PQvJPneFXdKOgvKWu
         QLlGd6/k3CT6gFRcekXqgZvdo1lW4A7r0ZNwxa33R/qLSa+1fRzgca1aT+4PCP/7yKEp
         DFcQE3hdU0h9UJ9jOVmj+C6psrgDyuZtZi5qjEnf5aRYIVPIFvhtsnIlvRN1qd4hzJpD
         ASqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYDg53wsGKutNyKBdN9lJQxQ/YinXUOzzbN1yqpmcgE=;
        b=TljNfPAvo/oyFO/T3Do6FXyg9iV7MINmVwC3RyfVrbChpX7yQLh7uEofBAVCOKgue9
         yIqk5cFro3+vIiIZepea1bVbfBc+50lgaTZTSW59kuLwbv2ZSBE28PZWtNxJJEWgJkqx
         Uj8ymkI7CqvrBoGMB+pQ6Aro0tkMN48H8lDV7FuPVk4hoRO6wDMhUYJWYEbVQL2ds7BZ
         Kejzo/SFV6ZUO0zrjmM9Si+atN5OTFayXNvaX/gP7t+MbaIfoPgvttaztB4BUrs2bKwR
         3GQt4J6xK180UYtMiBlNoxUiXxgly1V2w6ZqqR52qenCywMlII6UnQYN6MBxZ8tX0k9/
         YZNg==
X-Gm-Message-State: ANoB5plfjzaEH65q+OgnzckfGaG91V7UrRhHKYebOVogAy/YWyVTlnna
        pOWQ17ZEH1mDIjTi9k867xJ91A==
X-Google-Smtp-Source: AA0mqf5engmUU+Hc6t1F6Ib5V1yWVikFr373w4fj9rIxmIhbIEKPd3q1IKOAKEHl8Wb1UH5RkrcGLA==
X-Received: by 2002:a5d:678c:0:b0:235:14dc:5e14 with SMTP id v12-20020a5d678c000000b0023514dc5e14mr1192804wru.252.1668683187724;
        Thu, 17 Nov 2022 03:06:27 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m14-20020a5d56ce000000b002364c77bc96sm661051wrw.33.2022.11.17.03.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:06:27 -0800 (PST)
Date:   Thu, 17 Nov 2022 11:06:25 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Drop support for legacy PWM probing
Message-ID: <Y3YVsaO38g9EUgHq@maple.lan>
References: <20221117072151.3789691-1-u.kleine-koenig@pengutronix.de>
 <Y3YJaYx06Jzrs/Ej@maple.lan>
 <20221117102814.vdgixgfq4pr77fly@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117102814.vdgixgfq4pr77fly@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:28:14AM +0100, Uwe Kleine-König wrote:
> On Thu, Nov 17, 2022 at 10:14:01AM +0000, Daniel Thompson wrote:
> > On Thu, Nov 17, 2022 at 08:21:51AM +0100, Uwe Kleine-König wrote:
> > > There is no in-tree user left which relies on legacy probing. So drop
> > > support for it which removes another user of the deprecated
> > > pwm_request() function.
> > >
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >
> > I have to take the "no in-tree user" on faith since I'm not familiar
> > enough with PWM history to check that. However from a backlight
> > point-of-view it looks like a nice tidy up:
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> Probably "in-tree provider" would have been the better term. You can
> convince you about that:
>
> $ git grep -l platform_pwm_backlight_data | xargs grep pwm_id
>
> That is, no machine used pwm_id to make the legacy lookup necessary.

Thanks for that. pwm_request() seems so old that my intuition about
how device APIs in Linux work misled me and I completely missed that
the consumption of pwm_id at the call site was the key to the source
navigation here.


> Who will pick up this patch? Should I resend for s/user/provider/?

Lee Jones should hoover this up. Normally I only pick up backlight
patches when Lee's on holiday ;-).

No need to resend on my account. I interpreted the original
description as "provider" anyway, I just didn't know how best to
search for them.


Daniel.
