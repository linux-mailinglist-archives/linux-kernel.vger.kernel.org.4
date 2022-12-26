Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8E656551
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiLZWfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLZWfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:35:39 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE3C10BD;
        Mon, 26 Dec 2022 14:35:38 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id s186so11157326oia.5;
        Mon, 26 Dec 2022 14:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBSooSLPzvFUglz1GFfFXWzQ/wwPHw1yRamjP7L9bo0=;
        b=UhOZeBV6pDsYZ88eEIHIBxinK8g9yIAQxqXQbJvXeTPIyZLgCui3Lth5b3LBNK+TgP
         M+ILaBY85/CTY36fZe4tYFD/BOeLmS+MDl11O8gktbxrpZpXxEJXd87YPYTFbSdDvY6J
         6KX4ac6NUCAuEzBlzmBjpi91JPBz8aJx0v5SW8ujVpdtrip/aqy46skY3Jn+4Ze4FDBm
         cCBCAa5itsiq6DY8uADTnu7B+TfuyphkbxshK/8PT2C37NziBgUp3pZPjw6erqxPQMq4
         bjHSaW1QeluCEOSb57+RI6j1fDZnkHH+/4gEdSL/qBTDyxYJFT8cOUtfZA2pIzkZqJF/
         n5KA==
X-Gm-Message-State: AFqh2kryafPimI1XakxcbfdrjaKYyjZ3Zg7ZnF8MiKC3YVw/QSnQRNne
        7e9YMoregLxkE0drMUtdqA==
X-Google-Smtp-Source: AMrXdXvcuVIeH2Tw+m5YOf9l3TcXQPRxCMxRGeZCs8uX37jkZLCuXi4dXT4hTHIyu2rwKIak05kI0w==
X-Received: by 2002:a05:6808:2906:b0:35e:7b67:2eca with SMTP id ev6-20020a056808290600b0035e7b672ecamr7972402oib.2.1672094137683;
        Mon, 26 Dec 2022 14:35:37 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id bq13-20020a056830388d00b00670641eb272sm5941188otb.20.2022.12.26.14.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:35:37 -0800 (PST)
Received: (nullmailer pid 74851 invoked by uid 1000);
        Mon, 26 Dec 2022 21:59:57 -0000
Date:   Mon, 26 Dec 2022 15:59:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Fabio Estevam <festevam@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Peng Fan <peng.fan@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>
Subject: Re: [PATCH v1 4/5] dt-bindings: arm: fsl: add toradex,apalis-imx8 et
 al.
Message-ID: <167209199586.74782.7148832334662428314.robh@kernel.org>
References: <20221226062824.53113-1-marcel@ziswiler.com>
 <20221226062824.53113-5-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226062824.53113-5-marcel@ziswiler.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Dec 2022 07:28:22 +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add toradex,apalis-imx8 for the Apalis iMX8 aka QuadMax modules and the
> carrier boards (Apalis Evaluation board as well as Ixora V1.1 and V1.2)
> they may be mated in.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
