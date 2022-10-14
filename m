Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ABA5FF4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJNVAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJNVAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:00:34 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DB5106A74;
        Fri, 14 Oct 2022 14:00:33 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so2553728otu.7;
        Fri, 14 Oct 2022 14:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kq4otfpWoUaoxpIPZJV1lgpjpLZShT1J4qTsAKzDCpA=;
        b=4pZRoWI9RE0n1zgDZKgPtJrTCa9tkp07e3QWXRbMuJd/CptQmZg4y8aDM2lgOEg0dm
         NOnpytXrIDd1F/5MtLRI4eU5XxiPgr4DYMqIu94MPRIMU5vH8mb1egMNNV6lh9EPQTTi
         Mr9AQmqcPSorTQ5w8+1gW9bZTmjORWpRVqzlzssb4txAD9Ff4eRlmLE9rlt4vKPjUyuf
         1yb6PkbxnkCv6D/9VkX6DDZ7hl+iitxeUmM2yoP35w17YLSeIunCBo4guHyKZ4/5BMfk
         VIf0Tu1zCKPXh2q5pKcXld1XBkoA9Xg3Li600EqcbLSOfIRtodVjjb1vLv4HI7krgC+g
         q/xA==
X-Gm-Message-State: ACrzQf38B2Vng3vvUDapaVn6AA8H+z/SiNnbapVCQW1JiexLhggjhbFr
        ra93n6bG/tpvRRPQBTfc3Q==
X-Google-Smtp-Source: AMsMyM4UYGB/NG4VC9kqGAklC5tFZU87mpAg9iGmbI1BTt2NsChpYzNoQCdRkPW5fPumiZKwr+PVjA==
X-Received: by 2002:a9d:12ca:0:b0:661:b4b7:349d with SMTP id g68-20020a9d12ca000000b00661b4b7349dmr3380439otg.47.1665781232469;
        Fri, 14 Oct 2022 14:00:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r8-20020a056871088800b0010e73e252b8sm1860086oaq.6.2022.10.14.14.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:00:32 -0700 (PDT)
Received: (nullmailer pid 2832389 invoked by uid 1000);
        Fri, 14 Oct 2022 21:00:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
In-Reply-To: <20221014183459.181567-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221014183459.181567-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-Id: <166578091220.2826696.5981359507940429250.robh@kernel.org>
Subject: Re: [PATCH v2 1/5] media: dt-bindings: ov5645: Convert OV5645 binding to a schema
Date:   Fri, 14 Oct 2022 16:00:32 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 19:34:55 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Convert the simple OV5645 Device Tree binding to json-schema.
> 
> The previous binding marked the below properties as required which was a
> driver requirement and not the device requirement so just drop them from
> the required list during the conversion.
> - clock-frequency
> - enable-gpios
> - reset-gpios
> 
> Also drop the "clock-names" property as we have a single clock source for
> the sensor and the driver has been updated to drop the clk referencing by
> name.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Resend v3:
> * No change
> 
> v2 -> v3
> * Dropped clock-names property
> * Marked power supplies as mandatory
> * Dropped the comment for voltage power supplies
> * Included RB tag from Laurent
> * Driver change to drop clock-names [0]
> 
> [0] https://lore.kernel.org/linux-media/Yyh%2F3uzOJOu3drEB@pendragon.ideasonboard.com/T/#t
> 
> v1 -> v2
> * Dropped ref to video-interface-devices.yaml#
> * Dropped driver specific required items from the list
> * Updated commit message
> * Dropped clock-lanes and bus-type from the port and example node
> * Marked data-lanes as required in port node
> ---
>  .../devicetree/bindings/media/i2c/ov5645.txt  |  54 ---------
>  .../bindings/media/i2c/ovti,ov5645.yaml       | 104 ++++++++++++++++++
>  2 files changed, 104 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5645.txt
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


camera@3c: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6dl-pico-dwarf.dtb
	arch/arm/boot/dts/imx6dl-pico-hobbit.dtb
	arch/arm/boot/dts/imx6dl-pico-nymph.dtb
	arch/arm/boot/dts/imx6dl-pico-pi.dtb
	arch/arm/boot/dts/imx6dl-wandboard.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6q-pico-dwarf.dtb
	arch/arm/boot/dts/imx6q-pico-hobbit.dtb
	arch/arm/boot/dts/imx6q-pico-nymph.dtb
	arch/arm/boot/dts/imx6q-pico-pi.dtb
	arch/arm/boot/dts/imx6qp-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6q-wandboard.dtb
	arch/arm/boot/dts/imx6q-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6q-wandboard-revd1.dtb

ov5645@3c: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb

