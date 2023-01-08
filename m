Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58429661813
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjAHS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAHS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:26:03 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CCB5FEA;
        Sun,  8 Jan 2023 10:26:02 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id i1so374738ilu.8;
        Sun, 08 Jan 2023 10:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCg+GD5M1vImUPrOg+VgHiQBi2pxXwOpq1Xpy3/CfkE=;
        b=NNEQOl6wlFQ8nC5mToUwW6WT25VQDLjToE7TO2JaL9w1BGYMQ+TAkEXlk3/lLUEfoR
         3zof8QkNizwsMJZkqK5FDgb1fAjr4NyJ2ed5PTfMt18LNyoCVd0HAB68T8oUMrkb+XZO
         jAyW5Zv/L+IFR4cde3WBNGvl1XlHkjfZcpmGkUCsMFXj94WwKUiom2ixpN2KaRPtfzlr
         FR/lcIoSKvjDMClglUOx8GhuUOz8/pM3GCsmjvGPe3fOu4wm9/hYVyqjZPW+W6ZTRVi1
         H6ouIWrHGfcjldD5wo9SFRAXv3sBZuqp+BM3D0oVq9zQw8SXAoS/L7bOVFYurjDlXxlg
         GVVA==
X-Gm-Message-State: AFqh2kq2R+5Vh1oei54t1Tog3tgVa8G65tTptYu+JVhd9ibEBUaz3JCW
        LhWdjS6y844ZV1kQ4rFsdnMDbItuGw==
X-Google-Smtp-Source: AMrXdXtE7Z4tcdiSTawac2g0phPiuTAygn9PEfRtwRIGJ8f+rY2aq5U+pgCMsA6AmMnNsLeLnAU56w==
X-Received: by 2002:a92:da4f:0:b0:30c:42d9:22a5 with SMTP id p15-20020a92da4f000000b0030c42d922a5mr19902965ilq.13.1673202361711;
        Sun, 08 Jan 2023 10:26:01 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id y18-20020a027312000000b0039d71c4659dsm2163142jab.20.2023.01.08.10.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:26:01 -0800 (PST)
Received: (nullmailer pid 171671 invoked by uid 1000);
        Sun, 08 Jan 2023 18:25:59 -0000
Date:   Sun, 8 Jan 2023 12:25:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-media@vger.kernel.org,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/8] media: dt-bindings: qcom,sdm845-venus-v2: document
 OPP table
Message-ID: <167320235799.171594.3922598290790850660.robh@kernel.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
 <20221227144102.79391-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227144102.79391-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 15:41:00 +0100, Krzysztof Kozlowski wrote:
> Venus on Qualcomm SDM845 uses Operating Performance Points (in Linux driver).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,sdm845-venus-v2.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
