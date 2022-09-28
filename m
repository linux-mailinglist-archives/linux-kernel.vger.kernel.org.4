Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0F45ED187
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiI1AQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiI1AQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:16:52 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46647F9619;
        Tue, 27 Sep 2022 17:16:49 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11e9a7135easo15400355fac.6;
        Tue, 27 Sep 2022 17:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XWnEd41NsTeo1rj2n2iP2REZsRO1COSEZMaFf6nsPDw=;
        b=BLCbCm39eCN1VcnLsnq1UFisJG7UUe3AxWxtBFSaiXNzwteaYqW75cggfp8eOx0uHi
         NbfMLC/Nrr4vyo8PgvpS5F9FpI6v24ZkbsZx1VrI/NFxezMEVsPPuD+P8XBK8Zf9zfp+
         bZJCrztNEIystOhEWTulmYCEfNsPyNcXDZKtt4cKckjKkzm0lGjt0TXGVEmrqiRzpOQf
         Rii/4SU0VOMEM+Pgrv5msD6QVVy/cTg7MPYENc8gKvo7Ye/+W6Fpxpk5ugsQ1LsTLTUM
         PGbC5CfBQCP+1zEiDdsfugDUlNl9++wIFUdtPUX7KeBTXrwu74HWY6J2xWgKo9vP8auA
         owXw==
X-Gm-Message-State: ACrzQf2LdCDXXoVHrLPRTlpqBuCONZj8Xyga4629Wikrpa0KI/Nn54Q6
        Xco2VeBXu0omZxBEYXY4PQ==
X-Google-Smtp-Source: AMsMyM45ZXTxfXJpkWACwu9kE8A13iloAm1rZ69W5mAVuFtRRWfTU/XSIhUAscFPWClVmk0PgrB44g==
X-Received: by 2002:a05:6870:350a:b0:12d:91cd:cd50 with SMTP id k10-20020a056870350a00b0012d91cdcd50mr3968261oah.249.1664324209033;
        Tue, 27 Sep 2022 17:16:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b9-20020a9d5d09000000b006394136eae0sm1343320oti.57.2022.09.27.17.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:16:48 -0700 (PDT)
Received: (nullmailer pid 2659384 invoked by uid 1000);
        Wed, 28 Sep 2022 00:16:47 -0000
Date:   Tue, 27 Sep 2022 19:16:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 10/34] dt-bindings: pinctrl: qcom,ipq6018: increase
 number of pins in pinmux
Message-ID: <20220928001647.GA2659328-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-11-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:38 +0200, Krzysztof Kozlowski wrote:
> One pinxmux node can have more than 4 pins to configure:
> 
>   ['gpio1', 'gpio3', 'gpio4', 'gpio5', 'gpio6', 'gpio7', 'gpio8', 'gpio10', 'gpio11', 'gpio12', 'gpio13', 'gpio14', 'gpio15', 'gpio17'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
