Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4F639BB9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiK0QZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 11:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiK0QZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 11:25:32 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF71D97;
        Sun, 27 Nov 2022 08:25:31 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id e189so6104775iof.1;
        Sun, 27 Nov 2022 08:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yuUo839ouCRSbkJNJ1fxU1PZrrK1dbyq76ZJVUGD9/k=;
        b=n7Gyro81tLVLEGVKEIgj83DywSnbDRoRiifo6MjGEA9hnqU2ydkRjmowBkn39+b03N
         cg7txL67QzFx/rQKFYhtlHdsyKxW1gI6humbIG0TnkObUAasWoXy7Aqd1PhqHlW9denM
         xxC/qxbfyFRUGt+WOfE46+S0BTSpxtCIiNCmCXej3gjhNI981AX9Lto9ezeunatCfZGv
         20ch6OM5gMjQ3xD4RS+6ccgGJa47soveTEkHHznzZhaijcWpyL+FayzjBVXNgtYp3A7N
         qoo59o3VcWBPr4h2X7YoP4PxEFDRCbo/oIoVXB3yLiIJST1zbvPtNehH8Oh9DcHnP/GJ
         d3DQ==
X-Gm-Message-State: ANoB5plqAQF+Gx90nddDyGZlnpkUKif7g7iDcj35+A/1EmLkkAqKZdDt
        NampE8rz1G7p9Ab/gEyk8w==
X-Google-Smtp-Source: AA0mqf44R/wDWOVoHTVFS+SDacaqzAGlB6QCBeYoD3ZCH3iZsjq0w4dtFkFKXNm7XdshFRBGxYTxIg==
X-Received: by 2002:a02:6d54:0:b0:376:24f6:d0f4 with SMTP id e20-20020a026d54000000b0037624f6d0f4mr14700069jaf.206.1669566330359;
        Sun, 27 Nov 2022 08:25:30 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80c3:406b:3c03:158a:46b4:95c8])
        by smtp.gmail.com with ESMTPSA id j198-20020a0263cf000000b003753b6452f9sm3385698jac.35.2022.11.27.08.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 08:25:29 -0800 (PST)
Received: (nullmailer pid 7239 invoked by uid 1000);
        Sun, 27 Nov 2022 16:25:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-sunxi@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-usb@vger.kernel.org
In-Reply-To: <20221127073140.2093897-3-uwu@icenowy.me>
References: <20221127073140.2093897-1-uwu@icenowy.me>
 <20221127073140.2093897-3-uwu@icenowy.me>
Message-Id: <166956617204.3782.6939462747953664680.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: usb: Add binding for Genesys Logic
 GL850G hub controller
Date:   Sun, 27 Nov 2022 10:25:30 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Nov 2022 15:31:36 +0800, Icenowy Zheng wrote:
> The Genesys Logic GL850G is a USB 2.0 Single TT hub controller that
> features 4 downstream ports, an internal 5V-to-3.3V LDO regulator (can
> be bypassed) and an external reset pin.
> 
> Add a device tree binding for its USB protocol part. The internal LDO is
> not covered by this and can just be modelled as a fixed regulator.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  .../bindings/usb/genesys,gl850g.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/usb/genesys,gl850g.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml: duplicate '$id' value 'http://devicetree.org/schemas/usb/realtek,rts5411.yaml#'
Error: Documentation/devicetree/bindings/usb/genesys,gl850g.example.dts:26.41-42 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/usb/genesys,gl850g.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221127073140.2093897-3-uwu@icenowy.me

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

