Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200705B768D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIMQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiIMQdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:33:03 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F41B2DA9;
        Tue, 13 Sep 2022 08:27:55 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1274ec87ad5so33133815fac.0;
        Tue, 13 Sep 2022 08:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=28p++DHkT2/NKd7kOdWA6yeJGWEdUCO45c0Fr3NmGUo=;
        b=ZDzwgQZ0cySeIpjAeD0gtG1IUrMPExlYyKSK79uK7FxCIoYiRlvkhOur2msaQmG4mM
         V5oiQkVADkjyCY3o/+Wqw9wNbBJcR5WYnO+gAfkdkyiwAIM0Loem5Aqlv4rX5hyMwzJD
         5u1aMuiQPNJ400ZXdjtgNL+P1Ndx/h66mHJbihmaHw5QzdvIodpydjzdxIZRryWaj1TN
         XIbSB0HgLT16il9dphJNFZnzQAE/eNng9EGBNI8U/rRA/xqOEN9ErqgBP5osZ4CazAhx
         /NvWVXJi5/19Q3eLYeuTC1sv9LFxyM+FVRY8NhDBPH+aaBu+BQOhd3N9VVmJ+CS0Mj3G
         V2aw==
X-Gm-Message-State: ACgBeo2aqvays5uRbQK9hyKHQEXk3Aom154YGTCG1IMIA7sU8wQzL2+b
        ixj7wiop6CTLaoqDb1NLjGxrhsJwWw==
X-Google-Smtp-Source: AA6agR5wqNZLy22L71WNfOJNT87z8uSeDJLVU0mIk+hLG0SoqarBGfaG2KqDhVBKPWT9EAOJo98G9A==
X-Received: by 2002:a05:6870:558d:b0:10e:5a87:500b with SMTP id n13-20020a056870558d00b0010e5a87500bmr1988039oao.276.1663082306891;
        Tue, 13 Sep 2022 08:18:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e3-20020a544f03000000b00342e8bd2299sm5441874oiy.6.2022.09.13.08.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:18:26 -0700 (PDT)
Received: (nullmailer pid 3736159 invoked by uid 1000);
        Tue, 13 Sep 2022 15:18:25 -0000
Date:   Tue, 13 Sep 2022 10:18:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom: drop non-working
 codeaurora.org emails
Message-ID: <20220913151825.GA3736032-robh@kernel.org>
References: <20220911112520.203062-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911112520.203062-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 11 Sep 2022 13:25:20 +0200, Krzysztof Kozlowski wrote:
> Emails to codeaurora.org bounce ("Recipient address rejected:
> undeliverable address: No such user here.").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml         | 1 -
>  .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml        | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks!
