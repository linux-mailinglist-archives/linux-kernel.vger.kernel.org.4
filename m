Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549BD62CBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbiKPU43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbiKPU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:56:11 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B9168C47;
        Wed, 16 Nov 2022 12:54:19 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13b103a3e5dso21592021fac.2;
        Wed, 16 Nov 2022 12:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKjlsGpIZRtExAkk23Ms1E3ikS5e/TUS1Bw6/GljMhQ=;
        b=y1aezILj/ppVEBoZJIsJ9RBTrlQhxkK3eUBtvwJch0vZDjsqBoTiW/SPfQxT+JDZYC
         PGcWQ83B7XZ+hgJ/UP7hVlNDhPf284EMFnpcsgqjLZGAHUlMRRK668P7ktN1Y+bJRpcX
         8ahtnfBBjZJ1sAy/ZEth539ikTTlz+WBF/6mjalrd0YvD6O5Jgku7XrvWvhyD+rzNGZO
         AOdrt3jJYoBRItvg7Vj+G38Azzj4dx8kD/7M0SJc6Qo5IwkZotbD3YopyLD+vNf4UMnO
         bc2BEeh5foIx2j4Cbke2iYuEDlFhglCJDFqbf1IRS7xqGhH/GLC5FAj+AGp4/EJSefFe
         EESQ==
X-Gm-Message-State: ANoB5pmTNq0xvmlG0jh+RAC/hlpX5kfPrp35XSyG4G0beByM9eiFY7Do
        DDzQIpz69r3dNQq8YsCqt5aOkiRi5g==
X-Google-Smtp-Source: AA0mqf6/P7js/6CRjiPs3vFVuN9a7lA3l/+c269RWxMf5ik5/33cadQR0sOvDTie62yIY/0q/wgMbQ==
X-Received: by 2002:a05:6871:b1f:b0:13c:9414:5c46 with SMTP id fq31-20020a0568710b1f00b0013c94145c46mr2867994oab.79.1668632058648;
        Wed, 16 Nov 2022 12:54:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg2-20020a056808178200b0034fd36e95bfsm6622149oib.31.2022.11.16.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:54:18 -0800 (PST)
Received: (nullmailer pid 864688 invoked by uid 1000);
        Wed, 16 Nov 2022 20:54:20 -0000
Date:   Wed, 16 Nov 2022 14:54:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] dt-bindings: nvmem: add YAML schema for the ONIE
 tlv layout
Message-ID: <166863205977.864630.6987238461166944132.robh@kernel.org>
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
 <20221114085659.847611-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114085659.847611-6-miquel.raynal@bootlin.com>
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


On Mon, 14 Nov 2022 09:56:59 +0100, Miquel Raynal wrote:
> Add a schema for the ONIE tlv NVMEM layout that can be found on any ONIE
> compatible networking device.
> 
> Describe all the possible NVMEM cells that can be produced by this
> layout parser.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
>  .../nvmem/layouts/onie,tlv-layout.yaml        | 147 ++++++++++++++++++
>  2 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
