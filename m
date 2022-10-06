Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8F5F6F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiJFU1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiJFU1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:27:08 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B66BEAC0;
        Thu,  6 Oct 2022 13:27:07 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-134072c15c1so278916fac.2;
        Thu, 06 Oct 2022 13:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtbKD79xzcu3GnByW/u9LLD7bXS1blAdwhG+DUsm8yI=;
        b=wX6bm+G9uW+DkdCu8cVRBj3YPdQmriEJFyuroRzIlZzkG273UA6LrscicBqSH7Ni1H
         u+ISb8eitamN0pcGp19psQTNPBBmoquyObdYk6RtZbntJt1h1hP7gVvQ1jdRHxXrkbbP
         1SPYdFnDGjEhOzNOC5SKoBhTwoCpqKiXcYLaCdMj8zv8X60aUe0nbxsB3/7ld3EZ4rSM
         56YSYTeL5ZUO4d3bDlXy8TDhwIkY4ODnPQhlJTglD3URy8dRJNF/SkQlNZAUVt6A6+TN
         ewHI/t1kHWSc9dgfydEHam/veu99t1elwrJhrTehqbNqWZkVh1OlaZ1BzxC9+qIjxaiQ
         0jmg==
X-Gm-Message-State: ACrzQf3TgAdIfQ+cz90BPcb8hNLyvan1KbVwOiyG9Ya7R47WCsn1wqLd
        JOheZL6p3nteqwI7Bnjk3A==
X-Google-Smtp-Source: AMsMyM5ctJijtfZOkqs+Jp+RYSpWQNFrg7rO9jVsfrITcKq8e6LICGe+qrGW2rO22az7TE6lpIL91g==
X-Received: by 2002:a05:6870:d626:b0:132:9149:dc8a with SMTP id a38-20020a056870d62600b001329149dc8amr6116543oaq.141.1665088026458;
        Thu, 06 Oct 2022 13:27:06 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id h6-20020a9d6406000000b0065c2c46077dsm245765otl.67.2022.10.06.13.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:27:05 -0700 (PDT)
Received: (nullmailer pid 106568 invoked by uid 1000);
        Thu, 06 Oct 2022 20:27:03 -0000
Date:   Thu, 6 Oct 2022 15:27:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 12/34] dt-bindings: pinctrl: qcom,sm6375-tlmm: drop
 checks used in common TLMM
Message-ID: <166508802223.106507.11800474591947623954.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-13-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-13-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:15 +0200, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema already brings
> requirement of function for GPIO pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
