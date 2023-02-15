Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70656985FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBOUrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjBOUqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:46:37 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C27742BE8;
        Wed, 15 Feb 2023 12:46:19 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-16a7f5b6882so192900fac.10;
        Wed, 15 Feb 2023 12:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRSeJHy2SyPDaHEW/c54mDyRYYoKFp26R/Pea6LkzEc=;
        b=xWMdioFYxB3OCmQinRmYb8EK/rsXkuou0mrA28li8TU0E7T1mPWP5P33goVtX/QO5n
         BLCSC/VI2PGJNaD7X0NjHHANZQj2BGKJZ0/JDSwE6PTX+qOWmygM8T/SrE4STAj96EpH
         4yjuIO/S7YgvE9TcaHsBtqRLDAmbi40pLwXHUBVcsV+vlD/q8g1QVLaZZD6hSOitjzFg
         nhGbI4NkDfbOVc357vqn1GL+hqRhigdXGkmub7jKc4iHaEwqtfdRFk+wH6efRHx2UNrS
         HFhpLYx4OfY8FNCt39C88codfiBSYsgJgNLu/xSfGAtIMk6uqDWcQfLnTt+sEFYCCJNX
         Df0w==
X-Gm-Message-State: AO0yUKWE2yInLXlZ1l2bZD9xH0n78KGP6AQ4rz7KBguzDg7buPvzUZ1H
        /FnAuFUCBwIsKgsKmeDyvg==
X-Google-Smtp-Source: AK7set9Qx/gWbtf7g0aqU3LEWnLSu3VeF6+00UZ95YNE+jQ7rAp4apcpfYgMAuHmUQO0WUzv4gkNMA==
X-Received: by 2002:a05:6870:7392:b0:16d:db03:9efa with SMTP id z18-20020a056870739200b0016ddb039efamr1820371oam.28.1676493974619;
        Wed, 15 Feb 2023 12:46:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870c34300b0016dc6d38b16sm5623730oak.23.2023.02.15.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 12:46:14 -0800 (PST)
Received: (nullmailer pid 525019 invoked by uid 1000);
        Wed, 15 Feb 2023 20:46:13 -0000
Date:   Wed, 15 Feb 2023 14:46:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        asahi@lists.linux.dev, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm-pmu: Add PMU compatible strings for
 Apple M2 cores
Message-ID: <167649397316.524961.8297827132612365519.robh@kernel.org>
References: <20230214-apple_m2_pmu-v1-0-9c9213ab9b63@jannau.net>
 <20230214-apple_m2_pmu-v1-1-9c9213ab9b63@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214-apple_m2_pmu-v1-1-9c9213ab9b63@jannau.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Feb 2023 11:38:01 +0100, Janne Grunau wrote:
> The PMUs on the Apple M2 cores avalanche and blizzard CPU are compatible
> with M1 ones. As on M1 we don't know exactly what the counters count so
> use a distinct compatible for each micro-architecture.
> Apple's PMU counter description omits a counter for M2 so there
> is some variation on the interpretation of the counters.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/pmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

