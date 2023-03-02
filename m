Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39666A8617
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCBQSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCBQSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:18:20 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F17DA2;
        Thu,  2 Mar 2023 08:18:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f13so69736269edz.6;
        Thu, 02 Mar 2023 08:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hp1ldzecMJSj8pyzkXvIFccXdSO3caSaRZEFVbzbQpM=;
        b=ZIgL0StcY4gLMqogOHQ5KLRojn5BEKsBvtP1BEHXFLHChlWxRSnX05K+gptU/hIwlA
         ykEwO0x3jX/7seiw3M2WBNf7868m7JzF+XaArapkLZTAj33XPe3kX4SoKiEXDEruTZ/d
         s6FtC+OQBvU9u68cu+FmlDwsamUnOEWmZE3wIvwHMNf4bryITHwfPpaI31rG6wvi3+Ut
         20cf3D9NWzVrMiOMXnUmlF6iFUMP7kiMDUqQJnErltrifLYdD89fCgbe7/yGBxC8u+Tr
         ZSxaX9FQJCgSYSIqWA+Sjl3Al+HJ6fWhpS39AHAi89Y7cvH5Z16/FicXCAirc+ks56vv
         Xa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp1ldzecMJSj8pyzkXvIFccXdSO3caSaRZEFVbzbQpM=;
        b=UK5ijT9u1XnqnsyVJYeCynV4hEOhSdtqkod7r6bg8O7lmMKxX+9gRKqxZacwAIn8l2
         MoMUt88253FF3kCGd8G6VyGJ2q2wnT91FIW+aY8Xsc3bUGLl6Qatt95uE+FpYsWW/fpi
         C4THt3Ki4A8Kbg5YhkK6J9LowR9/eeov1vcmyL6XYbZDW5tPcUzVQCr8jlpRe+CUqwIw
         pL1bKOSS+iQTLoRZ/QMXFF4STSFvuHf4BZ6hn+PmdF2iepfQAdqTW9Yx6Rk4bs161JWe
         +WIJZUikksISkfbLdxBVLGC/VoV2cT6fFmrxIaD+Z+gGswZonyOU/j81Jqx7Ca4vF9+I
         IytQ==
X-Gm-Message-State: AO0yUKU8jRI1N94vLiVKHprnKzUD1WlIi1OBsbHMYK/Nbs1qEyfJK6ut
        QXqG0EOgrWzRIVayp4GHv0c=
X-Google-Smtp-Source: AK7set9hyd9h3fY6YyOtsU8yF2plr93raSsI7lGVrnNDp47AXDgEgDL/FpE9ZfvkvUPpTf1OAGVZbw==
X-Received: by 2002:a17:907:a44:b0:8f4:6efd:833f with SMTP id be4-20020a1709070a4400b008f46efd833fmr14059066ejc.3.1677773897949;
        Thu, 02 Mar 2023 08:18:17 -0800 (PST)
Received: from carbian ([2a02:8109:aa3f:ead8::dc02])
        by smtp.gmail.com with ESMTPSA id kg28-20020a17090776fc00b008c607dd7cefsm7253523ejc.79.2023.03.02.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:18:16 -0800 (PST)
Date:   Thu, 2 Mar 2023 17:18:14 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Message-ID: <ZADMRsDgxKZ/UfJj@carbian>
References: <cover.1677761379.git.mehdi.djait.k@gmail.com>
 <bd84fc17e9d22eab998bf48720297f9a77689f45.1677761379.git.mehdi.djait.k@gmail.com>
 <ZADGnRILByq1/1ch@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZADGnRILByq1/1ch@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Thu, Mar 02, 2023 at 05:54:05PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 02, 2023 at 02:04:35PM +0100, Mehdi Djait wrote:
> > Move the kernel-doc of the function to industrialio-trigger.c
> > Add a note on the context where the function is expected to be called.
> 
> ...
> 
> > v2:
> > - Changed the expected context of from interrupt to hard IRQ context
> 
> Thank you for an update.
> 
> But it seems I messed up with this and my previous remark shouldn't be
> taken into consideration.
> 
> The "relevant hardware interrupt handler" may be hard and threaded IRQ context,
> which looks like your first version was correct.
> 
> Let's wait for Jonathan opinion on this as he is a native speaker.

If I understood the function correctly I think you were right. It should
be hard IRQ context

The relevant functions calls:
iio_trigger_poll --> generic_handle_irq --> handle_irq_desc

handle_irq_desc: returns Operation not permitted if !in_hardirq() && handle_enforce_irqctx 
and it is the reason why the sysfs trigger uses the irq_framework to call iio_trigger_poll 
from hard IRQ context [1][2]

[1] https://lwn.net/Articles/411605/ 
[2] https://lore.kernel.org/all/1346922337-17088-1-git-send-email-lars@metafoo.de/

--
Kind Regards
Mehdi Djait


