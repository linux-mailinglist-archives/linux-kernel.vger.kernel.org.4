Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D3566283B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjAIOPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjAIOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:15:46 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9FFE03F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:15:43 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id az20so1367459ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 06:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZxwx51i+BIGNJvdhbm1l+QcJIg3vJ0V5Z9lmCSorLQ=;
        b=PACsPm6173A44/eLx1fCIdhLmjCVlMLjb4PmWzCa3135l74Oe+dfw/nl/f77Zr+8TC
         oyxRQEaX9KReiNI874+l+tHPg9HyfFMfPnB5/PxuvKQ+IkJY1ejQ9anO+epfQHGAsXdU
         gTSzJYtbLvCZ7m3cikOTSk9mYLi3p101/TXPRVLeCMCkaZwbdV03EAhGooljj2ImF9nN
         YDjHn1NlIa/NzwiN1CwRs5/5b+rVDJntyl5i2ub2MHIrVvjTN7Wn2grpFdlAnhrtAmd4
         M0mqIkjRecl7UPnMPoCHxVt0SF+txSTCkT7SLYUXxos9PtSSt32jwGeaX0yNvojQo24q
         bgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZxwx51i+BIGNJvdhbm1l+QcJIg3vJ0V5Z9lmCSorLQ=;
        b=y9uLDJJmtfDviMYPjTH7FuxhwpHtX2lGfoJN11W7WmHB+//qF6/tEj/pl8s+ldY2PR
         n8oZwwakjLEbq7zmVsba/xOZDNn02nznjd7d2MW3vT86TprRXQWaNYvgKvRcNpVgbRJA
         nwggIiLvfNKI+1CmSoQoC1GjFON11aXIAaoMKgdY124VxBUjpsH/CCfZjKOeJ0kNeZmD
         5D0hGPztYvdz3RuyX1jxZ1KUdkaiJ6DtN0MIflg48QzfhdXUojdLsyhd5XAfPdY7TH0Y
         Ar0AicO7a08HlNps0S10YZH9AG8WTymv00ptBuWrhXjzJOKmWsTk07WMkuL5SCrZ9U1W
         iQcw==
X-Gm-Message-State: AFqh2koY3Tk82wv5pDBM55v3di2mNLlYyCBnA+NjCrE9YuN8AMM4vEMA
        veCMrCIikSu3iBqfT9/j7CTi8Q==
X-Google-Smtp-Source: AMrXdXu8UkPnXWV7l6spq5CM1lBizx6r8JGq7e3bgVCc66E7Ti1PS7V3wXbdrROFFTaAtBmdrKLjNg==
X-Received: by 2002:a17:906:54d1:b0:84d:3819:79b9 with SMTP id c17-20020a17090654d100b0084d381979b9mr6777117ejp.71.1673273742344;
        Mon, 09 Jan 2023 06:15:42 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p17-20020a17090653d100b0084d4d81f938sm775384ejo.198.2023.01.09.06.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:15:41 -0800 (PST)
Date:   Mon, 9 Jan 2023 16:15:40 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add SM8550 compatible
Message-ID: <Y7whjCc+j0DLGUFz@linaro.org>
References: <20221116150600.3011160-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116150600.3011160-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-16 17:06:00, Abel Vesa wrote:
> Document the SM8550 dwc3 compatible.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Gentle ping.

> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index a6e6abb4dfa9..a3f8a3f49852 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -39,6 +39,7 @@ properties:
>            - qcom,sm8250-dwc3
>            - qcom,sm8350-dwc3
>            - qcom,sm8450-dwc3
> +          - qcom,sm8550-dwc3
>        - const: qcom,dwc3
>  
>    reg:
> @@ -301,6 +302,7 @@ allOf:
>                - qcom,sm8150-dwc3
>                - qcom,sm8250-dwc3
>                - qcom,sm8450-dwc3
> +              - qcom,sm8550-dwc3
>      then:
>        properties:
>          clocks:
> @@ -358,6 +360,7 @@ allOf:
>                - qcom,sm8250-dwc3
>                - qcom,sm8350-dwc3
>                - qcom,sm8450-dwc3
> +              - qcom,sm8550-dwc3
>      then:
>        properties:
>          interrupts:
> -- 
> 2.34.1
> 
