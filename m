Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7605ED1BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiI1AVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiI1AVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:21:02 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449F10AB3B;
        Tue, 27 Sep 2022 17:21:00 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1319573379eso2562281fac.0;
        Tue, 27 Sep 2022 17:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zWXIIgX0B71nDqgAu7Wm0OvyS5OfsJfgyZ+1oWd116g=;
        b=Z4cpFYwSekPG4+bv5+yvhD2qwOdXhY5bZPz1nvmmandj+JLpW3F38JnwX++5B6twmA
         uyrQhPU4H/S8EyvAuYm9JlWj9VGsKEw56hgDvQ7R3DuAvuca5lBkR/sFFEwi7odRG0p6
         Y2VDC1ZXoNwquH2Q6ID94kLfZAm8ZNsQqDMfI4AKGaAzyNy7aHnj9tkrf/YUPoCgGqa5
         6/IchFps7CApyzmyqgYL3+xnBJNMpXnleEjMJ2S84Tbty+eg+GNxng2TFxkH/7ylvDm6
         sVT/3vFlmBY3I6cjjmT7CXDJAVDrz8cUq7gf9YJbpV6XP1L7A8dAQ4t6r0Yqssju1f+t
         DWIQ==
X-Gm-Message-State: ACrzQf1/gwbD86ldJRYWg3C7Z3wYVCpuTadNHicF2oqTan3z8SSrvYfs
        EO4ct0zbB+emACD/xZa/+Q==
X-Google-Smtp-Source: AMsMyM74Uup6JCWzKAhoGNL1IKlQJCDS5jC94A8A5MxgAO/kdqr6L7W6hk8QJxB+ahua9oGYWIa9zg==
X-Received: by 2002:a05:6870:33aa:b0:131:6112:69eb with SMTP id w42-20020a05687033aa00b00131611269ebmr3999969oae.74.1664324459301;
        Tue, 27 Sep 2022 17:20:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z20-20020a05687041d400b00127ebb410a4sm1733703oac.11.2022.09.27.17.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:20:58 -0700 (PDT)
Received: (nullmailer pid 2686070 invoked by uid 1000);
        Wed, 28 Sep 2022 00:20:57 -0000
Date:   Tue, 27 Sep 2022 19:20:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 23/34] dt-bindings: pinctrl: qcom,msm8953: fix
 indentation in example
Message-ID: <20220928002057.GA2685991-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-24-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-24-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:51 +0200, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../pinctrl/qcom,msm8953-pinctrl.yaml         | 34 +++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
