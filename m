Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D01A73304C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjFPLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345204AbjFPLp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:45:28 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A2F3AA3;
        Fri, 16 Jun 2023 04:45:17 -0700 (PDT)
X-GND-Sasl: gregory.clement@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686915916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T7vKXcoGnfHByIjNR4PPOnXfjMYez+Hmo6GodYExhsY=;
        b=cTmBdZOVa7wbqWhmXSVD72Qc/Ds9ElgOdPoJLeG60uZz/X2FzpTaZBgUf1mTQnFiak3Wch
        y+hC+XwNCaxkbWNKbk2ezoz5gB0yRlpXswJgj14U0bGZl7vDodc8DQjIPblmerD7LHmGm/
        DENlhkG1c4RsTXxQpp1bEUB3j95R/VHXV4bsNsU8Eu8pplbVCBjNbe2g0vhz1hoTHP/uAF
        97/ojRMbaSub3mqqC6wiv8hzCEWSjFvU5igE5MnJSjDtd9pTMR3mIjdT2DBBsYeOcT3h4y
        5N1++kgT/+d/SGjUdsVFUDZgygac/sJlAsUbDYNENJKuz3DvXxFT9GLwfqQvfA==
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EC8D20007;
        Fri, 16 Jun 2023 11:45:14 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, vadym.kochan@plvision.eu
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        enachman@marvell.com,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v6 0/2] dt-bindings: mtd: marvell-nand: Add YAML scheme
In-Reply-To: <20230530005337.3687938-1-chris.packham@alliedtelesis.co.nz>
References: <20230530005337.3687938-1-chris.packham@alliedtelesis.co.nz>
Date:   Fri, 16 Jun 2023 13:45:14 +0200
Message-ID: <87r0qbhbqt.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:

> Add YAML scheme for the Marvell's NAND controller
> to validate it's DT bindings. Old txt file is deleted,
> not included the compatibles and properties which were marked as
> deprecated.
>
> Also fix node name in cp11x DTSI acording to nand-controller.yaml
>
> I've picked up this series to hopefully get it over the line. I think I've
> addressed all the feedback from the last round of review.
>
> Vadym Kochan (2):
>   dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
>   arm64: dts: marvell: cp11x: Fix nand_controller node name according to
>     YAML


Both patch applied on mvebu/dt64

However if the first patch should be merged through another tree, let me
know.

Thanks,

Gregory


>
>  .../bindings/mtd/marvell,nand-controller.yaml | 190 ++++++++++++++++++
>  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ------------
>  MAINTAINERS                                   |   1 -
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
>  4 files changed, 191 insertions(+), 128 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
>
> -- 
> 2.40.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
