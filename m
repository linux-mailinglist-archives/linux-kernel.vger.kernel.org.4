Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EDF67CCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjAZN56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjAZN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:57:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82A5A5EE;
        Thu, 26 Jan 2023 05:57:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6F6361812;
        Thu, 26 Jan 2023 13:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49963C4339E;
        Thu, 26 Jan 2023 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674741427;
        bh=A4FypTxPt7KtjZ3a/ZCUVPqWgiTChOiIy6RcBgD/1JU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gkaXnwVcYEjaV9cKX+jk22movsCf0mow5QoNroNM4enlyYMVrd0BX9SSSpVKG4aKB
         kKJcyiYU1Ibl/HIC9y+rRzltRAIiFTkyDCnl2iAO9vlc+6Z6pJsKr1Fb6avi6aPMMF
         Ahq3Vu/tWoCf1/CKnYJCeD9Tp16XP45lf+BTFzvv9BnrkpdYfF9pzx5Lu/JuwSiVzc
         CW0vbZrYiPEMLAI40mKDt5QDtkrhXGO6hv59TK98b2mxfWa+U8fvKf6gcIE84P12gL
         WBdnpj7uRr65R5ca5j/N3VHMzdkU9cyQYT4kk9jFQ0EbqmE4oK1RnU+TIU9wnQ8y0C
         wrYll7Oqn7Xug==
Received: by mail-vk1-f174.google.com with SMTP id v81so910962vkv.5;
        Thu, 26 Jan 2023 05:57:07 -0800 (PST)
X-Gm-Message-State: AFqh2ko+7suRGPphN7Mbvkp0TaD6xBPKO15MW01+etfC+QLLHrnLzOX+
        XBK2/lcq49J6FDbQko7cw98fZhOjMEVdYSmyVg==
X-Google-Smtp-Source: AMrXdXvRhY3YBxnwfuP26lobnBE5EYhYWq39LHxcmJlb1XlBGvEHYkW37o5avlOJSpGKu8CjXvG7+ZOtuESLmcYg5mQ=
X-Received: by 2002:a1f:a002:0:b0:3d5:d30f:81c2 with SMTP id
 j2-20020a1fa002000000b003d5d30f81c2mr4632814vke.14.1674741426154; Thu, 26 Jan
 2023 05:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-3-william.zhang@broadcom.com> <abedd2e8-3c7e-f347-06af-99f2e5a2412b@linaro.org>
 <ee4727e1-5705-edb0-c724-2ae4d4d1a8e2@broadcom.com> <20230125205123.GA2864330-robh@kernel.org>
 <1489564a-59d3-6d38-fad7-02119bfedbeb@broadcom.com>
In-Reply-To: <1489564a-59d3-6d38-fad7-02119bfedbeb@broadcom.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Jan 2023 07:56:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL3CYCdamv15-kzvMgoYVpftJ0DoyB5L=LGVi-54GXP5Q@mail.gmail.com>
Message-ID: <CAL_JsqL3CYCdamv15-kzvMgoYVpftJ0DoyB5L=LGVi-54GXP5Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] dt-bindings: spi: Add bcmbca-hsspi controller support
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 3:41 PM William Zhang
<william.zhang@broadcom.com> wrote:
> On 01/25/2023 12:51 PM, Rob Herring wrote:
> > On Wed, Jan 25, 2023 at 11:23:52AM -0800, William Zhang wrote:
> >> On 01/24/2023 11:35 PM, Krzysztof Kozlowski wrote:
> >>> On 24/01/2023 23:12, William Zhang wrote:
> >>>> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
> >>>> controller. Add new compatible strings to differentiate the old and new
> >>>> controller while keeping MIPS based chip with the old compatible. Update
> >>>> property requirements for these two revisions of the controller.  Also
> >>>> add myself and Kursad as the maintainers.

[...]

> >>>>    properties:
> >>>>      compatible:
> >>>> -    const: brcm,bcm6328-hsspi
> >>>> +    oneOf:
> >>>> +      - const: brcm,bcm6328-hsspi
> >>>> +      - items:
> >>>> +          - enum:
> >>>> +              - brcm,bcm47622-hsspi
> >>>> +              - brcm,bcm4908-hsspi
> >>>> +              - brcm,bcm63138-hsspi
> >>>> +              - brcm,bcm63146-hsspi
> >>>> +              - brcm,bcm63148-hsspi
> >>>> +              - brcm,bcm63158-hsspi
> >>>> +              - brcm,bcm63178-hsspi
> >>>> +              - brcm,bcm6846-hsspi
> >>>> +              - brcm,bcm6856-hsspi
> >>>> +              - brcm,bcm6858-hsspi
> >>>> +              - brcm,bcm6878-hsspi
> >>>> +          - const: brcm,bcmbca-hsspi-v1.0
> >>>> +          - const: brcm,bcmbca-hsspi
> >>>
> >>> Why do you need "brcm,bcmbca-hsspi"? Nothing binds to it, so it's
> >>> useless and very generic.
> >>>
> >> This was from Florian's suggestion and Broadcom's convention. See [1] and
> >> you are okay with that [2].  I added the rev compatible and you were not
> >> objecting it finally if I understand you correctly.
> >
> > Can you have a driver that only understands what 'brcm,bcmbca-hsspi' is
> > work on all h/w that includes the compatible string? It doesn't seem
> > like it since v1.1 is a completely new driver. Therefore
> > 'brcm,bcmbca-hsspi' is pretty much useless.
> >
> 'brcm,bcmbca-hsspi' should be added to the binding table of
> spi-bcm63xx-hsspi.c driver.   This is the initial driver that works for
> v1.0 controller.  For v1.1 controller, yes it can fallback and work with
> 1.0 driver spi-bcm63xx-hsspi.c simply not using the new feature in
> v1.1(chip select signal control through software) and keeping using the
> prepend mode or dummy cs workaround supported in 1.0 driver.

If v1.1 is compatible with v1.0, then say that:

soc-compat, "brcm,bcmbca-hsspi-v1.1", "brcm,bcmbca-hsspi-v1.0"

IOW, 'brcm,bcmbca-hsspi' is redundant with 'brcm,bcmbca-hsspi-v1.0'.
They have the same meaning. So pick which one you want to use. Not
both.

Also, if that is the case, you shouldn't be introducing a whole new
driver for v1.1.

Rob
