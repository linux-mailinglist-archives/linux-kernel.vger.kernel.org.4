Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA4B64B75D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiLMOad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiLMOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:30:31 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B3620BC5;
        Tue, 13 Dec 2022 06:30:29 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id w4-20020a4aaf04000000b004a1ab217cecso2378292oon.13;
        Tue, 13 Dec 2022 06:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM9kRLYMidEhJ9aWws+5SH1yRO1DfKGfusCzNc46Kb8=;
        b=ry7Ba1kr5OZIDHWTZCgur568PaTmz8o2nDhSvQVxnQ7YoUUqqANsZmFVXWWMB4nLyp
         o1BqfIflAr8SSml/NV5jEDDtccoD/IdrRlZdxzHmIdtpz3AVboNIHtGv4IhLwGYsgtwO
         H1PkcGJNXvg6XDks7TlUyWBR36bE9/CHFIm9QbGRBewiv+H1+h/kiR57g2+fPHUrcXWw
         MgSWHWR0delBB7h5w6JdKvk9vePNZTlW6Xq8JgdOyEhC5CZGvSqCuTxs4S+eia5jKGAy
         ocV2ZE8SlVmf4bLgdsuOSPpc4IbwY0pvDIogF8fnZoGFt2BpaxkdLNiKYp9cvahe5pv8
         hNYQ==
X-Gm-Message-State: ANoB5pnTBv30zQTk00NQDQt14VE+iaUrma6oB+6j5oTw0UaBwqwuBU19
        wYVp53+Ic1ktV7GBCm3y2g==
X-Google-Smtp-Source: AA0mqf7AEpvMIx/aOAPpbyv8k7VDkIuEE1vd0lhL7EyoXfww/93yf9Y+fuCDWDAFlrfpuOfPbODjrA==
X-Received: by 2002:a4a:e046:0:b0:4a3:f16e:3d0c with SMTP id v6-20020a4ae046000000b004a3f16e3d0cmr3969209oos.0.1670941829039;
        Tue, 13 Dec 2022 06:30:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f9-20020a4aeb09000000b0049fcedf1899sm1207639ooj.3.2022.12.13.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:30:28 -0800 (PST)
Received: (nullmailer pid 968949 invoked by uid 1000);
        Tue, 13 Dec 2022 14:30:27 -0000
Date:   Tue, 13 Dec 2022 08:30:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, daniel@ffwll.ch, paul@crapouillou.net,
        airlied@gmail.com, sam@ravnborg.org
Subject: Re: [PATCH 2/2] dt-bindings: display/panel: Add AUO A030JTN01
Message-ID: <20221213143027.GA967686-robh@kernel.org>
References: <20221213081034.14226-1-cbranchereau@gmail.com>
 <20221213081034.14226-2-cbranchereau@gmail.com>
 <167093911506.912834.5336090745245447936.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167093911506.912834.5336090745245447936.robh@kernel.org>
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

On Tue, Dec 13, 2022 at 07:46:32AM -0600, Rob Herring wrote:
> 
> On Tue, 13 Dec 2022 09:10:34 +0100, Christophe Branchereau wrote:
> > Add binding for the AUO A030JTN01 panel, which is a 320x480 3.0" 4:3
> > 24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
> > interface.
> > 
> > Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >  .../bindings/display/panel/auo,a030jtn01.yaml | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dts:22.11-21: Warning (reg_format): /example-0/panel@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.example.dtb: panel@0: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml

You need a minimal spi bus node in your example.
