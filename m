Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B352867A83E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjAYBFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjAYBFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:05:10 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C23E93D0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:04:47 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p189so7902584iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3irqnNBdQ9Wio7OIw4BasqAgdBTVFcPBsPir/dXgS1Y=;
        b=IOhwJoNGWrc6Ssnx/rAzo4+y8kZcnZglqC3ihgrdZFG6wunsTG50yW0kFXrmLkq6wY
         rEVQpwBEsMe3uSn3IZIJ8+JLIO1TOlyKwoi0tuNASYXyrXKzVDAq/MEZPmAP2J22J6U7
         9KS1ixqxzrKW8x6WZJ+ra5B8ySlxf7nmPJhbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3irqnNBdQ9Wio7OIw4BasqAgdBTVFcPBsPir/dXgS1Y=;
        b=44UhDSHDTXAKK2Zfxq3Fr5FEvB0Fo9EMNLIjR4Pz5EjhkPtHs9tQqm/yYaRiCJkEUd
         8W04hflBM5RYwYxCV0gxIoUdj9zBOiidNe8YtCqL1BcpCCRujdgRxKHh10No/jJyN1YT
         2gUeJB4hFpIHu0JIuAfQ774/HGXv8T5qCa6sX5m5iQpQ9iLcwGyPCE1G9wbArgCtuJl3
         NwHi6mIW5ScX8hJLF7ln0OMv6NbDWQTTHfjI/rLrSAP78PdffyLVKHaA3OHSAj9ATuON
         5mGwuA5TGyLZIklQ9yOJm5O7aCVJAvJqgd/hm+V1VvWkzqzkeR2lgjpikGpoHRd5Btfu
         TGFg==
X-Gm-Message-State: AFqh2krUbTJP1zNNVKwh3QifndLq4jVHFK9M2Z4hfQRDKuJEkJkF4QSq
        b9QkpM2PYhMnNLil93dTtylEeQ==
X-Google-Smtp-Source: AMrXdXsRTdO6kwJYFVkU1zh46cZoVczKlZniDBt22SEYCqwL/5QpIXZ8R4L6sjO0V/W4PTg85CEzmw==
X-Received: by 2002:a5d:950a:0:b0:704:cf41:8a24 with SMTP id d10-20020a5d950a000000b00704cf418a24mr19093320iom.15.1674608686462;
        Tue, 24 Jan 2023 17:04:46 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id g11-20020a05660203cb00b006bc039e3224sm1021116iov.17.2023.01.24.17.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 17:04:46 -0800 (PST)
Date:   Wed, 25 Jan 2023 01:04:45 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
 (=> interconnect issue)
Message-ID: <Y9CALT+ec6fxXlWZ@google.com>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
 <20220902043511.17130-5-quic_rjendra@quicinc.com>
 <Y8Ggh6RObbB1cxSS@google.com>
 <dc5487d8-d31e-28c6-07e8-8d1ff54a4ba4@linaro.org>
 <Y8baZWlKB9vNGYJw@google.com>
 <754f8193-09ec-8bbf-e0d4-898525dc242f@linaro.org>
 <Y8bfIv6GJU1TD4Dh@google.com>
 <Y8sIf+41EGJuPQrP@google.com>
 <2d064077-d4ec-31c4-19a9-4cc9aec8d85b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d064077-d4ec-31c4-19a9-4cc9aec8d85b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

Thanks for your reply!

On Tue, Jan 24, 2023 at 02:02:36AM +0200, Georgi Djakov wrote:
> Hi Matthias,
> 
> On 20.01.23 23:32, Matthias Kaehlcke wrote:
> > On Tue, Jan 17, 2023 at 05:47:14PM +0000, Matthias Kaehlcke wrote:
> > > On Tue, Jan 17, 2023 at 06:33:41PM +0100, Krzysztof Kozlowski wrote:
> > > > On 17/01/2023 18:27, Matthias Kaehlcke wrote:
> > > > > 
> > > > > > > which would set the initially bandwidths to 0 and determine the actually
> > > > > > > needed bandwidth. But since the driver isn't probed the initial
> > > > > > > bandwidths stay at INT_MAX.
> > > > > > > 
> > > > > > > This isn't actually an issue with this patch, but how the interconnect
> > > > > > > framework deals with devices that are registered on the bus, but aren't
> > > > > > > probed (yet). Not sure how this would be best fixed. Georgi, do you have
> > > > > > > any ideas?
> > > > > > 
> > > > > > Why the device is not probed (yet)? If it is registered, it will come
> > > > > > soon during boot up.
> > > > > 
> > > > > Because CONFIG_QCOM_ICC_BWMON is not enabled for the board in question (see
> > > > > above). It could be enabled as a short term mitigtion, however we shouldn't
> > > > > require drivers to be enabled just because the DT has a corresponding node.
> > > > 
> > > > It's the same case as with all other interconnect leafs/consumers. The
> > > > same behavior if you do not have it enabled, right? If not, I wonder
> > > > what is here different?
> > > 
> > > Right, this is a general issue. The problem on sc7280 (and probably other
> > > Qualcomm SoCs) is that the interconnect link at full throttle prevents the
> > > SoC from entering its low power mode (AOSS sleep) during system suspend.
> > > On many boards this might go unnoticed, on herobrine the condition is
> > > detected by the embedded controller (EC) and considered a failed suspend,
> > > which results in waking up the system.
> > 
> > I did some hackery to convince the EC to enter/stay in S3, despite AOSS
> > no entering sleep mode. That allowed me to take power measurements. With
> > the kernel suspended but the AOSS remaining on the power consumption of
> > the Qcard is more than 7x higher than when the AOSS enters sleep mode!
> > On a Qcard system I can't break the power consumption further down, but
> > I think the extra power consumption must be coming mostly from the SoC
> > itself, since the kernel and the EC are essentially in the same state as
> > during a suspend with AOSS in sleep mode.
> > 
> > The enormous increase in power consumption suggests that this is a serious
> > issue for non-Chrome OS platforms as well. On herobrine and trogdor boards
> > we have the 'luxury' of being able to detect that AOSS stays awake (though
> > it comes with the caveat that the system can't suspend when that happens).
> > On other boards this goes likely unnoticed until someone measures suspend
> > power or notices a significant regression in S3 battery life.
> > 
> > It seems something needs to be done at the interconnect core to fix this.
> > Is it really necessary to init all link to max bandwidth? Maybe it is
> > needed for certain links, but not all of them? What is the background
> > here?
> 
> The basic idea here is to do some initial configuration of the system and
> enable the interconnect buses until all consumers have probed. Otherwise
> it might disable the bus to some hardware, whose driver (module) is not
> loaded yet (and didn't had a chance to express it's bandwidth needs).

I imagine this is an issue for a subset of consumers that are already using
the interconnects before they are probed (like an early-console UART). For
most consumers (like SPI, USB, eMMC, GPU, ...) I'd expect that it should be
fine if the interconnect is disabled until the driver is probed and
specifies the bandwidth requirements.

> The max bandwidth is the default, but we can implement the get_bw() for a
> given platform to return the current (or initial) value. It would be best
> if we could read this value from the hardware, but as this is not possible
> on this board, maybe we can implement get_bw() to return something else.

If my above assumption is correct maybe it would be an option to return
a bandwidth of zero, except for the select links that might be used before
the driver is probed.

> I guess that you see some int_max values in interconnect_summary for the
> ebi and llcc nodes that stay forever?

Exactly:

grep -e llcc_mc -e ebi /sys/kernel/debug/interconnect/interconnect_summary
llcc_mc                                      2148483647   2147483647
ebi                                          2148483647   2147483647
