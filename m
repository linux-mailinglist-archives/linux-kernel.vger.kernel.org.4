Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8E673272
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjASH2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjASH1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:27:44 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0D867787;
        Wed, 18 Jan 2023 23:26:55 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id w72so520872vkw.7;
        Wed, 18 Jan 2023 23:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5eBlM9S6kPg63OsVYn1WA2umDAvRg38VWyYh3hm2sLE=;
        b=JpWmIbOb6gGkwcWmUgDpSSEQv1xzP2/Tl2mmQx9xNr4nPJ8p3Bd7lSIDluXGUftiKL
         Dm1DvmGDZIgwZMy8Nx1ZqhpjgP0ArRFW4LU2092czG2wECa/3EoDu22/iXR6nRZnnaXa
         2yUUN9KGbOny7TSpcSMvmM4l4AFUrzNn4syiebiOzyaq3MdDU6HA8lhiMEZpmW8heIGp
         2vDY4aMpBK/dn+qE+7htDMBPYH4aq5ZJ/bc85OZb+OIVzkTHw5ZNNHc1+abyXPkyXBAe
         vdQZTQKOwUGUFyTIJFNM+KQnEg+DYliyXexND5P2GPJBCIoHToc+IEhZPIXZAO/J9j0r
         NgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eBlM9S6kPg63OsVYn1WA2umDAvRg38VWyYh3hm2sLE=;
        b=71P3YOT+mk5/hdgV/qy22bfEGUBnGgz2PmYXa+j8K0ei7ZtmBwI4rqgQZ+lixoDup5
         UUybekmfFEDM7tCDCPwoHsjHgDea8WzuKFc0EPl0QWurHlVn/piNG73Kpd+ZOZUt8Ucv
         qYHc2hC7A+iMSzYKB1C2s1lImKEX64n7jZcs6ReFR99L2pobC2wa8+i2Mt8nk+GhLDNU
         UYpmtCVGynx0r6fO2BosGNFCv5fcZOYOH73AVqOxRFLXNQ6ywNaRl5OPrj4hQmkTDHel
         Trsljocs4F2NMp0HDmiLH2fCJ5885QiP0NedX4oTqtgiY2IMhX/dUeXqHJmbPOI9onFW
         CR2Q==
X-Gm-Message-State: AFqh2koHzK0zqbGM5dbork6C0TygEOywORLINpxIGEanRbh6wGCbkE3m
        kauPvi//qcQXMJk43lPnWX4q9GMzYcaOp2Pn2+M=
X-Google-Smtp-Source: AMrXdXuSvgPxqgmv5vUfpRjUazPZC3WTcKs4WtJls/xAktAXsSGvHC5Wi7Qhm1/UVmUM73HjQTo8e3s3Dv9BMhuUjUk=
X-Received: by 2002:ac5:c917:0:b0:3d5:542b:7857 with SMTP id
 t23-20020ac5c917000000b003d5542b7857mr1385848vkl.29.1674113213928; Wed, 18
 Jan 2023 23:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20230118044418.875-1-linux.amoon@gmail.com> <20230118044418.875-8-linux.amoon@gmail.com>
 <b112ee8e-93ab-2c30-ced3-82ff858884b4@linaro.org> <CANAwSgQ1b8vj+HCBS0ARnNqOwKHU8VzzsB7htL3L4Sr_v6Y=VQ@mail.gmail.com>
 <0dbefaec-e1de-fc3f-54f2-c5fe75a28c7c@linaro.org>
In-Reply-To: <0dbefaec-e1de-fc3f-54f2-c5fe75a28c7c@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 19 Jan 2023 12:56:37 +0530
Message-ID: <CANAwSgRFGrVePVVWRQHHt_HvanBTVGfhej9MbNHh84+6eqypUA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] arm64: dts: amlogic: Used onboard usb hub reset on
 odroid c4
To:     neil.armstrong@linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Neil,

On Wed, 18 Jan 2023 at 18:54, <neil.armstrong@linaro.org> wrote:
>
> On 18/01/2023 12:55, Anand Moon wrote:
> > Hi Neil,
> >
> > Thanks for your review comments.
> >
> > On Wed, 18 Jan 2023 at 13:59, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>
> >> On 18/01/2023 05:44, Anand Moon wrote:
> >>> On Odroid c4 previously use gpio-hog to reset the usb hub,
> >>> switch to used on-board usb hub reset to enable the usb hub
> >>> and enable power to hub.
> >>>
> >>> USB hub is combination of USB 2.0 and USB 3.0 root hub so
> >>> use peer-hub node to link then.
> >>>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>> v2: - fix the compatible string.
> >>>       - Fix the hub node to use peer-hub to link the usb 2.0 and usb 3.0.
> >>> ---
> >>>    .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 36 ++++++++++++-------
> >>>    1 file changed, 23 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> >>> index 8c30ce63686e..d04768a66bfe 100644
> >>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> >>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> >>> @@ -26,20 +26,30 @@ led-blue {
> >>>        sound {
> >>>                model = "ODROID-C4";
> >>>        };
> >>> -};
> >>>
> >>> -&gpio {
> >>> -     /*
> >>> -      * WARNING: The USB Hub on the Odroid-C4 needs a reset signal
> >>> -      * to be turned high in order to be detected by the USB Controller
> >>> -      * This signal should be handled by a USB specific power sequence
> >>> -      * in order to reset the Hub when USB bus is powered down.
> >>> -      */
> >>> -     hog-0 {
> >>> -             gpio-hog;
> >>> -             gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
> >>> -             output-high;
> >>> -             line-name = "usb-hub-reset";
> >>> +     /* USB hub supports both USB 2.0 and USB 3.0 root hub */
> >>> +     usb-hub {
> >>> +             dr_mode = "host";
> >>
> >> Is this really needed ?
> >>
> > I got carried forward from the other device tree binding,
> > If not needed I will drop this.
> >
> >>> +             #address-cells = <1>;
> >>> +             #size-cells = <0>;
> >>> +
> >>> +             /* 2.0 hub on port 1 */
> >>> +             hub_2_0: hub@1 {
> >>> +                     compatible = "usb2109,2817";
> >>> +                     reg = <1>;
> >>> +                     peer-hub = <&hub_3_0>;
> >>> +                     reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> >>> +                     vdd-supply = <&vcc_5v>;
> >>> +             };
> >>> +
> >>> +             /* 3.1 hub on port 4 */
> >>> +             hub_3_0: hub@2 {
> >>> +                     compatible = "usb2109,817";
> >>> +                     reg = <2>;
> >>> +                     peer-hub = <&hub_2_0>;
> >>> +                     reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> >>> +                     vdd-supply = <&vcc_5v>;
> >>> +             };
> >>
> >> The final discussion in v1 was to drop this /usb-hub node and move the
> >> hub_2_0 & hub_3_0 node under the dwc3 node.
> >>
> >
> > Yes, but It did not work back then, since these are two different events
> > USB node will try to bring the PHY and dwc2 and dwc2 nodes up.
> > USB hub supports the reset of the USB hub and links the power supply
> > to the ports.
> > This works on this board.
>
> Forget the dwc2 node, the dwc2 since GXL is device mode only, so you need to put both
> nodes in the dwc3 node which is host-only.
>
> Neil
>
Ok, I will move this node under dwc3 node, in the next version.

> >
> >> Neil

Thanks
-Anand
