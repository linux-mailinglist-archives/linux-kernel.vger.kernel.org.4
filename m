Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF51671C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjARMeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjARMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:33:49 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CCF2411A;
        Wed, 18 Jan 2023 03:55:29 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id j185so4311102vsc.13;
        Wed, 18 Jan 2023 03:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFwEIEOiSaW9hXN4k5YwZLmqm93pKj/xVyynsfLQsUA=;
        b=R0kiAqJYRSp/UTQPUDyGlM8oim8OrtDNUFJ/VlCzx/Xz4ZdBcong/DY/nekEOAdtzM
         CLy/t1aqHPjL/uJQ/6UxMuJeW60mzLgWwDh3uoUmrVidKcel2SUYy7Fi/8mAWrclK+lL
         QeEgNCtgZ/f3je+Ds1lpR3Cc9qf6AoHP45CFGBx8gMCVTPx7o2MJgBbA3tsy8a4ywpTI
         ir2+Hmy4s6s2FBFNsUHTkce82EOHqXSZkdskCfGSwfnyMRX1419R/Mg4+5z/VP9VE0wk
         JIQyOGYUTaaBpEzB57nMeLemi4zy93VSIX8cVse8V00WmdgaL6mms/wKjnasesQBub6R
         Vqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFwEIEOiSaW9hXN4k5YwZLmqm93pKj/xVyynsfLQsUA=;
        b=WqIvbw+dpMZ+PvfoZauDDxvJwontdo6b602Xnwx8O3EpTH6/iHjUSwRKA+lzONZNfv
         IqDZXpDqVMDDnCr1EDDu6EXGrHlc0+0K8w3ssKnWccKP3lKKNfOvEKnrjBJJ5BI6JRZd
         gJQneW1/DUq3VK7IyprySLhiv5Z65vbXLCvxZQiglF2XLWRY4jg0SjLtQSXsYmb2cFQM
         g3iVWvzJC7Nwevb/hBazEGZE2iAfgITyccdWg8U0J8SwTxfIZ2XamAkHXA7xi3gZbP03
         mQ0yYzFJDKi6qP3nWBN15a72o6fjNtW9p04S57wjfnhkPO+NwsXLRIoXMqzIfMVKWW8F
         Kr8g==
X-Gm-Message-State: AFqh2kpVGrtCJGAORFt2gKpZq3Mj9tj0bANuNNKAzqRMjzDrYQqMRQK9
        tDxcwxqO1PAZPPbZNz+cWjTEJr3BdC5znPirDaI=
X-Google-Smtp-Source: AMrXdXskNkq+CbqgiO87f6+YCzqH7CO6djk3enoyI29WdSBF6Z/zFZS74ORoGWFWatnmI3x1aSC6mTW4xu2ljMf6pow=
X-Received: by 2002:a67:e14a:0:b0:3d3:f10a:4f56 with SMTP id
 o10-20020a67e14a000000b003d3f10a4f56mr891572vsl.10.1674042928915; Wed, 18 Jan
 2023 03:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20230118044418.875-1-linux.amoon@gmail.com> <20230118044418.875-7-linux.amoon@gmail.com>
 <2c17eaa5-ee93-58c5-a35a-8366eb4cfc36@linaro.org>
In-Reply-To: <2c17eaa5-ee93-58c5-a35a-8366eb4cfc36@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jan 2023 17:25:14 +0530
Message-ID: <CANAwSgRJ6Tek7NxSfsExkrWrQ94Ro8mmitoWm3wfrg7NKbO+Lw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] dt-bindings: usb: Add binding for Via lab VL817
 hub controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your review comments.

On Wed, 18 Jan 2023 at 13:49, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/01/2023 05:44, Anand Moon wrote:
> > The VIA Lab VL817 is a USB 3.1 Gen 1 hub and USB 2.0 hub
> > controller that features 4 downstream ports and 1 otg, with
> > an internal 5V regulator and has external reset pin.
>
> Subject: drop second/last, redundant "binding for". The "dt-bindings"
> prefix is already stating that these are bindings.
>
Ok
> >
> > Add a device tree binding for its USB protocol part.
> > The internal LDO is not covered by this and can just be modelled
> > as a fixed regulator.
> >
> > Add combo of USB 2.0 and USB 3.0 root hub using peer-hub.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2 - fix the compatible string and fix the $id
> >    - update the commit message.
> >    - update the example for use peer-hub node because it
> >      combo of USB 2.0 and USB 3.0 hub.
> >    - rename the yaml file from vialab,vl817q7.yaml to vialab,vl817.yaml
> >      as q7 suffix is ued for USB 3.1 and q5 suffix is used for USB 2.0.
> > ---
> >  .../devicetree/bindings/usb/vialab,vl817.yaml | 69 +++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
> > new file mode 100644
> > index 000000000000..5f9771e22058
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/vialab,vl817.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Via labs VL817 USB 3.1 hub controller
> > +
> > +maintainers:
> > +  - Anand Moon <linux.amoon@gmail.com>
> > +
> > +allOf:
> > +  - $ref: usb-device.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
>
> Drop items
>
Ok,
> > +      - enum:
> > +          - usb2109,2817
> > +          - usb2109,817
> > +
> > +  reg: true
> > +
> > +  reset-gpios:
> > +    description: GPIO controlling the RESET# pin.
>
> maxItems
>
Ok,
> > +
> > +  vdd-supply:
> > +    description:
> > +      phandle to the regulator that provides power to the hub.
> > +
> > +  peer-hub:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle'
>
> Drop quotes
>
Ok,
> > +    description:
> > +      phandle to the peer hub on the controller.
> > +
> > +required:
> > +  - peer-hub
> > +  - compatible
> > +  - reg
>
> Keep same order as in properties: part.
>
Ok
> > +
>
> Best regards,
> Krzysztof
>

I will update these in the next version.



-Anand
