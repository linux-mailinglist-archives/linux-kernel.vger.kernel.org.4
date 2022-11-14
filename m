Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E2B62761D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiKNGvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiKNGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:51:20 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A07DF53
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:51:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l6so9552497pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qr+/Csa4DQbRfUmbmy3oZ72h1oNUuMzGZrFMsfi/w94=;
        b=J4pHBjE44RhQZyQPbpn0rS7CdMwvev9PP21t/XfKNpb7LdxYcFvINBI2MYfMLjaEnv
         Gzc0KyXSu87DHrO6UIbuMpCCN23ptJrgM6xIl9x8hHNLXkSRYLUCOoLWZ7TJPyJuA8Wc
         ypGHdEQyRQVYMzd+0vvI10M+YYygVfA7+IlE4aWw2g0lbEd6Nh8zKHb49RV4eCG/6g40
         NPgNJhZ7zkymjEgrwwTShciLZ6Fo1VJSuoyVj9ArlgVuAq3/m5iTEBy44eJMIK/9+9QT
         rBgjuNhFLFZ+qZAv/vkf8Hd+mJVBm0CqcPzP/3nX83acDAN7sKcI0qNL32Dy1FvBiAQo
         9p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr+/Csa4DQbRfUmbmy3oZ72h1oNUuMzGZrFMsfi/w94=;
        b=4hYCG54+N09+tnzPEIehWvb3SzbEtapBb/kkFDUHLt1xX4WOeXRBnuzPZOk/zwEHwx
         f7iCQeSxIxknK2knpwnI9rqB2zO09W5NJfg5lbex8L6eiBS5rC8TOWGSvA4B+9PpOoBb
         K5zx0CGdCUoBDZ66yPMqWTg93JR63UL93pv6YDMWb2p4iwWWOKPptHH/vLCiNbFlLp+V
         ZW6VxN3mdk+JuDjI9SsaiQAFFQ8CoepOc9YiyBs1ekf/Q26LtrPwQ94kPeelpHyTFzGI
         9D5DBHQMqehSea6pBcO8uhCDYP4UiqHaHRpLE+4oHIlnMCs5X+L5OoTx7L65LSAIBard
         wJ0Q==
X-Gm-Message-State: ANoB5pld2N8A5LqR3qgyKJtCBqU1LLCRtyect4SLsf/KoIZxDTTAb/Yf
        7xr80MelHw4Qj1hMHU++gbQpMQ==
X-Google-Smtp-Source: AA0mqf7O1kfKyS40WvCXZ5qP0whrae0q/ADSqdPFztRYqjWzf84q+mVXRSyTkyHNMe3Z5V7ql3NnDA==
X-Received: by 2002:a17:90a:5a4a:b0:200:8a2b:d120 with SMTP id m10-20020a17090a5a4a00b002008a2bd120mr12086138pji.208.1668408679225;
        Sun, 13 Nov 2022 22:51:19 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id c27-20020a631c5b000000b0046ec7beb53esm5209030pgm.8.2022.11.13.22.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 22:51:18 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:21:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] cpufreq: apple-soc: Add new driver to control
 Apple SoC CPU P-states
Message-ID: <20221114065116.zs67pkbhhgfoze52@vireshk-i7>
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-5-marcan@marcan.st>
 <20221102061819.dyl5ah6qffntqieh@vireshk-i7>
 <c3b88bae-f6da-4242-0b19-5e2a32b9c266@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b88bae-f6da-4242-0b19-5e2a32b9c266@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-11-22, 21:36, Hector Martin wrote:
> On 02/11/2022 15.18, Viresh Kumar wrote:
> >> +	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> > 
> > Why do you need this ? The OPP core should be able to find this
> > information by itself in your case AFAIU. The OPP core will refer
> > "operating-points-v2 = <&pcluster_opp>" and find that the cores are
> > related.
> 
> We have multiple clusters sharing an OPP table (e.g. the M1 Ultra has 2
> e-cluster and 4 p-clusters, and duplicating OPP tables seems very
> silly), so this is necessary to tell it about the subset of cores
> sharing a table that are actually one domain.

The cluster sharing information is already part of the OPP tables, "opp-shared"
property. Platforms like scpi needed this because they didn't have the OPP table
in DT and so no way to find out the relation of the CPUs.

See how drivers/cpufreq/mediatek-cpufreq.c has done this.
dev_pm_opp_of_get_sharing_cpus() followed by dev_pm_opp_of_cpumask_add_table().

-- 
viresh
