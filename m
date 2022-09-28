Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1F35ED1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiI1AYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiI1AYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:24:32 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EBA1ED6DC;
        Tue, 27 Sep 2022 17:23:56 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13189cd5789so3654371fac.11;
        Tue, 27 Sep 2022 17:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zMLeoHtdamoqlMw3SAiO+aszjrVM2v+8GP1lZ0YQlSQ=;
        b=o2anF7t8ItbGUhitaaRpyyzyCTdLWz6hnaKgdJuU+wlpU2X/9y3S6x3QwV4EP/fXwy
         Z68vzAKKX7CjDq9vbXngejIxDpVitaJBZTE8pYpJ+Ch4ssqijDXHtEl27DwSpmIQoMti
         EiciaRz4kBz8ys10+Drm68/fRscbdK85t+B1kxA0bvf0RMnGVrOQQMTsSOEme4BNIN2l
         JIcH9qL4Jc0ftNjBF0u/qFpxZ0ogMXrFPvnLiY2XvfN6R/g50w31Zn3QbE3R4wML2RhX
         aZDjJz2ToUzT+mvLOWZVEONGu7qGKdDTKtZteemfU8Aw9NB2tmPhTHyi8pccJxc/bjiR
         wAsA==
X-Gm-Message-State: ACrzQf0WKXZHY+TcuUnSLlpHWuuWhQ2RTFQoTKBCscfblc8/izPUxdrO
        e4H2itkBqWN5RVBeVOH2Dw==
X-Google-Smtp-Source: AMsMyM5nxBDhvS41nzdohFuv11m96EK8tE4quFTzO423gRGAdF9jNBHE3gHgpv+wD0PSdNxnIRiURA==
X-Received: by 2002:a05:6870:4594:b0:127:a9e2:1ab3 with SMTP id y20-20020a056870459400b00127a9e21ab3mr3849789oao.156.1664324634652;
        Tue, 27 Sep 2022 17:23:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i7-20020a4ad087000000b0044afc1ba91asm1185385oor.44.2022.09.27.17.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:23:54 -0700 (PDT)
Received: (nullmailer pid 2707679 invoked by uid 1000);
        Wed, 28 Sep 2022 00:23:53 -0000
Date:   Tue, 27 Sep 2022 19:23:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-gpio@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 33/34] dt-bindings: pinctrl: qcom,sc7280: fix matching
 pin config
Message-ID: <20220928002353.GA2707641-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-34-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-34-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:37:01 +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
