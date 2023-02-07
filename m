Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D146A68E31C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBGVq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBGVq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:46:58 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96832E7C;
        Tue,  7 Feb 2023 13:46:56 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id v15so6673680oie.9;
        Tue, 07 Feb 2023 13:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6W2gA6pauvnW3vnwASNmQJuaX/9eULn7ROGW6vDkvA=;
        b=vg/q0FugxUM8FUS3ENCU2QTCNVhlNmn2MVzEqWZXwNiKqrcueyQQtU7KSOpZJjAMSP
         pdHjsgQ1Dm6qEg3QW2acB6VLWR238MQLm5D7ALSLkUQvdTfEW54exwWx7Z3W4eKVXr4W
         PgLuOmKyjElo4BwGr4eTnPEIWPl+bD+Z2207hPZBoS60vpeFP2sSvNxbXYoQ8N74GmG4
         fiJiLWyWm9Ia2FCf/j2CVzo9ePitHax++8EQeRmV5VDoB/JQJZ+u0ALfX32xGyRkQNFN
         ICNwJQ1umvbqqGo8uTBK5WIkPS3fVCTXKVNLhZuHztYP1yh+fOQoxo5Q/M7p3GULsuII
         l0MQ==
X-Gm-Message-State: AO0yUKVJ5qVJ+oGPz7wDXq2IqUdOgdDr4wlkGLomX/Z/VPNtxiCQNcT1
        IPX+48D93x6YziQZq4oXxw==
X-Google-Smtp-Source: AK7set97ysg+h2ACqtQwJ6RWyRLb3iNXGYE9Gb8kT5JWCqkUINkrjVKeWI7bWGc/0oFvko2BVvmyCQ==
X-Received: by 2002:a05:6808:289a:b0:378:bd9:b9ac with SMTP id eu26-20020a056808289a00b003780bd9b9acmr1928943oib.57.1675806415401;
        Tue, 07 Feb 2023 13:46:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o8-20020a0568080f8800b003547a3401e6sm6076279oiw.43.2023.02.07.13.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:46:55 -0800 (PST)
Received: (nullmailer pid 13619 invoked by uid 1000);
        Tue, 07 Feb 2023 21:46:54 -0000
Date:   Tue, 7 Feb 2023 15:46:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, frank.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        tharvey@gateworks.com, marcel.ziswiler@toradex.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, lorenzo.pieralisi@arm.com, linux-imx@nxp.com,
        marex@denx.de, peng.fan@nxp.com
Subject: Re: [PATCH v10 1/4] dt-bindings: imx6q-pcie: Restruct i.MX PCIe
 schema
Message-ID: <167580641323.13540.10338788167148165643.robh@kernel.org>
References: <1675743508-24702-1-git-send-email-hongxing.zhu@nxp.com>
 <1675743508-24702-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675743508-24702-2-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Feb 2023 12:18:25 +0800, Richard Zhu wrote:
> Restruct i.MX PCIe schema, derive the common properties, thus they can
> be shared by both the RC and Endpoint schema.
> 
> Update the description of fsl,imx6q-pcie.yaml, and move the EP mode
> compatible to fsl,imx6q-pcie-ep.yaml.
> 
> Add support for i.MX8M PCIe Endpoint modes, and update the MAINTAINER
> accordingly.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   | 279 ++++++++++++++++++
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  85 ++++++
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 240 +--------------
>  MAINTAINERS                                   |   2 +
>  4 files changed, 372 insertions(+), 234 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

