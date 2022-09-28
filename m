Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DA55ED1E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiI1AXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiI1AXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:23:18 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745AE1B85FA;
        Tue, 27 Sep 2022 17:23:02 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id z18-20020a9d65d2000000b0065c3705f7beso3082448oth.9;
        Tue, 27 Sep 2022 17:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zFCpb2WJrpA5yRX+qQa9aTdLwVqkhCPZMDJOgHlUGQc=;
        b=af48PEbEYTVvBrTWbD/V4ATwuiWd2QXxN04cGmbxZIcjcDia2+4TCmjyxFVWg/Gs59
         2zMM0T8bez2r1i6fnI3zSLm/CKs9XQvuW0PFGq/982ZQau3R/VX00TI4U3g3GTpyGFMS
         ZeXBbT92zJcQI6vUX6qe5n2uDT20PsCfhsdPHwJB3uSeqr5DYHsqA2xHFkt5rm8zxmjt
         FAU+wtrdiB+SCdQFrBWSpYJfe3n7VZcwBQiVXUJaBXUtEP7jT2vpn0d/olkhoTa/kHZz
         2nbHlucCrZXwfXjcE3for+5Kwc8NC4TMPe1kOQC6B47VOxpwMNofWzz+4GjFByKrJZEr
         X1nw==
X-Gm-Message-State: ACrzQf005REgVLiIcbqcLYqEP+i3Qa4pgBCimlwBsZX2tFc/+GJeZkxR
        w0ws+tPd4ynYkCBbQTdnchfLy9xiOA==
X-Google-Smtp-Source: AMsMyM4uNlpJ7+WbcD2uux1DH1rHiM9rBOA6wQ/8Cu+Q7bYvhuj1i3cCPTthV+zhygUn941MhxHXEw==
X-Received: by 2002:a9d:7450:0:b0:655:f664:93ee with SMTP id p16-20020a9d7450000000b00655f66493eemr13295860otk.231.1664324581672;
        Tue, 27 Sep 2022 17:23:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k187-20020aca3dc4000000b003504805a618sm1208876oia.45.2022.09.27.17.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:23:01 -0700 (PDT)
Received: (nullmailer pid 2700961 invoked by uid 1000);
        Wed, 28 Sep 2022 00:23:00 -0000
Date:   Tue, 27 Sep 2022 19:23:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 30/34] dt-bindings: pinctrl: qcom,sdx55: fix
 indentation in example
Message-ID: <20220928002300.GA2700886-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-31-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-31-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:58 +0200, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  | 34 +++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
