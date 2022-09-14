Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737F95B8BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiINPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiINPdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:33:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CED35A880;
        Wed, 14 Sep 2022 08:33:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id v16so35573652ejr.10;
        Wed, 14 Sep 2022 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=euBywoUqWY+9yPtFA/h7+K25+vefjCBo4JeDdhHgIhg=;
        b=na7tS1cWTqcfmwovO/xG7sjSvLAaRTdSCnO+6swrap87QiTLrqQKu4jppnggBiwxR0
         CX2heIiM4FhpIb/birHu1wjC6MTWWWHjIH3QY15ZFGcPx2nTOUQWwo4nPl76tJD94AAY
         zsJwmVWai2JY/gyBwxAcR7dRmRUj7vlBd5bbt7dug8Bt2ckZDoGakuqqKPVzsgWuEthk
         9pxgkGEFzkr0BnV3R9ohnK2lLB64JJ+0YXI6TKhJIZwzoRrzAF52erwFi/u+a/KnpAS6
         y/o7yHTZBawGCDWaol6hc3jMrZlk2TfwPKLbxMpVNmNsBudZmGgJPs+cN/A8drMjf35l
         VNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=euBywoUqWY+9yPtFA/h7+K25+vefjCBo4JeDdhHgIhg=;
        b=ICM5Rnx0/4XCng0kZdsOMVVDLbbfolecm3jhW6V8RZiP/+XEfQ43JudbY/sAl3Evl5
         aGMuflvcBIuUgBGLihaFmVrVCSd6BxJSEWrG+VQAlvHT3xDpi5TesbNP6FqS7ExGnF4z
         skAoiJq7MH/DF+kHfN8L3Zw0Y7jFGzF7cEQ6URQ+ED77E7Q9hQKMHU6uPSFG8WOKkI4o
         nIq/GahYC5OuGOJZV8yYasi7pTeAmov+lQOF5ileoSu/apbGweXPZras/a4wHEn/yAju
         ts/IGG8JVj4giEgJz4AZWz19ZL7AI12PD6lwkuWoaKpqBZoWPbvoC+bLOVYFg/5mi83E
         oSig==
X-Gm-Message-State: ACgBeo3s32W1VUmFFZq4WegQ8jA/WLuMpN/q1l98UUBXtkuDHRrDgrFB
        bxnbKO6rlj9P44W8FjU7WMwETKiHGBOVoSn+4xw=
X-Google-Smtp-Source: AA6agR6FfLnXUSOTPacpx7RREDFu38n5a5EdGdNa5zwcSzUCfG/WghGZdEtUSgmo4eg0hC4iuJsVeuEL0FdtOUeP6Kg=
X-Received: by 2002:a17:907:80d:b0:73d:a576:dfbd with SMTP id
 wv13-20020a170907080d00b0073da576dfbdmr26468956ejb.402.1663169618930; Wed, 14
 Sep 2022 08:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220914151125.212876-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220914151125.212876-1-dmitry.osipenko@collabora.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 14 Sep 2022 17:33:27 +0200
Message-ID: <CAJiuCcefkre611=1UXEkwScN+bYSBhE_ivGzTK7ZMvp-j4MbRQ@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: sun8i: h3: orangepi-pc: Add CMA reserved
 memory node
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

Hi Dmitry,

On Wed, 14 Sept 2022 at 17:12, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add 256MB CMA node to the Orange Pi PC board. This fixes memory allocation
> failures for Cedrus video decoder on trying to play a 1080p video with
> gstreamer.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> index b96e015f54ee..e655346a9fb4 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> @@ -60,6 +60,20 @@ chosen {
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               linux,cma@40000000 {
> +                       compatible = "shared-dma-pool";
> +                       alloc-ranges = <0x40000000 0x40000000>;
> +                       size = <0x10000000>; /* 256MiB */
> +                       linux,cma-default;
> +                       reusable;
> +               };
> +       };
> +

This change seems legit for all H3 boards and could be moved to the H3 dtsi, no?

Regards,
Clement

>         connector {
>                 compatible = "hdmi-connector";
>                 type = "a";
> --
> 2.37.3
>
>
