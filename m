Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3DA5ED182
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiI1AQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiI1AQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:16:35 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331E9F5097;
        Tue, 27 Sep 2022 17:16:31 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so7292996otu.7;
        Tue, 27 Sep 2022 17:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1mCp/Ns0Hn89bqrz261N9ygEfbNFKh9BUfOIu5Gor8k=;
        b=G8vOnydUnV1SOh17PEhNEE6EoYfSplhFg9bCEmvf+YLfNnP8QRcTJooD8oCKdWBLeC
         Um1XcFtDp3PeH/Tes7VkxCucslDGJP72b8Ko7DNWzhLu4fUvbCNwz+EZaBDeUUeiwcVF
         CQxyiMXSYhtYSCLJDDnkqTp8vMavLwsQnKekRw02kSvhiKZ8eTXls5BmdC5JyngTGV9Z
         3I7Wqrbh6KwuV7nICHfHLvLPLy2c6+qma7NbcJnkvRobqwxLXJy+KB6b0vLd03Eh4BzW
         Vok8y4cE/LYhpKM592L5zaEEpG1YwpglHLpbDKU2Icx0QGr2vngrREXPB13so9jc12oc
         jPWA==
X-Gm-Message-State: ACrzQf0qtZqUEfPJBZFJpLllzXhrx67CqS8BdY2nC4sKjdEUmfPI+Zmd
        WqZCwvPC3mxxSLXGI+lbEPaRvq/b2g==
X-Google-Smtp-Source: AMsMyM6w2ghHHtmpR6oBsbI/bXYCIf4KieHoWK4xIPPM3hNVnKPgIA2PMx9NIXuGAwtKUX92YxWocQ==
X-Received: by 2002:a05:6830:1083:b0:65b:ca18:f1c1 with SMTP id y3-20020a056830108300b0065bca18f1c1mr13614220oto.314.1664324191217;
        Tue, 27 Sep 2022 17:16:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bp8-20020a056808238800b003502783c454sm1263748oib.0.2022.09.27.17.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:16:30 -0700 (PDT)
Received: (nullmailer pid 2657759 invoked by uid 1000);
        Wed, 28 Sep 2022 00:16:29 -0000
Date:   Tue, 27 Sep 2022 19:16:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-gpio@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v3 09/34] dt-bindings: pinctrl: qcom,ipq6018: correct
 BLSP6->BLSP0 functions
Message-ID: <20220928001629.GA2657664-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-10-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:37 +0200, Krzysztof Kozlowski wrote:
> The pin controller driver has BLSP functions from 0 to 5, not 1 to 6.
> Add missing blsp0_i2c, blsp0_spi (already used in ipq6018-cp01-c1) and
> blsp0_uart.  Drop blsp6_i2c and blsp6_spi.
> 
> This fixes dtbs_check warning:
> 
>   ipq6018-cp01-c1.dtb: pinctrl@1000000: spi-0-state: 'oneOf' conditional failed, one must be fixed:
>     'bias-pull-down', 'drive-strength', 'function', 'pins' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
>     'blsp0_spi' is not one of ['adsp_ext', 'alsp_int', .....
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. New patch
> ---
>  .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml   | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
