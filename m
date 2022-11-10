Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D062484D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiKJRYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiKJRYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:24:18 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4071658E;
        Thu, 10 Nov 2022 09:24:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gw22so2105719pjb.3;
        Thu, 10 Nov 2022 09:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSAiR/bO+Y1EjQroxRnppaTbWqL0F45BcX1uVs8Ey20=;
        b=qF80tYkxvvbBiBgHqBGqjYUwguG1N7MC/R9v9wgG0y+tOAZ0qh+hDd2IdPfCMWhRyn
         DM9fe+F8stjzOdPRH7UUK6swvxNQkPxfQuegASFJ1ieOD3f8Pj17EcCx7dVdyPtLU1/E
         F/E2A+CpWRqDjfDHpexPCEZJF3Qn9EKnFZdju2yFVmPb40TkE7t6B14II8ZRF5+W9rZZ
         pnxK13D0Qaxax5AgJy1nyAAMp7MZvV2KFuINhby8T96KygkRdqMopMlJBoAKc7YTzJYc
         +6L/prGbiLMIRmPagQs7T3JxGkp1J29mF2ZiTgwt0ehdV/L1nPpWAn572zseGscS/TqE
         WEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSAiR/bO+Y1EjQroxRnppaTbWqL0F45BcX1uVs8Ey20=;
        b=WLkAtzXX/dwNecR9J598z4+6xgmLFtADTcjqRYrzPjBQ2f8WPw0DnypYbSugi3zM58
         3rssrVX2lJ0+OL4B4v5LtQT0aApkRVfxBbBIoMpSn868jGJzEIpZmO4cYFwTEXCu+JKU
         10cBFrlU2AMa6hr9tVqLKG0UtGwCKdhltJ843tCIDrMRAQ9NIkZpjvBrMlbYw4dRAnIb
         HJ86plvoZVJFHvMLQ7PyDTDQwWfI44P+ZP5Qtp4HwDTVI1WRR9h32/JgFM1VcwOYGK1I
         wf+ErQ24ZXCkFVO5Eye7sWaJ+tzgRigm4NcYDJsQt2vPCRMd/bVeQstSSrAaBNxeCVA5
         ZI6g==
X-Gm-Message-State: ACrzQf30cTpppbMmQJuWmSG5hOGFmUcicxgI/ECu6UvroAhFvua8cZE1
        G4as8Tb+LO+yUtPoWWep18M=
X-Google-Smtp-Source: AMsMyM5/m34Zy3nq8DbNJh5jd0Fzqr0znfZBnlhPQtLQN7IYW1N5gZTt21+KgTaRm9kiiVOtuaNvEQ==
X-Received: by 2002:a17:902:eccb:b0:176:cf64:2f39 with SMTP id a11-20020a170902eccb00b00176cf642f39mr1587184plh.93.1668101057191;
        Thu, 10 Nov 2022 09:24:17 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b00186b7443082sm11574145plh.195.2022.11.10.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:24:16 -0800 (PST)
Date:   Thu, 10 Nov 2022 09:24:13 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y20zvUeRvnVPtUs+@google.com>
References: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
 <20221031-gpiolib-swnode-v3-5-0282162b0fa4@gmail.com>
 <Y20HJe/vQPI4dWyW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20HJe/vQPI4dWyW@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:13:57PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 09, 2022 at 11:30:43AM -0800, Dmitry Torokhov wrote:
> > Ensure that all paths to obtain/look up GPIOD from generic
> > consumer-visible APIs go through the new gpiod_find_and_request()
> > helper, so that we can easily extend it with support for new firmware
> > mechanisms.
> > 
> > The only exception is OF-specific [devm_]gpiod_get_from_of_node() API
> > that is still being used by a couple of drivers and will be removed as
> > soon as patches converting them to use generic fwnode/device APIs are
> > accepted.
> 
> ...
> 
> > +	if (!IS_ERR_OR_NULL(fwnode))
> 
> As pointed earlier I still think this is not needed. Even for the sake of
> showing an intent, the not-found fwnode(i.e. GPIO), will be handled anyway...
> 
> > +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> > +					    &flags, &lookupflags);
> > +
> > +	if (gpiod_not_found(desc) && platform_lookup_allowed) {
> 
> ...here by gpiod_not_found() which is an exact intention in both cases above
> (fwnode is not provided / invalid or GPIO wasn't found).

Thank you for the thorough reviews.

I think at this point I will leave to to Bart and Linus to decide what
form they prefer here. From the execution point there is no practical
difference, it is all syntactic sugar.

Thanks.

-- 
Dmitry
