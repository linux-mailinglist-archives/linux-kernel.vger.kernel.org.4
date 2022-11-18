Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053E862F61A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbiKRNbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiKRNbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:31:21 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D4713F4D;
        Fri, 18 Nov 2022 05:31:20 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so3044403otl.7;
        Fri, 18 Nov 2022 05:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0Mpv79OC10rvhUXLA0ACmvYs6p261vAofPBrF9lFpY=;
        b=Tj/aorcT5ngzXxbcAtPBrDnQx5m+iH38ovyDGWjcRmYeLbCqFWLnGnXUOIU8yvOtKz
         Wj7hjJLVB6VBBRV+X5YLY7ZWB/WFzktxO/qVlX9X8qq9GfSYm4M7F/eHKLqh8Vdxl8pY
         CrceEUHMp+SiZr/1ndrhktzzYF6nymuMqxDwBmKhm9VmMBLwVhiUsGKspBAA8g2odYFq
         Gp7X6KABeiwLKOdpJ5DKhcrhyXYslBjlc5w6ntUkKJovbrStGauLczvr02HjcVDc6PDs
         2AX8ur/PtT7XwGJwXu6/lqRcAl10vno4mKyU/Vk0PMI0n+aIlx4qckycyDcJqvpUkg2n
         56FA==
X-Gm-Message-State: ANoB5pljhiO3Im9JNL4u/UqK3dWe8To1hQXImkZSqBuVuZU7zd+ZaqqP
        S0O4d6D5sY0siHkI8LTCsA==
X-Google-Smtp-Source: AA0mqf4sTJcECMo1xKL09IoTWj/i5Q4HzYzaQhgjRACHz9Us2B9+woBC7DGak4TQZHl4kO19R4t7tA==
X-Received: by 2002:a05:6830:6407:b0:661:8fc6:2d77 with SMTP id cj7-20020a056830640700b006618fc62d77mr3756668otb.288.1668778279794;
        Fri, 18 Nov 2022 05:31:19 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x53-20020a056830247500b0066c7733be43sm1536301otr.30.2022.11.18.05.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 05:31:19 -0800 (PST)
Received: (nullmailer pid 1482192 invoked by uid 1000);
        Fri, 18 Nov 2022 13:31:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
In-Reply-To: <20221118093931.1284465-3-paul.elder@ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
Message-Id: <166877740033.1426068.13359373358036408238.robh@kernel.org>
Subject: Re: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP example
Date:   Fri, 18 Nov 2022 07:31:19 -0600
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


On Fri, 18 Nov 2022 18:39:19 +0900, Paul Elder wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Add an example to the rockchip-isp1 DT binding that showcases usage of
> the parallel input of the ISP, connected to the CSI-2 receiver internal
> to the i.MX8MP.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../bindings/media/rockchip-isp1.yaml         | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/rockchip-isp1.example.dts:199:18: fatal error: dt-bindings/media/video-interfaces.h: No such file or directory
  199 |         #include <dt-bindings/media/video-interfaces.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221118093931.1284465-3-paul.elder@ideasonboard.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

