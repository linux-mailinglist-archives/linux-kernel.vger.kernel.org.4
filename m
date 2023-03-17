Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B096BEE71
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCQQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCQQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:36:47 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E25311F0;
        Fri, 17 Mar 2023 09:36:45 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id h5so3021293ile.13;
        Fri, 17 Mar 2023 09:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nufLuwGvdiUyDvvGkb0YtX3z4IoJj7qYWEEj7Lhk4/0=;
        b=Jz7DfB5lCakMu/vWGBxWoIF+Cx8jAMyqO2rsTOYMofVdWLsW3E7nVTkINh3dwzjIAQ
         I6mRVw5ci0/BDZ01QsAie47orKNYThXdAHqjycLKAvLO5jdWSVTycehHY+cscKeuOR/1
         T8yheEyP9tWKyxLEN6y1xwvdhbCtXaDyTyFHK1kCLNJDZ3naKGvUUwoBp8NdBYTTtq0r
         ogsQWLGDQrUI5s8E5DorNqJ2XcI5PecIkB1a4CD4O1tUsPHzjfMK54l9cFBvefx/4O/6
         UEtAh92tXF2SunlQoSDc8inb8tq6nK4V//vlU9OlKbY/5SXGMT4tJsAEIKN/Fef4J7Ka
         tcqg==
X-Gm-Message-State: AO0yUKUgrFKvAe6TooxB5mgKlgiS+Q3G7ppoxMQEaqjWIpuSZGE9WgnP
        /yoWEBDmUDTXk1z7W4S5fA==
X-Google-Smtp-Source: AK7set+C73BEjFyJsEEz8nRV9C+T5b6VcQtTPPbLP66JDGWb8pLc3RlbdJa2L6hMJERbNx0VByvitw==
X-Received: by 2002:a92:cf0c:0:b0:322:fa92:7d60 with SMTP id c12-20020a92cf0c000000b00322fa927d60mr96697ilo.0.1679071004280;
        Fri, 17 Mar 2023 09:36:44 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id x10-20020a92300a000000b0030c0dce44b1sm722517ile.15.2023.03.17.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:36:43 -0700 (PDT)
Received: (nullmailer pid 2437985 invoked by uid 1000);
        Fri, 17 Mar 2023 16:36:41 -0000
Date:   Fri, 17 Mar 2023 11:36:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/9] ASoC: dt-bindings: qcom,lpass-rx-macro: narrow
 clocks per variants
Message-ID: <167907100109.2437918.10749959884384918069.robh@kernel.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 08:54:37 +0100, Krzysztof Kozlowski wrote:
> Currently the Qualcomm RX macro codec binding allows two different clock
> setups - with (for ADSP) and without macro/dcodec entries (for ADSP
> bypassed).  With more devices coming soon, this will keep growing, thus
> rework the clocks/clock-names to be specific for each binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-rx-macro.yaml   | 58 ++++++++++++++-----
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

