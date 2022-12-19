Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F0F650C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiLSN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:26:34 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EA4FF;
        Mon, 19 Dec 2022 05:26:33 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id v70so7801220oie.3;
        Mon, 19 Dec 2022 05:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDSJGuoBUlMGgiS087wDSGGlbj9bvZ8Uqb80GAsEvJQ=;
        b=s/G6LoAtfwbphjswEJqwNMQJH0FV2MI7JmSfTaRLhvCPD/ISczvEPzvJGwbwtGKOWi
         j+u3VZoIlhMKd8wz3yuHo+tFpD+3CEqnB+pxcf1G7m2iP6cG8S5t3MIvcNnVDx/8bO7t
         HUDeAE2UAlbWayw9hZz3kOYPNj4bNfyJBkrya20iE8nvtlwTSdq7MZUXg2Al9/vbUg/Q
         Evh01/DihYNK+vjbEsQNptw47YDarQLayBGqcNb/hWYNnfG2N3zdnZ2yclIBwNFCPu2E
         LPDJBUoIBhDNJj8xhI86ehQEzYrIZWs/FHvXyUWXwD7LiK0VtwsANu6HDmp2qSazTui2
         lovA==
X-Gm-Message-State: ANoB5pl057rgtTzs6bZju11ACur7Utu6vUZOwLKA4C3F9tbvRzJk7YPC
        fdNrahzhlXFvXMmqQxHOEA==
X-Google-Smtp-Source: AA0mqf45gJMy4jKgeBK6aXjInaHFDzhi2dL+gMB6cIn2NwjrEShN/UVjRZul9vLQgzZITxk5lO7e1A==
X-Received: by 2002:a05:6808:118c:b0:355:1df0:9b84 with SMTP id j12-20020a056808118c00b003551df09b84mr20960099oil.2.1671456392955;
        Mon, 19 Dec 2022 05:26:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c17-20020a9d6851000000b0066bb73cce68sm4344900oto.69.2022.12.19.05.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 05:26:32 -0800 (PST)
Received: (nullmailer pid 1185311 invoked by uid 1000);
        Mon, 19 Dec 2022 13:26:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        airlied@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, hjc@rock-chips.com
In-Reply-To: <dea33013-ae1b-a8b2-5287-68a52f5ce028@gmail.com>
References: <dea33013-ae1b-a8b2-5287-68a52f5ce028@gmail.com>
Message-Id: <167145632480.1180502.8911882694570490800.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
Date:   Mon, 19 Dec 2022 07:26:31 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Dec 2022 16:23:53 +0100, Johan Jonker wrote:
> Convert rockchip-lvds.txt to YAML.
> 
> Changed:
>   Add power-domains property.
>   Requirements between PX30 and RK3288
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V2:
>   Fix title
> ---
>  .../display/rockchip/rockchip-lvds.txt        |  92 ----------
>  .../display/rockchip/rockchip-lvds.yaml       | 157 ++++++++++++++++++
>  2 files changed, 157 insertions(+), 92 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/soc/rockchip/grf.yaml: Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/dea33013-ae1b-a8b2-5287-68a52f5ce028@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

