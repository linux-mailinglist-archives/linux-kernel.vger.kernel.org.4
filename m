Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5350A60D76A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiJYWxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiJYWxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:53:44 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB06A3A93;
        Tue, 25 Oct 2022 15:53:44 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id t4-20020a9d7f84000000b00661c3d864f9so8790076otp.10;
        Tue, 25 Oct 2022 15:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XqqarhGQrvSY3ksT1wW8eAEuSiXyprpezwh4x6/R8Q=;
        b=2SaiPj3yNGLqd9c2lL4T8kVWe06m4Tn1juo8xBxDR9Hmliu88/i3as9qitXIdGftgi
         iTni9YMYJOfjsa1lvJhaac6dd1Y/jMvxi33VLDhQdnGu/ZPLiu/JKZ3hrgSXLrkRDy4q
         pLIz27LmeHqjmiwSv8qSeIGCl1yJXVnEeTn5bqxdcw5NeV3UxWlGeFMWTAxsdGReHUGt
         DJjRFsebKzvdgBpeD6YXYrQdPs4xLfxssMRRdsRYSSs1Mw0p2UtZ3xyJxqZ9l2Ia6j/O
         0+nFvSrPEe84d6emKuX6udYqDm95pbBvvkiZNtOod/u0hG9DeLDwwErs63KvUAFvSviR
         y/Xg==
X-Gm-Message-State: ACrzQf3SKJuAY8Dp7uXKTGbDeoKLcvdzIECuzscnnSLioUqso6W4Thtn
        3DNK3w164ESL2WSzjeg/CA==
X-Google-Smtp-Source: AMsMyM46PL5sWdLU1Da2yyhtJgysr7PoxsTCx9ff5dPxVPbxpkOT68+zG4LnQDCW+OBIcFy1xd2iwQ==
X-Received: by 2002:a9d:61d6:0:b0:661:c1ad:848f with SMTP id h22-20020a9d61d6000000b00661c1ad848fmr20590325otk.111.1666738423326;
        Tue, 25 Oct 2022 15:53:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w110-20020a9d3677000000b0066227572ee3sm1561200otb.52.2022.10.25.15.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:53:42 -0700 (PDT)
Received: (nullmailer pid 3413843 invoked by uid 1000);
        Tue, 25 Oct 2022 22:53:44 -0000
Date:   Tue, 25 Oct 2022 17:53:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8916: convert to
 dtschema
Message-ID: <166673842371.3413786.3565382304303920817.robh@kernel.org>
References: <20221024002356.28261-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024002356.28261-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022 20:23:55 -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8916 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8916-pinctrl.txt | 195 ------------------
>  .../pinctrl/qcom,msm8916-pinctrl.yaml         | 166 +++++++++++++++
>  2 files changed, 166 insertions(+), 195 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
