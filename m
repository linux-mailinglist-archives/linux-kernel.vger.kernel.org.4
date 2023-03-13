Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510976B6E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCME2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCME2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:28:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF6B26CD1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:28:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id rj10so132639pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678681731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TAvGM9A2vDOzZdyZgN/PhkShf6xY7yJiV2Tqe3Nl+SQ=;
        b=vgSzyJf6wycqYZ/VP28K2uAd0g5ZW4Z17ATSTMj8bm/53X2tJN6kLXOuJUq2qi31px
         yTLOEvIj36P32blXlmvFWEpkRyIyz6ATGjFYQ99xtcsCFHsc2JewOeL8a0bqcWQhue0K
         Z5knfx4nBfuz7GdB05icBFRp6tGwuynWdlqAsAt0+7J16rlNB1iwp70JepKXzgvD38M0
         ifWATre3vYuJ0aduoRvF3Bakmn6wIVtpHx7H288oyWgmd0dvzyus7St6jM9vCxoDphRJ
         WCDeXAK4kePRLuHWAPz7O8Z+/yQDo4YzoXMueK6qhRQmHigR4daFHTCI5iuSZ6Um6HSk
         5iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678681731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAvGM9A2vDOzZdyZgN/PhkShf6xY7yJiV2Tqe3Nl+SQ=;
        b=ndSZnQ4YtJvqEVtERyj0MU3Sfr/R78QZLEHdCgvvQ/HCbHtmBltCGOcPlM80Jgd31c
         kbi7m8YVWAYsZ6SAWzW9oAiU12b9p0QoZO2O+8Z6NHMOjAZhqFG4kkJBGA7DcBG/JSpg
         uZPgaKP/H3SfIma8LLEd0z/mJmp8II4Cd3OhrFf2QCxtRjim064jg+we1D4TL6QB86gm
         EPxxoVzOXe8/BuOY4XXDwCvnZj83K7/axSJthsjXHTSILnVrE2iQFgekkjK14XSBNUem
         JStNwjGTJY3ZX/jR5r7Q3JmAyIHv5QRFg17bDdipwxjNJ+Ivauz4dxZNfaAs0vMCKlgT
         miFw==
X-Gm-Message-State: AO0yUKWFjHX6xEiti9RP3IFF29wZ47uh8FRroKaXSpAH4DFKTuHxoVWC
        5pilXBcljwpdqQEdKv49nTvtTg==
X-Google-Smtp-Source: AK7set9p4bFVrpjWBwosOcH7++GcaLBhSfedNIG7sXxnuN2cWJ9UqlzAa/4KGepgTsY0V/w5bofLMg==
X-Received: by 2002:a17:90b:943:b0:23d:198c:a5ec with SMTP id dw3-20020a17090b094300b0023d198ca5ecmr565374pjb.39.1678681730991;
        Sun, 12 Mar 2023 21:28:50 -0700 (PDT)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709029b8200b0019f0f5704besm3557029plp.236.2023.03.12.21.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:28:50 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:58:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Use of_property_present() for testing DT
 property presence
Message-ID: <20230313042848.bt4vl3tjjdb6qs34@vireshk-i7>
References: <20230310144702.1541730-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144702.1541730-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-03-23, 08:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
>  drivers/cpufreq/imx-cpufreq-dt.c     | 2 +-
>  drivers/cpufreq/imx6q-cpufreq.c      | 4 ++--
>  drivers/cpufreq/scmi-cpufreq.c       | 2 +-
>  drivers/cpufreq/tegra20-cpufreq.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

Applied. Thanks.

-- 
viresh
