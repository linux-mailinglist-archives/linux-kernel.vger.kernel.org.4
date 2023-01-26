Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0867CC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjAZNlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAZNlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:41:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54024457FE;
        Thu, 26 Jan 2023 05:41:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3010B81DBE;
        Thu, 26 Jan 2023 13:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FCCC4339B;
        Thu, 26 Jan 2023 13:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674740498;
        bh=OfjvJlFHKnWvYxycX8NSllNoKHk1aH1b6L4NLVoak14=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KvJFq9K9eto2JqqoAFUOX/dUmibZpc3MmkO1gjyBIQE/GpBB6BeKWzVngDmJ8u2lm
         lB/oBz06HGHnjGWlVQDwIeD38j2xRbtUiSqknObpNRjWnzyipVFCeteJR1Mkqwtrpd
         fq709+RWXH67L6dHXvwDmTJURFGs3hjjoE0406BuusrGNKM+ajX3GvUX52f5tz/1dk
         DaxfprWiHcOGWBoFJ5cFi0Tx1sthjh+aLN62le3jrsrN8+m125eSwk4WUcWq/HE/3Z
         Fi4tirDCp5H2hrJlAntmw5TqAsPCpblvSBcLi/yIj9IrIqXgO6W5KMR9ShmoO6Rxu7
         FnTzio1ywds1w==
Received: by mail-vs1-f49.google.com with SMTP id 187so1877360vsv.10;
        Thu, 26 Jan 2023 05:41:38 -0800 (PST)
X-Gm-Message-State: AFqh2kr0fWORURRV4c8EiGUCQplZTp9ULoCUilfIuzNXaYNosPO5nc3u
        chAaOwsumvIzp9yU9qYy7Yjvcz0a+7UaUGVImw==
X-Google-Smtp-Source: AMrXdXsWENzKkYOuOdC+oVtMFqxH4XRwLpmuHN77BN9u4u6pqZ52lbeZfgKydbou4+U0NFA6ehsUq0i0oKKw3/eQRlM=
X-Received: by 2002:a05:6102:5490:b0:3b5:1fe4:f1c2 with SMTP id
 bk16-20020a056102549000b003b51fe4f1c2mr4864173vsb.0.1674740497377; Thu, 26
 Jan 2023 05:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20230125175943.675823-1-krzysztof.kozlowski@linaro.org>
 <20230125211329.GA2899932-robh@kernel.org> <afce38b0-be90-a3b5-f181-a88ad3025bd9@linaro.org>
In-Reply-To: <afce38b0-be90-a3b5-f181-a88ad3025bd9@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Jan 2023 07:41:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKpibaWgWXwhNFQ4U_tT0cdvUMO4attSsYqoSFmbq4RZQ@mail.gmail.com>
Message-ID: <CAL_JsqKpibaWgWXwhNFQ4U_tT0cdvUMO4attSsYqoSFmbq4RZQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: allow unit address
 in DTS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 4:48 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/01/2023 22:13, Rob Herring wrote:
> > On Wed, Jan 25, 2023 at 06:59:43PM +0100, Krzysztof Kozlowski wrote:
> >> The Samsung Exynos SoC USB 3.0 DWC3 Controller is a simple wrapper of
> >> actual DWC3 Controller device node.  It handles necessary Samsung
> >> Exynos-specific resources (regulators, clocks), but does not have its
> >> own MMIO address space.
> >>
> >> However neither simple-bus bindings nor dtc W=1 accept device nodes in
> >> soc@ node which do not have unit address.  Therefore allow using
> >> the address space of child device (actual DWC3 Controller) as the
> >> wrapper's address.
> >
> > The correct fix is 'ranges' should have a value. Though the whole
> > wrapper thing when there are no registers I dislike...
>
> You mean something like this (diff against this patchset):
> ----------
> diff --git a/arch/arm/boot/dts/exynos54xx.dtsi
> b/arch/arm/boot/dts/exynos54xx.dtsi
> index 08786fd9c6ea..75b6f9678672 100644
> --- a/arch/arm/boot/dts/exynos54xx.dtsi
> +++ b/arch/arm/boot/dts/exynos54xx.dtsi
> @@ -142,16 +142,15 @@ hsi2c_7: i2c@12cd0000 {
>                         status = "disabled";
>                 };
>
> -               usbdrd3_0: usb-wrapper@12000000 {
> +               usbdrd3_0: usb-wrapper {

Why did you drop the unit-address? Unit-address is valid with 'reg' or 'ranges'.

>                         compatible = "samsung,exynos5250-dwusb3";
> -                       reg = <0x12000000 0x10000>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> -                       ranges;
> +                       ranges = <0x0 0x12000000 0x10000>;
>
> -                       usbdrd_dwc3_0: usb@12000000 {
> +                       usbdrd_dwc3_0: usb@0 {
>                                 compatible = "snps,dwc3";
> -                               reg = <0x12000000 0x10000>;
> +                               reg = <0x0 0x10000>;
>
> ---------
>
> Unfortunately dtc W=1 is still not happy:
>
> exynos54xx.dtsi:145.26-159.5: Warning (unit_address_vs_reg):
> /soc/usb-wrapper: node has a reg or ranges property, but no unit name
>
> neither dtbs_check is:
>
> exynos5410-smdk5410.dtb: soc: usb-wrapper: {'compatible':
> ['samsung,exynos5250-dwusb3'], '#address-cells': [[1]], '#size-cells':
> [[1]], 'ranges': [[0, 301989888, 65536]], 'clocks': [[5, 366]],
> 'clock-names': ['usbdrd30'], 'pinctrl-names': ['default'], 'pinctrl-0':
> [[21, 22]], 'vdd10-supply': [[23]], 'vdd33-supply': [[23]], 'usb@0':
> {'compatible': ['snps,dwc3'], 'reg': [[0, 65536]], 'interrupts': [[0,
> 72, 4]], 'phys': [[24, 0], [24, 1]], 'phy-names': ['usb2-phy',
> 'usb3-phy'], 'snps,dis_u3_susphy_quirk': True}} should not be valid
> under {'type': 'object'}
>         From schema:
> /home/krzk/.local/lib/python3.10/site-packages/dtschema/schemas/simple-bus.yaml
>
>
> Best regards,
> Krzysztof
>
