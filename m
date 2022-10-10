Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310375F9F05
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJJNAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJJNAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:00:08 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC2C13F63;
        Mon, 10 Oct 2022 06:00:07 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so7880053oog.12;
        Mon, 10 Oct 2022 06:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQgW7lo0zUMDYP1RepfUvxdbQM2PCGljk0xH1fZ56Tk=;
        b=MTXVpW+8GdI29x7xKpriiGWJldkoZ3ghaBJkvlIqUxGziBPT+3XaoJ+4nbI14mojH7
         ojF4cvmq/eII5y9Vsl3v5OTIwpWWd5H3RgrQLSz081MeHSMAhmxzy21VMNJ0OE7i/gIK
         HDch66PUhZ7IS02EuCHwZdcWKmdTEbmhRNcfhq4Kn3yYEGLSzcZy/N00VZXHgUK8JN1r
         Qe1+QF7LQvZXGByr/DJ4Vw/F68YFat9LdG3qS+Lz981q5jwzYIwhqv+Bss2XpmfPtkHu
         eiefuo4RgjICDh3H1XBQ/i+ofK6jQguc1ka23Pmxnrm17DxdZSShiBNpUFdxIDbGW93J
         eVrA==
X-Gm-Message-State: ACrzQf1qMA6fxuBY7O26Txjr02ZekOMYXHdF1y+jTCm6T4zAk2+A8UMz
        OaWGED+P3LuwY4i8bi07bw==
X-Google-Smtp-Source: AMsMyM7TI9rjDVlg50qScFZDGmsEAfWkS7KThYiSzOK+ko7XVhgsfxPGblu23n14sXgcImoJXvTsig==
X-Received: by 2002:a9d:73cc:0:b0:659:9686:5563 with SMTP id m12-20020a9d73cc000000b0065996865563mr8320503otk.40.1665406806868;
        Mon, 10 Oct 2022 06:00:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z22-20020a9d62d6000000b00661a1d92aacsm595112otk.33.2022.10.10.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 06:00:06 -0700 (PDT)
Received: (nullmailer pid 478335 invoked by uid 1000);
        Mon, 10 Oct 2022 13:00:07 -0000
Date:   Mon, 10 Oct 2022 08:00:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: qcom,sc7180: convert to
 dtschema
Message-ID: <166540680726.478270.1817901990631570843.robh@kernel.org>
References: <20221007145116.46554-1-krzysztof.kozlowski@linaro.org>
 <20221007145116.46554-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007145116.46554-2-krzysztof.kozlowski@linaro.org>
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

On Fri, 07 Oct 2022 16:51:16 +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm SC7180 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Doug Anderson <dianders@chromium.org>
> ---
>  .../bindings/pinctrl/qcom,sc7180-pinctrl.txt  | 187 ------------------
>  .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml | 163 +++++++++++++++
>  2 files changed, 163 insertions(+), 187 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
