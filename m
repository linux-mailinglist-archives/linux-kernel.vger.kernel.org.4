Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD7743FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjF3QkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjF3QkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:40:06 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2E3A9B;
        Fri, 30 Jun 2023 09:40:05 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3426e9a9c3eso5129945ab.0;
        Fri, 30 Jun 2023 09:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688143205; x=1690735205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeB/bfHSBcU9maXUNIluojjzFlamBE8CEArcolnrob8=;
        b=cuL6ATqx3ESLDwHctSCt9MvRDhzhjjjWHXHpJcbjGskDu2aSjuSSUWfi/DJOYMz1Hw
         2YW5BmgBlQM05tTDoEo9K2ZlX0LrsdkIB0pW+8YWOmHp3MN07HYLCPtB0SMnol4sBjKP
         c4DuTCQKSQLQzBnmNxQ05Xi1CoYpun2qrXwN81QBVl43S5s/FNeANuxujqJMJrNlZ9Ny
         q8vwuIhmiskV4/LkDC9edomdX7ouitOWx4QKzvFVv8VgnAgK0HP1cYa9q6Q+IKFG6RXG
         1QESvNitN9k/B0aHM99CWSQx8Bad0ap6uzDMCgK75eqBaiDN2wDGsI211YHlT0E+QgeR
         Co9g==
X-Gm-Message-State: AC+VfDxpUuXhq2V2cdjs7maiaahwraiV8q5mvcQYxFDNlKKk9d9R+noO
        9HQLyYuCB9IpptXrCBzI8A==
X-Google-Smtp-Source: ACHHUZ4DLZ3IurzatjPxbZeoavj6m0W8wqNX8o02xrmVCC4dlOC415Oo8kXvv2bRAOJgcoQ2rt3L/g==
X-Received: by 2002:a05:6e02:f91:b0:345:ad29:1f84 with SMTP id v17-20020a056e020f9100b00345ad291f84mr5878456ilo.3.1688143204998;
        Fri, 30 Jun 2023 09:40:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z13-20020a056638000d00b0042b1354452csm811726jao.83.2023.06.30.09.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:40:04 -0700 (PDT)
Received: (nullmailer pid 1877025 invoked by uid 1000);
        Fri, 30 Jun 2023 16:40:01 -0000
Date:   Fri, 30 Jun 2023 10:40:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        devicetree@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        freedreno@lists.freedesktop.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/4] dt-bindings: regulator: Describe Qualcomm REFGEN
 regulator
Message-ID: <168814320140.1876966.17866889850041692910.robh@kernel.org>
References: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
 <20230628-topic-refgen-v2-1-6136487c78c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628-topic-refgen-v2-1-6136487c78c5@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2023 22:35:41 +0200, Konrad Dybcio wrote:
> Modern Qualcomm SoCs have a REFGEN (reference voltage generator)
> regulator, providing reference voltage to on-chip IP, like PHYs.
> It's controlled through MMIO and we can toggle it or read its state back.
> 
> Describe it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../regulator/qcom,sdm845-refgen-regulator.yaml    | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

