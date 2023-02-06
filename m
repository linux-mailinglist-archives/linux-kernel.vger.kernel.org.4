Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D5D68B4CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBFEKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBFEKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:10:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A245F10A86
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 20:10:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so12290277pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 20:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9Iz2bAeLVNImFf6m81UM3K4j23JmjCeZY/bShjsHls=;
        b=Vycgf+fbsgHZwzdyLAoDwVLfhQcCD+eGGikeqW1Ybku93AZoWkzWdTwAQwe0KJ8Run
         nIDU9ixEbPw04kvJ+9i6o70RMs2ioyGOxYaHW/+vQylN+xideNIpgvSGtRJ2DtNYOl9H
         dSKcYPZqdesVG4cD6JLscWQgVaop0fSsfp+P2UQFpidFHwGl/JNKHgVJKs+kOHC1nMCw
         R+xZ8mnqID3szLn/WE6mNt+nGDMIBv0lr1Z4uEHknj4rRckfJaW1TTlWXG0sc0CafEOg
         toKWXBwzI3Eh6YbRAd6fV4ThDd+W8odigspOFP8s8bsExM+QtKRnfvb2tvcT7SGEGTrP
         Il1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9Iz2bAeLVNImFf6m81UM3K4j23JmjCeZY/bShjsHls=;
        b=GkhVPWSPvZG+AfmS3wrvp09ZUUg1QEJ+MbsbPmshV6VV8AAligSPp1YV5Qo04srDpd
         MntWLvJA0qeLXhCXt4gH/CafO98NdM2lmtcYzdSOdulN6ikaRNgm0Ix4plXTxLMjmhGu
         MP13GxTbHtrI58fEtNzpSvfARXJGkST9Lt5F42qwHAdMm7Z4R1uVtymb8OhPyW2XCtMg
         XgOrKMx+bpU46vJPjMHN3J8hPQb+4VNnKTKcBZuY44aTuI1kpsijVnKfF3YM0+TOkm4/
         tmNOY31pf9OTvvFgBGE7rpNjLsR0pSKGMzSFwxjcM5nNgos8ozqf9Vh/IfhZwie3FtBY
         4JWg==
X-Gm-Message-State: AO0yUKWCvrXl3PkRdfj8Tf3sjCfu+4AwaTjDGqDNYO5sA+Cl2neVflpE
        ntjmyllF9kDzvbx4kMwaMWr+fg==
X-Google-Smtp-Source: AK7set+b2UTl2C42Z5xZH+fjD3TXTG3mMLOOn4va/SeQjXW2BH8fTUFRrzAU2RnUHRGmY37v5vPeqg==
X-Received: by 2002:a17:902:9a03:b0:198:c27f:8952 with SMTP id v3-20020a1709029a0300b00198c27f8952mr9339782plp.20.1675656606156;
        Sun, 05 Feb 2023 20:10:06 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b00199203a4fa3sm120779plb.203.2023.02.05.20.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 20:10:05 -0800 (PST)
Date:   Mon, 6 Feb 2023 09:40:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, swboyd@chromium.org,
        mka@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH
 systems
Message-ID: <20230206041003.4dhwunhq6yemvbur@vireshk-i7>
References: <20230202140005.1.I4b30aaa027c73372ec4068cc0f0dc665af8b938d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202140005.1.I4b30aaa027c73372ec4068cc0f0dc665af8b938d@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-23, 14:00, Douglas Anderson wrote:
> On a sc7180-based Chromebook, when I go to
> /sys/devices/system/cpu/cpu0/cpufreq I can see:
> 
>   cpuinfo_cur_freq:2995200
>   cpuinfo_max_freq:1804800
>   scaling_available_frequencies:300000 576000 ... 1708800 1804800
>   scaling_cur_freq:1804800
>   scaling_max_freq:1804800
> 
> As you can see the `cpuinfo_cur_freq` is bogus. It turns out that this
> bogus info started showing up as of commit 205f5e984d30 ("cpufreq:
> qcom-hw: Fix the frequency returned by cpufreq_driver->get()"). That
> commit seems to assume that everyone is on the LMH bandwagon, but
> sc7180 isn't.
> 
> Let's go back to the old code in the case where LMH isn't used.
> 
> Fixes: 205f5e984d30 ("cpufreq: qcom-hw: Fix the frequency returned by cpufreq_driver->get()")

This is incorrect.

Fixes: c72cf0cb1d77 ("cpufreq: qcom-hw: Fix the frequency returned by cpufreq_driver->get()")

Applied. Thanks.

-- 
viresh
