Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81654654721
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiLVU21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiLVU2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:28:16 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5DC20BC6;
        Thu, 22 Dec 2022 12:28:06 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id v70so2919936oie.3;
        Thu, 22 Dec 2022 12:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woCGv7/8V5+DgCxctIizIezO0GXF75G9DSlcq8wC02A=;
        b=p9Gij5HOZ0vDj1Hp0sPRu6JNJKl8PBYJcyGLThZH0pVSPUM2eSmOMz7sN1hOG7YboK
         RWhQTvNmLjdL571Koa1kDJ8WHKHMdAfsCizZfYJWZ8jKGg0DHr8pgY+fDcCLoXPLdRLp
         lYLwQIkP+BBYpFOjLFmsIZ3/Poq4UiEXcAzk4wD1V+9RE4EKeWewReTSmObLRm+9AW4l
         y1gVbYgt6rxUArT94uObKiPn1GTN3aTsrAaD2tso1LGPDu2uSSuFCkT3BLj6DUqqZ3FP
         RwL2SCcDbIfECzEYeQ5/a9BdClQ7LerVS2M9J4Me2ggMXakTnk3kBDyuJxBoBMeIo6UW
         SByg==
X-Gm-Message-State: AFqh2kqmR5tsQgrSlmyV3FVo+ydmjFbmthR2D9qMCtaPYZSnhLpg+q8f
        v1I2CwG/PmY5DJwyRiZThw==
X-Google-Smtp-Source: AMrXdXtqKbN/OPTnwnQNU/6pMgxhP8Q2rVkS0/IlBr4E6YM0ho5oZEvS/xsQPxtbRrQIy0lV9Hz3pQ==
X-Received: by 2002:a05:6808:8f:b0:355:1de8:bc80 with SMTP id s15-20020a056808008f00b003551de8bc80mr3269891oic.34.1671740885878;
        Thu, 22 Dec 2022 12:28:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k20-20020a056808069400b0035b80dbf1easm720249oig.14.2022.12.22.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:28:05 -0800 (PST)
Received: (nullmailer pid 2068406 invoked by uid 1000);
        Thu, 22 Dec 2022 20:28:04 -0000
Date:   Thu, 22 Dec 2022 14:28:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-usb@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        philippe.cornu@foss.st.com, heiko@sntech.de, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, jonas@kwiboo.se,
        linus.walleij@linaro.org, hjc@rock-chips.com,
        devicetree@vger.kernel.org, kyungmin.park@samsung.com,
        airlied@gmail.com, gregkh@linuxfoundation.org,
        sw0312.kim@samsung.com, jernej.skrabec@gmail.com,
        linux-kernel@vger.kernel.org, inki.dae@samsung.com,
        daniel@ffwll.ch, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
        andrzej.hajda@intel.com, robert.foss@linaro.org,
        alim.akhtar@samsung.com, Laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v6 08/17] dt-bindings: usb: convert fcs,fusb302.txt to
 yaml
Message-ID: <167174088325.2068348.12900872964177598466.robh@kernel.org>
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
 <0336a3c4-4a43-c983-11d7-e2ae16187fc8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0336a3c4-4a43-c983-11d7-e2ae16187fc8@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 15:28:53 +0100, Johan Jonker wrote:
> Convert fcs,fusb302.txt to yaml.
> 
> Changed:
>   Add vbus-supply property
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V6:
>   Add unevaluatedProperties
>   Drop unused labels
> ---
>  .../devicetree/bindings/usb/fcs,fusb302.txt   | 34 ----------
>  .../devicetree/bindings/usb/fcs,fusb302.yaml  | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
