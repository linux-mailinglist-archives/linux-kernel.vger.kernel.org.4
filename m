Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1868746A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjBBEZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBBEZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:25:37 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2E179F2B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:25:36 -0800 (PST)
Received: from [172.16.71.140] (unknown [49.255.141.98])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 22A4720009;
        Thu,  2 Feb 2023 12:25:26 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1675311930;
        bh=3a00ksI9FfaCnwNIF6Fz6sO/kXtD3TGtq1wMQcLK9F8=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=MLoBMjnWXWPeC13H4DN4j/NBgrm0DXcVDGeRWcza3TiR/HERr0p+akVjEcUpBViMF
         274YWteqCja1+khCSuHYvtwaRXgDIG1kIFM1eBBUxCNzt2siO4giedxK1m3igvY1Np
         6xpQhHgJa6J5eezt81EJoXkDUWzcNUdNupNOvi7JHN2/YJWbc0rRqVMEFssxfoc0sJ
         5vhrVNTne8eaBu3DpE/Mx9sxkigg8B3aaR5j8im7csuyzTbUq+evrAZeNShiNzVE9j
         Hict9qwaZtw4/TzLYnr0meCttYcqoC8C3yPtXZJohpkTq2kmWwgnqnQ2DkBolSjEHt
         nM9k60P52J8ng==
Message-ID: <c227fa62c1040c7c280f1a6559dcf4cf8fb40428.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/3] dt-bindings: i2c-ast2600: Add support for
 AST2600 I2C global controller
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Feb 2023 12:25:26 +0800
In-Reply-To: <20230201103359.1742140-2-ryan_chen@aspeedtech.com>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
         <20230201103359.1742140-2-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

> AST2600 I2C global register controller, add bindings document
> to support driver of i2c global register set.

[...]

> +allOf:
> +=C2=A0 - $ref: /schemas/i2c/i2c-controller.yaml#

Are you sure about this? This particular binding doesn't describe the
i2c controller.

> +
> +properties:
> +=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0 enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - aspeed,ast2600-i2c-global
> +
> +=C2=A0 reg:
> +=C2=A0=C2=A0=C2=A0 minItems: 1
> +=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: address offset and range o=
f bus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: address offset and range o=
f bus buffer

Seems to be a duplicate here.

Cheers,


Jeremy
