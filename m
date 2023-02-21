Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB84D69E3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjBUPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjBUPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:40:08 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF4298C3;
        Tue, 21 Feb 2023 07:39:45 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1723ab0375eso1572861fac.1;
        Tue, 21 Feb 2023 07:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbiwxMfcRltjaWYCCfS3va2vMzxTOwRyWLGnK7Gq26M=;
        b=amnhCvPqQ5pp0L0L6l3ubkUQrshYCVf6GIlJraGs7kls8WvV2+cUPRNmPMhUVnrKr5
         eaZw1T+WvsMm9wmOp9IhuloEWIw/qngQzRbGyD7MCmCmpMffZk4TTgC31kv106Pb8vRh
         XgT03UW18AlShYL/5FjlSBvBl5ZDFV0UDuz6bPySbxJ4TI+ZPytSHNfp0/Vvk9SIX3Dc
         CT0WMrv5iz0PxQfbqrLp4ZrQSZ1Nu5/EgjLLjFZENrTP8hVeiULDBigG5j1DLHcJap0G
         GFZKGRmxE3Oyt5oaMZLPbXcAky5hZOJz8HFUrlacjIWnQAAXAYCPeXPAfQAxoKQB9vst
         ifHw==
X-Gm-Message-State: AO0yUKX+kbCji3TrjmL8TzHId4sNXcHjLwgS5vclJxtOcg5sAIapcte2
        JFgCVoK5WfKdEE0a2smffw==
X-Google-Smtp-Source: AK7set8Ws8xnnT40ibyA8bO3Dnc4X2y8bRJMZ9QvlUgPMFmltBzRXAQCMw82YcywMAJU4nhRgIj4XA==
X-Received: by 2002:a05:6870:5628:b0:16d:fc22:b520 with SMTP id m40-20020a056870562800b0016dfc22b520mr8213547oao.54.1676993941109;
        Tue, 21 Feb 2023 07:39:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s131-20020acadb89000000b0037fcc1fd34bsm4335872oig.13.2023.02.21.07.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:39:00 -0800 (PST)
Received: (nullmailer pid 2583407 invoked by uid 1000);
        Tue, 21 Feb 2023 15:38:59 -0000
Date:   Tue, 21 Feb 2023 09:38:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Randy Li <ayaka@soulik.info>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        - <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: wlf,wm8960: Convert to dtschema
Message-ID: <167699393653.2583308.15571733878236882240.robh@kernel.org>
References: <20230217150627.779764-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217150627.779764-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 17 Feb 2023 16:06:25 +0100, Krzysztof Kozlowski wrote:
> Convert the Wolfson WM8960 audio codecs bindings to DT schema.
> 
> Changes against original binding:
> 1. Document clocks and clock-names - already present in DTS and used
>    by Linux driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> One DTS warning still remains:
>   uniphier-pxs2-gentil.dtb: wm8960@1a: Unevaluated properties are not allowed ('port@0' was unexpected)
> 
> I am not sure if this is correct usage of endpoints. I would assume the
> codec should be used only as DAI.
> ---
>  .../devicetree/bindings/sound/wlf,wm8960.yaml | 88 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8960.txt      | 42 ---------
>  2 files changed, 88 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8960.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8960.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

