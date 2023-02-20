Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A64669D1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjBTRMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjBTRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:12:14 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7D01CAD6;
        Mon, 20 Feb 2023 09:12:13 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e10so483556ilu.4;
        Mon, 20 Feb 2023 09:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAe9wSQVfwtoS5sktomFbF8JMWQ08miV6h3pIefRQgE=;
        b=jngzEqYg6r0q9FKVPLVD5xheVozhHlSp9/1EzV7236EOBnXHNRU1aBXi4FDSiEUaol
         eKszHKIxqAeKgvHRY22JPpPVxvxquUr2NLiAKFUl7K7GRuWf4jl4vgjzbm4mZd/z49uq
         HslZHkt2pJzuht4WXnYWhGnW2PHi9X5zWjZLyXHwLJ5RMqf5GpcBNudKC+642pG7iVwV
         4wAvpI2Q3eppli4cTx0VsJNQbryXpcu148rniBcCNt6PLr0E39A50XDLYeJegHkzU/V8
         zWx929W+X5wQDv7Mj0D2EEJVq4zXusr6N8kZ4sOMTRwbSRAyo+LN8I3o24uaGBaKkOtU
         hUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAe9wSQVfwtoS5sktomFbF8JMWQ08miV6h3pIefRQgE=;
        b=Bf4OeVUI5ukglA7G2Xe8cE8Bgw4CFzyKf9Zgm8m8EFS46lJ9XQQO2H64UYy7tZFFZB
         WDuynJvIe6qtwJ8h+BolJZQYXV496q624Q2Y8xu4k7nUajZyzK6X9iyRFJ/nRTl1eQ1M
         eLS4vXN/sE0gpyHi0iab4n+ffvolLQ2AojXMn8rQb5+D5IuPxT4CILTlyTVsP0oUhXD6
         3hERjjopeCzo9TJQUuc7w+h7HrZWPaHwC2FQw5cRfdmiWQYGgryenFS6i1uJUOhEuhYd
         bgK9o07I8BydRH8tU67Qw9do+Z3ESPUT+jHhEBpKZI7wI0koMjK0s2ILfTcRNa8IR9Ei
         fY0g==
X-Gm-Message-State: AO0yUKUge6l4ZkCX0S9zy/qFD1drDcLoZcczqB92aiETB/azQSQHQGrN
        nkiLCTci5FvJNrlndDSZc8Y=
X-Google-Smtp-Source: AK7set/2KSJeo4jHY5Z8FNmEovOTMJUbSC6a0m4xej+SmB6Q0x2PmlCrQP7qWdaEJ8ugIhV+8vrKwg==
X-Received: by 2002:a05:6e02:be3:b0:315:9a9b:9b54 with SMTP id d3-20020a056e020be300b003159a9b9b54mr1963117ilu.12.1676913133021;
        Mon, 20 Feb 2023 09:12:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2-20020a02cf22000000b003c4fab138b6sm214967jar.104.2023.02.20.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:12:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Feb 2023 09:12:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Subject: Re: [PATCH v1 07/17] thermal/hwmon: Use the thermal API instead
 tampering the internals
Message-ID: <20230220171210.GA1606748@roeck-us.net>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
 <20230219143657.241542-8-daniel.lezcano@linaro.org>
 <9ac3a59f-a3b7-4128-87d0-7b3310ce7828@linaro.org>
 <20230220141154.GB4009286@roeck-us.net>
 <1c8efdae-1ef4-ab45-d891-72010d8a4343@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c8efdae-1ef4-ab45-d891-72010d8a4343@linaro.org>
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

On Mon, Feb 20, 2023 at 04:39:48PM +0100, Daniel Lezcano wrote:
> On 20/02/2023 15:11, Guenter Roeck wrote:
> > On Mon, Feb 20, 2023 at 02:34:08PM +0100, Daniel Lezcano wrote:
> > > Hi Guenter,
> > > 
> > > my script should have Cc'ed you but it didn't, so just a heads up this patch
> > > ;)
> > > 
> > > On 19/02/2023 15:36, Daniel Lezcano wrote:
> > > > In this function, there is a guarantee the thermal zone is registered.
> > > > 
> > > > The sysfs hwmon unregistering will be blocked until we exit the
> > > > function. The thermal zone is unregistered after the sysfs hwmon is
> > > > unregistered.
> > > > 
> > > > When we are in this function, the thermal zone is registered.
> > > > 
> > > > We can call the thermal_zone_get_crit_temp() function safely and let
> > > > the function use the lock which is private the thermal core code.
> > > > 
> > 
> > Hmm, if you say so. That very same call used to cause a crash in
> > Chromebooks, which is why I had added the locking.
> 
> Mmh, I see. I guess we can assume thermal_hwmon is part of the core code and
> remove this change.
> 

Yes. Anyway, the sequence of events was roughly as follows.

- thermal zone is device is registered
- hwmon device is registered
  - userspace is triggered and starts reading device attributes
- while userspace has a hwmon attribute open, thermal device is unregistered
- hwmon device is unregistered (sysfs attribute is still open)
- hwmon device attribute function is called
- Since thermal device ops have been released after the thermal device
  was unregistered, trying to call an ops callback fails.

That doesn't normally happen, but the Intel wireless driver has the habit
of registering a thermal zone early in its probe function, only to unregister
it immediately afterwards if the probe function fails. If some userspace
activity is triggered by the hwmon device registration, the thermal and
hwmon device removal may be timed such that the hwmon devive is removed
while one (or more) of its attribute files are still open. Normally that
doesn't matter, but it is fatal here since the ops callbacks are not owned
by the hwmon device but by the thermal device.

Essentially every ops callback has this problem.
thermal_zone_get_temp() had it as well, also associated with
a hwmon sysfs attribute read operation. See commit 1c6b30060777
("thermal/core: Ensure that thermal device is registered in
thermal_zone_get_temp").

If you don't want non-thermal code to access ->ops directly, the thermal
code would have to provide protected accessor functions, similar to
thermal_zone_get_temp().

Thanks,
Guenter

> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
