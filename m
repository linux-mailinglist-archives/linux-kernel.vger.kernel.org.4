Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7517073ECE2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjFZV2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjFZV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:28:09 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F14BD;
        Mon, 26 Jun 2023 14:28:02 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-345ad94db0aso4943795ab.1;
        Mon, 26 Jun 2023 14:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687814882; x=1690406882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zK2Mav2vb8JF0Fy3zgYjfX71+8hxBKQuHXPFvrmmGM=;
        b=Hd+BH7wAj6/Qkt/W3FH1UPfkVqI143iLcftpY7immNTRg768tmP3aFl/O7YkfUjAFF
         PmXksPtm2klYIVPl/WW2awOkkbrZSpxSSxwqvdu7PBTtpswlSoM77nS9B3HsJhI0u/GV
         td8t8e3+dyjTBEGV2tTO0zs3ZDjWIC3j3yeH12b1sZmJ7zBoh1DCVWuAx+zoklMXpSYU
         wftz839YEmaQZ7VMQ4nznCwd3LihFMEmtkB0MEp5drLJGAQZ3ey4a8zbhkvRnr+OtOR8
         wlElwNRS8FQJFRwOlFb1jkIAvdpiXXfCAcHfgBhyNWZFGI/+VhPIbnnRMLghg0XkBBjr
         IZqw==
X-Gm-Message-State: AC+VfDz+fuyT/pge2QYIQzUgDXjPu4HYAtnePyXy41J+8GCbeZa7EmmZ
        RNy5/bMDahjHEkI+lfPvmA==
X-Google-Smtp-Source: ACHHUZ7jHnb/zyrVLJqne0rdhbKBqgq5BwI/rrAQp52zF8/hXNAaImKe9kC5laVUV6/ht3rofQVxug==
X-Received: by 2002:a92:c141:0:b0:345:97a9:48bf with SMTP id b1-20020a92c141000000b0034597a948bfmr5117562ilh.26.1687814881973;
        Mon, 26 Jun 2023 14:28:01 -0700 (PDT)
Received: from robh_at_kernel.org ([199.114.228.113])
        by smtp.gmail.com with ESMTPSA id dx1-20020a0566381d0100b00411b4acc990sm2060972jab.7.2023.06.26.14.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 14:28:01 -0700 (PDT)
Received: (nullmailer pid 3928119 invoked by uid 1000);
        Mon, 26 Jun 2023 21:28:00 -0000
Date:   Mon, 26 Jun 2023 15:28:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/7] dt-bindings: remoteproc: qcom,msm8996-mss-pil: Fix
 8996 clocks
Message-ID: <20230626212800.GB3924052-robh@kernel.org>
References: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
 <20230626-topic-bindingsfixups-v1-2-254ae8642e69@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-topic-bindingsfixups-v1-2-254ae8642e69@linaro.org>
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

On Mon, Jun 26, 2023 at 10:00:24PM +0200, Konrad Dybcio wrote:
> Change RPMH to RPM (as RPMh was introduced 2 generations later) and drop
> the prng reference, which made ARRAY_SIZE(clocks) !=
> ARRAY_SIZE(clock-names).
> 
> Fixes: bdea142295ff ("dt-bindings: remoteproc: qcom,q6v5: Move MSM8996 to schema")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml       | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
