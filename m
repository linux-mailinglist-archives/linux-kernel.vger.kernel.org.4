Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB76BDBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCPWgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCPWgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:36:45 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE3D5889;
        Thu, 16 Mar 2023 15:36:41 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id w4so1866110ilv.0;
        Thu, 16 Mar 2023 15:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fFaYRaLL3JKuCrCJqmJrBYuEJ3mxHPOfdY+l8rLlnU=;
        b=l2gqCQlWBx9DbQcqvsadnUPjS4KTz1KCq5aopVxYfZsI5VAWEkqnCrpmZaFdbLFSX6
         ZMsh1KOTPNnla21Rt9ziEr/S0KPFfF77oswk9vhAKmpyRv18HAUUdgnGac0yKLAoSwn0
         Taq6D5HBA+t4oBsBmzIe/cuGvMF0rYpH7L1rRwtF5ObN5IiSfvJZwT9BbFoLU8utf6wS
         +M8Q+2I1AMLFe2bc/WSrLLUpA31MO9Zq3Wbw0SjrWRHhRKEG279Utay/EPrq5Y7q5Lp9
         E/Ffq71+saMGskzZ1v147e44NQaQuvwPlSrT4B7ROpHZP/dQ8nYthWopo/87W6PN3jus
         +8ug==
X-Gm-Message-State: AO0yUKW3aU6tfmMDv3EgnrCSxKftmHleHTn/kXsyBa2/Ewzv+s3CJg/s
        FWratF311gO6WIEPCwq/csQq41QySQ==
X-Google-Smtp-Source: AK7set8C2en+GhcRJBIrZyzXlF+P32aLozw/4aeABL0iRCbU+9at4TAmujIm/m3t3N7PhbgSvoow8A==
X-Received: by 2002:a92:4a12:0:b0:323:70c:ba79 with SMTP id m18-20020a924a12000000b00323070cba79mr8576869ilf.12.1679006201157;
        Thu, 16 Mar 2023 15:36:41 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id cl4-20020a0566383d0400b0040639da0a02sm143978jab.135.2023.03.16.15.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:36:40 -0700 (PDT)
Received: (nullmailer pid 4014336 invoked by uid 1000);
        Thu, 16 Mar 2023 22:36:39 -0000
Date:   Thu, 16 Mar 2023 17:36:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: cpufreq: cpufreq-qcom-hw: Allow just 1
 frequency domain
Message-ID: <167900619866.4014261.927825171033177419.robh@kernel.org>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
 <20230308-topic-cpufreq_bindings-v1-1-3368473ec52d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-1-3368473ec52d@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Mar 2023 02:26:58 +0100, Konrad Dybcio wrote:
> Some SoCs implementing CPUFREQ-HW only have a single frequency domain.
> Allow such case.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

