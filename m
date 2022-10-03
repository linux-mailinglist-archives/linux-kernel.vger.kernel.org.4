Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEE65F3432
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJCRJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJCRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:08:50 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCEC2C117;
        Mon,  3 Oct 2022 10:08:43 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1326637be6eso3973031fac.13;
        Mon, 03 Oct 2022 10:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0x3TM5/cgthPCl0//SYP9j2cBgcwoips7NTwwcRNCms=;
        b=gBAuy6hqkgf6RzeG8K90OFVp+SWxVWdzuEoPYY93ihJJkAXO3RIdzhIjl7Y3I+zFiD
         jcekmzC1+dfcUyUxrRIeft3oD0YPdABRR8dyHjnxnyoDojOtpZgG8sfD1PXO1o770qMe
         dlx+ntYCWYbQrRZlZlXo3PCqnns6w4oUefvVe5iJ3iMJU/w3NxK5QBmNUMAqZqLhn/QJ
         HePMijNY7CEnaSphRG7qAcGG46o9VB/YVI0coL0fLuad4CdecVND6/y2d5twEWLq5rl/
         HTRCHeKI5xcAG8jSeGqpw8rv8FRe1wkUx9Uj9FJe2sRK2HdvWwhp1ircux3y+y3ntAwR
         O5Gg==
X-Gm-Message-State: ACrzQf0YhfHEH/uYxohRlpv7R0xCP1e4RCYqTIchfgG4OGKKfsmnlT8T
        kssLCDRsinDgiN1QS26IxQ==
X-Google-Smtp-Source: AMsMyM4uHTKbTCFCraQGFYR/5vs/A40FED8PyPNMvxoSAcEw42Db6R7GLYusIQpgzUZGyR7T8t/H6Q==
X-Received: by 2002:a05:6871:1d4:b0:12d:6e53:d053 with SMTP id q20-20020a05687101d400b0012d6e53d053mr5624641oad.241.1664816922317;
        Mon, 03 Oct 2022 10:08:42 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n22-20020a056870241600b001317413344esm3048560oap.47.2022.10.03.10.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:08:42 -0700 (PDT)
Received: (nullmailer pid 2457435 invoked by uid 1000);
        Mon, 03 Oct 2022 17:08:40 -0000
Date:   Mon, 3 Oct 2022 12:08:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 13/16] dt-bindings: pinctrl: qcom,sm8250: fix matching
 pin config
Message-ID: <166481692019.2457395.5449643477607674047.robh@kernel.org>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
 <20220930192954.242546-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192954.242546-14-krzysztof.kozlowski@linaro.org>
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

On Fri, 30 Sep 2022 21:29:51 +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> The change causes indentation decrement, so the diff-hunk looks big, but
> there are no functional changes in the subnode "properties" section.
> The only difference there is removal of blank lines between common GPIO
> pinconf properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 128 +++++++++---------
>  1 file changed, 67 insertions(+), 61 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
