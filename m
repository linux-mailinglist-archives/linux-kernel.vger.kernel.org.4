Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BB5675FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjATVcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjATVcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:32:50 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7004F6FD26
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:32:48 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s26so3045541ioa.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGh7z2QCcYtuLnnn5HxrYgE2W7WHF0q3ybR8ZwW2Opk=;
        b=ErErCh+SyLzVrXwk5sTL6ON5khysoH5uPwtEEP2RrhSb4kW+PmZsWtzRqqkOdvdv93
         ml6UcDCWItkfL10h02NfLc4FqQ1xGn7YGCxqZQ6xQh7XRKLoSyUrj5NIyAJ+KxbQK3D9
         pYK8USAvicgv7NSyCLf1NEfF8IKc1TEiS2O5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGh7z2QCcYtuLnnn5HxrYgE2W7WHF0q3ybR8ZwW2Opk=;
        b=kIbVxoD11EEnsc1mjoasqRj2/24YdsobKyPsRd8Xfgq1/a8bYPXnb/5oY9Ou8MlJRA
         1bRetP0E+eisMZy9rzl2i3OIaxPZntqB6zy6aGCBP6PIimof0OU5z6lltumhpAF50ujB
         3piQM5N8IPtSbywDiMy+eEmnuShcOq8BSc84rmT64qcbLdPfPgSTyPnNDZX9sUvQZRQG
         wA1Sl5ZzxgKL2mwDxLbmrRLSlSw8+rT+pY7irTl3iUvKSGcmtN+erlhNtNyq4683eP7o
         ceJNaXOGAQEVJzbmc+c8YP52vh1T3g0oE5aq9p+vmgf7JDmkgyPTSF88GxHlqbFBjFTK
         LDeA==
X-Gm-Message-State: AFqh2kqxQ+rKypC6yVjcIDF7X97+gr+7iOO5U3crXcxZEHQSby/X7M2h
        OCHZYdZQKupylzSRFV5FcoaWyg==
X-Google-Smtp-Source: AMrXdXtnAhHkL781VLN0so7egxNcy8BBdXXXe44PdtdTbv/L2JwJzZe9etg6kwTkFYhzHdFDohIdaw==
X-Received: by 2002:a5d:8b0e:0:b0:704:939a:dc3f with SMTP id k14-20020a5d8b0e000000b00704939adc3fmr11422454ion.13.1674250367834;
        Fri, 20 Jan 2023 13:32:47 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id o128-20020a6bbe86000000b00704c767ead9sm1841055iof.28.2023.01.20.13.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 13:32:47 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:32:47 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
 (=> interconnect issue)
Message-ID: <Y8sIf+41EGJuPQrP@google.com>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
 <20220902043511.17130-5-quic_rjendra@quicinc.com>
 <Y8Ggh6RObbB1cxSS@google.com>
 <dc5487d8-d31e-28c6-07e8-8d1ff54a4ba4@linaro.org>
 <Y8baZWlKB9vNGYJw@google.com>
 <754f8193-09ec-8bbf-e0d4-898525dc242f@linaro.org>
 <Y8bfIv6GJU1TD4Dh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8bfIv6GJU1TD4Dh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:47:14PM +0000, Matthias Kaehlcke wrote:
> On Tue, Jan 17, 2023 at 06:33:41PM +0100, Krzysztof Kozlowski wrote:
> > On 17/01/2023 18:27, Matthias Kaehlcke wrote:
> > > 
> > >>> which would set the initially bandwidths to 0 and determine the actually
> > >>> needed bandwidth. But since the driver isn't probed the initial
> > >>> bandwidths stay at INT_MAX.
> > >>>
> > >>> This isn't actually an issue with this patch, but how the interconnect
> > >>> framework deals with devices that are registered on the bus, but aren't
> > >>> probed (yet). Not sure how this would be best fixed. Georgi, do you have
> > >>> any ideas?
> > >>
> > >> Why the device is not probed (yet)? If it is registered, it will come
> > >> soon during boot up.
> > > 
> > > Because CONFIG_QCOM_ICC_BWMON is not enabled for the board in question (see
> > > above). It could be enabled as a short term mitigtion, however we shouldn't
> > > require drivers to be enabled just because the DT has a corresponding node.
> > 
> > It's the same case as with all other interconnect leafs/consumers. The
> > same behavior if you do not have it enabled, right? If not, I wonder
> > what is here different?
> 
> Right, this is a general issue. The problem on sc7280 (and probably other
> Qualcomm SoCs) is that the interconnect link at full throttle prevents the
> SoC from entering its low power mode (AOSS sleep) during system suspend.
> On many boards this might go unnoticed, on herobrine the condition is
> detected by the embedded controller (EC) and considered a failed suspend,
> which results in waking up the system.

I did some hackery to convince the EC to enter/stay in S3, despite AOSS
no entering sleep mode. That allowed me to take power measurements. With
the kernel suspended but the AOSS remaining on the power consumption of
the Qcard is more than 7x higher than when the AOSS enters sleep mode!
On a Qcard system I can't break the power consumption further down, but
I think the extra power consumption must be coming mostly from the SoC
itself, since the kernel and the EC are essentially in the same state as
during a suspend with AOSS in sleep mode.

The enormous increase in power consumption suggests that this is a serious
issue for non-Chrome OS platforms as well. On herobrine and trogdor boards
we have the 'luxury' of being able to detect that AOSS stays awake (though
it comes with the caveat that the system can't suspend when that happens).
On other boards this goes likely unnoticed until someone measures suspend
power or notices a significant regression in S3 battery life.

It seems something needs to be done at the interconnect core to fix this.
Is it really necessary to init all link to max bandwidth? Maybe it is
needed for certain links, but not all of them? What is the background
here?
