Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE165CB08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbjADAmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbjADAmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:42:22 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B621649C;
        Tue,  3 Jan 2023 16:42:22 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id a9so6560815ilk.6;
        Tue, 03 Jan 2023 16:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1g83OSSu3QiXhYjCljnUwd0VoQP0/wjekUDGXp9bdc=;
        b=kcPY1GjnMCgJHcjAVUc8XCLC/POEGDi8UxdT7U/phTfy/W1pOezdDCrTd+DaG0VYKk
         ejTOqZFeUPpJc+S2WmcKKoLDG/bRkHp2jlUDieP1s+3BDFJPQMeHfXKwlYT/3iIy44fb
         PTZa3GXpODETujsn49Oyn8oFexZbBUUaqLGLzFd+KK9jlUFeqNXksdZhlEr0rzg5yloq
         lt7zx4ozEhQkp6NteJvq2rXdW7UfAZUR4i5bFqLBw79a95MPcD+WV6KwUGLx2SyAN4gl
         uiOGPNSH0txtxZ6Ku2+kvYMvyNm1iREGGgyZvL69bYVStnAIA1ZopEcTG/MrxRjLIy/7
         eMRg==
X-Gm-Message-State: AFqh2krC1YDoZHjnPOqviA+qhf0XEtJ8DXjeWdgHDlTxb2tJMYEDoLig
        UZpaz4y4aTLyxm1xDu/XZQ==
X-Google-Smtp-Source: AMrXdXtZ8Iv27+U5gKIsitbqCFmpUAbFTYPdwn7uiMEnoIOVq08xkv0z+iOw4CeBcmytx3bNaZlN2g==
X-Received: by 2002:a05:6e02:1524:b0:305:e1f9:89b with SMTP id i4-20020a056e02152400b00305e1f9089bmr38587379ilu.24.1672792941242;
        Tue, 03 Jan 2023 16:42:21 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i4-20020a056638050400b0038a5b8d79basm10584873jar.106.2023.01.03.16.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:42:20 -0800 (PST)
Received: (nullmailer pid 161533 invoked by uid 1000);
        Wed, 04 Jan 2023 00:42:19 -0000
Date:   Tue, 3 Jan 2023 18:42:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sm8450-tlmm: correct
 gpio-line-names size
Message-ID: <167279293841.161448.17344555773044379937.robh@kernel.org>
References: <20221223132226.81340-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223132226.81340-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 14:22:26 +0100, Krzysztof Kozlowski wrote:
> The SM8450 has GPIOs from 0 to 209, so 210 in total:
> 
>   sm8450-sony-xperia-nagara-pdx223.dtb: pinctrl@f100000: gpio-line-names:
>     ['NC', 'NC', 'NC', 'NC', 'WLC_I2C_SDA', 'WLC_I2C_SCL', ...
>      'APPS_I2C_0_SDA', 'APPS_I2C_0_SCL', 'CCI_I2C3_SDA', 'CCI_I2C3_SCL'] is too long
> 
> Fixes: 9779ed30f92c ("dt-bindings: pinctrl: qcom,sm8450-pinctrl: add gpio-line-names")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
