Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890CB6A5F78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjB1TRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjB1TRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:17:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840E732CE5;
        Tue, 28 Feb 2023 11:17:01 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ec43so44389386edb.8;
        Tue, 28 Feb 2023 11:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqQ/ShIAOZwCImjbSCQBE8GsaSJPKXSxwvHlxK05UmY=;
        b=jJ8qnkfGfYeA95NGuJ93TBJeOQ9Aa7whuWUGRqCNILxZ3IsiqVkCascOvIzqgbxvlJ
         PpBzTLQ3khPCzBaLj0s8AKeyFJqKxHLGpKl18ZzJApN8Sb42nyIckqhmtkLdtkeTZ6SU
         ur0ZQC53mUXmunKCiUoJx4zunJuqqjrWbpM35A4cGAmFZPJTVqdKuSllTwFvjg3hy9jS
         0amAOPjhUWbbmghamU97Jb9q5xDo8EZ5Psg1mIhRvqWMHgnVwU2a9l+s9/sPsTnM6+y7
         Q7Taf+0bByzSCa8FHtqRE6qbeIQRwOVgPTR+Fpwz5rPTZpkO5zxP+cpK8wQtA8Ea0DjQ
         J4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqQ/ShIAOZwCImjbSCQBE8GsaSJPKXSxwvHlxK05UmY=;
        b=dx+yUlGd5A6XEJrcDOHjxZzsfUZOebg01FZwDAioHO6f4VWQSB5TAyPmK4Ucynx4lq
         8Z6MSMxSv9fJv3yC7EOh7RzpLkLZHm3PjflIo5Ro1kpcIGZlit7pnVI4N3qwgfbv0ntD
         wm5PAF3oRUB6dUVX5xI812tE64trEXKsTLam0JE4y1bs5+VuAHUH4R5IhdDtTvEQfh1A
         rfWiNRrYIkD/DasfAQQOP+9p2ey8uuzGfrTIuvkBAYahqCkn6c/cUe4hVge98w5E75el
         YWP10Zah38HZEupAv1NlcFbOHnfSV2XWjM91mh/gCqJX/NnaVufpfFlSba23KRpAMhmR
         D8vQ==
X-Gm-Message-State: AO0yUKXdlyKNlQ5yHqhD+rmbzf5LO+jSjbD+rxxt/cocvVcKcUkDSMuh
        83epSZmUjPEVjgcr17gEUbH/1anQujY=
X-Google-Smtp-Source: AK7set+uFV6wxD/vgDd+fPNl+nF9Chu7bew7c8XGXkaHUXWMFIqXlSn8Z4Cd4caRg0YyD/yiultXuw==
X-Received: by 2002:aa7:c90c:0:b0:4aa:b63f:a0e with SMTP id b12-20020aa7c90c000000b004aab63f0a0emr3994112edt.17.1677611819959;
        Tue, 28 Feb 2023 11:16:59 -0800 (PST)
Received: from carbian ([2a02:8109:aa3f:ead8::dc02])
        by smtp.gmail.com with ESMTPSA id b31-20020a509f22000000b004af596a6bfcsm4680061edf.26.2023.02.28.11.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 11:16:59 -0800 (PST)
Date:   Tue, 28 Feb 2023 20:16:57 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Message-ID: <Y/5TKSylDDT74YBT@carbian>
References: <cover.1677520155.git.mehdi.djait.k@gmail.com>
 <219496d4d21755937a40c2c7dfbeca64660c9258.1677520155.git.mehdi.djait.k@gmail.com>
 <Y/0znth++tPsptKs@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/0znth++tPsptKs@smile.fi.intel.com>
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

On Tue, Feb 28, 2023 at 12:50:06AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 27, 2023 at 07:00:38PM +0100, Mehdi Djait wrote:
> > Move the kernel-doc of the function to industrialio-trigger.c
> > Add a note on the context where the function is expected to be called.
> 
> ...
> 
> > + * This function needs to be called from an interrupt context.
> 
> > - * Typically called in relevant hardware interrupt handler.
> 
> These are not equivalent. Can you explain in the commit message why we move
> from hardware to any interrupt context?

I read the definition of handle_irq_desc more carefully and [1]. I will
change it to hard IRQ context. 

I got confused by the kernel-docs under /kernel/irq/irqdesc.c as it states
that the function must be called from an IRQ context for generic_handle_irq 
but explicitly states hard IRQ context for another funtion. 

[1] https://lore.kernel.org/all/1346922337-17088-1-git-send-email-lars@metafoo.de/

--
Kind Regards
Mehdi Djait
