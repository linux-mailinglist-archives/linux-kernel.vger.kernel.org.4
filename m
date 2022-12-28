Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7687D657B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiL1PSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiL1PSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:18:33 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E313F1F;
        Wed, 28 Dec 2022 07:18:32 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id g65so4107257vkh.8;
        Wed, 28 Dec 2022 07:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lkaAG2YOajQYFJDJM0i4sGT7QKIFbLQrj4z1FPIpfyU=;
        b=GzmHM6smAHp5ldKDKJlC8ic+MWAvqfbXRTL1wMlO/CfghIxbb8H/HXDZO7Lhgg3/3S
         frOyEKhQJ4KfhNbX4Lzp15tOVGSWO9rcTyhipEiTobRnAkMTKNIBS1u4f1bNb4vJHAnY
         +U3dWEMtyGHTX24tbr0KDEFw2rH73lBFA/sDdpG+JPzQLcqE1Pxv1zdvFK5o/RYjDnM5
         WHApMN1UQJCOZG9KcdLwJVwj3NnPRO0nDmXNhwRt+woMVRxRJ9aIb+mwHMZ7YU9OtSdk
         tWjVi7skhMy2t4qa5BzfLGQecEOuNxHctPmpcACjYBbofMr9Hq7rzuWwsvfXKl6OG81s
         8wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkaAG2YOajQYFJDJM0i4sGT7QKIFbLQrj4z1FPIpfyU=;
        b=Fq8T/Ik+04zxDaTLAswMniYSOcdXyPbpPHr4an/t9lCzsIS0SMoxO93R8Dx4niV1wx
         y0nXVYI3Bj/4XV4rp5TfLdmCZXLoMSxjnS7N1HVtPlAziq1Y2U+n0JQoe8wMr+k2G4QD
         uoYKJ6BdD+dsZrEr+KFwG+qMw1hYEzsay+ec4+4AAbwSlWUmJPlQL5g70gJMPrvMPo6G
         Jr0bKwj2uWFhN4QcQRdPd+0JkmZ8vWEsi1t290c+LiEQhCkh1ovDxMnYC+bM4nxVfoLo
         KrEADitOnl24pT3bYghr8tNTEnWpyso96u4+Luk0WxESay0bwYsiRR4ezG/igSjCYSDz
         M1vg==
X-Gm-Message-State: AFqh2kqSIRyVnmmkbXp+NpgDCTb5GqhS6W6x/dlnIqZiQyY7vB36fsha
        rLaGgXx4kamQ/gh1lcov47vgE15LQDWXNWcj/bhpjuNsYjOVMg==
X-Google-Smtp-Source: AMrXdXux0yInKtn4v33xY2OSIkdigLnD4DPsiOKVxemqi8YoaAUVw2IQPco2RqhN0ev+9q2aSW3n/JSRZ8Se1oJX4Wo=
X-Received: by 2002:a05:6122:1689:b0:3c5:db35:9288 with SMTP id
 9-20020a056122168900b003c5db359288mr2701335vkl.32.1672240711908; Wed, 28 Dec
 2022 07:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-2-linux.amoon@gmail.com>
 <d0127811-6be1-4f1c-c138-1e8b0c69aaeb@linaro.org>
In-Reply-To: <d0127811-6be1-4f1c-c138-1e8b0c69aaeb@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 28 Dec 2022 20:48:15 +0530
Message-ID: <CANAwSgSD_zTmPTJQ7PMDqQeagppv2SsaO9+H2h4XVJdYJAg1Qw@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] dt-bindings: usb: Add device id for Genesys
 Logic hub controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
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

On Wed, 28 Dec 2022 at 20:38, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/12/2022 11:03, Anand Moon wrote:
> > Add usb hub device id for Genesys Logic, Inc. GL852G-OHG Hub USB 2.0
> > root hub and Genesys Logic, Inc. GL3523-QFN76 USB 3.1 root hub.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > index a9f831448cca..db009f3ef438 100644
> > --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > @@ -16,6 +16,8 @@ properties:
> >    compatible:
> >      enum:
> >        - usb5e3,608
> > +      - genesys,usb5e3,610
> > +      - genesys,usb5e3,620
>
> This does not look like correct compatible. Did you test the bindings
> and DTS? This should fail.
>

Yes, I have done and it did not report any error.

make ARCH=arm64 mrproper
make ARCH=arm64 defconfig
make ARCH=arm64 -j$(nproc) dtbs
make CHECK_DTBS=y amlogic/meson-gxbb-odroidc2.dtb
make CHECK_DTBS=y amlogic/meson-g12b-odroid-n2.dtb
make CHECK_DTBS=y amlogic/meson-sm1-odroid-c4.dtb

Ok I will update this in the next version for all the patches.

> Best regards,
> Krzysztof
>

Thanks
-Anand
