Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99426661007
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjAGPip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjAGPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:38:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4C043D84;
        Sat,  7 Jan 2023 07:38:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7E5AB8196F;
        Sat,  7 Jan 2023 15:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75179C43392;
        Sat,  7 Jan 2023 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673105916;
        bh=L1aDE2CoqF7LNTMW1trxeJ0+OLba8uY4pEtw1JvyfL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPTljTGqJldJtZ45K8MlXeV4NWxwDRu+5l1H/yI7MiUc+nM8ZvOLSCwysyd3F0rCa
         4kMklC3ePzm06mdY89Wcf/eYGZG8SgvL/6dPDHASTRMLK5/XJCDsQ1LPPLbrHTM2QN
         0js7x9ToONwDZobaGPyCfYY4PeuTNZqirniWFAgnllqjkh3MJ2ym75ACFhN2l3hMM2
         v6apSBTzwt9w5crl2e9VFkG7166RDbKeXBWC9dLnAI169d6TLkiKbl2VrFX8T9KrUv
         8rcINBW5DBqAJpNwK+OTULEpL6ChpdY6OdU/3U3N717M1UcGTQ74M93jA4zde41cyn
         cDRg36GSOtF9w==
Received: by mail-vs1-f48.google.com with SMTP id o63so4386700vsc.10;
        Sat, 07 Jan 2023 07:38:36 -0800 (PST)
X-Gm-Message-State: AFqh2koPO0Fr1fmU3swI+AbeOZjSi+YMHtQ+cOv8VWaw8Dbc0VTqASjt
        X4w7KL5XTGJKUdW1khyr9c+YlYqwzTWszgumFQ==
X-Google-Smtp-Source: AMrXdXtWoJGDMbKzwDrNPHbL8cBF4oNvv7HneFyWHJofeURhql0OMADVs348x9XyPsSXbqGBh4nk4NyPd4IwhieCS/M=
X-Received: by 2002:a67:fbd6:0:b0:3ce:c25f:ad85 with SMTP id
 o22-20020a67fbd6000000b003cec25fad85mr1293080vsr.6.1673105915424; Sat, 07 Jan
 2023 07:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-4-william.zhang@broadcom.com> <Y7iPS48viBg0QRok@sirena.org.uk>
 <3ff9a7fa-25dd-701c-078e-03e47bd3c08b@broadcom.com>
In-Reply-To: <3ff9a7fa-25dd-701c-078e-03e47bd3c08b@broadcom.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sat, 7 Jan 2023 09:38:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ7kr-6xs53NYJufem=wXnXVRnj3-1t1rG+W6g09kJ3ew@mail.gmail.com>
Message-ID: <CAL_JsqJ7kr-6xs53NYJufem=wXnXVRnj3-1t1rG+W6g09kJ3ew@mail.gmail.com>
Subject: Re: [PATCH 03/16] dt-bindings: spi: Add spi peripheral specific property
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 9:27 PM William Zhang <william.zhang@broadcom.com> wrote:
>
> Hi Mark,
>
> On 01/06/2023 01:14 PM, Mark Brown wrote:
> > On Fri, Jan 06, 2023 at 12:07:55PM -0800, William Zhang wrote:
> >
> >> brcm,no-clk-gate is a Broadcom Broadband HS SPI controller specific
> >> property for certain SPI device such as Broadcom ISI voice daughtercard
> >> to work properly. It disables the clock gating feature when the chip
> >> select is deasserted for any device that wants to keep the clock
> >> running.
> >
> > Why would this property be Broadcom specific?  Other devices could in
> > theory implement this.
> >
> It does not need to be Broadcom specific if other SoC's SPI bus
> controller support such function. I am not aware of such case but
> certainly I am no expert on other chips. I can put it in the generic
> spi-peripheral-props.yaml if that is what you suggest.
>
> >> +properties:
> >> +  brcm,no-clk-gate:
> >> +    $ref: /schemas/types.yaml#/definitions/flag
> >> +    description:
> >> +      Some SPI device such as Broadcom ISI based voice daughtercard requires SPI
> >> +      clock running even when chip select is deasserted. By default the
> >> +      controller turns off or gate the clock when cs is not active to save
> >> +      power. This flag tells the controller driver to keep the clock running
> >> +      when chip select is not active.
> >
> > This seems problematic with any host controlled chip select support...
> >
> Yes those ISI chip based voice cards do need such strange requirement
> and will not work with other controller.  That is one of the reason I
> put this as Broadcom specific option.

Keeping the clock on or not would affect all devices unless you have a
per device clock you can gate, so making this a per device flag
doesn't make sense.

If this is a requirement of the slave device, then the device's
compatible string can imply the need for this and its driver can tell
the host controller in some way.

Rob
