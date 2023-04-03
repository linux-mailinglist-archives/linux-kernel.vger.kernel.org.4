Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132846D5515
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjDCXEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjDCXEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:04:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D56E67
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:04:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ml21so6750703pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 16:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680563076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwmhPKb9BQJU26rgYsH2u7/1DgHEwu06/TKECDowtiE=;
        b=hou2YZY7OgLNyFAx9q1sbZ87opOlNh/9O/7K+gYsBX5Ahf5gYTuKpYFDVsRb7192tq
         UuTktxgqbHFly8D39nRoZo6SV4awTR0+wgf0Vhe1EaM5zbBvltR2+qv6HTg1TmIhlw/z
         75sy54FiB9SKBAjgemngpDtDO05EiEAHIf3gC1/THD1PP2cgA0v0WP381VWuT/hKAQJD
         Hy3CvAI0vqbGMWLvoMoj0nuywUdkhSunmt3LM9gbfjlFx8zo/y5dn2wrToxX0ZDRmM5H
         KUspmdp6cF1OXkFKOOLwBR+CZK+e4o1uSr8ynRIrP3WYq4y+9Ztyk6jSeqRQE99LIlV5
         Xnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680563076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwmhPKb9BQJU26rgYsH2u7/1DgHEwu06/TKECDowtiE=;
        b=ntIqigjOMYDjMAPJzrl5LtOiJPArqaU5Phpi6ybmuuwOXqwIqWLvNsC+gSM2ujOwHi
         9UQT28T97Sqdn5BiykywPM8Mz4dbKO7pI9vFKXGybh0Vi9/sYcZzuxVld0ir3xhU6aJ5
         HTwFo7MXg/rCZX7vkz3F/dFaASfNBtSQn1Q+NnkBMsljgcld3ie7JhMfVanlWsfXj+H3
         mEPn4AxW4xOr+Z2MmQf2v9AWAqcwbixT1D6jdPcVJ+6LkgZg4S1W2/xkqVd+ecrbEMX6
         BGZeGnJPhge1XQDuWyu9+6xEBTzaFKVEbTH1AFj/KWGB5RsxQ5CouXCT4W9I0WR/+1+C
         CCXQ==
X-Gm-Message-State: AAQBX9ds6jkFHSY+X0uPC+hZCiO/UawfsDIxGpMADEm0d7gdbl1lI9R9
        u3NZP0/wVHRDxVMAQgc+FzsDnA==
X-Google-Smtp-Source: AKy350bNwBJDFOjq8q8OLFBNmlWt2HkF2T/luEQ+bf38xgIQLszAY9m7eLvhuA1UPom4VMVQZBcDuA==
X-Received: by 2002:a05:6a20:1e4d:b0:da:897b:ae40 with SMTP id cy13-20020a056a201e4d00b000da897bae40mr307835pzb.37.1680563075745;
        Mon, 03 Apr 2023 16:04:35 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b00625cfe645d0sm7516700pfb.7.2023.04.03.16.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 16:04:35 -0700 (PDT)
Date:   Tue, 4 Apr 2023 04:34:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: sparc: Fix exception handling in two functions
Message-ID: <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
 <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-04-23, 14:50, Markus Elfring wrote:
> >> +++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
> >> @@ -324,12 +324,12 @@ static int __init us2e_freq_init(void)
> >>  		ret = -ENOMEM;
> >>  		driver = kzalloc(sizeof(*driver), GFP_KERNEL);
> >>  		if (!driver)
> >> -			goto err_out;
> >> +			goto reset_freq_table;
> >
> > I would just return error from here.
> 
> I got the impression from this function implementation that a bit of additional
> resource release would be relevant so far (at the end of a corresponding if branch).

That is exactly what you are looking to fix, so lets fix it once and
for all.

-- 
viresh
