Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68EC68F634
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjBHRzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBHRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:55:51 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831759E2;
        Wed,  8 Feb 2023 09:55:50 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id p24-20020a056830131800b0068d4b30536aso5424173otq.9;
        Wed, 08 Feb 2023 09:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38PTeztQrL9qtAxD4sqn35R+raT1OYxHt79zEk4qHls=;
        b=aIdstLHyJNveusptl7Pc6MxMQKCVoL0h+ochJ+fpBM/uyfSaS0F6n0EDvBvf9q+0CI
         3nKwtXNf6Llb1ZexkbWVdOEP71IhXTww09PTzXM3gwtP88UdB7q+lUHSrQpZbrXfHxue
         vroyErXP66c86uh9DT/TxQFTZ48pC9BX87/plAL856ZJw6NsNwi+2kAWnhnOB1DU4M4m
         imfPDsMECUs+pM+2T5hwoTwaqvOtPygRNW3svT0Lkth3X3JaL7hpsmgNSZn3hpXDSlpE
         AM4V3pogxq64JK/LklaNrnCZuL31wdfrhfpL+c6YexUxP3OGLhsQ0uqsvjrQL3cV13fU
         JvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38PTeztQrL9qtAxD4sqn35R+raT1OYxHt79zEk4qHls=;
        b=6hhGodRoGdcjFFlhyUQklNE/+l+1HbWkZNNFld2rWAkMuuAab29IxPw/vVFdbUpDt0
         LayO9Vhozc88ZxO6DwHIuqQ1ELyDWDUITpZQki5aVvg3SPNNpcEcUe80Pc3xP3PT7+an
         VnmtdSUpAvPuRuzO+YxKh+nZ+ycJi9x5IXUyORV5a1Twf7TjhLVM2cMYnZ6fkCU7nJOw
         eJCCYpDmyoQJuy7FyYJZBGfz3jRuTG7c5OcmIC1Q3xsJlkf6xbqhkYm3Nru4ezwNOcds
         b3BWDls/H5XKhvGLcgaftigHLz3tAGyxQPbd4XFFH12GpSax9BoGsvS24C2N/yVZ3qlk
         xyew==
X-Gm-Message-State: AO0yUKUveFFMH+EGT+DPYnPeA9fF9uAvk4kCLg6UwS4dO8m16snwuRiM
        0qOqiGxyJkj9cO/EuiQpn8eIlEhavc8=
X-Google-Smtp-Source: AK7set97gGges1jnkKiBdN4ewY/AP5dNBC9M1zVXjJOW9Vqf5a1e0Rwoyj2jB5ganwS4hmZ5BrH5Gg==
X-Received: by 2002:a05:6830:2713:b0:68b:e01b:2508 with SMTP id j19-20020a056830271300b0068be01b2508mr5633386otu.15.1675878949586;
        Wed, 08 Feb 2023 09:55:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c15-20020a9d75cf000000b0068bbaf7a1b0sm8347477otl.34.2023.02.08.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:55:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 8 Feb 2023 09:55:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     George Cherian <gcherian@marvell.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: sbsa_wdog: Make sure the timeout
 programming is within the limits
Message-ID: <20230208175547.GA3065515@roeck-us.net>
References: <20230208083736.1237256-1-george.cherian@marvell.com>
 <2f2dcb7c-e5bc-7e97-71e0-eebdc72fbd03@roeck-us.net>
 <BYAPR18MB267995FB55301778894B3334C5D89@BYAPR18MB2679.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR18MB267995FB55301778894B3334C5D89@BYAPR18MB2679.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:20:34PM +0000, George Cherian wrote:
> 
> 
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Wednesday, February 8, 2023 8:41 PM
> > To: George Cherian <gcherian@marvell.com>; wim@linux-watchdog.org;
> > zhangshaokun@hisilicon.com
> > Cc: linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] watchdog: sbsa_wdog: Make sure the timeout
> > programming is within the limits
> > 
> > 
> > ----------------------------------------------------------------------
> > On 2/8/23 00:37, George Cherian wrote:
> > > Make sure to honour the max_hw_heartbeat_ms while programming the
> > > timeout value to WOR. Clamp the timeout passed to
> > > sbsa_gwdt_set_timeout() to make sure the programmed value is within
> > the permissible range.
> > >
> > > Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> > >
> > > Signed-off-by: George Cherian <george.cherian@marvell.com>
> > > ---
> > >   drivers/watchdog/sbsa_gwdt.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/watchdog/sbsa_gwdt.c
> > > b/drivers/watchdog/sbsa_gwdt.c index 9791c74aebd4..ee1039a652f1
> > 100644
> > > --- a/drivers/watchdog/sbsa_gwdt.c
> > > +++ b/drivers/watchdog/sbsa_gwdt.c
> > > @@ -149,6 +149,7 @@ static int sbsa_gwdt_set_timeout(struct
> > watchdog_device *wdd,
> > >   {
> > >   	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
> > >
> > > +	timeout = clamp_t(unsigned int, timeout, 1, wdd-
> > >max_hw_heartbeat_ms
> > > +/ 1000);
> > >   	wdd->timeout = timeout;
> > >
> > 
> > Wrong order. wdd->timeout should still contain the requested timeout.
> But then the requested timeout is not being set in HW.
> Isn't that a disconnect?

No. The driver is supposed to set a timeout no larger than
max_hw_heartbeat_ms. The watchdog core then takes care of
differences between ->timeout (as seen by the user) and
max_hw_heartbeat_ms and pings the watchdog as needed.

Guenter
