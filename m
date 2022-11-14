Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BA2627621
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbiKNGvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiKNGvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:51:47 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A911A29
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:51:46 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so12891069pjs.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=as5OGi88eO1eBiQbZ3n0aEvSa6v8k/oQH4L8VWw5Fm8=;
        b=KM7+QYjMRyl2lel/gkm+jBZ6omtODOEk/bUmQzB4c18uz9I+Ek/DEeqwvjEwAQxoz7
         0THq7q3p0DQUv5PjhUxsxBvl251FZPu5FUkER4Dpafmc3jtdRDEtjomSSqbJwYcXqxsB
         e+1Ffm/nbMAiR+wihGXKLjYwIDmwKecww4JvygNZLxiqExFmjcr5mRdSWF5zlTSLzvHZ
         I3HqwQBO22tfk7RXfz/ZlKR2L21A5MLuWbmSNXtDDpornoxTgrlnzlzy5TCeP1YRKX+g
         mbtzS3EinGMO17K6S+L0nvWavuUOr/nMJD6dMbwlOgt/jrbuQMO3DIuzOWDRUUfyHflJ
         CWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as5OGi88eO1eBiQbZ3n0aEvSa6v8k/oQH4L8VWw5Fm8=;
        b=af79Fz0TPT7QiPHS74HLnJJjxpZuR5yMGIzZz3glszFc++OrkEg4iSHaHJkrwb6Q31
         5fu/6f5B9Rh9QpnxrASwoFhgaI6Zsyg2xVE0p/L9RM7Xr7uX5IEYnSXEhd0va0rDtgCe
         O/o15PjwPAaRYJdXXBFiJa73GZ1i/jVW+XiB90oiodWxE8Sm3cgVkDoHCIm8coY53kQX
         iRZNxDpiB5jPzlTo+Vc+Cj2Vq5t+Ldr7BSOHt2dZsV9784WH030UpjmC1GhXW3MHYqHG
         MEaX5qZCalBhw6jd5jkVzDx6CINTu1ksTxqEPahnNrhAZUh0lfIkphk+IvnTeBCjg0Kr
         SePg==
X-Gm-Message-State: ANoB5pmHjw3tdyNphQF/N5xeMiCrbMQtIBQABUwE3lPyi/6N0wFa5fKZ
        /D278NZ/8gzM4V96aBImES8Zpg==
X-Google-Smtp-Source: AA0mqf7Ge7+F7+F6cj0KFKkoKYjFuZkiLPBYWjkyKmpDmWJ+FIYKEhWzDB3Hk6wekApwXSEjwUNBSg==
X-Received: by 2002:a17:90a:3884:b0:213:5de3:13e with SMTP id x4-20020a17090a388400b002135de3013emr12638207pjb.6.1668408706408;
        Sun, 13 Nov 2022 22:51:46 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001869d71228bsm6506628plh.170.2022.11.13.22.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 22:51:45 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:21:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221114065143.73gbfzfoihwobzjz@vireshk-i7>
References: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
 <20221108154037.111794-4-manivannan.sadhasivam@linaro.org>
 <20221108155717.srlnabls5ze2resx@bogus>
 <20221109074908.GC4651@thinkpad>
 <20221109110831.lngwmwyjqp4qj73r@bogus>
 <20221109123526.GA29805@thinkpad>
 <20221109164719.d7kowdu7wskyzjsc@bogus>
 <20221114031658.pnbf7uiqqgiq3uk7@vireshk-i7>
 <20221114062510.GB3869@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114062510.GB3869@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-22, 11:55, Manivannan Sadhasivam wrote:
> On Mon, Nov 14, 2022 at 08:46:58AM +0530, Viresh Kumar wrote:
> > On 09-11-22, 16:47, Sudeep Holla wrote:
> > > Is the cpufreq_get() API expected
> > > to return something close to what was set or is it expected to return the
> > > real set h/w value if and when possible.
> > 
> > The real frequency the hardware is running at.
> > 
> 
> Oh... In that case, qcom-cpufreq-hw driver is not returning the real frequency
> but instead whatever set by the cpufreq core previously using target_index().
> 
> Should I fix it too in the next version of this series?

Yes.

-- 
viresh
