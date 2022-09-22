Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD05E65EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiIVOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiIVOhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:37:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E3F85A4;
        Thu, 22 Sep 2022 07:37:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 3so9329119pga.1;
        Thu, 22 Sep 2022 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=uhHJO/Q7MKuqbAWsd+TDN9NUVDqnM2of5dIeopNe4UE=;
        b=D5tld7lTKIhAQBke03/geeqtfqWYB2aVt2EFWB3737gpUeNRVYTWveZmrAhMK5jLJ/
         E2mMuaivMTYnfPvm75u5AmJU7OjhVW2Oc+SdHhXRsRa0LyfxWjwjnGpkgNfsNsn1QXZV
         RPw5EdoFbJNC4L35/UW/QitVUO0XsAt06itsKLqzT3NZq2uFp7LbEVHazeQTRn4LsrNs
         EsdAskhzJRlLQuCvvcI7iVS9qRr3X+WlEtuN9ieu/fX/PZJoV5JMsoDMtsEJJKBtGLQ0
         8nzDU0YBhqEqcsOdgVKVDg+q+I1ZhkfP6PgA0pH5QaS+aRhDqvDcWTS+KF+mrcqsMrhp
         kapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=uhHJO/Q7MKuqbAWsd+TDN9NUVDqnM2of5dIeopNe4UE=;
        b=mJj1b2HEtINkwYK9zfZN0a3hJ8T8bJok4FJxWos7IaWmfSHeH0c07u8i7mbOqEbtan
         0l8t85jkKc0C65izZC3Hsz3ihU9C5PoWCZuz29ndRLQ+BkoPT+/lt5Lt0dY6RBDdE0jJ
         MO1GwabYWFCpx9s2I8Gx6aFtC+wsuekVRZHAUPnttM2KdFrGTvJrVu0Lr5G6Mnu/GdmF
         k7gagASkrYrwBlBTcjVMZNP78dAEwU9ubwLnvQepFyywv8I2ddPIe/+ArDMaqDjWvDMp
         eXBVAwt4XefnmQI08fib+vTisgq9rWPNq+hqkfHgM2WJmD8sr+v+whLPAvMQbB2MlkBL
         EdXQ==
X-Gm-Message-State: ACrzQf2NM1OlFjfrnmvO+k9r574vxB3W4UEcRccSN7mlfVVJq7QNUXTT
        +hysB7E78eXvK7h70Qa29k0=
X-Google-Smtp-Source: AMsMyM4C21WgzIRahWmNt/PuVBN9kqw+VqKK86oixqjJAbJhyN7wprwnxB0zMaA/wgcMvg40QjVIPw==
X-Received: by 2002:a05:6a00:14ce:b0:544:1ec7:2567 with SMTP id w14-20020a056a0014ce00b005441ec72567mr3846781pfu.24.1663857440057;
        Thu, 22 Sep 2022 07:37:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902bd0400b0016f057b88c9sm4187564pls.26.2022.09.22.07.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:37:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <052ab7b7-ef09-a751-bb03-2cd5742083af@roeck-us.net>
Date:   Thu, 22 Sep 2022 07:37:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6] watchdog: add driver for StreamLabs USB watchdog
 device
Content-Language: en-US
To:     Alexey Klimov <klimov.linux@gmail.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, gregkh@linuxfoundation.org,
        oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, atishp@rivosinc.com,
        atishp@atishpatra.org, yury.norov@gmail.com, aklimov@redhat.com,
        atomlin@redhat.com, stern@rowland.harvard.edu
References: <20220917030534.363192-1-klimov.linux@gmail.com>
 <20220917031502.372319-1-klimov.linux@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220917031502.372319-1-klimov.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 20:15, Alexey Klimov wrote:
