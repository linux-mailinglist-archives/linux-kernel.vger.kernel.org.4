Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61096E5619
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDRA6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRA6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:58:34 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469732D77;
        Mon, 17 Apr 2023 17:58:33 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-187ec6a5504so76669fac.2;
        Mon, 17 Apr 2023 17:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681779512; x=1684371512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXYI9t+uhIrIqHGofk7KodCSd0KD+a+f9muMXWOvwoI=;
        b=U/kiNfVEphqUDGth3tPXB07gieCggyJdBJJrHUerrjACirvjhZ0JPcRQjI/CCFKv2Z
         2HhP40y1PMB45TbbpZ6eb9HWYPKQyYgcMqAZAFD5bcXEUSmbmAnkxtFAdJt5UOfKWeQc
         /kJMAb4hhCxth66VNPguFRQ/FkdOe5FjtFLyhEBoQ8q0K6y3I/tG342xqlFnk+zYqs8t
         yi41sRCnqoqn4injBBmEHZmbg9Ef3+tZV69xMuIjd2yEtiUPBCpbFRb3TI5MwZ8Z1O5M
         K1g7ugBf5XXi2Vo7xsS6APfS4e0T9pUAMmnkdBv9Bt29sJWDvp2IbRWO/Ty4wq3dsUUk
         TbFg==
X-Gm-Message-State: AAQBX9flonhSX8oclhpE7CpzCkD3nZpk7sB8oUnHBeOrs/PC6Gu9QCnd
        gEhwV4LDlce67i71606lyLNpcH3ukg==
X-Google-Smtp-Source: AKy350bPqPxucQ0TtF2gVHTpq49ndfYCjdXmxQpqh32tloC6VCltN0j5EIggvm/aGOCZJnEkxuXLNQ==
X-Received: by 2002:a05:6870:65a0:b0:183:fab4:efb9 with SMTP id fp32-20020a05687065a000b00183fab4efb9mr254235oab.43.1681779512502;
        Mon, 17 Apr 2023 17:58:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a0d83000000b005251e3f92ecsm5306962oob.47.2023.04.17.17.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 17:58:32 -0700 (PDT)
Received: (nullmailer pid 3814440 invoked by uid 1000);
        Tue, 18 Apr 2023 00:58:30 -0000
Date:   Mon, 17 Apr 2023 19:58:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, p.zabel@pengutronix.de,
        linux-pwm@vger.kernel.org, kernel@collabora.com,
        chunkuang.hu@kernel.org, linux-phy@lists.infradead.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        houlong.wei@mediatek.com, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, vkoul@kernel.org,
        chunfeng.yun@mediatek.com, daniel@ffwll.ch,
        linux-mediatek@lists.infradead.org, xinlei.lee@mediatek.com,
        airlied@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jassisinghbrar@gmail.com
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
Message-ID: <20230418005830.GA3802030-robh@kernel.org>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
 <168133318912.3190428.16120880490622098945.robh@kernel.org>
 <5c0bc1f2-5917-ab84-8b0b-f2adc48f8be7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0bc1f2-5917-ab84-8b0b-f2adc48f8be7@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:52:28AM +0200, Matthias Brugger wrote:
> 
> 
> On 12/04/2023 23:03, Rob Herring wrote:
> > 
> > On Wed, 12 Apr 2023 13:27:13 +0200, AngeloGioacchino Del Regno wrote:
> > > Add a compatible string for MediaTek Helio X10 MT6795's display PWM
> > > block: this is the same as MT8173.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> 
> These are not new warnings. I think we should address them in a different
> patch. In my opinion it shouldn't block this patch. In the end it only add
> as compatible here.

I disagree if it's the schema that needs fixing. From the looks of 
it, I'd say it's probably at least some schema fixes needed.

> 
> Regards,
> Matthias
> 
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412112739.160376-2-angelogioacchino.delregno@collabora.com
> > 
> > 
> > pwm@1100e000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'

Are you saying the MT6795 has no power-domains?

> > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb
> > 
> > pwm@1400a000: compatible: 'oneOf' conditional failed, one must be fixed:
> > 	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
> > 	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb
> > 
> > pwm@1401e000: compatible: 'oneOf' conditional failed, one must be fixed:
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb
> > 
> > pwm@1401f000: compatible: 'oneOf' conditional failed, one must be fixed:
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
> > 	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

The commit message says the MT6795 is the same as the MT8173. Which is 
wrong here, the dtb or the schema? 

Rob
