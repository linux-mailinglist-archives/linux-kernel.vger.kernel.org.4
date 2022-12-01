Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2263F54E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiLAQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiLAQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:31:48 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC7A47F8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:31:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s7so2135962plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PHWh3vTnQwPH5AUGwQVpkqxlXcg99T9mbDTP/oWxx7Y=;
        b=h+9nc/dRebqaoBZVovK4NZQXb2wOYqV6JvEnOP6OABdOlyOlEnZRd9L0QxjUHnNTT8
         FfLqFfYxnEe22nj8uBRG/r9A5rPjJXlqW3rm9sFQfyDzXp1AQwRrDStn+DJhPG7SZL2/
         Ub/wMq+MPkAaaB75Yshu0nVRLyrhxcEY8NWpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHWh3vTnQwPH5AUGwQVpkqxlXcg99T9mbDTP/oWxx7Y=;
        b=QKOJaIK3QLraTRP+1eslZQGdOI/1MqJ8AJNJav7RcI1xg7ieygJcofXRYM6ArJEEan
         gubm3gPo6j2JAqq2HrlA9bYr0mCzu+RD3mGFaHQxpA3mcxYO77Lbk8rmyLluftMAosjR
         uVl1EjwWOL+u2E7YyzuA1pRZH1ok07GXnqbRtN+dKqNkXoBwbaPX4wqOwLHuKhKNpdXt
         XiFIVj75BzPkvAuHeWAGUW5clWkQfqItPXnaoC4V15WBn9pWuP6rgfPG1dmWvMr/aT5/
         nKeW/BPK83nJNC74KkVGtNwD1HWAMDCZ8JMgKm9c7py6FawtCUmSnkB3OEdEifCqN0yZ
         Qn4Q==
X-Gm-Message-State: ANoB5pn6nLMfygWSM3lnDbOqOUDlLQYp1MVhx9lFPCoNwGDIt0w/xQ5M
        1Ghe3iB/bmyWsKeAGoxoXdxfww==
X-Google-Smtp-Source: AA0mqf6FszPtGUfRpDjcaDhJeVqK/3senmrm1PkSzuCElFNsb+h74kJ/At19we0BmOE4DMYSKSr2hQ==
X-Received: by 2002:a17:90a:5b09:b0:218:a0cd:5a99 with SMTP id o9-20020a17090a5b0900b00218a0cd5a99mr60448737pji.76.1669912306949;
        Thu, 01 Dec 2022 08:31:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090322c500b001896ba683b9sm3882330plg.131.2022.12.01.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:31:46 -0800 (PST)
Date:   Thu, 1 Dec 2022 08:31:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202212010831.75F705C51@keescook>
References: <20221201140758.1d3e9aec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201140758.1d3e9aec@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 02:07:58PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> kernel/panic.c: In function 'check_panic_on_warn':
> kernel/panic.c:238:25: error: format '%s' expects argument of type 'char *', but argument 2 has type 'unsigned int' [-Werror=format=]
>   238 |                 panic("%s: system warned too often (kernel.warn_limit is %d)",
>       |                        ~^

Ugh. Thank you. It looks like my unfixed tree got pushed; apologies.
This has been corrected now.

-- 
Kees Cook