> Hi Wim/Guenter,
> 
> For me it seems that there could be a potential race condition. I have to rely
> on watchdog_active(&streamlabs_wdt->wdt_dev) function which tests the WDOG_ACTIVE
> bit in struct watchdog_device->status member.
> The watchdog_dev changes the state of the device with ->start() or ->ping() and
> ->stop() methods and updates the WDOG_ACTIVE accordingly.
> In {pre,post}_reset methods here I have to change the state of the device from
> running to stopped and back to running conditionally, however WDOG_ACTIVE bit
> could be updated in between these callbacks execution or starting/stopping
> the device can race.
> For instance, I see the potential dangerous race like this:
> 
> 	CPUX					CPUY
> 
> 	..				watchdog_stop() {
> 	..					if (wdd->ops->stop) {
> 							...
> 							err = wdd->ops->stop(wdd)
> 						}
> usb_streamlabs_wdt_pre_reset() {
> 	if (watchdog_active())
> 		stop_command();			/* WDOG_ACTIVE bit is still set
> 	...					 here indicating that watchdog is
> }						 started, but ->stop() has already
> 						 finished */
> 	...
> usb_streamlabs_wdt_post_reset() {
> 	if (watchdog_active())
> 		start_command();
> }
> 	...					/* WDOG_ACTIVE is updated here */
> 						clear_bit(WDOG_ACTIVE, &wdd->status);
> 					}
> 
> As a result, the watchdog subsystem "thinks" that watchdog is not active and should
> not be pinged. However, the driver observed using watchdog_active() that watchdog
> was active during {pre,post}_reset and restarted the device which will lead to
> unexpected reset. It is very unlikely race to happen but consequence is fatal.
> In other words, there are two independent paths leading to driver changing
> the state of the watchdog device and one path relies on status that can be changed
> by another path.
> 
> Thinking about that I see the following approaches:
> 
> 1. Introduce a variable in struct streamlabs_wdt that tracks the state of the
> watchdog device itself and checking/updating the state of a device happens under
> semaphore lock.
> Obviously, this "internal" to the driver state variable should be used in
> {pre,post}_reset. In case there will be other drivers (say, USB ones) they also
> need to implement this.
> 
> or
> 
> 2. The updates to wdd->status should happen under wd_data->lock.
> Currently, it is mutex-based. The acquiring and releasing the lock could be
> exported for the drivers to use. The mutex lock probably should be switched
> to a binary semaphore for that.
> 
> In such case, in pre_reset() for example, I would need to do:
> static int pre_reset()
> {
> 	lock_wdd();
> 	acquire_internal_driver_lock();
> 	
> 	if (watchdog_active())
> 		stop_command();
> }
> 
> static int post_reset()
> {
> 
> 	if (watchdog_active())
> 		start_command();
> 
> 	release_internal_driver_lock();
> 	unlock_wdd();
> }
> 
> There should be an order that we have to acquire subsystem wdd lock first, then
> internal driver lock. Otherwise there could be deadlocks.
> 
> This could be done if you think it's more wiser move.
> 
> or
> 
> 3. The {pre,post}_reset callbacks should execute watchdog_dev.c subsystem functions
> (not sure which functions exactly). Eventually, it will look similar to what is
> described in the previous point with respect to locks order.
> I meant something like this:
> 
> static int pre_reset()
> {
> 	watchdog_dev_pre_reset_prepare();
> }
> 
> static int post_reset()
> {
> 	watchdog_dev_post_reset_done();
> }
> 
> In watchdog_dev.c:
> void watchdog_dev_pre_reset_prepare()
> {
> 	mutex_lock(&wd_data->lock);	<-- should be changed to semaphore too?
> 
> 	watchdog_stop(wdd);		<-- without updating WDOG_ACTIVE bit?
> 					 or there should be a way to indicate
> 					 to watchdog_dev_post_reset_done() if
> 					 watchdog should be started or not
> }
> 
> void watchdog_dev_post_reset_done()
> {
> 	if (watchdog_active())
> 		watchdog_start(wdd);
> 
>          mutex_unlock(&wd_data->lock);
> }
> 
> I didn't really thought about point 3 yet. For me personally the point 2 seems
> the like right way to go but you have more experience with that. The exported
> locks could be re-used by other drivers if needed in future.
> In case of point 1 each USB driver should deal with {pre,post}_reset by themselves.
> 
> Any thoughts?
> 

Please go with 1). pre_reset/post_reset functionality is a first in the watchdog
subsystem and the first to require locking outside the scope of a function or set
of functions. I'd rather avoid having to deal with the potential consequences
in the watchdog core. We can do that if/when it becomes more common and after
we have a good understanding of the potential consequences.

Thanks,
Guenter

> Thanks,
> Alexey

