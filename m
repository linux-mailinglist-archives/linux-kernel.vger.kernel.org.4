Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0D692C56
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjBKA5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBKA5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:57:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3011F4A8;
        Fri, 10 Feb 2023 16:57:47 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r18so5089932wmq.5;
        Fri, 10 Feb 2023 16:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2q5DWKlcgUdWbAA6iWY58XbP4RfZVp9PEgf0M06khas=;
        b=YsqtaeSw8aaNfml9ZalA2klYfDdZc0LUAA5w3oa7nV06fzQvoWeliZLQf9FXVEuQui
         ykReQTxFq0k8X0eOpvlXGo7WGXax+KSc/dAWux/Gc7dfLogsutjZBb8L82Txtjlh/KiN
         Fqx84HjGdu+Et8MdJeTbwmotQCTeAZY8B3j8PY3pzhe57CIFVjZnMgfFpsXUgVQ+q5Ul
         q/2O3mqX0UgpcYUv0C5sBwYCAM3SlwkpF869VrZRg04X/rQkM+wO9626g0HWsusUguev
         zAD5KV+68G4pQwxsvWwwXIZg2qe0es5xwvtWb7OiRR/IjoF++ejrLvnpmcgxDhgGQbl4
         XHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q5DWKlcgUdWbAA6iWY58XbP4RfZVp9PEgf0M06khas=;
        b=ukpzOCDbrtZHgX7btwjpNlX913mNG0Q8Mg193ielLpZxMnUwGSV24djixUvwW/D/Bq
         Ozkhcut1Hy+lUBxlgN6E0C0dOjjEf2ee6HhmdAOLhWnQow3LjLZ8qvjFc7dMPiR4bIf/
         SLcnufcPsYATr6M+WogFylP+G7vxsNToTfSMzGu5sNzXkCwD4elQsMZPW/SCK8lPEcFH
         /K7yrHojxEz0GGxlIoVWO2VtXs3u4jfwdXlwChOi7SOGYyZQYG2oQT3Y3e9t4IEAJzoP
         3RXbGOdzM3u6aL5DSF93uCkRgjg8WDNhrykFwL5cvqFVm4wFhFM6r752uVG8bSItU5gk
         bUvA==
X-Gm-Message-State: AO0yUKWBvEMF7Er2nxNdq3ehTxY/+WbAMAjFprCdQ4J9pSX/viWbOUD0
        J/XeoOWkRD2zU4P4lc6p81hIeZrLBT4=
X-Google-Smtp-Source: AK7set/petyGDc3jo4YIwhH9rki3o9kIEKdEIpx72v2P0TqU2El+2SGIAxlJ9qKmKvJOCllwqCyrDQ==
X-Received: by 2002:a05:600c:1685:b0:3db:2e06:4091 with SMTP id k5-20020a05600c168500b003db2e064091mr15932236wmn.37.1676077065730;
        Fri, 10 Feb 2023 16:57:45 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b003dff2b493c8sm10773493wmb.36.2023.02.10.16.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 16:57:45 -0800 (PST)
Message-ID: <63e6e809.050a0220.af3df.d908@mx.google.com>
X-Google-Original-Message-ID: <Y+aOI5t93VAIlcz2@Ansuel-xps.>
Date:   Fri, 10 Feb 2023 19:34:11 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: Warn and add workaround on misuse of
 .parent_data with .name only
References: <20230131160829.23369-1-ansuelsmth@gmail.com>
 <e5b71c243022d341022b4f172060268b.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b71c243022d341022b4f172060268b.sboyd@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 04:40:29PM -0800, Stephen Boyd wrote:
> Quoting Christian Marangi (2023-01-31 08:08:28)
> > By a simple mistake in a .parent_names to .parent_data conversion it was
> > found that clk core assume fw_name is always provided with a parent_data
> > struct for each parent and never fallback to .name to get parent name even
> > if declared.
> 
> It sounds like you have clk_parent_data and the .index member is 0? Can
> you show an example structure? I'm guessing it is like this:
> 
> 	struct clk_parent_data pdata = { .name = "global_name" };
>

An example of this problem and the relative fix is here
35dc8e101a8e08f69f4725839b98ec0f11a8e2d3

You example is also ok and this patch wants to handle just a case like
that.

> > 
> > This is caused by clk_core_get that only checks for parent .fw_name and
> > doesn't handle .name.
> 
> clk_core_get() is not supposed to operate on the .name member. It is a
> firmware based lookup with clkdev as a fallback because clkdev is a
> psudeo-firmware interface to assign a name to a clk when some device
> pointer is used in conjunction with it.
> 

And the problem is just that. We currently permit to have a
configuration with .name but no .fw_name. In a case like that a dev may
think that this configuration is valid but in reality the clk is
silently ignored/not found and cause clk problem with selecting a
parent.

Took some good hours to discover this and to me it seems an error that
everybody can do since nowhere is specificed that the following
parent_data configuration is illegal. 

> > 
> > While it's sane to request the dev to correctly do the conversion and
> > add both .fw_name and .name in a parent_data struct, it's not sane to
> > silently drop parents without a warning.
> 
> I suppose we can do
> 
> 	WARN(parent->index >= 0 && !parent_data[i].fw_name && parent_data[i].name, ...);
> 
> or maybe better would be to make the clk registration fail if there's a
> .name field and the index is non-negative and the fw_name is NULL.
> 
> Can you grep the code and see if anyone is assigning a .name without a
> .fw_name or .index?
> 

I can check and have some fun with a good regex.

Reject registration may be an option but consider that this may cause
some device to not boot at all if the error is done on a core clock
driver like a gcc driver.

What I would love is if there is a way to cause a compilation error but
I don't think that is doable with a C macro?

> > 
> > Fix this in 2 ways. Add a kernel warning when a wrong implementation is
> > used and copy .name in .fw_name in parent map populate function to
> > handle clk problems and malfunctions.
> 
> We shouldn't be copying .name to .fw_name. They're different things.

The idea here was that in theory the global name should not be that
different than fw_name. But I understand this can have drammatic side
effect so I agree that we should only WARN that there is something
wrong.

Hope with these expleination it's more clear what this patch is trying
to achieve. The referenced commit should make the problem clear.

-- 
	Ansuel
