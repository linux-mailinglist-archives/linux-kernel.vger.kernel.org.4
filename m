Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC85EB545
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiIZXPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiIZXPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:15:14 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2623B7EC;
        Mon, 26 Sep 2022 16:15:13 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so595271oon.10;
        Mon, 26 Sep 2022 16:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=n8O0YjEU4HDPBOcVvXlbpih9Rq3SK8hlWVthARh5M4c=;
        b=DR6pT/8JEmpsIh7jCabu5bmtMxHBMfAqOhTX60u9I3lVUL/1xqk2CN96JXcO6XypPa
         XjY/OcpD2OQBko3yuW4NlEaBqxpwHttTsbU3xASUEgeQ1vAgoVo+RqY5u2PwLCNIykrE
         No1oStSmX2Hnjx49cYjGfC57VtxwGjWZ6w2HJpmk7mZRcwL1UJbIcS5lhk2TgUiCV1J6
         mhuPMWaPFq3UH/Po1gV7LjLEv8s30JuEyTocFBY9IB71X16ysiVIGw8BJ4wcAKAIc9gH
         hUacOeyyyZZvShhKFXg/4t1u5ERxs11XlXsKeGB9g0z0ycngVTnc78UC+IpTC0bxBZnj
         rwPw==
X-Gm-Message-State: ACrzQf0R2S0ZxkzOUdoK9J5Ctv3GDw3yTi/gAv20abfErstN/23sfMZ7
        7rqa14yGN1l23qYVVClCOAxziwBlKA==
X-Google-Smtp-Source: AMsMyM67LcJCGCvPGElxB6A93x4g5cfRBX94HUkr1PCqvvR9aEjzc4fHr0cBbzmdf8nqW030brrz2A==
X-Received: by 2002:a4a:e750:0:b0:476:8300:a732 with SMTP id n16-20020a4ae750000000b004768300a732mr108996oov.52.1664234112790;
        Mon, 26 Sep 2022 16:15:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u17-20020a056870f29100b0011d02a3fa63sm9763851oap.14.2022.09.26.16.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:15:12 -0700 (PDT)
Received: (nullmailer pid 3150812 invoked by uid 1000);
        Mon, 26 Sep 2022 23:15:11 -0000
Date:   Mon, 26 Sep 2022 18:15:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH 25/32] dt-bindings: pinctrl: qcom,qcm2290: do not require
 function on non-GPIOs
Message-ID: <20220926231511.GA3150783-robh@kernel.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
 <20220924080459.13084-26-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924080459.13084-26-krzysztof.kozlowski@linaro.org>
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

On Sat, 24 Sep 2022 10:04:52 +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml        | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
