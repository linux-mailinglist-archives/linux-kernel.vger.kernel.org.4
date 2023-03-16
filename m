Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40336BDBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCPWjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCPWjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:39:17 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1C161BD;
        Thu, 16 Mar 2023 15:39:16 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id j6so1838514ilr.7;
        Thu, 16 Mar 2023 15:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsqFVnYnC4mqzM1Vj6ZPQS8VvQDQokC4dCTIjGVEgkc=;
        b=LQcKeYtGC4ag9oCB9eSy29f14FwTnrfx4LdofX9rubpnZAEJhy5GgSgJBI8hhRtD+e
         WG6m6wlyPbDSa8inthiKBDTbVObk6emMf4j0vXRuPf75CaJmY/kXqBJb3m+AOM5GqFc+
         G6VEKMHZAr+MiZF0DbffUC0X1SyM7EhqhE8ws58i868RZ880Ve/4vGX6SSnktUw59id4
         b1fT0xAyCtVomZxZSa5HEp01+UHpDTSTVI2cgAEWHY/A579QEgKlTd78SE2tjOLv8dgH
         lKliua+4fNxBkW00FkBtjYn+EuOkDRrtzrBTsosGkL5rshyrANkSc+DgWENCRfgQJMaI
         QXwA==
X-Gm-Message-State: AO0yUKU+hrFN2Au2arLYhHvn9vpD/w8rD3bmMBeswicgvLlwIusNxnm2
        DzPvxe9m/ONR+oxwvFvxlg==
X-Google-Smtp-Source: AK7set+QNZ61mtQSQlbypIFSrdLZiNdCGs7y+c4e2r3DjnaAbvGRMfI7cuH+uinYNLT3SE8fRJ5RCQ==
X-Received: by 2002:a05:6e02:60e:b0:318:aa8a:6455 with SMTP id t14-20020a056e02060e00b00318aa8a6455mr8036446ils.19.1679006355347;
        Thu, 16 Mar 2023 15:39:15 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id n24-20020a02a918000000b004050d92f6d4sm164216jam.50.2023.03.16.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:39:15 -0700 (PDT)
Received: (nullmailer pid 4017235 invoked by uid 1000);
        Thu, 16 Mar 2023 22:39:13 -0000
Date:   Thu, 16 Mar 2023 17:39:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: cpufreq: cpufreq-qcom-hw: Sanitize data
 per compatible
Message-ID: <167900635326.4017174.10935191728003512769.robh@kernel.org>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
 <20230308-topic-cpufreq_bindings-v1-2-3368473ec52d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-2-3368473ec52d@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Mar 2023 02:26:59 +0100, Konrad Dybcio wrote:
> Introduce per-SoC compatibles for OSM targets (read: pre-sm8250) and
> sanitize the number of interrupt{s,-names} and reg/-names per-compatible.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 90 +++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

