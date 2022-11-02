Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5062616B0F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKBRks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiKBRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:40:29 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E839248C3;
        Wed,  2 Nov 2022 10:40:17 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id s206so19953443oie.3;
        Wed, 02 Nov 2022 10:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn3Md3DDfmwu7mRJMxtw1Zqk7ZmyZ+wVWjGzjR5XqhI=;
        b=x+G0g5Lbi7NceqZRMOCeOocvRsBsOPx1/CJu2Y+SCeOhibgXuiyxmXTQRXjNmSnBo1
         n8WEs4Yb8iGXbyXvM99vvlXw3Syhl+8gwDIEq7N7KGzcOCv/wUg0uQg/wzrVH5ODnDMc
         Bi/h8kk/A5Icx86VK7O3fscjdARTRIkhu35ZSKDJyrJQufu5vq5eDCXsmtnV7JCTpW4t
         9IUmYpBfKMBMty3wmt0fbjOdwH3psydWBQ3jpx/4PfSSXyvaFcacJ4XW6DLUjxXFLAks
         TZv2/0uRSJZxhkwg0kB1wREg11VhtySKt/9SN1xAyj03jqrCsxG+J0MltThz1+Hw5Ke+
         UFeA==
X-Gm-Message-State: ACrzQf0NYfPuZ7V0gyrv0Bcs/Qnz+duGLH+hvmhc8wvY/JUiaH3EVT5s
        Saq2q0eX9ZYlq8qfoN5/Hw==
X-Google-Smtp-Source: AMsMyM7oXYtc9f6PWQYuC20JPF3XtzpncveMbbhlpWcpJrh6XWLEekXVe/HHbdZiH/n3hyzjxANQjQ==
X-Received: by 2002:a05:6808:1582:b0:359:dc30:d716 with SMTP id t2-20020a056808158200b00359dc30d716mr14210554oiw.104.1667410816627;
        Wed, 02 Nov 2022 10:40:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g93-20020a9d2de6000000b00666fdab9da7sm5145036otb.78.2022.11.02.10.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:40:16 -0700 (PDT)
Received: (nullmailer pid 11369 invoked by uid 1000);
        Wed, 02 Nov 2022 17:40:17 -0000
Date:   Wed, 2 Nov 2022 12:40:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Lubomir Rintel <lkundrak@v3.sk>, loongarch@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: soc: add loongson-2 chipid
Message-ID: <166741081722.11313.14449505612000016628.robh@kernel.org>
References: <20221102035511.19972-1-zhuyinbo@loongson.cn>
 <20221102035511.19972-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102035511.19972-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2022 11:55:11 +0800, Yinbo Zhu wrote:
> Add the Loongson-2 SoC chipid binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/hwinfo/loongson,ls2k-chipid.yaml | 38 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
