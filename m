Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A736C6BDBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCPWjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCPWjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:39:36 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95889E2752;
        Thu, 16 Mar 2023 15:39:30 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id bp11so1845961ilb.3;
        Thu, 16 Mar 2023 15:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5aXNvYe6Lfz7Jma92mTBnkBP/+jaJ3wVWecQeVYXIU=;
        b=LMe8+8ZmrdDDPhkUqNLITuZM7BDVPgulc06mPsDdgrRRHoxKcEVhAaJ1H1PwmuGCzx
         jGvqI6bspPLzgUtNEbBvPGGT4S0J/xtEJX/aTQ5YNSWr+VQQblcXTjXjQweQylr8ZDkq
         crvkOs6nRdWZi+MF6iEfJXykADolLFPe4pXztfaJpcis/H4zLkxXSCTJUnMTp7bcvY5S
         szQ9FkvQIzKciTyzplDj+d6qfHeYGVI6NAdQuY87CGDHEhP+y9o+6VL9nx/zxI1hn+SR
         QJn+hYZkObfGNRlAOWCFcc6UvODCZGzhgPgmqqX/+jXTAWrw7sVt8Y1dZ3tayQEzEDzd
         I+aw==
X-Gm-Message-State: AO0yUKX43xfgw/LsgPkeWAQeTuI0xgttnd93rMRwdocOZxJPb8Cmmsn8
        d++YDlX6/CgTFeUapcsJ9JFZkgivag==
X-Google-Smtp-Source: AK7set+A/04zgI5D+zpxUlN/NfcVLC8GIHlfnsQO+c99XrBbxJDpsc0FckFElMYYuiR9klu8iCu18Q==
X-Received: by 2002:a92:c9c5:0:b0:323:bce:f23f with SMTP id k5-20020a92c9c5000000b003230bcef23fmr8095568ilq.3.1679006369431;
        Thu, 16 Mar 2023 15:39:29 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id t23-20020a02b197000000b003c4ec576030sm173777jah.4.2023.03.16.15.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:39:29 -0700 (PDT)
Received: (nullmailer pid 4017617 invoked by uid 1000);
        Thu, 16 Mar 2023 22:39:28 -0000
Date:   Thu, 16 Mar 2023 17:39:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCM2290
Message-ID: <167900636751.4017563.6443660096958377320.robh@kernel.org>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
 <20230308-topic-cpufreq_bindings-v1-3-3368473ec52d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-3-3368473ec52d@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Mar 2023 02:27:00 +0100, Konrad Dybcio wrote:
> Document the OSM CPUFREQ_HW present on QCM2290, featuring just one
> lonely frequency domain.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

