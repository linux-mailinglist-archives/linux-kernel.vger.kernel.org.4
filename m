Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DF16D653A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjDDOZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjDDOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:25:21 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C2116;
        Tue,  4 Apr 2023 07:25:20 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id a30-20020a9d3e1e000000b006a13f728172so14229913otd.3;
        Tue, 04 Apr 2023 07:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfFv+QOf1yDHw8Nr+wigwgw08UuoqTsGPijrLxx6WDQ=;
        b=SKsi+MNLZMxIoGQNjiIkabXi2Z1orsjhn6Gm4o4So+dnIGLzfmquASjNh9ktDCjjhH
         6NbI5+3S5EO95pKI/miNY2ZVuA25mCVpwhpASVMqz811ipcOlWejLZEgHnGEGEQB4VGD
         20IBIuUPWDWIxhi3APaBLAoqi9xRXGQLlUhe1SS+zcnLPZC1SVmuV71eBbReX97cdFxZ
         4pf7Fb0mAC427NcUUBlNMD15uhiUcIt8sAjOTzH/gs2nwFHoFwcF2XoXU194Ks+X+7qn
         C2gMem9glaJJB75u66oLip8T6d4XULFGZye32IlH/sQ150n1niWOmuXj8V9nD2JL4glm
         WBAg==
X-Gm-Message-State: AAQBX9cIbnQqa17Re9op0qkZqh/YzYaWCByBGTj0AutB+S1uNsQtGDOl
        xlJ6ZQ6h2EYbhzKroVUcZQ==
X-Google-Smtp-Source: AKy350aGHvbr3/R6CmlMOZBHR4mblqLK7dsQewgjjTGJyRnzwdMXECZyKR21UEsg0xIjmKvgIOySZg==
X-Received: by 2002:a05:6830:e8a:b0:6a1:796e:c380 with SMTP id dp10-20020a0568300e8a00b006a1796ec380mr1283573otb.6.1680618319614;
        Tue, 04 Apr 2023 07:25:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830008f00b006a036b9794asm5563444oto.37.2023.04.04.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:25:19 -0700 (PDT)
Received: (nullmailer pid 3833292 invoked by uid 1000);
        Tue, 04 Apr 2023 14:25:18 -0000
Date:   Tue, 4 Apr 2023 09:25:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     linux-amlogic@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel@sberdevices.ru
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: add Amlogic A1 SPI controller
Message-ID: <168061831774.3833234.8717892160543675087.robh@kernel.org>
References: <20230403183217.13280-1-mmkurbanov@sberdevices.ru>
 <20230403183217.13280-2-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403183217.13280-2-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 21:32:16 +0300, Martin Kurbanov wrote:
> Add YAML devicetree Amlogic A1 (A113L SoC) SPIFC.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>  .../bindings/spi/amlogic,a1-spifc.yaml        | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

