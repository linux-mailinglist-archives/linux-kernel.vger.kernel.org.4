Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BB365277F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiLTUBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiLTUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:00:58 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A86419;
        Tue, 20 Dec 2022 12:00:57 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so16756081fac.2;
        Tue, 20 Dec 2022 12:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7rQADosS+b3+803ppmC4G5l6lsD7QIny2Q7opGqliM=;
        b=RlYkUyh6J0i/1QPLEukHlVydkZkTIFZ5y09riGRmumVrbJ1IZz7WkKeX4maak66OCQ
         Om+qqCbNZkfXMY8AThn7j3bFBfvaIx4D3FTJOoN5ZRxOw8JZs0Ce2pYzw4qdWo5AW3o3
         FkXsWmNPLvJJw78lh5dtuNtOajj3KxEmla5LMmoj6xoUc+0zxJlEtyY4f2DQNqTSynET
         o3rIFYBmveZ30Cn/aVOJElB8sUfDxuqh4N4zmQIxZYFHGPLxloCLgJr7EYuNpbkeHhHY
         Lky5jpIbOJs2byDIwoT5zbTVLglerTdnpaNPNCXs9Fg3bFIM7GQ6MZ62jMLM6z3zzA8I
         IOAw==
X-Gm-Message-State: AFqh2koZO/cpbpPxnwf1JZHbdNlu+jqC+nCiGWHB3360JMUY8QTfcuLZ
        zMQCf8TwZOr4IO6maH0ALsSMJcwkCg==
X-Google-Smtp-Source: AMrXdXt9sEtEqgQZhotj9V3mZGPtA+Z0Jj7vkU5jn2um2dvY3ioakyoO6JU+NnthNj+8BzLMwIRf8g==
X-Received: by 2002:a05:6870:c991:b0:148:500d:c6fb with SMTP id hi17-20020a056870c99100b00148500dc6fbmr7635185oab.38.1671566456641;
        Tue, 20 Dec 2022 12:00:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y29-20020a056870459d00b0011d02a3fa63sm6504888oao.14.2022.12.20.12.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:00:55 -0800 (PST)
Received: (nullmailer pid 990414 invoked by uid 1000);
        Tue, 20 Dec 2022 20:00:54 -0000
Date:   Tue, 20 Dec 2022 14:00:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, airlied@gmail.com,
        daniel@ffwll.ch, vkoul@kernel.org, kishon@kernel.org,
        linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: phy: add port node to
 phy-rockchip-inno-usb2.yaml
Message-ID: <20221220200054.GA953433-robh@kernel.org>
References: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
 <e54f7b52-3530-59c4-90c6-1fb5a17d6491@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54f7b52-3530-59c4-90c6-1fb5a17d6491@gmail.com>
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

On Mon, Dec 19, 2022 at 05:56:55PM +0100, Johan Jonker wrote:
> On Rockchip rk3399 a port node with one endpoint can be connected
> to a USB Type-C connector node.
> Add a port node to the phy-rockchip-inno-usb2.yaml file.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> index f71920082..ffc7e7560 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> @@ -115,6 +115,11 @@ properties:
>      required:
>        - "#phy-cells"
> 
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      Port node with one endpoint connected to a USB Type-C connector node.
> +

This doesn't make sense. First, this phy has an otg and host phy, so 
which one is it? Second, the USB connector graph is supposed to be 
connected to the USB controllers, not a phy.

But I guess we already have this in use, so I guess just mark it 
deprecated to discourage more usage..

Rob
