Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E0567B843
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjAYRRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjAYRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:17:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0110437549;
        Wed, 25 Jan 2023 09:16:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E7961576;
        Wed, 25 Jan 2023 17:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE22BC433A7;
        Wed, 25 Jan 2023 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674667003;
        bh=UVy49VwAMvNvfly1owkooWr3fc9DSt30v0h99b71T2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uaD9EW7rjHHXbvhkf/mp5jKQdeoxq6Q82JD9py3lRSGJ6YjIVsjVf7GxAAoMMX+71
         +V10qssso3Ag4IW5LJ62BRHZ6e8cyVC07FyIyMZYeIbyRAjAAvf6GsruIDnUTnC4/d
         c0lYc2u21KEBjswd+mvjS6g5Zr6HragxahqZP77bUJULBm+k/nO1uOl93+N+0biEHb
         +fbH4heOSQtRyxm42Vsx7wZ24ppGvpxwnpp59CZnHdEvIWDOSDTiiNGSwZlQUUULWf
         6FuQj23lRCvsRdFFZlxl0YtYoEb42mzsWHjLvSiwAM7dAasHH3HYaF9mE+VoyQX0qB
         c6cGfGn2QbMLg==
Received: by mail-vs1-f45.google.com with SMTP id j185so20391060vsc.13;
        Wed, 25 Jan 2023 09:16:43 -0800 (PST)
X-Gm-Message-State: AO0yUKXFy3PujAmtBhi2wM5GinzH4/QjwLUEj4xDDH/a0NMfhzRl1aX8
        J+XQEfhe1iNcxYJWPGgfI4q3jNpD94WlBX/N0w==
X-Google-Smtp-Source: AK7set/9MH2+8m/u8CsJY1QynMiZjKxMVjlsPnhguaIoTxMs8JGmoZA4y6kFqKQs9YuW49fZGC5DK93+2plS+rfNt00=
X-Received: by 2002:a67:fe41:0:b0:3ea:c8c:48a5 with SMTP id
 m1-20020a67fe41000000b003ea0c8c48a5mr91271vsr.53.1674667002782; Wed, 25 Jan
 2023 09:16:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674409777.git.daniel@makrotopia.org> <7c680bf2502ddfd2077306a46c69728d212386f9.1674409777.git.daniel@makrotopia.org>
 <20230123225943.GA2781371-robh@kernel.org> <Y88eMrwDmSZ2xovw@makrotopia.org>
In-Reply-To: <Y88eMrwDmSZ2xovw@makrotopia.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Jan 2023 11:16:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLnuJKhm46dSShtkwW1o9tQNbHQ9bCd-9U5UqMij3J-0Q@mail.gmail.com>
Message-ID: <CAL_JsqLnuJKhm46dSShtkwW1o9tQNbHQ9bCd-9U5UqMij3J-0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: add bindings for MT7981 SoC
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 5:56 PM Daniel Golle <daniel@makrotopia.org> wrote:
>
> On Mon, Jan 23, 2023 at 04:59:43PM -0600, Rob Herring wrote:
> > On Sun, Jan 22, 2023 at 06:23:55PM +0000, Daniel Golle wrote:
> > > Add bindings for the MT7981 pinctrl driver, based on existing MT7986
> > > pinctrl bindings.
> >
> > What existing bindings? A .txt file you need to remove, or undocumented,
> > but in use somewhere (where?)?
>
> What I meant to express is that I used the existing
> mediatek,mt7986-pinctrl.yaml file as the template to create a similar
> document for MT7981. I guess my English was not clear enough.

No, I just missed the 1 digit difference...

> Maybe better like this?
>
> "Add bindings for the MT7981 pinctrl driver. As MT7981 is simiar to
> MT7986, the existing mediatek,mt7986-pinctrl.yaml was used as an example
> to create a similar document covering MT7981."

Describe how the h/w is similar or different. Can they share the same
schema doc? I'm guessing all the if/then schemas for pins/groups are
different, so no. But I shouldn't have to guess.

Rob
