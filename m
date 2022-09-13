Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C345B75C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiIMPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiIMPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:54:36 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFC072EC1;
        Tue, 13 Sep 2022 07:55:15 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id c39-20020a05683034a700b006540d515722so8257563otu.5;
        Tue, 13 Sep 2022 07:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TSHBRN52piGzyQ2SeaWNnzbJL+eY7oEAdsKsIXmbyJg=;
        b=NMlsCXEbK3+Atlwjro1LUQG391TfvpI4V2lGAMsm/aoJhrRdiKOC1jyWb8Q6sOBgSk
         iEJZxBmGX5sdfivzdiZCMBWzS05+DVNF1b9uFEInEyxeGb2f3JpTY7FZw9t92yLr8gap
         t/J/P8KdexP6tjF1T5N4Xk4MLxqRDqyDo2PZvbkHVwPR9fntoUrbT1e/9eM8g4fUNxCh
         0L6WGsAjKhCkTxt1DqH15QW0oKJYt7Il1w0SEPop47RTfAq75lW/uADgIOPbyMwnbrKD
         wDS3csQbU3gSHkI2RVz0h3RtozDFpDRv61dB2MKWvw+0SICXyXzKeICAByf/fmGv34U2
         7oWw==
X-Gm-Message-State: ACgBeo1M/auoP6KWNyszrBFzsJ3Fx4C37Obk21Q/nPRdjL0lyvHPC7gE
        YP8NDrAPyfb4e7ThLoRy+g==
X-Google-Smtp-Source: AA6agR7b4fCRQV9hAml+0stAXwKyzxgcbUAhzdygqeuyuDl9wz2tq2vdl0oglzsbrDq7JrL4VSC1xg==
X-Received: by 2002:a05:6830:20cf:b0:655:d9fd:39f9 with SMTP id z15-20020a05683020cf00b00655d9fd39f9mr4700196otq.95.1663080827006;
        Tue, 13 Sep 2022 07:53:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y16-20020a9d6350000000b0065689e13f52sm592525otk.71.2022.09.13.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:53:46 -0700 (PDT)
Received: (nullmailer pid 3658100 invoked by uid 1000);
        Tue, 13 Sep 2022 14:53:45 -0000
Date:   Tue, 13 Sep 2022 09:53:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 13/15] ASoC: dt-bindings: qcom,q6dsp-lpass-clocks:
 cleanup example
Message-ID: <20220913145345.GA3658055-robh@kernel.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
 <20220910091428.50418-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910091428.50418-14-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2022 11:14:26 +0200, Krzysztof Kozlowski wrote:
> Cleanup the example DTS by adding APR and service compatibles, adding
> typical properties, using proper device node names for services and
> fixing indentation to 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add few more properties.
> 2. Adjust indentation (better).
> ---
>  .../sound/qcom,q6dsp-lpass-clocks.yaml        | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
