Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4D36D95FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbjDFLjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbjDFLip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:38:45 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA21A2;
        Thu,  6 Apr 2023 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YLWXUtPlBzNRctfCp3LF0O5qcqt639y98cAc4+5cpy0=; b=glPn+IesWMVvAEJ0FzHVYHlEFj
        mDPZh/l+MAcwkoHuEVHKHvWYjJKzKcO27aTPHOE/ZP3xxdayp+pqNxyEcn53jKLX+vE5ryB0vmGDm
        hucmfHkLa3t5buJXyt5Eab9FqtXZRimI8ppRc3PPfSjxj9ddEYev32YRD/yHWUZQ/h5W0puY9i0yg
        AlQeX+lvyLb8m8lKNkP9KmlUnNCQUafwrDG9zsD+Z17K82ir5hVTCV7ruIcxu9bABMniUZsUOSqOn
        bmxZx4yPp/bFR4DJepmG7R/XSEH+10DRX3Gt5SQmBV579k/RXppbMxCag/DNgKJ163mFRvLOdeLXF
        JePUuJtg==;
Received: from p200300ccff190e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff19:e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pkNsM-0002Aa-Vf; Thu, 06 Apr 2023 13:34:00 +0200
Date:   Thu, 6 Apr 2023 13:33:57 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
Subject: Re: [PATCH 1/2] dt-bindings: leds: ROHM BD2606MVV LED driver
Message-ID: <20230406133357.45e48bd3@aktux>
In-Reply-To: <f73050b7-3f86-0dcd-5e43-d8a9258afcae@gmail.com>
References: <20230406060825.103187-1-andreas@kemnade.info>
        <20230406060825.103187-2-andreas@kemnade.info>
        <f73050b7-3f86-0dcd-5e43-d8a9258afcae@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Thu, 6 Apr 2023 11:32:42 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Andreas,
> 
> Thanks for the patch! Adding new support for devices is Much Appreciated!
> 
> On 4/6/23 09:08, Andreas Kemnade wrote:
> > Document ROHM BD2606MVV LED driver devicetree bindings.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   .../bindings/leds/rohm,bd2606mvv.yaml         | 76 +++++++++++++++++++
> >   1 file changed, 76 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> > new file mode 100644
> > index 0000000000000..6d4ddd8d31162
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/rohm,bd2606mvv.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: BD2606MVV LED controller
> > +
> > +maintainers:
> > +  - Andreas Kemnade <andreas@kemnade.info>
> > +
> > +description:
> > +  The BD2606 MVV is a programmable LED controller connected via I2C that can
> > +  drive 6 separate lines. Each of them can be individually switched on and off
> > +  but the brightness setting is shared between two of them.  
> 
> Maybe add a link to data-sheet?
> https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/led_driver/bd2606mvv_1-e.pdf
> 
Maybe also (because it has the register description):
https://fscdn.rohm.com/en/products/databook/applinote/ic/power/led_driver/bd2606mvv_tsb_001_ug-e.pdf

> > +
> > +properties:
> > +  compatible:
> > +    const: rohm,bd2606mvv
> > +
> > +  reg:
> > +    description: I2C slave address of the controller.
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^led@[0-6]$":
> > +    type: object
> > +    $ref: common.yaml#
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 6
> > +
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: false  
> 
> According to the data-sheet, BD2606 has an enable-pin. Should it be 
> visible in the bindings?
> 
yes, it should.

Regards,
Andreas
