Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946BD5ED1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiI1AUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiI1AUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:20:36 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C600B107DC7;
        Tue, 27 Sep 2022 17:20:33 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id cm7-20020a056830650700b006587fe87d1aso7282833otb.10;
        Tue, 27 Sep 2022 17:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xdx8sOKE++isVD+rpqw6b/vFqNsBykBhWp0yS9EZZRQ=;
        b=fmEFg/u3uSilBR00UiI73PXXx6beBBdFOtJwuptLdOlKZ/4H+2bzk5F/rerIiyz/7p
         e7B6LSYb3lb5xbxSBTavVrCeVyxZNKF//2wub/S/HPBuoCYdQiTPGSIW1JCjFfHZ9vTq
         tXNPitPmO4IqqRw7CVKvYOprbngWE0HRaP5N3k0hbVyW1noulotaKj5T5o9M97GMoMSz
         YQt5W48mZ3K1jZXVKPpcGCeruIL6Ef7Ebr49OCk8DIjCQLZ75WPctizZVCpqvM4jp7/x
         x8DklAJ45lS87aQacM4U/XpDJCcF2o26/JFAl3qXZmiClB3FNHfGeWCD0ZJiDkXQevPl
         EXUg==
X-Gm-Message-State: ACrzQf1NoUMN0aoQU5xA/YuBNUlYp2xf4jdEDjzVlrBDDsBrD5oqYkgX
        6itXbeNn2NmHioz4wOygBfJlxxPYkw==
X-Google-Smtp-Source: AMsMyM4xRCt6U5Wsgu1E1vV2hkoYikrW2K5MwuIHr7NFZTiRqas0fjGDbV+XD5Qyrf3Fc4sTIzPa3g==
X-Received: by 2002:a05:6830:2906:b0:655:d5b5:cb53 with SMTP id z6-20020a056830290600b00655d5b5cb53mr12708515otu.261.1664324432430;
        Tue, 27 Sep 2022 17:20:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a056870d38d00b0012b342d1125sm857436oag.13.2022.09.27.17.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:20:32 -0700 (PDT)
Received: (nullmailer pid 2682978 invoked by uid 1000);
        Wed, 28 Sep 2022 00:20:31 -0000
Date:   Tue, 27 Sep 2022 19:20:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v3 21/34] dt-bindings: pinctrl: qcom,msm8953: fix
 matching pin config
Message-ID: <20220928002031.GA2682891-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-22-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-22-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:49 +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
