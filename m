Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3A631A94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiKUHsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKUHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:48:14 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2AC31DD2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:48:13 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n17so10409053pgh.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IACc2gkcOz5V66qY6IE0pXOutouS3CLvlPRM7bFD3Fs=;
        b=jiMU/+ADUNU95PVFy5dZLAzE6RJp/GSzuaToJOl3NL37TEC1ZWJJow2LIBAdf/6TrB
         B6FmmdipjU6XKXOcDU8R0I4uTNu2IkdPqEhunYLKHw2w7dVLWFr+jvF0U1s2uLYlHUM3
         MVV7Si07nlH6VaYYIsU+7+WfGfFc5P0MMAfQtPGbEzbxI3lBeMasQ04fi4A621Z6FFoT
         me1fGQF2X2kscfSowpC1WW+oe5LqlJ5/G4MvNBVUZzaS585SDq+HKnKJrPw+GbtrHihX
         oBf++bdZ6Qa65UseTIqKKAMxEi5hfNirQ/HEFVaL1zUIqXXkvA/bKqQfNRRLKsO1eM4x
         f82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IACc2gkcOz5V66qY6IE0pXOutouS3CLvlPRM7bFD3Fs=;
        b=hIsdxCn4nhaNDWdUIdTGYr2tD/0Dg/pJgu+Y80aloXsTx4edcAoiUj7+i+LBXwd1r3
         BhSKG0un94cSrLpBAkOfJUN1Tw1+zK1wH/j80gbHjIao0L7CUNeHEkL/Ll84iDlTL2zE
         1O6tAtiXh319HXuElK/6kqiDYj3EC/Z21CuOHcHZ1lb9/J2+hwqnPnNNLYQrp2U7mgzg
         ELeQa/ErHgECfmZ++X67pAW3B8QKGXRsyHPjE53H6Ci1IL3/iFf3TAKnexEorQwbLnd8
         LwSly5jHd3BCbDnOd7ILFXAZafNpXW5E1ZkIjDLbxP7tKqv1q51pbVdXreykgH4hwM1W
         CoBA==
X-Gm-Message-State: ANoB5plamLz0xs3+xp4EI7+qkWV4TFENeumV1rCbAPz3eZAQ7Y+RjgDT
        OFYpAswVn1VWYN5g5OHb28AOmg==
X-Google-Smtp-Source: AA0mqf57/6MzTK8YP0wv6rPUYELOh2yI5mYTfv3pzQm6Mysb0UxKQIfTqS0N4qR6rVHFCCO2+JfZwQ==
X-Received: by 2002:a63:4543:0:b0:46f:3dfb:8fb3 with SMTP id u3-20020a634543000000b0046f3dfb8fb3mr16528480pgk.121.1669016892545;
        Sun, 20 Nov 2022 23:48:12 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id 139-20020a621591000000b0057210dc5f23sm7918038pfv.218.2022.11.20.23.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:48:12 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:18:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221121074810.mbpm5feyfbcupl5r@vireshk-i7>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221121051959.hphzjuaif423xwn6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On 21-11-22, 10:49, Viresh Kumar wrote:
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

I have dropped patch 2/4 now, since Mani wants to get it merged via
SoC tree.

-- 
viresh
