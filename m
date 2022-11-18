Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD462ECD4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 05:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbiKREXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 23:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiKREXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 23:23:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C95487A66
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:23:08 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b185so3773329pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGvu/t6VQHvFZoFQJP8begGit+q5T35vmLy7YY+7LqI=;
        b=QqJ6uhZH0VMF13hXEnQkDFf+EfQH2axSc37xch8zbO2zI9cKfuGKl3Ob2gBsFaiOem
         2gHR2oUlTXKFG3fxjaDUaoqy1/q77lzJBANBisXqov1dM/mVmsr4aPTRlVXp3LR8Ktxj
         FyLnXitq1z8TGzcm/qUOOzXDiwl08t1TZfWc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGvu/t6VQHvFZoFQJP8begGit+q5T35vmLy7YY+7LqI=;
        b=wR3bTLhLoU/lQbIdUtWa/6WO3wg/0nLM22nVoQfo44sAGkdm10wQ+1XDZLtpslW44Z
         S5FM90DcYe9W0HS7BedWUJvbY91PYN/k/FT8v8ek03YQmcUAVJ9YH5U+yALlcrZJqozV
         fUtnfj18L6bqC6T/WvJtVx2x/XFWYEy+wWSoVeHjWUnpH4ckHXmcW7I1tAFEovFKT24X
         5fKLNDe96nUGanSNj8KOBzJ+Em3DXNQjnK+cC78B4vzYIaBvSsylHdZ9oq1UCAhjmNz7
         F6UH5AdZ1UVMB/4BuqIv/7s338CZe3m9KZWPYwLyiTDccdopceeadkRhqMX3H75edvFJ
         wioQ==
X-Gm-Message-State: ANoB5pl5xMy1sxrXKzhZIPBi9T9MwW+BI2FdDg3N6EAdRHPwKkcn1ccx
        djfBRDu9ORdGADkBueduRq2efw==
X-Google-Smtp-Source: AA0mqf6aUof28Q+DQar0DVId1qX2RKIiKVV8Hi3uE/487MrpnBdcIuRllUGrx2Dri7iiaOPuKZAJsg==
X-Received: by 2002:a05:6a00:21c8:b0:560:e4d1:8df5 with SMTP id t8-20020a056a0021c800b00560e4d18df5mr6173779pfj.39.1668745387902;
        Thu, 17 Nov 2022 20:23:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g197-20020a6252ce000000b0056e0ff577edsm2015438pfb.43.2022.11.17.20.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:23:07 -0800 (PST)
Date:   Thu, 17 Nov 2022 20:23:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hpet: Replace one-element array with flexible-array
 member
Message-ID: <202211172022.43C0478D6@keescook>
References: <20221118034250.never.999-kees@kernel.org>
 <Y3cB3MqiM+KFJHNm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3cB3MqiM+KFJHNm@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:54:04PM -0600, Gustavo A. R. Silva wrote:
> On Thu, Nov 17, 2022 at 07:42:55PM -0800, Kees Cook wrote:
> > One-element arrays are deprecated[1] and are being replaced with
> > flexible array members in support of the ongoing efforts to tighten the
> > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> > 
> > Replace one-element array with flexible-array member in struct hpet.
> > 
> > This results in no differences in binary output. The use of struct hpet
> > is never used with sizeof() and accesses via hpet_timers array are
> > already done after explicit bounds checking.
> > 
> > [1] https://github.com/KSPP/linux/issues/79
> > 
> > Cc: Clemens Ladisch <clemens@ladisch.de>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Such a sneaky 1-element... ~.~

Yes! This one made my system unbootable after adding
-fstrict-flex-arrays=3. :) All better now.

> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

-- 
Kees Cook
