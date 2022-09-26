Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A15E9901
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiIZFvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiIZFvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:51:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3481220E3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 22:51:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e68so5641779pfe.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JuhOks1hQfFo95ag4lKfeQ7gstLas2WjFXJVZ4xzLZI=;
        b=R0BqlZxMW7iRaSdnB9Nub7ZXZ8vjjcREkB7ZSCZl6WoRHdygEqJ3PVhGo0HcDhM+VB
         JBqf9BgM86J2nku8ZO9no1RIPMth1JhaoFQD3uz8x9wGvrte3dFK6l9he4mA+7hBMR4x
         M8URu3CKkCm+yPJSF4/IQHBrP8baTw8tc9RAM0aa1U3Q3XYg0cA2GjLFxzOGW01n89lM
         2nSrSIJ67eXNwBwt3ohM05Skwe5X+KatXZqcFv4NanNKu07gYnIytzyQWdkokSFMh7Uq
         2NheVLPAO26G3C2m+p8qMWvbgX+oyjKMAH0cGVzBlvBfLtG8AvSdXawnoM/hTlccjOlr
         gbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JuhOks1hQfFo95ag4lKfeQ7gstLas2WjFXJVZ4xzLZI=;
        b=fzc6hdoA6aKrQltOJt2Tx8D6hg3p/0nJJFv6Tiix+DYh3UOq4NnO/dUMNlDoiIpjU4
         h82/DlvgTJ5apfr9LaGOdqZ+l30uKk4+/oq4MSwnFwWuQCjhovy124LoL/Xa6E/lWDP0
         ruPh7DHd66kweAYPYdYYn85QIJJ/XN/SLvovC/HzF/OZoJtBWwwoTXzIF5jqjAT0iJgF
         +9G/WSVTr2XVA+F8hCsXQKcf3/bY4RICg1ojjNzy6KlYYnD6/pFZMLr31GpGrKCw7y90
         3vjALIpU9qYYdky2KiYK/e7vSJRXiA8f3eNKvTnL6uc6MOBBAGYKgGfaK0tTQoCu5RNU
         vuPQ==
X-Gm-Message-State: ACrzQf3y+DGMKbAEjKqSbrgwhO74oVLKxHUDUR4iRbG+DgMpTRzPAnjV
        G9sgmoXXBMvKJoqFJTPF3EW6LRkBjduOjQ==
X-Google-Smtp-Source: AMsMyM40BIaeAR066YrerNnWIYd15Ig6FFvztVRrDOjy/bTtUKL3TKZNhPyD/XV2f7zEXDhr1RLhlg==
X-Received: by 2002:a63:204a:0:b0:439:1802:dd99 with SMTP id r10-20020a63204a000000b004391802dd99mr18619064pgm.153.1664171493445;
        Sun, 25 Sep 2022 22:51:33 -0700 (PDT)
Received: from localhost ([122.172.85.153])
        by smtp.gmail.com with ESMTPSA id g189-20020a6252c6000000b0053e47dcfa32sm10990429pfb.155.2022.09.25.22.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:51:32 -0700 (PDT)
Date:   Mon, 26 Sep 2022 11:21:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, di.shen@unisoc.com
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh
Message-ID: <20220926055130.yr67653e52vyuutv@vireshk-i7>
References: <20220915090515.1660-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915090515.1660-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-09-22, 17:05, Xuewen Yan wrote:
> Before update thermal pressure, the max cpufreq should be limited.
> Add QOS control for Lmh throttle cpufreq.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

This doesn't apply cleanly over my tree anymore, can you please rebase and
resend ?

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

-- 
viresh
