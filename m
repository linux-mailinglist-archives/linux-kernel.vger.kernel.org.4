Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815A369EDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBVED2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVEDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:03:24 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D25BDE8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:03:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s15so2233548pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QuI/VvwDNYNNazJWSsosiKrPGXGOzC0MjV/AUA+0Y18=;
        b=nCQyd6hFnx68A0tFIWYPEgBjsOibWoTXo/smz+3gYmBRuFPBPE4pSywkfCdKUgkvpA
         2hEWf1fS6sHfJJXEu8DWcYvgIJnpq7iCy2lvMkzx+HoVbnLXGhDO3iOZBooeJGtaR0Pd
         PIZdAXgjwX/QLrf6b4kb2lhJNJ1j/mPGS3Ik1K0eu/3Wy4urzl1+NUghMtTwh0O3P7VO
         XwlRUrcPNrxw9hmttzjw+mE8ECx7oXM2WAMltKMJ6Ph5wzLKVBrlFjqFfJs7uN86eaQv
         wJJXhF1XzUfKegtHqxyQWMa88wL+GMAeFpaouHVUjOmGIQMWTqRQH3o2TN5f/VRX0YMW
         7WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuI/VvwDNYNNazJWSsosiKrPGXGOzC0MjV/AUA+0Y18=;
        b=Cf5yze7CEqFWlpx/XSoO3I4Kq/1dh2tKBLYkedk5+315hNu9ov71mLfXvB1Q+GzAUL
         AuSan6XtGjLvLn7dLEXz58c0xsLL7lkxvYsd6eU8NMZU+fX3RfX4NUXVk4Y0PfD6lFGV
         VoBXo4rAoHoApP3Yv+UNZoc60CcRoH46gyAJbt9Maj18KvSb7CNlQpVHI7+LIKTsEDom
         b7U0Op1VXzSDeBQe1SIza6LAsbw4URvlrGe23tC218nNU15wx4cO0sbomZp+QkgP5ONd
         mJaHu/AKJV/s4I1jYKln2Pj4jQrgomrlHVzBC8ktQksyQcRAXakxanPJWrPKRAvXq7dY
         64hg==
X-Gm-Message-State: AO0yUKUbBGmtKlRRomBu4YWYxYdQjp2cEnxuosK+UfLfDWWliaPBVAlk
        7pc33wxuEi9n0Ku05HbsM/8j9Q==
X-Google-Smtp-Source: AK7set+j5AzguT+wPMqJTKHp23ybKVMqcUGOXK1UT3NyydZuoWzKn02WTplOAHKPGXm8wetjgNETZA==
X-Received: by 2002:aa7:96d0:0:b0:5a8:515a:eba4 with SMTP id h16-20020aa796d0000000b005a8515aeba4mr6768719pfq.10.1677038600006;
        Tue, 21 Feb 2023 20:03:20 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005ae8e94b0d5sm6764079pfn.107.2023.02.21.20.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 20:03:19 -0800 (PST)
Date:   Wed, 22 Feb 2023 09:33:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, rafael@kernel.org,
        jonathanh@nvidia.com, robh+dt@kernel.org, lpieralisi@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v2 7/9] cpufreq: tegra194: add OPP support and set
 bandwidth
Message-ID: <20230222040317.r2p6zlbumazymluc@vireshk-i7>
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <20230220140559.28289-8-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220140559.28289-8-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-23, 19:35, Sumit Gupta wrote:
> +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long freq_khz)
> +{
> +	struct dev_pm_opp *opp;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		return -ENODEV;
> +
> +	opp = dev_pm_opp_find_freq_exact(dev, freq_khz * KHZ, true);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	ret = dev_pm_opp_set_opp(dev, opp);
> +	dev_pm_opp_put(opp);

What about dev_pm_opp_set_rate() instead ?

> +	return ret;
> +}

-- 
viresh
