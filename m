Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052CF6BEE80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCQQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCQQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:37:49 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A39EC2;
        Fri, 17 Mar 2023 09:37:47 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id 4so3038190ilz.6;
        Fri, 17 Mar 2023 09:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Tkw3eaII1y3pgHphXAwlzh2YeiwPP3mszw5UTrgdvY=;
        b=B8L9+pb5kltEVNJu2otnNSDNgKYbG42Y8OLTJRXOobZJuNyOQktwq0BqkRQUK3idgV
         zYvJmpTFvU4QE3G8kYtmMqJOGTwRWNzHvSt9wx57Qusny9GgwDyAU0Cqc6V1FNDTMEAx
         V9oDvcieoiEWe6L5bqaiqzkD6NaCXOSbXNY8q7OE/q6tuAB5QunR7wn/HhgGeXwPeJIb
         H+xDtOKH/OlbKc5+hEV46Pv/6H1bU7XvJJNzBj4IIUs3itAIdcM8v6e05fw4sypQV0hk
         H01OP0DtC9Pw4eiE55VCVVGwSEDx7y+Dsnax9Jht/DaogsBeRsA+fBb1B26jR0yVoXF0
         +9dw==
X-Gm-Message-State: AO0yUKV27MvwhXZ8Uite1U1uDtgEbL2/dy66lsjhSGENoZgq9hYMTp7p
        aMASA7m9ldQ11JFw8LzSeQ==
X-Google-Smtp-Source: AK7set+ImpsTlNG013ORftCG4IbkX7jpPoBLc9bfDARkDdM2Om2CplQwBGBj55LNnI5HAJNdL5D3Zg==
X-Received: by 2002:a92:6909:0:b0:323:d3ab:8f3c with SMTP id e9-20020a926909000000b00323d3ab8f3cmr27476ilc.17.1679071066833;
        Fri, 17 Mar 2023 09:37:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r3-20020a02aa03000000b004061d3cce02sm838838jam.67.2023.03.17.09.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:37:46 -0700 (PDT)
Received: (nullmailer pid 2439494 invoked by uid 1000);
        Fri, 17 Mar 2023 16:37:45 -0000
Date:   Fri, 17 Mar 2023 11:37:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 4/9] ASoC: dt-bindings: qcom,lpass-tx-macro: narrow
 clocks per variants
Message-ID: <167907106400.2439419.6123316767501705730.robh@kernel.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
 <20230313075445.17160-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313075445.17160-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 08:54:40 +0100, Krzysztof Kozlowski wrote:
> Currently the Qualcomm TX macro codec binding allows two different clock
> setups - with (for ADSP) and without macro/dcodec entries (for ADSP
> bypassed).  With more devices coming soon, this will keep growing, thus
> rework the clocks/clock-names to be specific for each binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-tx-macro.yaml   | 63 ++++++++++++++-----
>  1 file changed, 46 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

