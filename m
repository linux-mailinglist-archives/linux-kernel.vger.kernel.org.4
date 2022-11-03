Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2637617D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKCNLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKCNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:10:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B041572A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:10:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l2so1838744pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NScQLLQ/DV98W7NdOU4iAEm84rVm1FNM8LeyiaSiNU=;
        b=M5vFwOHO3FEzDVgyut7RpcM4LkoVEl4L1Cexet74BrLS/TOrHYQ8+SQoRGiEdTcRtI
         R7vef8s7QlZWX6WLaLTM+AJK7eNc48J2bBg0YjVHOAtAInoN2vdfpDhwfHffpAzXhlNA
         Nb4bX3uhAlA9dPZ35DpnacA8G+xkzqbu8BVY3hj7N79vEorniR4QnQPjt0sQ1jUdpVzN
         Lp1wJ/Z/h7K+PTX9v5LSt+pOO0mJFTSCx3fC1I7k80zO85u7E+mRkGZEL/JZoYllCkoA
         5WlT68o37eiKcoWiMZO7IEioQyvjHVtBmdqVF0epCdvUrfJbyYQLMrZnl/NmNd5v9amX
         2HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NScQLLQ/DV98W7NdOU4iAEm84rVm1FNM8LeyiaSiNU=;
        b=btwe5Nl3O1E0Fn3hA+JIljr8Wv5x+n1NSqL9+eEmTlIW/aefsuj0v5JX0fzPIKNXx7
         ADsSXzwWBT8qPbewaUVRWvq+szMW4TRSfGUHLaWqoV7sf97sfbpxUXeSkxv7ATtczwvU
         jKdEWgwZKnwRcFxGFo4+KfhWo0p6SVEsGASWNfBIXAFW4UExJA6uua6fEerXEZa0DU/V
         9NRtMwMNZYI6OApEspoUtzPHS4vK+PmSmBzCaNtGUYBvH71KNUIie5l/x9e9T46G9JB/
         A+f/N/qIzScFsxTZoDA5xQ+Dj9e9+cl4/+1kG47pkTRHCUs4McrcZmUz/H6QCm+QVzHS
         gnuQ==
X-Gm-Message-State: ACrzQf1QVymUjDkDBjlsYZp3GrbMLFAY9+Zgn6NxZJDNkFG2GJFcLCdp
        Q1kEt9t4O+aChX2/SlYKTVC4KA==
X-Google-Smtp-Source: AMsMyM7ViWWzGUThV0eQRcWC+DQJJUxxqjCrQU0xu8YM/+BgFS5gegKE5vqZSbum38Sux0oZxrJaOA==
X-Received: by 2002:a17:902:9a43:b0:188:5256:bf42 with SMTP id x3-20020a1709029a4300b001885256bf42mr3613700plv.69.1667481054780;
        Thu, 03 Nov 2022 06:10:54 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b00186c5e8b1d0sm628655plx.149.2022.11.03.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:10:54 -0700 (PDT)
Date:   Thu, 3 Nov 2022 18:40:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
        rafael@kernel.org, sboyd@kernel.org, vincent.guittot@linaro.org,
        vireshk@kernel.org
Subject: Re: [PATCH V2 5/5] OPP: decouple dt properties in
 opp_parse_supplies()
Message-ID: <20221103131051.2ivkhibbsdarbewt@vireshk-i7>
References: <cover.1667473008.git.viresh.kumar@linaro.org>
 <5acd93462bff6c108d65802fd39f6002dfadd1a0.1667473008.git.viresh.kumar@linaro.org>
 <3519763.iIbC2pHGDl@makoto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3519763.iIbC2pHGDl@makoto>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-22, 22:24, James Calligeros wrote:
> On Thursday, 3 November 2022 9:01:08 PM AEST Viresh Kumar wrote:
> 
> > @@ -674,7 +677,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
> >  	bool triplet;
> >  
> >  	microvolt = opp_parse_microvolt(opp, dev, opp_table, &triplet);
> > -	if (IS_ERR_OR_NULL(microvolt))
> > +	if (IS_ERR(microvolt))
> >  		return PTR_ERR(microvolt);
>  
> Erroring out here will still block EM registration on platforms without 
> the opp-microvolt prop so we're back to square one, which means the 
> patch does not do what the description says it does. It behaves
> almost identically to the current code.

I am confused.

With the current code, the following will work:
- all three available
- microvolt available and nothing else.
- only microamp available
- only microwatt available
- both microamp and microwatt available but no microvolt
- and other combinations

Isn't this all we want ?

We error out here when there is a problem with DT entries, i.e. incorrect
entries, etc. Else we will get NULL here and we continue as we don't check for
IS_ERR_OR_NULL() anymore after this patch.

> I assume this is an intentional choice given the comments in
> opp_parse_microvolt(), so the commit message should drop 
> references to fixing such platforms.
> 
> If this is a hard sticking point and opp_parse_supplies() must return
> a regulator with opp-microvolt, then I am of the opinion that the parsing
> of opp-microwatt should be detangled entirely from the regulator
> infrastructure.
> 
> Otherwise for the whole series,
> 
> Tested-by: James Calligeros <jcalligeros99@gmail.com>

What did you test exactly ? As I thought you will be testing the only microwatt
case here and you say it won't work.

Sorry, I just got a little bit confused :(

-- 
viresh
