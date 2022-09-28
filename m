Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37BB5ED1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiI1AXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiI1AXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:23:23 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8D1110B12;
        Tue, 27 Sep 2022 17:23:14 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so1047741oon.10;
        Tue, 27 Sep 2022 17:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=p9c+t+v2wMcsnSDU2Mm+zMU9uCqz2qHCyjklNxUR/og=;
        b=BblLbSPIG0USL7QczNhzdZEhIBR1VjyNDK8UdsE4Z86slMWVJQicUsXalbD++NMZV6
         eXI5YDbxEDqFRc5Kbw7GJnXx3/3YSm/QrN/IBf3o9T/8eEW7sl79qpVW90gAar1/Bo7c
         Y0oesGoWTZy3g79tpbKbgyuErb3WGsT060eiX9aYLDfPWdlxNQU2mQO/3a+0ttA/YhQg
         Vuj3DEFdhgLg39hRNTiM7b4D74tSUTk7nt8NbDjTItH8bZYMpFOVAYiSnKLDCWwUNiYF
         nkuc4+KSEXto8Rg+2qSAtJAtuB3++Z0TLpdM4PF9OHd4O4EpKfCyhlrp9SzvQ67uUYsa
         0asA==
X-Gm-Message-State: ACrzQf04QzP02z3OYC7tMaDiCsKc2Ygoi6ClJ/FS4qX/Acyki46WcXwt
        XySSHIiccFwdjRYgAd8tSBCcv8aOOQ==
X-Google-Smtp-Source: AMsMyM7DE00GnmEqzPu2IHOn+X10Xu6DhptXmXdged9pEzepocDXpgSkwEDv4HIPzYVyaMuSrIAhOg==
X-Received: by 2002:a4a:8e81:0:b0:475:811f:3f9e with SMTP id p1-20020a4a8e81000000b00475811f3f9emr11801093ook.35.1664324593283;
        Tue, 27 Sep 2022 17:23:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w4-20020a9d70c4000000b00659f659a5acsm1425431otj.27.2022.09.27.17.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:23:12 -0700 (PDT)
Received: (nullmailer pid 2702033 invoked by uid 1000);
        Wed, 28 Sep 2022 00:23:12 -0000
Date:   Tue, 27 Sep 2022 19:23:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        krishna Lanka <quic_vamslank@quicinc.com>
Subject: Re: [PATCH v3 31/34] dt-bindings: pinctrl: qcom,sdx65: fix matching
 pin config
Message-ID: <20220928002312.GA2701950-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-32-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-32-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:59 +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml   | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
