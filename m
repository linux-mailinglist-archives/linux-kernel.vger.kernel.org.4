Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F873681E86
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjA3W5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjA3W5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:57:41 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8616727D6C;
        Mon, 30 Jan 2023 14:57:40 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-15fe106c7c7so17187595fac.8;
        Mon, 30 Jan 2023 14:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsVWxlkQYCHAIRMaNLAnFZ5h9tURIR8RlLwfOVsH1ro=;
        b=t7A99f6TaoR4kpnsDeswkbwsMm6p+G+K+F2ft66M/6Mtr8QNS+TONW1Iu7yl2zmjrh
         ubx+hKdTF7/6SG90FRetBYgAiKiJNho6OLszfdK1kK+8tEyaVPd8CInK5JGE75pUaWS/
         rnn5AE6LtulckNMUrv8TJKkqiyASbo5sCk8etwTMvnST7M7C7zTJy8cDRVN6F2QxlcZl
         k7/rscWmh9oQjgSz+uP8p2mOpJM+/UZU4Mhh57Q41ppaYCwIQSmp6tey26+Ykp5w/Tw6
         ZDB8yvItnt3fHWbKMepeWfhXbbhNF76y8oT3VfrPV5M6wCxsVjSilKlAIx8Ke509c5sP
         DYHg==
X-Gm-Message-State: AO0yUKXtoyPtzqQHbfo7SlUeNt93UYVgAzlDwjh87MtpYx/m0fkAG3OF
        wSm3I4Eh6ug2a/GLgVCBlQ==
X-Google-Smtp-Source: AK7set8UXW6Q5xKbJK9q9i8EwSLlkVVbTjyGS+GbjCsLlbPmYxm7gaVxfLexzkbJrbDj2ZP0VK7NfQ==
X-Received: by 2002:a05:6870:82a2:b0:15f:2e21:a795 with SMTP id q34-20020a05687082a200b0015f2e21a795mr5059625oae.9.1675119459743;
        Mon, 30 Jan 2023 14:57:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id os13-20020a0568707d0d00b0014fb4bdc746sm5807660oab.8.2023.01.30.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:57:39 -0800 (PST)
Received: (nullmailer pid 3680271 invoked by uid 1000);
        Mon, 30 Jan 2023 22:57:38 -0000
Date:   Mon, 30 Jan 2023 16:57:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, iresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM8550
 compatible
Message-ID: <167511945818.3680212.2462768912519621362.robh@kernel.org>
References: <20230130123046.3229654-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130123046.3229654-1-abel.vesa@linaro.org>
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


On Mon, 30 Jan 2023 14:30:46 +0200, Abel Vesa wrote:
> Add compatible for EPSS CPUFREQ-HW on SM8550.
> Also document the interrupts.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v1 is here:
> https://lore.kernel.org/all/20221116115046.2687244-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * dropped the interrupts related properties as they are already there.
> 
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
