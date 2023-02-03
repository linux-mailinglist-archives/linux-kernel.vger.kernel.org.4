Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB478688B66
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjBCAFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjBCAE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:04:57 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D3086243;
        Thu,  2 Feb 2023 16:04:56 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id s66so2864462oib.7;
        Thu, 02 Feb 2023 16:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtYrMLYXtmK6GAL0DZZzV9+tRS1coRRQI6UjPmzjAM0=;
        b=Uo/QP1/BCA/LCzLl4ta4kTN5wuTOtqH1pyY7LNx4HrFBKjiNvISlP+tOUv2x2QuxNK
         aHAAjnKPr63CIBrwnYh4DsAwWVc53PfPSx6ZGpE0qddiTflTm12e+1Eqz43x/mY1wSnj
         +hx7obu8qEev1ICcuBnPAgdjoU3zzQEzpaBt6sUbiMRyzDVpAieeRX8t1nn2Hymz2W2W
         9cgHXQJdGqtA0stzHT3pYcpLU7yVHx2XJYaMWkAFWy5nT/UK5zyIWqvOha8Zb7pSZiVV
         fT36lKfjPGrfoCBpSHmJ2qZugs04XtEf8n4DfYrJQ0Lv8Rw0LCMuZ6tohjxGL5V+dem8
         bM9A==
X-Gm-Message-State: AO0yUKUCKHFufiWTBB5hXImANZWHeRZVEJr993/yY/uXs1iQlw7zdqyM
        S7UFfR5E422GDYAfh/HtimV0rvV3Uw==
X-Google-Smtp-Source: AK7set+Ty/ScAYQDbxRf+HVlaWBcfK2Q86i/tU/SlHNMXzntNkgD5NAD8B4TyN4sRbT/Cs86n1T90g==
X-Received: by 2002:a05:6808:10c1:b0:35a:7043:ee4d with SMTP id s1-20020a05680810c100b0035a7043ee4dmr5169355ois.0.1675382695302;
        Thu, 02 Feb 2023 16:04:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x39-20020a056830246700b0068bb7bd2668sm402813otr.73.2023.02.02.16.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:04:54 -0800 (PST)
Received: (nullmailer pid 2939204 invoked by uid 1000);
        Fri, 03 Feb 2023 00:04:53 -0000
Date:   Thu, 2 Feb 2023 18:04:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Iskren Chernev <me@iskren.info>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH v2 05/10] dt-bindings: pinctrl: qcom,sdx55: correct GPIO
 name pattern
Message-ID: <167538269339.2939166.8261454185118428659.robh@kernel.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202104452.299048-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Feb 2023 11:44:47 +0100, Krzysztof Kozlowski wrote:
> The SDX55 TLMM pin controller has GPIOs 0-107, so narrow the pattern.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

