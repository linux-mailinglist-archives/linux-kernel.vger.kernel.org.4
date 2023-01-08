Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F299A661917
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAHUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjAHUKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:10:09 -0500
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F7DF4D;
        Sun,  8 Jan 2023 12:10:08 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id e129so3623935iof.3;
        Sun, 08 Jan 2023 12:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqGjsmUmm5zH0fsCCu3kEOJMq75cJfhx/udu4xeQr9c=;
        b=hP0dIGKeVN7/3KTY860Sr6QFw4D5Z/KctkIfpKKeJhyfizgsFzYqGAMlYfKgfXtLvp
         xC7NSFZW334J4/eXOGcoTq5uSfIS3v3DICNYz3II6ZSXUQ4cYyMkhLcxZHo6ECRCoytc
         IOfqezLAA8pOd+1PPEeuREeKezet9+s5NRAVZSls01Tw8Fm5dTDlg++aurlRb+Wzl1rF
         a5aAT3fyUKOoXGvN0PSd0kwGd7CyUbSj+ZTERN3rWWNHkUvsDwCP5yUk2cyLYL1PZVV2
         4SZy/XQ19r8p5N9rNIddT3WpzMpUcWhVXwsB7sxqTxPzP9nVrbj4FsdJj/+QHB47Vlf+
         dAyQ==
X-Gm-Message-State: AFqh2kpkGKzbCCTuyol71SYvAGA+FvAamS2uz5O/0/81qdFz13GP1ClF
        GzbMr0VN3JgNyndhqBZ22w==
X-Google-Smtp-Source: AMrXdXvxzvj0Yaw6TQtyY8jiKFlZ04seQWxPL/HCRF9RoYBi6pLrhKHc9jOsY2kwW5v0p20++hwmhw==
X-Received: by 2002:a05:6602:3785:b0:6ea:6c79:d224 with SMTP id be5-20020a056602378500b006ea6c79d224mr50029272iob.7.1673208607937;
        Sun, 08 Jan 2023 12:10:07 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id o32-20020a027420000000b0038a5b8d79basm2216096jac.106.2023.01.08.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:10:07 -0800 (PST)
Received: (nullmailer pid 214740 invoked by uid 1000);
        Sun, 08 Jan 2023 20:10:02 -0000
Date:   Sun, 8 Jan 2023 14:10:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <me@iskren.info>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 4/9] dt-bindings: pinctrl: qcom,sm8350-tlmm: add
 gpio-line-names
Message-ID: <167320860104.214563.6053509518668014612.robh@kernel.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
 <20221230135645.56401-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230135645.56401-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Dec 2022 14:56:40 +0100, Krzysztof Kozlowski wrote:
> Allow gpio-line-names property (quite commonly used) and constrain
> gpio-reserved-ranges:
> 
>   sm8350-sony-xperia-sagami-pdx215.dtb: pinctrl@f100000: 'gpio-line-names' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml    | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
