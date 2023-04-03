Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC266D4558
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjDCNKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjDCNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:10:37 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA531205F;
        Mon,  3 Apr 2023 06:10:36 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso30698449fac.4;
        Mon, 03 Apr 2023 06:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527435;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o1kKey6PlIVrGiedNCgzb3ITGKBr8PtCTIVpOZFY/ns=;
        b=C3xzu1jiFOjdVCOcxbc8pVKYhRyYBshC9Av2PHFfj6lfMPanui61Erg3uzHr3GfjLA
         EprNW0XecrkptBJjhYpa1HXVuNV5UcgpPqLeEXnPT67xAYLN4iy8z4JKlAaONYWouljg
         WTpe3ypOKBDRmToix/n8b/X8KfvcLa/0s29dAXlEpYJ00lO0MCdttSaaSh/f5+4bACu4
         A1mbNsiE0d1nniVWwKlGzcJRE9rwj6Kj00HNa6yIXU9qQ9UP7tHqym+Idlaxf3fJ29Ke
         uf3Y8o2W6VeAKLB+9n+7fsdc7Eqka02KBLqHN+/SRzNxacw8bMxTHXjoqZCNuQlO1mPa
         Cp4A==
X-Gm-Message-State: AAQBX9fB8y0qca7DCdMChQgAdF0iiuHWNSS3fgHOrCYTM1CEGfC+26PO
        gDOifO+Ep4sh3OlzTTKXNw==
X-Google-Smtp-Source: AKy350aeqXbcoZPSQKC+2LpveFsajgQlLDe8zsm92EarjLau+y1ZyX6HkJ6JgKiUX26LXKjhCeBxeg==
X-Received: by 2002:a05:6870:64ac:b0:177:c2bd:3f70 with SMTP id cz44-20020a05687064ac00b00177c2bd3f70mr23423087oab.54.1680527435525;
        Mon, 03 Apr 2023 06:10:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a26-20020a9d6e9a000000b0069f85f0a1b7sm4141865otr.33.2023.04.03.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:10:34 -0700 (PDT)
Received: (nullmailer pid 522010 invoked by uid 1000);
        Mon, 03 Apr 2023 13:10:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20230403090640.3237060-1-peng.fan@oss.nxp.com>
References: <20230403090640.3237060-1-peng.fan@oss.nxp.com>
Message-Id: <168052514419.463338.6004475095346006596.robh@kernel.org>
Subject: Re: [PATCH V2] dt-bindings: input: pwm-beeper: convert to dt
 schema
Date:   Mon, 03 Apr 2023 08:10:30 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 17:06:40 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding doc to dt schema, and also fixed the
> example from fixed-regulator to regulator-fixed.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  License update
>  Don't need to show providers
>  Make example complete
>  Decrease beeper hz
>  Misc update
> 
>  .../devicetree/bindings/input/pwm-beeper.txt  | 24 -----------
>  .../devicetree/bindings/input/pwm-beeper.yaml | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230403090640.3237060-1-peng.fan@oss.nxp.com


beeper: beeper-hz:0:0: 4000 is greater than the maximum of 4
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

beeper: Unevaluated properties are not allowed ('beeper-hz' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb

