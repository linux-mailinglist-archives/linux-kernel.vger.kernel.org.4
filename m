Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A185B68FB7B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjBHXqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBHXqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:46:42 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493ED1CF73;
        Wed,  8 Feb 2023 15:46:35 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id i17-20020a4adf11000000b0051abd9835d4so67544oou.1;
        Wed, 08 Feb 2023 15:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbEn39jZuVbrp1KfyknBN5gIqFu1Lykme5hYfqFo0KQ=;
        b=SL3SSkRxt5VDPxqoKokNYJSkkLTcxtWQ6A0KZJfVjy0sBYPDvvTsYuvu9KpJx2AptY
         Eu0D1K6227SYn+Ln4h+9wZo+Ot19ufs4avtx23+dq4AD/3vo22zGpCjJpRCbO4pvJzQS
         W/XuMFvTnucH0NH+dKQ8htog0PBbR8rj5hia4zC3Kk3M+0Bh9VuxJtAj5mi8fA4GtrSi
         gCBwL4FjDWJNEYwrJDeKYb5dcpYxNeUhpDVQtivYbGOxsl4dCcApPkVORHrXatgrje48
         83vEgt7h9rTFhHLDNoxKg7ZySKUYqXBfOMLR4AfYxNYhibj1U/P4S/rRHd/mlQA915sE
         mC/w==
X-Gm-Message-State: AO0yUKW5lDPp7jcX/QDfONaUN3RJr7GM1//nU34qqh3LjWrHVi4gedMR
        Qwjcfy/AksySBbNJltzIyHyhbFaiwg==
X-Google-Smtp-Source: AK7set+u84M8vV5Z7iR2FMh6IRGAFVe2dAiIP5ph2YQMbwK4m652fyZPas/rGZQc1f3IcdFVrQdE1g==
X-Received: by 2002:a05:6820:1355:b0:517:98b6:b08b with SMTP id b21-20020a056820135500b0051798b6b08bmr4911474oow.2.1675899994513;
        Wed, 08 Feb 2023 15:46:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g26-20020a4ab81a000000b0051a72e69e24sm6388811oop.37.2023.02.08.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:46:34 -0800 (PST)
Received: (nullmailer pid 2934831 invoked by uid 1000);
        Wed, 08 Feb 2023 23:46:33 -0000
Date:   Wed, 8 Feb 2023 17:46:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: make G12A
 usb3-phy0 optional
Message-ID: <167589999250.2934778.14203415915697370629.robh@kernel.org>
References: <20230207-b4-amlogic-g12a-usb-ctrl-bindings-fix-v1-1-c310293da7a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207-b4-amlogic-g12a-usb-ctrl-bindings-fix-v1-1-c310293da7a2@linaro.org>
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


On Tue, 07 Feb 2023 16:02:04 +0100, Neil Armstrong wrote:
> On the G12A USB complex, the USB3 PHY is shared with the PCIe controller,
> thus on designs without PCIe enabled the USB3 PHY entry can be ommited from
> the PHY list.
> 
> Fixes: cdff2c946f06 ("dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG Families USB Glue Bindings")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

