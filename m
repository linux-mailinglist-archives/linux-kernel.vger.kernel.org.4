Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8971B5FEE42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJNM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJNM5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:57:23 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D435DE987B;
        Fri, 14 Oct 2022 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665752239; x=1697288239;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ttZNASHnmEqUZ2mopvyLwA6LBCua1EQTWQV3Jt4anHw=;
  b=SXycol5aS3bFV0fJO23rx5g8x2qnXeVNrXWGC5tR+OrAucZiH+tmqLB6
   i1SRAS1X5HZD3AeMN7eS9UQRFMhKIMB4gOoKPefxm3x1D5gsdqqZzg34y
   nSuK+R+MOu+ROPMT+VtBPgu5Zx5Y5WtEsc5RSw4kPJune8pvuGbwCb+8f
   od/kpaLV9iIP2Z9XuB9Eh1Edu6/cvC28wcki1UBLwkzXdgXRq+uRlD6Os
   3QQ1IgMgFRoEe51dABcNcmKI2lNF5YBwrQj8Cw6w1O7KUJaXL2Z7m1Fcp
   bPKCdBwdmsyECE51xAEm2Y0a2xjpyqJu0k0z/lH5BPRqHnyomk2kGStLE
   w==;
X-IronPort-AV: E=Sophos;i="5.95,184,1661810400"; 
   d="scan'208";a="26760549"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Oct 2022 14:57:16 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 14 Oct 2022 14:57:16 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 14 Oct 2022 14:57:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665752236; x=1697288236;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=ttZNASHnmEqUZ2mopvyLwA6LBCua1EQTWQV3Jt4anHw=;
  b=IAXBvXNDBy04Kq+zU54Sv1V9ya9xMnO67D65C2aO7JLqbbf3MQY+DxNG
   6NBcTGwzQIvSU65FKk8i6ebOoLe8WZ7CUk2y9gVu50TCi4K6aeArPHZ5Y
   CN8uDyieyBsQyajK9wEt8UrQV+jzIBXvMeKDr0T3YxsNty9Kq+K3D831A
   jQtILSWOQcYn0TVfltYTw+WWRtbBvVwR+x/pD/zeLo+w0SV389QBkxwOa
   DJ47uZIjeGzrmRs+QOro9xEp6rCTnc3AAEy8AHtOsjf2IFdaUbl5zJ/F2
   jqZGx4vI/YmF+J61mRxM7kDGqZVCsJgHuwgyjwzoh090KMkzg4kOzG4b2
   w==;
X-IronPort-AV: E=Sophos;i="5.95,184,1661810400"; 
   d="scan'208";a="26760548"
Subject: Re: [PATCH] dt-bindings: phy: imx8mq-usb: add power-domains property
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Oct 2022 14:57:16 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 30F78280056;
        Fri, 14 Oct 2022 14:57:16 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, xu.yang_2@nxp.com,
        kishon@ti.com, vkoul@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jun.li@nxp.com,
        linux-phy@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Date:   Fri, 14 Oct 2022 14:57:13 +0200
Message-ID: <3203711.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221014095550.2125018-1-peng.fan@oss.nxp.com>
References: <20221014095550.2125018-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 14. Oktober 2022, 11:55:50 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add optional power-domains property for usb phy.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml index
> 2936f3510a6a..5ba9570ad7bf 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> @@ -28,6 +28,9 @@ properties:
>      items:
>        - const: phy
> 
> +  power-domains:
> +    maxItems: 1
> +
>    vbus-supply:
>      description:
>        A phandle to the regulator for USB VBUS.

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>


