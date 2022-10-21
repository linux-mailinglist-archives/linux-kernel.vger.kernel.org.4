Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2E606D41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJUByN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJUByL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:54:11 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D339158181;
        Thu, 20 Oct 2022 18:54:10 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id x188so1694092oig.5;
        Thu, 20 Oct 2022 18:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50G7i/VlfV6g3TEgkiDJrPM7pGNq9cJ5IVshh1NyIl8=;
        b=WlHlbCI3lcnp3an7Ql4RwOkReic9LzDlZksDmuf2qE4yHc3o3boOjht4Ztbq7PqNYv
         rR6+IMg/p6XsomI2ELajlhA4B4kOoh4jM1/F9GSjW2IeJmyrxyerMYTWVnr51a1cQAEv
         tTr5kIqtXYaKjtppN9tdRjn+I71CBo0LrbCLWfygUxKVSFEwqAz6F5lwQGF3zzsT6G6g
         EXs0gbPy3kSh9lJoVSKj/TvVmfY+6Ws8ZT9C2BHO6YSwxOlrhxg1kUDa25V1cc2R0fDE
         rkJ1q9kzJlIO0YarCNc9S0O23lV155Z1BSH+Vn3JnYM9YfNBvCz+RgCepzmM9BPR1BZi
         EWvg==
X-Gm-Message-State: ACrzQf1T0CMr0gnBeNvXmdl21bb+kTwSfxfQH0FD0YuDva1lkv74O3q0
        5gCcX4mZQnHqkICr8V5sIvQs9af2TQ==
X-Google-Smtp-Source: AMsMyM6FYQPGkJtjJ4yIdF1gZq3keLCLJfvptvRw+9kSDjrA4k6PhW7tEtGJYtouyGkJqxwUpbXDdQ==
X-Received: by 2002:a05:6808:ecd:b0:34d:8ab0:912 with SMTP id q13-20020a0568080ecd00b0034d8ab00912mr22293238oiv.89.1666317239605;
        Thu, 20 Oct 2022 18:53:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 33-20020a9d0c24000000b00660d73c8bdesm565568otr.50.2022.10.20.18.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:53:59 -0700 (PDT)
Received: (nullmailer pid 2154135 invoked by uid 1000);
        Fri, 21 Oct 2022 01:54:00 -0000
Date:   Thu, 20 Oct 2022 20:54:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        johan@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq
 clock provider
Message-ID: <166631723974.2154081.10911150649507151378.robh@kernel.org>
References: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
 <20221019135925.366162-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019135925.366162-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 19:29:23 +0530, Manivannan Sadhasivam wrote:
> Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
> to the CPU cores. Document the same in the binding to reflect the actual
> implementation.
> 
> CPUFreq HW will become the clock provider and CPU cores will become the
> clock consumers.
> 
> The clock index for each CPU core is based on the frequency domain index.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
