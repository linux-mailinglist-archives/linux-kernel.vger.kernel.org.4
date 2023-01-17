Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0653766E588
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjAQSAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjAQR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:56:03 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF24F86C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:47:15 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id m15so15767022ilq.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8F81q3l/TJktOEcsAAxVIySD1mWyFaZRhl5NfEknlwM=;
        b=eGBEqUNrEcTTtbihLCI82m3GrMUfa/u1FaeVqcFS1kv0PlNWZ0LI/zPTKTd32cUDxJ
         omNj8Eowo53XzGkUZj9O/el/um50AteuVwiDOhpLCzK2BJFi8bY2Yag7DOQyeVKEWpw1
         dpgG2PtpBNxrAcS9h6K0hLALRH1aMVPYaM/B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F81q3l/TJktOEcsAAxVIySD1mWyFaZRhl5NfEknlwM=;
        b=FO/5w03dSH5NEUYrgA7wd3VziAvulB89Q5ugyJwzvOnExbF523rV75/H3dN7AYNLkn
         T0PofR+4dGCrwDKmOB1Z2lJk1sAJrVh5iiStgfjZ5xBFoUdlqgZlJa9eqv57TaF2cq3g
         A+9tRk8qAogf3AbajV68A0MFkZ2gMfsn17AEWW/KGQNdYZ9ou/ScOu7+otqCqvzejI6y
         DpnjoZhep33ppLPxsauWWEYIQ7N0AGGMGKozQulAUky+qqSnAu+mhHIcx6nqjumxYxng
         rY5wOTLOoSP4GHPLxItr3IkG6KZm8fj8Vi1W4xZdfGXM/VKP1LFls1c6jCm8wYRE1TPP
         pFRQ==
X-Gm-Message-State: AFqh2krPfiKrB5mTigryjzeBraCk/g59q3Z7UVVNQN9X4cskjoTM9K6O
        op39Am3qaUY9d4IE9WH+zQE3hg==
X-Google-Smtp-Source: AMrXdXsMe/3YbShdIn9hNUkJvH+E7o8CrBvenCfXUSgVpSPU/i9zfX7YnJFUlYqZmgIutCKUd3zFIg==
X-Received: by 2002:a05:6e02:ecf:b0:30f:159b:3846 with SMTP id i15-20020a056e020ecf00b0030f159b3846mr3402581ilk.20.1673977635000;
        Tue, 17 Jan 2023 09:47:15 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id r8-20020a92ac08000000b0030c68d38255sm9142749ilh.38.2023.01.17.09.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:47:14 -0800 (PST)
Date:   Tue, 17 Jan 2023 17:47:14 +0000
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
Message-ID: <Y8bfIv6GJU1TD4Dh@google.com>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
 <20220902043511.17130-5-quic_rjendra@quicinc.com>
 <Y8Ggh6RObbB1cxSS@google.com>
 <dc5487d8-d31e-28c6-07e8-8d1ff54a4ba4@linaro.org>
 <Y8baZWlKB9vNGYJw@google.com>
 <754f8193-09ec-8bbf-e0d4-898525dc242f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <754f8193-09ec-8bbf-e0d4-898525dc242f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:33:41PM +0100, Krzysztof Kozlowski wrote:
> On 17/01/2023 18:27, Matthias Kaehlcke wrote:
> > 
> >>> which would set the initially bandwidths to 0 and determine the actually
> >>> needed bandwidth. But since the driver isn't probed the initial
> >>> bandwidths stay at INT_MAX.
> >>>
> >>> This isn't actually an issue with this patch, but how the interconnect
> >>> framework deals with devices that are registered on the bus, but aren't
> >>> probed (yet). Not sure how this would be best fixed. Georgi, do you have
> >>> any ideas?
> >>
> >> Why the device is not probed (yet)? If it is registered, it will come
> >> soon during boot up.
> > 
> > Because CONFIG_QCOM_ICC_BWMON is not enabled for the board in question (see
> > above). It could be enabled as a short term mitigtion, however we shouldn't
> > require drivers to be enabled just because the DT has a corresponding node.
> 
> It's the same case as with all other interconnect leafs/consumers. The
> same behavior if you do not have it enabled, right? If not, I wonder
> what is here different?

Right, this is a general issue. The problem on sc7280 (and probably other
Qualcomm SoCs) is that the interconnect link at full throttle prevents the
SoC from entering its low power mode (AOSS sleep) during system suspend.
On many boards this might go unnoticed, on herobrine the condition is
detected by the embedded controller (EC) and considered a failed suspend,
which results in waking up the system.
