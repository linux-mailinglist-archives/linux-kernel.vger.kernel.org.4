Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE02D61393C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiJaOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJaOpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:45:42 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9197101C3;
        Mon, 31 Oct 2022 07:45:40 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-13bef14ea06so13691102fac.3;
        Mon, 31 Oct 2022 07:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/FH10O3eEqn0o6aN8sU7z4Nn4gIFyCFRKnoNg2C2xQ=;
        b=J+909/6mBWUWa388jxN0d2CqCJoeXr+eFoB7Bua75SxYQMIrt/DHymaJUYoKo/Dcu7
         JuFJkGI9+5f+ZMt+3kCEtGX+N6eLXLAT6e1JGbSedzcvJXkv5+weWSi8ZayPVH/eWnU4
         22wpOoLxgCIEa9Kv7OJPbqTGMOBZB9RSnF1nhwywt7A63nJN5f/gvZG3SapxofjmbJyr
         BxTuAQmiv6ujF6ooqIBvwvQV7K/52UaFMwCVgSu1/Q/qKXRXJ8LcBSaB1MP2xyU54MIO
         qCnkB/IikTPxCjTLeTft4Cd8mGzsG78ATVGkvbGUFz51G+8d9qa48euNts0OsHyOwzft
         gKlQ==
X-Gm-Message-State: ACrzQf2SDZrfd4is+TFiPcdpInIXHl8Z/7/t7PS6aeERDQI25yY1SX3y
        nz4iPZ0uQOMn28IU3jg8wQ==
X-Google-Smtp-Source: AMsMyM4gN4Iq1Ov3dfpswcegWaJYp37N5YBOswH241Qjw5B5vTf4Z3GAqdV0Xl9o8o3INqomAwal+Q==
X-Received: by 2002:a05:6870:630f:b0:132:8af2:c8f2 with SMTP id s15-20020a056870630f00b001328af2c8f2mr17541017oao.284.1667227540101;
        Mon, 31 Oct 2022 07:45:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q7-20020a056871080700b0012b298699dbsm3093444oap.1.2022.10.31.07.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:45:39 -0700 (PDT)
Received: (nullmailer pid 2861020 invoked by uid 1000);
        Mon, 31 Oct 2022 14:45:41 -0000
Date:   Mon, 31 Oct 2022 09:45:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        William Zhang <william.zhang@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH V3 2/2] dt-bindings: nvmem: u-boot,env: add Broadcom's
 variant binding
Message-ID: <166722753485.2860867.13096604705900447995.robh@kernel.org>
References: <20221018154202.4634-1-zajec5@gmail.com>
 <20221018154202.4634-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221018154202.4634-2-zajec5@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Oct 2022 17:42:02 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. U-Boot
> stores its configuration in an environment data block.
> 
> Such blocks are usually stored on flash as a separated partition at
> hardcoded address. Broadcom however decided to:
> 1. Store env data block inside U-Boot partition
> 2. Avoid sticking to hardcoded offsets
> 3. Use custom header with "uEnv" magic and env data length
> 
> Example (length 0x4000):
> $ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
> 00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu.@..4.z.IMAG|
> 00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=NAND:1M,1024M.|
> (0x40000 offset is unit specific and can change)
> 
> Starting with the commit 118f3fbe517f4 ("dt-bindings: mtd: partitions:
> support label/name only partition") DT can describe partitions matching
> them by a name (without specifying actual address). With that feature
> and this binding change it's possible to:
> 1. Specify DT node for Broadcom's U-Boot env data subpartition
> 2. Add nodes for specific environment data variables
> 3. Reference them as NVMEM cells
> 
> This binding is unlikely to help Broadcom's U-Boot. U-Boot SPL needs to
> find environment data early (before it accesses DTB) and it does that by
> looking for an "uEnv" magic. Dirty way.
> 
> This binding can however be used by operating systems. It allows
> describing cleanly U-Boot, its env data and variables. It tells
> operating system about Broadcom-specific env data so it can parse it.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Work on better commit body & add example
> V3: Avoid duplicated "mac" label
> ---
>  .../devicetree/bindings/nvmem/u-boot,env.yaml | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Applied, thanks!
