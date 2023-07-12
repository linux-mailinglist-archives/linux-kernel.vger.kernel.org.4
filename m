Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41096750852
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjGLMca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLMc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:32:29 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08ABB0;
        Wed, 12 Jul 2023 05:32:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0559D24000C;
        Wed, 12 Jul 2023 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689165146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMAmlAAfV/E3+8xeb2DY6C2+zCz1wmbuPYuto9/gghs=;
        b=UIBF8vAIz5VH3xswnjijkgkjrvCSy+4uPDwLYpvSwymiFlzJz4j1cFtt/yUspvcmzqK4gx
        EGE/KIKQliTr6P5p7ZFxIf4Xb40v5dQQ/zgKyWgmUS+nhjM3NmvvPrgoUs6ZAqjSgKUS9e
        fTGWEW3kcixsXElORuQ75dMrpu6ciq/iv5CVyyQvTtlV3402JqUShoUQVU/95L8fFffnd2
        8jg9i10QjT7qIkILpdq+uLXnsHED36kbzME51KUa59jFalwQIWEUbmcfLOMGQ0G4wPSwsC
        qDFwMbVMVrY26baRGsd47JnlMURXmPAXCcAOF6pyRQjnrJxGsbTYWLBqOVCQMg==
Date:   Wed, 12 Jul 2023 14:32:20 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregory.clement@bootlin.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mtd: Add AC5 specific binding
Message-ID: <20230712143220.06a3d6eb@xps-13>
In-Reply-To: <20230703035044.2063303-2-chris.packham@alliedtelesis.co.nz>
References: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
        <20230703035044.2063303-2-chris.packham@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

chris.packham@alliedtelesis.co.nz wrote on Mon,  3 Jul 2023 15:50:42
+1200:

> Add binding for AC5 SoC. This SoC only supports NAND SDR timings up to
> mode 3 so a specific compatible value is needed.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I need DT-binding maintainer's ack to take this patch, but this commit
did not receive feedback (positive of negative) from them and is no
longer in their patchwork. Can you please resend the series?

The other patches LGTM.


> ---
>=20
> Notes:
>     Changes in v3:
>     - Collect ack from Conor
>     Changes in v2:
>     - Keep compatibles in alphabetical order
>     - Explain AC5 limitations in commit message
>=20
>  .../devicetree/bindings/mtd/marvell,nand-controller.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controlle=
r.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> index a10729bb1840..1ecea848e8b9 100644
> --- a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> @@ -16,6 +16,7 @@ properties:
>            - const: marvell,armada-8k-nand-controller
>            - const: marvell,armada370-nand-controller
>        - enum:
> +          - marvell,ac5-nand-controller
>            - marvell,armada370-nand-controller
>            - marvell,pxa3xx-nand-controller
>        - description: legacy bindings


Thanks,
Miqu=C3=A8l
