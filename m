Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606FC66E090
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjAQO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjAQO0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:26:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F0D402FD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:25:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso4675969wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0o5JKqHA2jE2pZCqpewPRuIPIvKyqcaqw+l6676pGJY=;
        b=Xt4JgcY4xB0r7T92IzDEDPjSB5vXfr00+YuDT1ZcYsxdhY22g+XGDHlWzWHw9EVfF/
         glqP6b1I/M3w5Juepr1Bl0RkPLkE8LxIDMXphUZbGPfetM9yFlRvujF3XZrc0qY3+0Od
         5ZEi738PWLGo4On8nvLAx8455u1MDkvtXUP170YCS4vlwXE2hfsNHuM0krmr86SE8QP7
         5XV2c7tv7PDTPR79ox7PqF0mlon5JlVS+qW2kl54+SWj9TltiGQtQ5co3SfiwRffgR7u
         BRXsh6Wn0j+nB1Zs05uXqcIOAS9hbqQaLK+0ejZ+6+qpspKMqapmjgbzx3JEYU6nVfMv
         OxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o5JKqHA2jE2pZCqpewPRuIPIvKyqcaqw+l6676pGJY=;
        b=j4zhx8yEMu94wwUCP2GTEFJDpzPHj+H6c+gyLlj1+8jktTzV/+SMey+HdGfrQrTef5
         KMM3FojCrILmua2U1VGr5kht1GvX/+Zo9wYK5vVfY66+FXLXfsCet4qk7dYogrTYCXof
         0U5c3kjBaaY+LqxqtwuHo8WqhRHAHCbBTQwaMRqgLQNu03tId3RXFPJRb3IPrl5/Jz81
         TcV/aItJu1u/waN1GwzfXp9QNmJOATgZyIVdXuc+Au/XSrz5gD+p+nwF9CXswZXQa6by
         FxbRkrGofP/BY1oF/WVbiLUJxduq/fbCxNNkZ717xb9BVc/f7Epbo03DgxjPau28p3V6
         pVuw==
X-Gm-Message-State: AFqh2kr14ZsjjZlR/Hyubh8JXBF9zImhauJhkaVy4ImRKdvkJ8RPU9nd
        AWdM4xLrHpEBS2yX5EpKhDRP2w==
X-Google-Smtp-Source: AMrXdXvUiyE7TTzBBUfTs4/cb9g/hSrNJbSFCgye8F3KowhvGTrU+ni8vLPEN0p9Wn24H5f8GY1x9Q==
X-Received: by 2002:a05:600c:181b:b0:3da:ff1f:e8d3 with SMTP id n27-20020a05600c181b00b003daff1fe8d3mr3255753wmp.15.1673965506462;
        Tue, 17 Jan 2023 06:25:06 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c3b8600b003db012d49b7sm5854466wms.2.2023.01.17.06.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:25:05 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:25:04 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: phy: Add QMP UFS PHY comptible for
 SM8550
Message-ID: <Y8avwNKKQYwbgmRX@linaro.org>
References: <20230117125555.163087-1-abel.vesa@linaro.org>
 <20230117125555.163087-2-abel.vesa@linaro.org>
 <33eda50c-c70f-1bb6-0917-22b6fdb4a2ca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33eda50c-c70f-1bb6-0917-22b6fdb4a2ca@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-17 16:09:12, Dmitry Baryshkov wrote:
> On 17/01/2023 14:55, Abel Vesa wrote:
> > Document the QMP UFS PHY compatible for SM8550.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> > index 760791de0869..44745a5c64cd 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> > @@ -17,6 +17,7 @@ properties:
> >     compatible:
> >       enum:
> >         - qcom,sc8280xp-qmp-ufs-phy
> > +      - qcom,sm8550-qmp-ufs-phy
> >         - qcom,sm6125-qmp-ufs-phy
> 
> Please keep the list sorted

Ugh.

I sent a new version.

> 
> >     reg:
> 
> -- 
> With best wishes
> Dmitry
> 
