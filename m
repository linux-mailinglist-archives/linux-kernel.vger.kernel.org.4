Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AEB6B2AA2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCIQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCIQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:24:07 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421DF73B7;
        Thu,  9 Mar 2023 08:15:28 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-176b90e14a9so2789930fac.9;
        Thu, 09 Mar 2023 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678378401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYOeUJJ89Hztfcvaky8Mr2gLJEdiaCb6nJHTudqVZvs=;
        b=O2AJ3swIqJ9DTvxFmQEwTHlSVvUPVEj7ctsMdozKZiHm3NKvTN41YJybBpos+D/H1z
         Jt6Xss7r3mPpxCcAXe2/cFBpZe4b4kDOu+Rp6Ac3wNianJJx6YJJDMzKJYupN1YpdTJC
         SQ9rnqulBrhB+ZFyAxwD6gs9JN0ZePrVI0Z+AFt3Y3GJL0ma1AN+1KaQeLssBQD3UyI8
         E/AXYaoKN8hhQbMOPXUipCxFuSa0BD14ffRJScv+1Rnbn8XWoV5vPVMiEqk+IlnMyP3w
         /N26aitnnmf1b2mtNGX2gkg5Z03XQihlMV/qY0eoB9euX32BvAl9crkAIPJdy0ViqFkH
         5MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678378401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYOeUJJ89Hztfcvaky8Mr2gLJEdiaCb6nJHTudqVZvs=;
        b=5QOp2VXLeMg5i4Vi3tNklxwVnyadRGDMHnlgk3Pn6IcyoIYiODk/24X6GuZORchJbE
         pIMiHiVn1u/efmtbm3giZmXIA3aGIt6BTicfoBETHnLVtX7kUXZrPUcX76llvZFhKJnx
         EvYzMrUwkeVexaISvDXk7FFwFuNEjgbNkUA+Iy6vyLnSMmL3i8IQbY/72TkLelhqVezl
         nz7OWw2F+3mKCHTTdkhF6Y/DCjSvKcWHGkRIZRxlXLJracDffmCzm0+ydzxkETkleMFv
         ZDrj7pObDVKJ57914qH8cDN9y+dtExO3xZVS2sgXiBBLMbxydjCPdx3Q55v6PK/3bLqg
         xjMQ==
X-Gm-Message-State: AO0yUKUYGwYCkXBHQhtopn5eo/a3Jr38i+SLuDo2MKJ4UmKCAmFI1U1Y
        a7ICte7Dp/gMbi42G2BAxYvQaFVIc44=
X-Google-Smtp-Source: AK7set8CTKtO8nszGkxqDdca/+76IH9WrUXt/+umVOrDyibD/nEBdQJ/Oi04TI4ZvCTIwescBrel1Q==
X-Received: by 2002:a05:6871:806:b0:176:1fd8:d144 with SMTP id q6-20020a056871080600b001761fd8d144mr15629605oap.26.1678378400901;
        Thu, 09 Mar 2023 08:13:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u27-20020a4a6c5b000000b00524f381f681sm7406546oof.27.2023.03.09.08.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 08:13:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 9 Mar 2023 08:13:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: constify struct hwmon_chip_info info member harder
Message-ID: <2f0a6217-3747-4493-90e6-8fb129cb6a34@roeck-us.net>
References: <20230309082841.400118-1-jani.nikula@intel.com>
 <e0579cbe-cbd6-46cf-b425-234cfed4ff00@roeck-us.net>
 <87h6uu9nxn.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6uu9nxn.fsf@intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:14:28PM +0200, Jani Nikula wrote:
> On Thu, 09 Mar 2023, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Thu, Mar 09, 2023 at 10:28:41AM +0200, Jani Nikula wrote:
> >> Let the struct hwmon_chip_info info member be a pointer to a const array
> >> of const pointers, rather than mutable array of const pointers.
> >> 
> >> Cc: Jean Delvare <jdelvare@suse.com>
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> >> Cc: linux-hwmon@vger.kernel.org
> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >> ---
> >>  include/linux/hwmon.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> >> index c1b62384b6ee..492dd27a5dd8 100644
> >> --- a/include/linux/hwmon.h
> >> +++ b/include/linux/hwmon.h
> >> @@ -430,7 +430,7 @@ struct hwmon_channel_info {
> >>   */
> >>  struct hwmon_chip_info {
> >>  	const struct hwmon_ops *ops;
> >> -	const struct hwmon_channel_info **info;
> >> +	const struct hwmon_channel_info * const *info;
> >
> > As pointed out by 0-day, you's also have to change each
> > instance where this is is assigned to another variable.
> 
> Ah, sorry, I had THERMAL_OF=n.
> 

You also didn't test compile drivers/hwmon/hwmon.c.
I had wondered about that, and 0-day now confirmed it.

Guenter

> BR,
> Jani.
> 
> 
> >
> > Guenter
> >
> >>  };
> >>  
> >>  /* hwmon_device_register() is deprecated */
> >> -- 
> >> 2.39.1
> >> 
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
