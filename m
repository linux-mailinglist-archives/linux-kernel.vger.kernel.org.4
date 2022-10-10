Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4949A5F9810
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJJGFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiJJGFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:05:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7784A2251C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:04:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l4so9486499plb.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 23:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze6sWpLp4OvIIrfkLpb2+ilcLI2WvN54fOLaHJtyJQ0=;
        b=brojRUA4twJZbhunUPYWOqEG3kEV1+Dt5K34DHoxqPqdRk7/m1oig7e/E3ZrIjKEm5
         WwwJX5MD/Tt2CNOhQx1slrOGSRpTWRQ0f5og5wJMxA9qRP8OatdepajU6lGlQvTerV5t
         +tGum6VU5yOzWqdv6V7W4E55U6C3LWAassuBs+1VQ4B7Dr46mCY0LmkLZY6QWglhSo1h
         mPq+5W/QRslkKQ8rJajiRu3rIVgS9hAzw5Wvbcs4BQApO4SkRr58PBNmDxLvHT9/zbIX
         zEPNQ3juQycV/tbNxi/ike8VJIfzIxKRdykkRfET/wR/yBJahqydktty3iFLaOmKp4Up
         cdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze6sWpLp4OvIIrfkLpb2+ilcLI2WvN54fOLaHJtyJQ0=;
        b=qt3IeQJDQ8/VJf1bg+t2c5Wgb/vUPHg6vZCjo3VYpWydOAKKmibFGl97M6FMMQ7HGC
         6uSXukcNwiIYbJgiMvpEdX0Uk/ZKRNFU5UC4jr/ze6xdSAtqCmYbfb3z28T+WcqZi5VT
         KAdk4wmnbJuFUDCHyKOCfZj9iFw+UeqdwRrUloFLm5m9By3DVWSqYSSnimNV6l1iRFVd
         M+gmeEsQfBxkW4ny3I2zpQxkTicDekbXalut83gyOyZ9rrm9GZZN946/WXvTy/k284Gc
         300g6KpiVrZ1GDhTNemU68HYWU60AMXVGp0uqJ+Ic886U4Hlxz1hnLa2Xp/Dpj6jFFIq
         VVvw==
X-Gm-Message-State: ACrzQf2ooi0O98ZWmD2SApKxtBVg9dpeNt8YMsu68epu/YiZkK6beF5W
        EWEK/Ka/F+QUv8YZV1PZvUwMyw==
X-Google-Smtp-Source: AMsMyM4Dw8vuxf5zlXz41FyIpJmGE5/yHcnIZmYyUCdgOIk9PW8Q4pogshvbi2TUcY/YN/hvkrBz0A==
X-Received: by 2002:a17:902:ea0c:b0:181:61d1:ac1c with SMTP id s12-20020a170902ea0c00b0018161d1ac1cmr9048198plg.120.1665381897930;
        Sun, 09 Oct 2022 23:04:57 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902784a00b0017dd839f2a5sm5691051pln.38.2022.10.09.23.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:04:57 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:34:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com
Subject: Re: [Patch v2] cpufreq: tegra194: Add support for Tegra239
Message-ID: <20221010060455.o3mnc5fx2xm34wpb@vireshk-i7>
References: <20220920110646.27837-1-sumitg@nvidia.com>
 <20221004152714.GA1524940-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004152714.GA1524940-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-10-22, 10:27, Rob Herring wrote:
> On Tue, Sep 20, 2022 at 04:36:46PM +0530, Sumit Gupta wrote:
> > @@ -586,6 +586,7 @@ static int tegra194_cpufreq_remove(struct platform_device *pdev)
> >  static const struct of_device_id tegra194_cpufreq_of_match[] = {
> >  	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
> >  	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
> > +	{ .compatible = "nvidia,tegra239-ccplex-cluster", .data = &tegra239_cpufreq_soc },
> 
> Not documented.

Sumit, can you please send a patch to document this in bindings ?

-- 
viresh
