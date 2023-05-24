Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241E70F602
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjEXMPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXMPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:15:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B60D130;
        Wed, 24 May 2023 05:15:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f9cfa7eddso152484766b.2;
        Wed, 24 May 2023 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684930513; x=1687522513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sUEzEX3IxY8Nj/uA0tEcwms+OAaTSJtcQdltzfG1TQM=;
        b=X/G1NRsS65NS3/nroiKeHVMFrgfmO06b1WCf9NBEt/zESPE47jw43hqRGOAShFpJE1
         m3xTu1TjLQMjTgoqDmVUZDyyzU+a73NtinuXY5ckIzQysyIOpXo1M0SM0qStrdIeekUi
         R3/tDDkULOtYtQ3A+VMR4+u88WPvDgZlz4jmSvCrI6Rw6mVnE8R5UT+HiB0mvhHS943V
         CznrLkLGsxNCrfXDWJUd4jL+UP2LUKr3KtZm3nuiTtkGOvoh+OVqIikKR3QINUszw30m
         YV1e62+euP4Zvn4f7sRunatEnf80HQsWQYwxtUvjyelOFbKOSyWcQ9aHnRUcTDX1apva
         RRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684930513; x=1687522513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUEzEX3IxY8Nj/uA0tEcwms+OAaTSJtcQdltzfG1TQM=;
        b=ecKzj4DxxtOFTLd8cxJoymIzFDOERoYSTPr9gEkVVEcjIue2SeYCMZIxbs4pEdoFkI
         ezwK7A9F5goUdgSMkSgnv/dTukKwSxUt5Oj4bvhP4eSNflNX95/JH8BbMOOTFfgMkJnT
         jNwbXaMD9y9p52Qa8F0mqP2taOLvwVvo0SsYW/KDx2k0rWJ0I8qR67YiljM00R2LuaXH
         o6v4TKhpJOhiTNvOBglrsCk6Dqbiu8Au/dXqdqwVbYouQEVFsEYX/AumevIwfedPpCXN
         fmiOB6KDE5lhyqEt1l3xNBbLuyzohX30Uhu9y0RNXDdNNerQOS+mR9iGjsFPTmcVZNXa
         2zxA==
X-Gm-Message-State: AC+VfDzp3zn4CepPkesjngbC7CXliMkV0C8PAGFsH6y7rwjIeHng4ePY
        C7ygFWpR4t2aAhHsqQ5+72l2z/oMDVS+zuLtQcI=
X-Google-Smtp-Source: ACHHUZ51AUAOCcHb4T/Z3x9qqA2jZVV2HPi2un7zsMK9HeI68/1biA1xYkNAn9I+KTD2GDPMckgYEPnNIWHEvtCefbA=
X-Received: by 2002:a17:907:72d2:b0:973:8198:bbf6 with SMTP id
 du18-20020a17090772d200b009738198bbf6mr2018665ejc.3.1684930513259; Wed, 24
 May 2023 05:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
 <20230524082744.3215427-2-bigunclemax@gmail.com> <20230524110105.4928906c@donnerap.cambridge.arm.com>
 <ZG3vzxWicUgndMqv@smile.fi.intel.com>
In-Reply-To: <ZG3vzxWicUgndMqv@smile.fi.intel.com>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Wed, 24 May 2023 15:14:54 +0300
Message-ID: <CALHCpMhhUnkko7COzg6W9AqLUfwzKA+EAmcZ+Vwmy_7KB=UdWg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/4] iio: adc: Add Allwinner D1/T113s/R329 SoCs GPADC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andre Przywara <andre.przywara@arm.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Przywara <andre.przywara@arm.com> wrote:
> Or we follow the other idea of reading the number of channels from a DT
> property, which means we would already support every IP with up to 16
> channels, without further driver changes in the future.

I like this idea. This will rid us from duplicating code, and we could also
use a common DT node for D1 and T113.

> Is there any particular reason you chose a regmap to model this here?
> Isn't that just straight-forward MMIO, which we could just drive using
> readl()/writel()?

Actually there is no special reason. I just made it in the same way as
in the sun4i-gpadc-iio driver.

> I wonder if this should be either moved out to some multiplexer: the DT
> bindings suggest that such a thing could be independent.

Sorry I didn't quite get it :)

> But at least we could cater for the possibility that this channel is
> already selected, and skip this part then?

Thanks for that suggestion.

> Couldn't taking the lock go into the function? It seems to be only one
> caller,

Yes, we could. Thanks for the remark.

> and we need the lock in any case, it seems?

This lock is used in others ADC drivers to protects a read access from
ocurring before another one has finished.


Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> Even though regmap adds a few nice features that might be used.
> For example, locking. But I dunno if this driver actually uses it
> OR uses it correctly.

Just I wrote above, I made it in the same way as in the
sun4i-gpadc-iio driver

> > > + config = of_device_get_match_data(&pdev->dev);
>
> Please, avoid using OF-centric APIs in the new IIO drivers.
>
> config = device_get_match_data(&pdev->dev);
>
> should suffice.

> > + irq = platform_get_irq(pdev, 0);
> > + if (irq < 0)
> > + return dev_err_probe(&pdev->dev, irq, "failed to get irq\n");
>
> > > We should not repeat the message that printed by platform core.

> > > + ret = devm_request_irq(&pdev->dev, irq, sun20i_gpadc_irq_handler,
> > > + 0, dev_name(&pdev->dev), info);
>
> You can simplify your life with
>
> struct device *dev = &pdev->dev;
>
> at the definition block of the function.
> > > + .data = &sun20i_d1_gpadc_channels[1]
>
> Also, leave comma here.

Thanks for the remarks, I'll fix this in the next version.
