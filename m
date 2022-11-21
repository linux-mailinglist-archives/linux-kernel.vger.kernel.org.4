Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201FC6319D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKUGpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiKUGpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:45:13 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3CC19C0F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:45:11 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b185so10485239pfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T9z6VNHAh5buPLOQbn4DZRIbuRpf7GLAza5o2jIuncE=;
        b=oyqKPJqV6ChsbvcTQN+xTD9PeymSUxzZ4mMliDJurfoOfDB9tEnQWdI7PQaKjC1D0T
         LIHx/SMR/6Q/7er1lusBloufr8W4xin7Qq2hfmIpZnRdWzTrEgCcgBJA2GhjmelaXvsI
         V7iWawCflMlMvGxfITd89DW2MG1jgB1MG167Rh5uUUwRYS17aFVz9aT+XBY/hlbLXUwY
         CII1XP/HqWT5StaQo6HXfG3eMIcMvfjbKa9TWZCNplJ5aPb92KuZsbTfZ/2Z9JSee89L
         mm+TGdN+02s25vkFuC/G+eQWp3OjSa/6P8LrPLB2/LUD8mcMO7Mxdimiu+/fdxahIwPo
         NxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9z6VNHAh5buPLOQbn4DZRIbuRpf7GLAza5o2jIuncE=;
        b=tk7GDuN1tv8h7A0P52FsoFe1b1fxsp2cLJhho47kl55WDU8u5h4DLie89nz40bnPmI
         1qix6sDjdklHOaq1UtM8qW9ve9koaepLH3OmotkB9OYlSMVvRwyhpUxgHjT5fD/zGMzp
         q8pB85cF7p72Any0+YrrLIWPAIVI9OOiWsEyJKJck7XSjqWIJU1d+N/xAc5ozZF1pORV
         o5bzT6xzxRBkY5CMHm9FufnbI2iurhOpbtyFLGNWueGnt3Y6m9Wa3seJVApdUWg326Fo
         1sJijUesYDiFCqR7p4asxJKCGbJx0prXJ3mwAW05PwuFXXgrZBHmNw+d+13Fo1iVL/kr
         JJMw==
X-Gm-Message-State: ANoB5pl+FdCRlpgttA16eryvk14kdnLHdJgf8OXF2+OiGsb65P69jJyT
        bYZa2P0TVpuo6zJZCNG9uDd7
X-Google-Smtp-Source: AA0mqf6ddMnQGXatGtIKDuBbyT3kbY7n1kpxrE0Vd9I/tQTaSSyurICcwD9LRXBLZlh0j9EpMLqbdA==
X-Received: by 2002:a63:5007:0:b0:45f:beda:4116 with SMTP id e7-20020a635007000000b0045fbeda4116mr789381pgb.618.1669013110909;
        Sun, 20 Nov 2022 22:45:10 -0800 (PST)
Received: from thinkpad ([59.92.99.222])
        by smtp.gmail.com with ESMTPSA id d187-20020a6236c4000000b0053e62b6fd22sm7752028pfa.126.2022.11.20.22.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 22:45:09 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:15:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221121064507.GC11945@thinkpad>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221121051959.hphzjuaif423xwn6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121051959.hphzjuaif423xwn6@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:49:59AM +0530, Viresh Kumar wrote:
> On 17-11-22, 11:01, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds clock provider support to the Qcom CPUFreq driver for
> > supplying the clocks to the CPU cores in Qcom SoCs.
> > 
> > The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
> > clocks to the CPU cores. But this is not represented clearly in devicetree.
> > There is no clock coming out of the CPUFreq HW node to the CPU. This created
> > an issue [1] with the OPP core when a recent enhancement series was submitted.
> > Eventhough the issue got fixed in the OPP framework in the meantime, that's
> > not a proper solution and this series aims to fix it properly.
> > 
> > There was also an attempt made by Viresh [2] to fix the issue by moving the
> > clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
> > since those clocks belong to the CPUFreq HW node only.
> > 
> > The proposal here is to add clock provider support to the Qcom CPUFreq HW
> > driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
> > This correctly reflects the hardware implementation.
> > 
> > The clock provider is a simple one that just provides the frequency of the
> > clocks supplied to each frequency domain in the SoC using .recalc_rate()
> > callback. The frequency supplied by the driver will be the actual frequency
> > that comes out of the EPSS/OSM block after the DCVS operation. This frequency
> > is not same as what the CPUFreq framework has set but it is the one that gets
> > supplied to the CPUs after throttling by LMh.
> > 
> > This series has been tested on SM8450 based dev board with the OPP hack removed
> > and hence there is a DTS change only for that platform. Once this series gets
> > accepted, rest of the platform DTS can also be modified and finally the hack on
> > the OPP core can be dropped.
> 
> Applied. Thanks.
> 
> If you get review comments later on, please send incremental patches
> for that.
> 

Sure thing.

Thanks,
Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
