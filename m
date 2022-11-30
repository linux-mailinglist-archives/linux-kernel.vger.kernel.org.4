Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72863D16B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiK3JJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiK3JJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:09:10 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA93F061;
        Wed, 30 Nov 2022 01:09:09 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so10798177oti.5;
        Wed, 30 Nov 2022 01:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B04fj9P00rqNhYYFd7+/64238rHa0D4FG/P5nQ2+7wA=;
        b=mDQvEm1QplQg6YYyArNrM+4YH1l2ZwXmiBdYl+pswyW6I5sLmbPz+bUOW4saQgm5SV
         RMRttnO718bCX4d3B+3FwynDrnMldjqGzetgTSaNlnVtSvj+4xku8XUOP8A/dgHajeJk
         G2H67Y/u8tSQwfwqME8/zkA+9/kIHQEsf0QU+bEcJuekgJ2jbgemUkdGgjZjfmdz99/+
         zJq9gQyWw8I31QzZ+DqfYr1UCpDwHfMaX5ZqsEfjJ6OPhnHVg1pOT211oX8D9BuMpbtz
         ro+HKT4vqeAsQP94N3hhmkGgz/mkzFcctqftEofv/88pdAlXzy04dWkeQpvv7tBO/1+S
         TjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B04fj9P00rqNhYYFd7+/64238rHa0D4FG/P5nQ2+7wA=;
        b=NTaaLz0jp0j1SSURrBE89/NuSRuHElb1nfWJHn/0eP7IGqkDD5aULdyjLrYkVgwn4H
         dVyRuYtnhJ96W/v4w2nM9D1yfIVjYp+BEqN6SK2cl/9bc2FhUGRmAsal0Kzdj2eO+Rjw
         ADmGWDx4Ut6CWBELee41jupYrxnqAYGA06obWP25XhAIVs23mXVLPyuhtpl8o62/Z9j1
         14cnVMGEEObgs4rptXKB99JMMXtV5pLcmrq+DGKcnPKqLfbwTzMhzP1DmuQVJmhkYUXH
         ni7kZpnzrITqpSHiltWV393aUOa2K5y8YsQITFvoNbVapJutbf0XPR4THuARRgN9cfF6
         J6Qg==
X-Gm-Message-State: ANoB5pnDwEQwIWXdxIWkhiWkC8rm4p0441mr8V5NaPYLXltoRJL8y9fk
        QrKj85EAMUMG6Hlhu/+hsyuDDvkViASeVeQ9F2Q=
X-Google-Smtp-Source: AA0mqf4iveLTZYV/xPRmj2emARsFD/Nu70y1nVjqfEd3HoFurktQjGnoPWWEZdf5U2qztxEjQN3owWB4HNcmz+Z3LBs=
X-Received: by 2002:a9d:161:0:b0:66e:65dc:18e1 with SMTP id
 88-20020a9d0161000000b0066e65dc18e1mr2106886otu.83.1669799349116; Wed, 30 Nov
 2022 01:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
 <20221128020613.14821-8-xiangsheng.hou@mediatek.com> <9985d44e-977e-d7ea-0932-4879a3ccd14d@linaro.org>
 <f83184ae803dbe0afd37a31a8a83a369a9772880.camel@mediatek.com>
 <08ebc76a-0220-f984-b546-23dba8677be9@linaro.org> <741d7ce16df25450b08c92e508190bc7c91fc8d9.camel@mediatek.com>
 <bc356f96-600a-64df-c0fe-00c807fa605c@linaro.org>
In-Reply-To: <bc356f96-600a-64df-c0fe-00c807fa605c@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 30 Nov 2022 17:08:57 +0800
Message-ID: <CAJsYDVKdV7Pzt4fhc+OFWto6hK9U=WBe7LkPZU5sJHX1nyXTDw@mail.gmail.com>
Subject: Re: [PATCH 7/9] dt-bindings: spi: mtk-snfi: add two timing delay property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Nov 30, 2022 at 4:35 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> >>> Will change to other private property. The read sample delay with
> >>> MediaTek SPI NAND controller can be set with values from 0 to 47.
> >>> However, it`s difficult to say the unit of each vaule, because the
> >>> unit
> >>> value will be difference with different chip process or different
> >>> corner IC.
> >>
> >> Why you cannot use same formula as other SPI drivers for sample-
> >> delay?
> >> And divide/multiple by some factor specific to SoC, which is taken
> >> from
> >> driver_data?
> >
> > Even for specific SoC, the unit of sample delay may be various with
> > different corner IC.
>
> Which is easy to achieve with driver_data as I said.

I think Xiangsheng means this:
This sample delay isn't achieved using a fixed clock signal. It's
probably some kind of delay circuit whose delay value varies
due to its manufacturing process. Every single chip made got
different delay units, so it's impossible to specify a single unit
for one chip model.

If that's true, shouldn't this be a value calibrated on-the-fly
on probe instead? A single device-tree is supposed to be
applied to all devices of the same model, so a value that
varies on a device-by-device basis probably shouldn't
be a device-tree property.

-- 
Regards,
Chuanhong Guo
