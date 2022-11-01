Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA86149F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKALxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiKALwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:52:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7FE1BEA1;
        Tue,  1 Nov 2022 04:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0C12B81CC1;
        Tue,  1 Nov 2022 11:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B42DC43142;
        Tue,  1 Nov 2022 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667303434;
        bh=b9DuYeJ8UAyKN4iunSt8QITKWhgj/OI7HXDzc4+2l1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UYRKmAH9YdIMxLU8EIhuvvnbpOp7f11/bypSfTgAnJ565eqzNIZhOubyyXnOkFswX
         rhxW/gDb/p+cg9Lu0k0BFY9UoeX9g+O320lJ4oyNnP39nPcim7deDVUf6OcbZAz/i3
         zHvY+drmkwx21kwgXW1OfmfPT0Te1NND2AK6kynHuFF0rqSGxEqrD629HK7QXRFz+V
         Le522I8ivpz1IgpVuvWozjhySVwzSABDDZkwEjdKqI51HxP9ORUYEvx7pXo+rTWQ9l
         aMxApK4Kt9dNwjIF60jmsZlHYfRYvz0WxGzXm2ghiWZpCemYMCfygsCZWQ0pFASGoR
         CsU8sKuJgpGYw==
Received: by mail-lf1-f52.google.com with SMTP id t4so10102074lfp.2;
        Tue, 01 Nov 2022 04:50:34 -0700 (PDT)
X-Gm-Message-State: ACrzQf3ExM1ZhFcAohp/pUws3qOdk8rf+u8UQzY+GN/iaD5Z/lCN6vZo
        TbPe/bkf+K3WtSfuQGtHPFYwSNuyiVzMSPQLZw==
X-Google-Smtp-Source: AMsMyM5KpWl/s5M/2RwB97O0OoBTIFMD/4tFktgErD2EfbHM6BU8nZZywCB3++o+IvLHYAQ1WNuxKb0WTeinXEUk2sM=
X-Received: by 2002:a05:6512:3e10:b0:4a2:48c1:8794 with SMTP id
 i16-20020a0565123e1000b004a248c18794mr6906292lfv.17.1667303432390; Tue, 01
 Nov 2022 04:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221026114908.191472-1-alistair@alistair23.me>
 <20221026114908.191472-3-alistair@alistair23.me> <Y2BfCkVhE9GNdjWI@google.com>
In-Reply-To: <Y2BfCkVhE9GNdjWI@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 1 Nov 2022 06:50:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKppGZ2Dm3GiDY-e4TvLSvcc-EHwafXNwfoSD1AHzz=GA@mail.gmail.com>
Message-ID: <CAL_JsqKppGZ2Dm3GiDY-e4TvLSvcc-EHwafXNwfoSD1AHzz=GA@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] dt-bindings: input: Add Cypress TT21000
 touchscreen controller
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        shawnguo@kernel.org, rydberg@bitmath.org, alistair23@gmail.com,
        s.hauer@pengutronix.de, andreas@kemnade.info
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 6:49 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Oct 26, 2022 at 09:49:06PM +1000, Alistair Francis wrote:
> > Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> > documentation. It can use I2C or SPI bus.
> > This touchscreen can handle some defined zone that are designed and
> > sent as button. To be able to customize the keycode sent, the
> > "linux,code" property in a "button" sub-node can be used.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Applied, thank you.

It looks like you applied v8, not this version. linux-next now has a warning:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dtb:
touchscreen@24: Unevaluated properties are not allowed
('#address-cells', '#size-cells' were unexpected)
        From schema:
/builds/robherring/linux-dt/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

>
> --
> Dmitry
