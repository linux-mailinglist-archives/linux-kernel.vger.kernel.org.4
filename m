Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A9463CBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiK2XbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiK2Xaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:30:46 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E341A73429;
        Tue, 29 Nov 2022 15:30:18 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id r21so538863oie.13;
        Tue, 29 Nov 2022 15:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Cubshc49cfUySOoKGcznuCahjy85fYWeWeknC7r/cQ=;
        b=gTzGkCuXDNRcvqNtNu4rtS1pA8sovt9iMth3YA1l5JOkzJXQPrxu5UWBzVPYh7+7LI
         T+OQjI1ZyFQhMvhBejag5TwczQ6cbjb56IU2RnKn8vum1QbXT7DJPqqRRP8tU7THqBy4
         HPbPc2hETnfC3/qmS4N2ZAEWOCGApTE3583VmgF0vESpqakG+noSu+9OYHG1U8XoVSGo
         VqB3d9hHh4fU6OlSQiKFuA04fsIvkKRDjF7rJ7vbTAn4g6dWaKhRS38fnn9BIiAmt6Zq
         uz2fyCP0D7CqMhjLUev6NQnUWHe6WpAfsVecQ5uGcmUDs7bGZG52oBnhXWxFmVQ6hMIb
         A7rw==
X-Gm-Message-State: ANoB5pn5dtn8DhyZcxS/5bbhhgaJcUBm8fgomrYCYFgqwPKk76HIzqNS
        Poxhi2+nsI9V2kYpUSp4pQ==
X-Google-Smtp-Source: AA0mqf7NpqAOHvnw7gsjMPErdhx488BE0DOOs4rFZ+Q1ilWNL8hQUZr7D7iE4DKBVfw712+L/ukaiw==
X-Received: by 2002:aca:3dc5:0:b0:359:a845:76bf with SMTP id k188-20020aca3dc5000000b00359a84576bfmr20031267oia.22.1669764618136;
        Tue, 29 Nov 2022 15:30:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m22-20020a056870059600b0013c8ae74a14sm25463oap.42.2022.11.29.15.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 15:30:17 -0800 (PST)
Received: (nullmailer pid 494706 invoked by uid 1000);
        Tue, 29 Nov 2022 23:30:16 -0000
Date:   Tue, 29 Nov 2022 17:30:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-pm@vger.kernel.org, asahi@lists.linux.dev,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Message-ID: <166976452497.492619.4657547716318967067.robh@kernel.org>
References: <20221128142912.16022-1-marcan@marcan.st>
 <20221128142912.16022-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128142912.16022-3-marcan@marcan.st>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Nov 2022 23:29:10 +0900, Hector Martin wrote:
> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
> The hardware has an independent controller per CPU cluster, and we
> represent them as unique nodes in order to accurately describe the
> hardware. The driver is responsible for binding them as a single cpufreq
> device (in the Linux cpufreq model).
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../cpufreq/apple,cluster-cpufreq.yaml        | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml

In case there's any doubt:

Reviewed-by: Rob Herring <robh@kernel.org>
