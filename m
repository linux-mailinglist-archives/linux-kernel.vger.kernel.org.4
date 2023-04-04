Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9C6D6417
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjDDNzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjDDNz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:55:28 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658611990;
        Tue,  4 Apr 2023 06:55:01 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id o25-20020a9d4119000000b006a11eb19f8eso16171306ote.5;
        Tue, 04 Apr 2023 06:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJEw1H1pkfdI8k8tgnJUG93r+dsLUB9hI2v6VwBw+Ws=;
        b=DoPgYxT62+Lbzb9yAnxIgEb8Gj9zP+Gh5RhliY4t42KEjJU8J6zlnE7ohwk2bL2FDa
         SfRIbSOsWUh/3+iTcKIJkjFLpSno9dXuRFuzeQOGZMk2BUX1BsFb/bt4bNcFQRSGpX8d
         VyRZ0L0a3GNCJcUi7B68nXjTDoiajQofIhJaeHCE4ejQztZj2jG/uCBEJCLK3iD38nNy
         kqCJS7jIsYw6DBrW63fSeKQOjxcXOOY41DdGy7zcIR2Sd6U5IDNNJa/8um3F3Jz1iktY
         fMkFPOt7Z3NytpghyBwalHUTsBNmZWUCY8AfMOtDqt2ZARWADNmcMdq1rV4WNNameUNe
         AJvg==
X-Gm-Message-State: AAQBX9cl2/DFg3CWd0/GyjFT7cbNOxZQ+Q1ZS2xIxS01WEZCW7gvBvvp
        2WgG8gTCObl+5MojTw/HEg==
X-Google-Smtp-Source: AKy350b+cqls0gSn2TeHIm4sRXtpjFeVIsHj7uZEjkZFzNbY1hEuGkXE9PfxqXau8Y9ylqfSGtmm+g==
X-Received: by 2002:a9d:75cd:0:b0:699:896e:c9e1 with SMTP id c13-20020a9d75cd000000b00699896ec9e1mr1102300otl.34.1680616500607;
        Tue, 04 Apr 2023 06:55:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s18-20020a056830149200b0069faca091acsm5499334otq.54.2023.04.04.06.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:55:00 -0700 (PDT)
Received: (nullmailer pid 3797380 invoked by uid 1000);
        Tue, 04 Apr 2023 13:54:59 -0000
Date:   Tue, 4 Apr 2023 08:54:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Message-ID: <20230404135459.GA3793612-robh@kernel.org>
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-2-cristian.ciocaltea@collabora.com>
 <168052514639.463695.9544022277060710805.robh@kernel.org>
 <dcd79e14-d9df-39c1-5465-4e9d71221659@collabora.com>
 <79396eed-18ab-bcee-5c7e-c3e5e61f32c3@collabora.com>
 <49c226ff-08a3-a7ca-59bd-f0b9cea865e3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c226ff-08a3-a7ca-59bd-f0b9cea865e3@collabora.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 07:22:45PM +0300, Cristian Ciocaltea wrote:
> On 4/3/23 17:43, AngeloGioacchino Del Regno wrote:
> > Il 03/04/23 16:32, Cristian Ciocaltea ha scritto:
> >> On 4/3/23 16:10, Rob Herring wrote:
> >>>
> >>> On Mon, 03 Apr 2023 13:50:51 +0300, Cristian Ciocaltea wrote:
> >>>> Convert the PWM fan bindings to DT schema format.
> >>>>
> >>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >>>> ---
> >>>>    .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +----------
> >>>>    .../devicetree/bindings/hwmon/pwm-fan.yaml    | 109
> >>>> ++++++++++++++++++
> >>>>    2 files changed, 110 insertions(+), 67 deletions(-)
> >>>>    create mode 100644
> >>>> Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> >>>>
> >>>
> >>> Running 'make dtbs_check' with the schema in this patch gives the
> >>> following warnings. Consider if they are expected or the schema is
> >>> incorrect. These may not be new warnings.
> >>>
> >>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> >>> This will change in the future.
> >>>
> >>> Full log is available here:
> >>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230403105052.426135-2-cristian.ciocaltea@collabora.com
> >>>
> >>>
> >>> pwm-fan: 'cooling-max-state', 'cooling-min-state' do not match any of
> >>> the regexes: 'pinctrl-[0-9]+'
> >>>     arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dtb
> >>>     arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
> >>>
> >>
> >> The only references to the offending cooling-{min|max}-state are located
> >> in a few DTS files. Assuming they are obsolete, may I simply drop them?
> >>
> > 
> > If they're obsolete, you can mark them as `deprecated: true` in the
> > binding, but
> > dropping them entirely would be an ABI breakage, so no, you can't.
> 
> >From the pwm-fan driver point of view, the properties are not supported
> and I couldn't find any indication that they could have been used in the
> past.
> 
> Hence I'm not sure adding them to the binding is the proper way to
> handle this issue.

They can be omitted.

Rob

