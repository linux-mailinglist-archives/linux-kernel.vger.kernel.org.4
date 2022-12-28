Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B56576A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiL1Mvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiL1Mvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:51:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25108E5D;
        Wed, 28 Dec 2022 04:51:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t17so38164301eju.1;
        Wed, 28 Dec 2022 04:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bj/ZL2pLmcXfsa7o3GSd/7KGOVFsIvFAmCWaGTxxqbg=;
        b=TJKeuhAUb7ZbCaOdrTkQUd7Z/r49zaO58n0Zv4PflVM5kx/E7dGV7Bc8K1rzlnXGEj
         i5o3LcLDVH1m6fmvJqG0lX7Clr1Cn3YwbUrX7EZxgiXcTAMJgarkvDCjxSjkltL99D9Q
         e4Y8QxpsD/fgWvSA59zanzRiabPEgKbp5bcWE6Gzk2qBM85zIjxTsYnYq6LkZwZvofYE
         BCE3jA11Wb3kiIaaAzEHrfNjmCbsUungBSriRinw3u098ZSp+HznCc88mIRX6XfgJbd0
         WcO0vhFxIFZeMAUuEiMv7hHPcSMCn7Qk/pmWtBgvSPEgC2VybeF1eWfXp12QL1KETVQ8
         D23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bj/ZL2pLmcXfsa7o3GSd/7KGOVFsIvFAmCWaGTxxqbg=;
        b=Ur8pSF6vIFErYk8XwRRH8pdXVeETwxSNbHjOPXVfoFWBuZBP+AlKEiP3Do27BCly9H
         x2Q3MBg7Fh5dKUcENL3O5RRP/7PXMbPFfR6b12Rlh29EKl6aU7pMVfXpXNUDxnX8F0d6
         n/yiAtT+nIfwgivu86KgNIm8PbO5g5wKUBvPVG5VlMFqkHFFSmkw/JeAJQFvDLz2lt2A
         HBiBJfbi8yVi+ljQ+u4GKCXYm9bJx8sXIN/hBHoAEA1KjNr4nSTckA7KVNL3ItKE0Sn2
         ozs143DIMidCuEkuN1XgHA+SQTBohDFQmeXY428ODsxUOqN8JU6Hqd5fH9hBy3MKRAjE
         L2hA==
X-Gm-Message-State: AFqh2kqJx+61Zlb5YWfRnd+sBqKpc7tEZjMaOsZ+PEfT4Ndd8r5J9j8i
        t+xHba7dUq2MNkmrA8asdbN2GgcUhJLLW9K7Md5bEP2PXDs=
X-Google-Smtp-Source: AMrXdXuldPgrgToRGeOjUGw40QIrUzyl/L/VlUjm7Dv3WJDMBybJwNUKSnb0YjxKfDZiXJU/66WeGLUtchDsNY1LAQs=
X-Received: by 2002:a17:906:e4f:b0:7c0:ae1c:3eb7 with SMTP id
 q15-20020a1709060e4f00b007c0ae1c3eb7mr1575024eji.510.1672231903589; Wed, 28
 Dec 2022 04:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-4-linux.amoon@gmail.com>
In-Reply-To: <20221228100321.15949-4-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 28 Dec 2022 13:51:32 +0100
Message-ID: <CAFBinCCtJbF6UjG3czQjVy_Zy_B4DO8BkcayOqDirn0OXw3PtQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] arm64: dts: amlogic: Used onboard usb hub reset
 on odroid c2
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
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

Hi Anand,

thank you for working on this topic!

On Wed, Dec 28, 2022 at 11:05 AM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> +       usb {
> +               dr_mode = "host";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               hub@1 {
> +                       /* Genesys Logic GL852G-OHG usb hub */
> +                       compatible = "genesys,usb5e3,610";
> +                       reg = <1>;
> +                       vdd-supply = <&usb_otg_pwr>;
> +                       reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
> +               };
> +       };
My understanding is that the hub@1 node should be part of the
corresponding USB controller node, not a new node.
In this case hub@1 should go into the existing &usb1 node. That way we
describe the way the hardware is set up (meaning: hub@1 is connected
to &usb1).

In case hub@1 is not detected within &usb1 then you may need something
like [0] (not tested for your use-case).
If that helps: feel free to include that patch in your series.


Best regards,
Martin


[0] https://github.com/xdarklight/linux/commit/d8b96e5bc9c20ab2585194e0e59580c3b062c431
