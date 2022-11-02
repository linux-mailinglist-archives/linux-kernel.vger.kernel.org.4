Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B9961697F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKBQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiKBQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:43:27 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D020BD1;
        Wed,  2 Nov 2022 09:38:43 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 16-20020a9d0490000000b0066938311495so10578517otm.4;
        Wed, 02 Nov 2022 09:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9ksTZ83TtbRKPPlqnz00eQ8hM+aPwJfXyLg4128WEI=;
        b=cSW1HcnV9v9A6i8Q8SA9vRUqUA+6paC59MZklYcnI1NRCRX5WTI+9AtODGGeJ0cY+O
         UkuTv0xxvOT6VGI/VNgU6Tg7zA3wLLZrOJkNe8xIcp83jvugNyHJB+OH4U1LpFmtJ0Rd
         YPQ9TGmyP0UQ5dQiTAgr3qq9+gRRMWdBJ4MMl0KAIdOiDxqXrcIitJ/65fW4p8wxNZ7M
         gPPrSKBmj33Q7zmEyA9Q5XLcSdm+1mKwaIiqRHgL4zYgS6iOFtAv9uNuQ/KwWccCXn0n
         703LsEyZa9UjPYSIkpRc7jzGt/Xc9vVsqGmfEGeJE+uAFB7IPjzYrC/pDaKVF8BqZLJq
         f4Yg==
X-Gm-Message-State: ACrzQf0wR1HhE111VXE8oWlvBLW49WH8qreNrc4xMEMc+oTGrF2YsCrE
        qKN7oobEO4FlayJyC3NJgA==
X-Google-Smtp-Source: AMsMyM5E0phLlXbOOPIfqMi0psVJ3aAAbDHqmPGVzw82Uj2oW84WOtt0Hpm0fYkA+oJBV56lx5Ewuw==
X-Received: by 2002:a05:6830:1f34:b0:66c:4a42:9ca5 with SMTP id e20-20020a0568301f3400b0066c4a429ca5mr10015204oth.175.1667407123140;
        Wed, 02 Nov 2022 09:38:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bh23-20020a056808181700b003547a3401e6sm4722569oib.43.2022.11.02.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:38:42 -0700 (PDT)
Received: (nullmailer pid 4014126 invoked by uid 1000);
        Wed, 02 Nov 2022 16:38:44 -0000
Date:   Wed, 2 Nov 2022 11:38:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-media@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Tu <shawnx.tu@intel.com>
Subject: Re: [PATCH v4 5/9] media: dt-bindings: ov5645: Convert OV5645
 binding to a schema
Message-ID: <166740712341.4014070.1564117171862683626.robh@kernel.org>
References: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221031232202.131945-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031232202.131945-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 23:21:58 +0000, Prabhakar wrote:
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
> v3->v4:
> * Used 4 spaces for example node
> * Added reg property after compatible
> 
> v3:
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

Reviewed-by: Rob Herring <robh@kernel.org>
