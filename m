Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1D65656B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiLZWgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiLZWgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:36:07 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A692C62CA;
        Mon, 26 Dec 2022 14:35:58 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id r11so11122647oie.13;
        Mon, 26 Dec 2022 14:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeNBUbGDn4xdCtwlj9RAq3WVYSRQB1KO/qTg4Zks/mQ=;
        b=pvHO42EuO/mAupnhbTOgWtf9GznhAtzr1LlJzFej3jmLp60wCKfFgLVHK9AuAMykuC
         cO7fQNlDQohdns1ekcuXxKPYLF+MUBSl+Paq1ef8RGO8bEGd2RKAdEiifHEbT8Gyzxrh
         6v469Xh881hDP0RQRB5DzzjxjLULCv5KLcZWs9yue8cJUMI5V40K5dP160TGHkDPKjAf
         rH1AKLLh4T7mLiBwbNhGBo+cDhn66oBLCmRKUx5PVXK3zpPSI7QjytswsXlyyKMM+zIs
         IkAOle22LMwJ9eM1zYCQi4TiFmJgAEAozrumQSxLSzkxhxdDdgmOXELWHX1axiDv7BJZ
         sxYg==
X-Gm-Message-State: AFqh2koQPnlvuiAA15z+tx/rXKGvzVRzbgRYIg1psoBZ1gCwJJ2FeBtS
        k938CQ6tqRyVQ1tQxtkfAQ==
X-Google-Smtp-Source: AMrXdXuGQBnK4GOOz4Pj3nDQschEzoMDzY1DtfzGyYcgjBm1xOpSHACbLIjWALed+TtwJIUTCNanJQ==
X-Received: by 2002:a05:6808:f0c:b0:361:12d7:c160 with SMTP id m12-20020a0568080f0c00b0036112d7c160mr11272590oiw.10.1672094157949;
        Mon, 26 Dec 2022 14:35:57 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id a19-20020a056808129300b003436fa2c23bsm5263764oiw.7.2022.12.26.14.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:35:57 -0800 (PST)
Received: (nullmailer pid 37959 invoked by uid 1000);
        Mon, 26 Dec 2022 18:49:07 -0000
Date:   Mon, 26 Dec 2022 12:49:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, shawnguo@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: soc: imx: add IOMUXC GPR support
Message-ID: <167208054642.37890.16783213190353315745.robh@kernel.org>
References: <20221223025703.15784-1-peng.fan@oss.nxp.com>
 <20221223025703.15784-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223025703.15784-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 10:56:59 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add binding doc for i.MX IOMUX Controller General Purpose Registers
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
