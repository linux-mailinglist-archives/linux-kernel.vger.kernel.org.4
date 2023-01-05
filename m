Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABF165E89A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjAEKE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjAEKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:03:39 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC77233D63;
        Thu,  5 Jan 2023 02:03:27 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3D37524000A;
        Thu,  5 Jan 2023 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672913005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhxtqzDnqdn/yv5fZtR2reVGVJ31mNbQjd2aTvJ+gc8=;
        b=SBmiOtHGwyzmO79FWDV/qh5ZTui++lkqYDJeO+C46F6xwcPCH5rnZFZe8mUna8MHTFLFRk
        AeKgQqDPfilLburR5yGbr2w9KLO68RykVkBVQuia3lfBBtzd3Xl7dqBW11RayfCO+U/4ph
        B+TR6vvppSlQyTGk0sATa/Kk9/qWFj8HfSqzgXetzsooxmkZUxtF5QJKLZS7UE1Io8eKS0
        ee30e3pNeFovPU+u2Vz05zNsOIK8U0IKruqRj6xaDWNRIRQhZyGeWPRGIaNmFw41sGsibc
        7m9F74wrejriya+lN4jXoGZc4hy88fOmMd43/nPbpmyRNX3RTLHFjne6Lzs4iQ==
Date:   Thu, 5 Jan 2023 11:03:22 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][next] dt-bindings: nvmem: Fix spelling mistake
 "platforn" -> "platform"
Message-ID: <20230105110322.60145714@xps-13>
In-Reply-To: <20230105095828.2951-2-colin.i.king@gmail.com>
References: <20230105095828.2951-1-colin.i.king@gmail.com>
        <20230105095828.2951-2-colin.i.king@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

colin.i.king@gmail.com wrote on Thu,  5 Jan 2023 09:58:28 +0000:

> There is a spelling mistake in platforn-name. Fix it.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-lay=
out.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.=
yaml
> index 5a0e7671aa3f..714a6538cc7c 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> @@ -61,7 +61,7 @@ properties:
>      type: object
>      additionalProperties: false
> =20
> -  platforn-name:
> +  platform-name:
>      type: object
>      additionalProperties: false
> =20


Thanks,
Miqu=C3=A8l
